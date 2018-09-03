Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AE9C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 00:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF05B204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 00:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rzS6QhTN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF05B204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbeICEej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 00:34:39 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45720 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725762AbeICEej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 00:34:39 -0400
Received: by mail-pl1-f196.google.com with SMTP id j8-v6so7779713pll.12;
        Sun, 02 Sep 2018 17:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=fw9qfkx1rajv9uo147j2iZZ43vl6D8Ms1tH4qeYQtig=;
        b=rzS6QhTNt3nyjBTT+0yv6M+fn56sEr/YzvqEqStNzD36M0H6cIKYUznWTE9SG93i5K
         l0kf8wFZL8I8vqQWbHR8jqXEfix1rOFbyx6uI/fjcPhFhWJme4AEJRKcFdQjjaafUz+s
         DlzjRHzDqnnSEhoMpO9TckeOmn4hwSPhV9ypML7IB5hy55ApiLUnu8UrHaAwBTDUEKNU
         qBkRR5hWiWRzRxgmXRjMcbyGVzey86M435gv+pbtbEcfekd4IfblIf30QJ/XfUw6iBih
         vmgabznUXeppl+ax+Kp/pk0pverXw5QJiESCnJ6+6/sXia2cqjgS5TRiKtkW7ZzN4VB+
         br8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=fw9qfkx1rajv9uo147j2iZZ43vl6D8Ms1tH4qeYQtig=;
        b=WNjMShEQQpPvMJb/L0c1IToz9P9T0jxgNMOgTGgh++SfufRuPH418xXyAoi8yAb+0g
         o73ug9eLptb5ed8iqM1K4p0VXNanbG59yMjuUjMYbfG3hNxlAhNdrxOlcGj0llUlAFxs
         YgJs011Z42hexvRTv9qp+wXONvCtJ6lh848/+BEOz+U3eue2K2A0VRVSnem0xmOmI8z3
         q3NV+8ImUgu6VkXB1X8XfeXegZ+ZOGRiBL6cPb8l5lk385uLb/G0zmCr5GZtX5krFG8E
         25lewozHquNbgRzqGo6SgAnt+oQE5qLnXtgelMGPYXbRJDMP1e0wGPgGMmJLKS3ok55v
         BjVw==
X-Gm-Message-State: APzg51BdlZj/+d7A/OWI017GUshMmEqA6L53xzXmoFeP14sEJ7lGRQwJ
        HKtPTE0FZLI//r5XQyJL47w=
X-Google-Smtp-Source: ANB0VdbbvlttdbiaoLKTJ5XOhqNE0FTc9mWNJ3dsTsrzZjnm5k0YAMpIBtzUoODzd7BVzIlIEYdP6A==
X-Received: by 2002:a17:902:6ac7:: with SMTP id i7-v6mr25977757plt.288.1535933823968;
        Sun, 02 Sep 2018 17:17:03 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id y128-v6sm22492907pfb.56.2018.09.02.17.17.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Sep 2018 17:17:02 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Clemens Ladisch <clemens@ladisch.de>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Guglielmo Fanini <g.fanini@gmail.com>
Subject: [PATCH] hwmon: (k10temp) Support all Family 15h Model 6xh and Model 7xh processors
Date:   Sun,  2 Sep 2018 17:17:00 -0700
Message-Id: <1535933820-23767-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BIOS developer guides refer to Family 15h Models 60h-6fh and Family 15h
Models 70h-7fh. So far the driver only checked for Modela 60h and 70h.
However, there are now processors with other model numbers in the same
family. Example is A10-9620P family 15h model 65h. Follow the developer
guides and mask the lower 4 bit of the model number to determine the
registers to use for reading temperatures and temperature limits.

Reported-by: Guglielmo Fanini <g.fanini@gmail.com>
Cc: Guglielmo Fanini <g.fanini@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/k10temp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index bb15d7816a29..2cef0c37ff6f 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -325,8 +325,9 @@ static int k10temp_probe(struct pci_dev *pdev,
 
 	data->pdev = pdev;
 
-	if (boot_cpu_data.x86 == 0x15 && (boot_cpu_data.x86_model == 0x60 ||
-					  boot_cpu_data.x86_model == 0x70)) {
+	if (boot_cpu_data.x86 == 0x15 &&
+	    ((boot_cpu_data.x86_model & 0xf0) == 0x60 ||
+	     (boot_cpu_data.x86_model & 0xf0) == 0x70)) {
 		data->read_htcreg = read_htcreg_nb_f15;
 		data->read_tempreg = read_tempreg_nb_f15;
 	} else if (boot_cpu_data.x86 == 0x17) {
-- 
2.7.4

