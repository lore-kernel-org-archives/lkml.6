Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9931ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A0A208D8
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qEB791gT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71A0A208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbeGNGQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 02:16:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45799 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbeGNGQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 02:16:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id n9-v6so5358889pgp.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 22:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xcr/LmQPOCpqj0oSZ/kICvwHuug5QNAyJTZ1T0fGuak=;
        b=qEB791gTLzEbBFrS7xRjIosemq2fQpyFe0iRYhfLeMRPFStAFlbZvrf1v7aBLhz8fV
         MV+hwXkguqNiXLaBvujx/xI8zKgn9sYlAnw+2wST6lWSGru1ymETqXUM2uB4FAOV7Rai
         epc+EwjBDp+Jc3r0+EKRG6NK2KMRmcJYPX8iFoPz6AsFF9yhtraDiTbVbeTC9fbFxcMv
         gJr9eRf2uzWawyqmNqyNgRdOvjKn/H7cG4lahRzJc33W1ETydKESgbiCGiA5Qe5jbmQI
         p868DFQ3mAs0jH6k6SmA25+qwiW0v/Gbh6H6X1ACQnaCcQI4WZWDBSiYb1OFj5pwAHgr
         SkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xcr/LmQPOCpqj0oSZ/kICvwHuug5QNAyJTZ1T0fGuak=;
        b=jRFZr/bcw88pt9rupkX21mW5SU9gE3t+RZxEKSYUPoy8vru9f/c5E4ou7kKecklwn4
         arjBBUu9+WpRdoOFSdNgqTI0xtwlamFurA3jk0m3tOAErlHtJ3GufkD/qBA7JwRnc9LP
         009m+j2IvF8nZYqgQuRTVnSuzCW1Lrvyf683REriaYAOivtfCqBB99lWmSuOrXwTCYJX
         iDoIpF2MQWRiVB9j+CYi4W6xhhcSm7DxP8+AmaZlT/PbZTVORi/WUtvp5ztp45CQqomW
         5eQbqtODHJS0rN4/RHTa83TmJ6yug3sZ/6jnhBUEvf5m9Era9YATDw3ciR4BdqHCtb2O
         OSEg==
X-Gm-Message-State: AOUpUlH3if6PvPBq5CMo7PJaa4WLEdX1NfG0odmXzFk6hLKrgdMB4hrk
        eRyOhSpC/8pBSNs0nv/Ts4w=
X-Google-Smtp-Source: AAOMgpctVLbNGuFjyKiQ6i8VGDCHZopU54fPte+zwBcENjcL1Lz65QGNHY7buGBLYRxMto3lpOV2Hg==
X-Received: by 2002:a63:e56:: with SMTP id 22-v6mr8626535pgo.438.1531547933128;
        Fri, 13 Jul 2018 22:58:53 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id 203-v6sm48411112pgb.14.2018.07.13.22.58.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 22:58:52 -0700 (PDT)
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
Subject: [PATCH 09/18] staging: gasket: bail out of reset sequence on device callback error
Date:   Fri, 13 Jul 2018 22:58:07 -0700
Message-Id: <20180714055816.223754-10-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180714055816.223754-1-toddpoynor@gmail.com>
References: <20180714055816.223754-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

If device reset callback returns an error, error out at the gasket
level.

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 6316e6c800ba..ffd6ce801313 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1879,9 +1879,11 @@ int gasket_reset_nolock(struct gasket_dev *gasket_dev, uint reset_type)
 
 	/* Perform a device reset of the requested type. */
 	ret = driver_desc->device_reset_cb(gasket_dev, reset_type);
-	if (ret)
+	if (ret) {
 		gasket_log_error(
 			gasket_dev, "Device reset cb returned %d.", ret);
+		return ret;
+	}
 
 	/* Reinitialize the page tables and interrupt framework. */
 	for (i = 0; i < driver_desc->num_page_tables; ++i)
-- 
2.18.0.203.gfac676dfb9-goog

