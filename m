Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69250ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22DE120868
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkY9kERh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22DE120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbeGUO2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 10:28:16 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42545 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728221AbeGUO2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 10:28:15 -0400
Received: by mail-pl0-f68.google.com with SMTP id z7-v6so4576415plo.9
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 06:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MG6jsLkszC3R0FeIrd5LjxKJQBeR0pBYt0FFTyPwqHE=;
        b=jkY9kERhYc8WW57xdpDqtfd79L1hWrj1SfmTVkP+uBjKs14mp//MGpCp0M7S5iUIGI
         6RBu2pxqOtoZavbWwUitwOBzYkntdyJO15lhC9wEHe1MW7Bqzzl8zXOrYUwPLsDGdI58
         Xx9VQJBmD5aKSNd0tgQIGuPVxNnaWzb71PkrPCyAMCKs4cpkhttsFgLyetj0vVp2oLSM
         CzgVr1pV5ZVX/o5T0/dAK115bCrWKJiaaQuk294AOaWU95wfB0PZJbFrgqR7EPCyK8J2
         dogP+BRhdH1YdI717SA3KRkLc4c970ryj4oq8zjk7l0IR8Jy/BtabHTna1rFrdf66Os9
         zCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MG6jsLkszC3R0FeIrd5LjxKJQBeR0pBYt0FFTyPwqHE=;
        b=pqb6zT/GkSVyU1IAd1+s8hfDEUpATMitiX22NTjfRs54ZuvCPvn096f6ni4SQjsQRT
         aXPslykbTKWnGXeUxRDOPFTCKClt5oDN3DLqZvwrAMuWd3gAgRYs8IkImh7nn6GH/mZL
         xOv8nvWrZUyrupwZFqA9pJxFNzR0oUhnFodPIPP3L5flSuBrKjBtriXDXyqob82qUcjC
         eODbv8bjD36CGUMTOEWQSvWBNtTQPzKQmxyrZCZVHqVNd9qLQJEOK8MkC3GkH8NqTk+H
         BJwixhDFUZHt4fFZzA6OFv9Tg7qsJHrQLMEqmXwyeZzeftSQIzyuIFYGgeuEgsuP29e0
         LpLA==
X-Gm-Message-State: AOUpUlHSkYOwkcvRy4x0A0JJ5DAHGDeC5ZpUhB+LJd/f+DYLn2NgzjH3
        FngkVSBPD0MPg+h7ONvCys0=
X-Google-Smtp-Source: AAOMgpf01pXfIjMNilzZIKYESNHBFUkyfyclgjRSNeDIFNlfjait+2d1kEpv3xdMeJc0vdXEjVm3SA==
X-Received: by 2002:a17:902:758c:: with SMTP id j12-v6mr5875389pll.195.1532180127647;
        Sat, 21 Jul 2018 06:35:27 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p26-v6sm9445023pfi.183.2018.07.21.06.35.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 06:35:27 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 08/14] staging: gasket: apex return error on sysfs show of missing attribute
Date:   Sat, 21 Jul 2018 06:35:01 -0700
Message-Id: <20180721133507.95599-9-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721133507.95599-1-toddpoynor@gmail.com>
References: <20180721133507.95599-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Apex sysfs show function return -ENODEV if the attribute is not present,
rather than silently failing from the standpoint of the userspace
accessor.

Reported-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/apex_driver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index 3e76c4db5db2e..1c6f73b5a2a9e 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -710,14 +710,14 @@ static ssize_t sysfs_show(
 	gasket_dev = gasket_sysfs_get_device_data(device);
 	if (!gasket_dev) {
 		gasket_nodev_error("No Apex device sysfs mapping found");
-		return 0;
+		return -ENODEV;
 	}
 
 	gasket_attr = gasket_sysfs_get_attr(device, attr);
 	if (!gasket_attr) {
 		gasket_nodev_error("No Apex device sysfs attr data found");
 		gasket_sysfs_put_device_data(device, gasket_dev);
-		return 0;
+		return -ENODEV;
 	}
 
 	type = (enum sysfs_attribute_type)gasket_sysfs_get_attr(device, attr);
-- 
2.18.0.233.g985f88cf7e-goog

