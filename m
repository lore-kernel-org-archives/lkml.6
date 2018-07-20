Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BFBECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB8D20833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTnUMErn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CB8D20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbeGTEgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 00:36:14 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36919 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbeGTEgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 00:36:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id n7-v6so5615286pgq.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 20:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=puS/rJO8cP0CWWLHNR8DiIC8n1Lb4rPWwazmigLXvkc=;
        b=HTnUMErnBUbz14cS+elmnEYCFt8UoGdB2BW8+hNxH7ZLijY9tdjbIAhvkbsmscqkv/
         R3yAY7Wemfb22wvHqa+4hPQ0VfqqhlfmAUprBiGuWSwhmXoE/vgEDhccozeaTx02G0uT
         FmuEUFRfJe+tWrzQTAYr7ez3ehndxALR8G3lbFIM/eSKyw35KS39cmEWf78UaUZgWdZY
         98qxZZmn1oJ3taQXE6c1t+/Erv0JLZr6YfIncPH8seKmFs35ex+ZSdrEQdR9w9/DSbhm
         I7NBDqOSl0XXQt4vjC3lakFDaCHIWZ+J1CG74EYBwcpgOW7mVNXQLJ7+0mOiPaBVsBIe
         01tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=puS/rJO8cP0CWWLHNR8DiIC8n1Lb4rPWwazmigLXvkc=;
        b=IB4trWoxwp9dBCENmCebsf2gfcOreeXBJLX5uDnkag5VLTObpfj+iqCXnoZ4a9wz2L
         3Mdj4IJvgng6J5+tOvrsVtJEjxkKSfWR7dsdMBpiCfaswihm/Aa5Rlf1VdNMLvLggIRc
         VGIeXkUe7uXiajTY63KiMsuBWUWphItU79LSxXf3iRh8LeC/jWKljGdFr+sigelTDGqg
         I9k4vk5Do1ftD2xr7I2x0iIRRSCbYM8+LGaK0q01iESf752iDBOOac9iLZKvtmV/yUz6
         dx70Xno+1W4TiQx2pRNlM0kd9v+g4YCe6jM4PHUDkMYFBhuc6skXB13oY3CczbbRgWBy
         PQ0A==
X-Gm-Message-State: AOUpUlH9M1lB2wSQ/bkQs2kVpqmsmbyllOUQgUOv2pWMPx3RtJY+oXdL
        32J10jOSBsQVTTBgn9Zd63M=
X-Google-Smtp-Source: AAOMgpd3/6LezTGWLNSvfX/VZbH2GaZzYhcqRgZboodrX9W8NE6lboyNnp7Og/6nC1Ykre+Oi4Eliw==
X-Received: by 2002:a62:23c2:: with SMTP id q63-v6mr451538pfj.91.1532058601749;
        Thu, 19 Jul 2018 20:50:01 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id x66-v6sm864255pff.123.2018.07.19.20.50.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 20:50:01 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 13/20] staging: gasket: gasket_mmap use PAGE_MASK
Date:   Thu, 19 Jul 2018 20:49:13 -0700
Message-Id: <20180720034920.77320-14-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180720034920.77320-1-toddpoynor@gmail.com>
References: <20180720034920.77320-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

gasket_mmap use PAGE_MASK, instead of performing math on PAGE_SIZE, for
simplicity and clarity.

Reported-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Simon Que <sque@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 3cf918f9d2604..ae5febec8844c 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1591,7 +1591,7 @@ static int gasket_mmap(struct file *filp, struct vm_area_struct *vma)
 	}
 	driver_desc = gasket_dev->internal_desc->driver_desc;
 
-	if (vma->vm_start & (PAGE_SIZE - 1)) {
+	if (vma->vm_start & ~PAGE_MASK) {
 		gasket_log_error(
 			gasket_dev, "Base address not page-aligned: 0x%p\n",
 			(void *)vma->vm_start);
-- 
2.18.0.233.g985f88cf7e-goog

