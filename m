Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987FEECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A48208FE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="mL4UkTsj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A48208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730810AbeGPJBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 05:01:03 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51952 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbeGPJBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 05:01:02 -0400
Received: by mail-wm0-f67.google.com with SMTP id s12-v6so14289318wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 01:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tTDn4uGQ0EwV3UUJYqVjoJWU273YjBzy6q3MKhVtuDM=;
        b=mL4UkTsjEjG4Jb85y4KvQjhfNtROuvH2DnpvsaRv86r7hAfmbstHHw9gpHV+GRGZWt
         Ug1Dseh70zlDZyUp2hFd7xTGO3geBgKqALZ5ye/lQzBdkAcjc/tHkxndxMB1x24cadlg
         qwsUXN3tmJFtUTAJdsyJGbcerdipb7H3oI7dIrk7PuVxQGGFUCi62WosKA7Nuv4Gr7y3
         cWLOAPfmx+bvnCUv3Baixd8ZxxzrDndFyVR0ZlfBCp+ZyvO3wgYdArTtYF3yzPHFGNmA
         DU06KlQhlnshfRWFEXyIuDA7g2G91Wm4ONORS5n7N0nhAQgCPZfFGpHT4bdto5UAs+m4
         16QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tTDn4uGQ0EwV3UUJYqVjoJWU273YjBzy6q3MKhVtuDM=;
        b=qS20IqtwQUMcCfShTj4eMkxPAtXkvO6r8eEZx8K71DrKLB/2ZmK9iI3izcTWQc993y
         UhCwIe1mnWLfVebR2ho/B8D2dHlRF/RkKF02fOjoBdy3JXH2v+4gsMZFmaMN3kAhIxwf
         fINVzPDDkOUPO0WdowR8PJFcMBRuJrn0sXfquyiABIam2dhfcPM0URNUJLpO6mm2LYAp
         e9e6RxhB4ml/iACT3ZuQ0EtWVL72bwqlZ6tIAx8YPdWkwJf4castbMChGErUx727p/+G
         4xh13xtF4LWx463DdCN/+a9OAspABLcl/PqJUcCzsaiz8iU4hRm9V5BcAcp9zd/WQJ0Q
         qyDw==
X-Gm-Message-State: AOUpUlHUmLIu8vAeLH61qH8XmFJ8DBHFC9CKVl69n+C10VvqkgXV9ajg
        JSseXdQByzcNWdm9Tye11/0qlw==
X-Google-Smtp-Source: AAOMgpeo5cRTF1MIT1q3h2a4Vca9Kh/qpxkUfdigYk/EvQ/VnYmKI4jx0vZGIA3odH5OpeUivtACWg==
X-Received: by 2002:a1c:87ca:: with SMTP id j193-v6mr8980407wmd.76.1531730084314;
        Mon, 16 Jul 2018 01:34:44 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id z3-v6sm29483104wru.27.2018.07.16.01.34.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 01:34:43 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 1/2] gpiolib: don't allow userspace to set values of input lines
Date:   Mon, 16 Jul 2018 10:34:23 +0200
Message-Id: <20180716083424.11157-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180716083424.11157-1-brgl@bgdev.pl>
References: <20180716083424.11157-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User space can currently both read and set values of input lines using
the character device. This was not allowed by the old sysfs interface
nor is it a correct behavior.

Check the first descriptor in the set for the OUT flag when asked to
set values and return -EPERM if the line is input.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/gpio/gpiolib.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e11a3bb03820..57973524360d 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -449,7 +449,13 @@ static long linehandle_ioctl(struct file *filep, unsigned int cmd,
 
 		return 0;
 	} else if (cmd == GPIOHANDLE_SET_LINE_VALUES_IOCTL) {
-		/* TODO: check if descriptors are really output */
+		/*
+		 * All line descriptors were created at once with the same
+		 * flags so just check if the first one is really output.
+		 */
+		if (!test_bit(FLAG_IS_OUT, &lh->descs[0]->flags))
+			return -EPERM;
+
 		if (copy_from_user(&ghd, ip, sizeof(ghd)))
 			return -EFAULT;
 
-- 
2.17.1

