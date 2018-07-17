Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289A3ECDFB4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D544620C03
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lY3LS5S/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D544620C03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731558AbeGQCkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 22:40:05 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44882 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731371AbeGQCkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 22:40:05 -0400
Received: by mail-pf0-f195.google.com with SMTP id k21-v6so2324269pff.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 19:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xAi+tz1xR+vTMPZHa4TPt80jizzIjIj8dZU0G1ekIfQ=;
        b=lY3LS5S/vj43WdNtO+kBG7NRjmOGpFdE6SmNTqbQLxy8vUafEB0KbZndBJpmy/ZNaP
         xESjZNqtjbx167WzsJD0ehKiOnaAVOLUfN3nJ0xoW7Z5eidPnseczw27a1BN4yVtKvTe
         7V8f1u/weClUwNfSUN3dc/h7J/Qs8Q14uc1DmM2Bcpx8UPug1GIUytaGWZYGwbTxw1SE
         lOEq4jx4ATQN/Z88+/9D7OH04TS0RpN/W4gehNzC5SntAO4mEsjD9Zg6pd6YbxBm8NzX
         t8GbfwISqekLAls6gyAcU9J+lh+2XnX5JvbNxzRAACEEt8fiht8iALlH0Ri4jYfNzfqW
         XdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xAi+tz1xR+vTMPZHa4TPt80jizzIjIj8dZU0G1ekIfQ=;
        b=eHprX4fT0e/lxl7VyalcbCbRjMtbcpeq/QltO5fgwJSCTJ0y0VJXOO7R34lRbu6LRN
         azF/JBVvo57UOZ9Iu7S2arQg4Beohtvh9X5g3qWfPaqLb7LNAWmlq2t9l+dHMKGhf1Ma
         7fvKsgbJo7udM49hsqKSskJzEoRGyvSGfogYi1Bw9cRhHZGwaP+CUU0i/gm2F9D7oUo7
         YwIcfqO5ShTrxw90kky6QcSY554ZXMIzJf28mBhwTKU7MKNSeP5gcEn7YJJ3Cahbbw9W
         z218iveK0kCwAJTFjINB+6SZY27ocXtG4z7Whwm1k4KIBPJqaOQ5kizYs32mGrEgj0FN
         m96g==
X-Gm-Message-State: AOUpUlH5B2eWoIbDpVBWcmWOQAg9qCyfPImhn2T6bRzsv3ZrRoxFJmZ8
        /O73umWogciZVB3NUuPcgJI=
X-Google-Smtp-Source: AAOMgpfdWpUGVQcG88r3My6L+8rMrZyM9GjySAAMPaMtXj/bkhEuEt/NFpqHOG8hwSGp3Psfvd9G+A==
X-Received: by 2002:a62:283:: with SMTP id 125-v6mr20383625pfc.51.1531793395058;
        Mon, 16 Jul 2018 19:09:55 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id i20-v6sm41597152pfj.82.2018.07.16.19.09.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 19:09:54 -0700 (PDT)
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
Subject: [PATCH 08/32] staging: gasket: Remove stale pointers on error allocating attr array
Date:   Mon, 16 Jul 2018 19:09:02 -0700
Message-Id: <20180717020926.176408-9-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717020926.176408-1-toddpoynor@gmail.com>
References: <20180717020926.176408-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

If gasket_sysfs_create_mapping() hits errors allocating the attribute
array, remove stale pointers to device info from the mapping object.

Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/gasket/gasket_sysfs.c b/drivers/staging/gasket/gasket_sysfs.c
index dd4d3aaa57e2f..1c5f7502e0d5e 100644
--- a/drivers/staging/gasket/gasket_sysfs.c
+++ b/drivers/staging/gasket/gasket_sysfs.c
@@ -225,6 +225,8 @@ int gasket_sysfs_create_mapping(
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

