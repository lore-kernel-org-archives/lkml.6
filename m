Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50706C468C6
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08ACD208D8
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AP0TC3VP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08ACD208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbeGNGQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 02:16:39 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46055 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbeGNGQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 02:16:39 -0400
Received: by mail-pf0-f195.google.com with SMTP id i26-v6so12334809pfo.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 22:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xk2ryzpVLuqGPuAzBDiKHKzQ3d09hZ/9MuED5R/pMhQ=;
        b=AP0TC3VP3BMCHCFGbIMtTZ9gjAmcj5fPSkJNdODDmfPhbxn3M44m+oUgqHkZBULVe4
         SPfDjhui3xB9t3ocQ7lc30yPZ7M9eVk/QT1oTSsLZT7zC+AEgXArTNVq0T/yocSIVOG2
         5O8l6Ya39EHBNpLf64d2CzR18DOnzMEy+AUIagKaoiFMd+2bnrrGqg4B7OPAgQU+noLL
         4NpjyXHqKT4UBBu4rao7rU2PciI750n45twFhYzs9rxrU24rp+rrNKEsG9Exlb7NqpGw
         YpPwzzVmSNrYRx5i6+8+6n+c4xRcvSt1L55RqBsDE1UJ6UuQMi30nnEVikGIXbE3EzNf
         BNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xk2ryzpVLuqGPuAzBDiKHKzQ3d09hZ/9MuED5R/pMhQ=;
        b=OJfaeeuxMEy2OcvvG+xyXx7mygvi+818xu91G6QFC5Ixr4lZIHtMS81ZuJMIwsGAMM
         NwsQb/qn6OwVUAh14KCypEGEHbFb9Yw/75jbh8yOoRufMvLu6O36KHPGh7Je/egb8upl
         21C8FYD8+HWI31UDRzN/6nco4NW3BIcB+AZHB6++u2T0WGZqpLHNiCO2sgk/QWCbi5yw
         +gzHW5PoIK18gGNONLKIRSuii2eYiA2ZhoooCNXYUVL4Ow5FK6XcnisFZC8K0mgs3Mat
         d/4ZJsdxy56Wfzao3bdNeaeOB1XNniXQh7QdNq2+rzThQCXpvMzKWi4mbK0FYUv7cVpL
         CbOQ==
X-Gm-Message-State: AOUpUlFwxLWaPidF84TyAoWKxAnxwrQoGM8QIe0g65PSUQRmAkJ4yZ70
        lhn/970x+7qktcONIzuyqtQ=
X-Google-Smtp-Source: AAOMgpdIPE8HxlzBCDTFF87POT3rJ5085p36xSVt7SK0FoW1yqGjppv0DwN8kUK/JL52QrqdY+ymWw==
X-Received: by 2002:a65:62ce:: with SMTP id m14-v6mr8514399pgv.407.1531547929366;
        Fri, 13 Jul 2018 22:58:49 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id 203-v6sm48411112pgb.14.2018.07.13.22.58.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 22:58:48 -0700 (PDT)
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
Subject: [PATCH 05/18] staging: gasket: sysfs mapping creation fixups
Date:   Fri, 13 Jul 2018 22:58:03 -0700
Message-Id: <20180714055816.223754-6-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180714055816.223754-1-toddpoynor@gmail.com>
References: <20180714055816.223754-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Return EBUSY for attempt to create a mapping already in use.

Remove stale pointers on error allocating attr array.

Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_sysfs.c b/drivers/staging/gasket/gasket_sysfs.c
index a3705d6e088a..d1856a09b894 100644
--- a/drivers/staging/gasket/gasket_sysfs.c
+++ b/drivers/staging/gasket/gasket_sysfs.c
@@ -213,7 +213,7 @@ int gasket_sysfs_create_mapping(
 			"0x%p.", device);
 		put_mapping(mapping);
 		mutex_unlock(&function_mutex);
-		return -EINVAL;
+		return -EBUSY;
 	}
 
 	/* Find the first empty entry in the array. */
@@ -244,6 +244,8 @@ int gasket_sysfs_create_mapping(
 	mapping->attribute_count = 0;
 	if (!mapping->attributes) {
 		gasket_nodev_error("Unable to allocate sysfs attribute array.");
+		mapping->device = NULL;
+		mapping->gasket_dev = NULL;
 		mutex_unlock(&mapping->mutex);
 		mutex_unlock(&function_mutex);
 		return -ENOMEM;
-- 
2.18.0.203.gfac676dfb9-goog

