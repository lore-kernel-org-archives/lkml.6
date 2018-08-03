Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C205C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE52A2174D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6qpH1To"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE52A2174D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732627AbeHCMQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 08:16:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37917 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbeHCMQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 08:16:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id x17-v6so3020862pfh.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 03:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pnbeDbs9odK7UGlTOGaavm27rWSmHXYWHCMTdzHtR7w=;
        b=T6qpH1TozOVAkIPRwh2WZL1QsI3bN0o+ARc0QtfQ3+bi7KWSkcMdXI8aSpGpEc6puM
         fe1UHXGbi4eTVTAFNEO8NTnpAVPO5WS6J3R/pOIhEHH2Kcjdk4JKFbZUmAyg1f7A09nv
         do7vv9idJEU0l3biCA518BZ+6bAPQhvPUzXBbBckldJBStQBTkLENHbszlIUmAFuyaVo
         bc+ilgf6JkfdiQ/s2uUEPoG5G1wOKmo4ZR7GLsWaaAr13B79ikLzVmZMQJL+CiiFGQOm
         P8n3u0xSiZd0qM93VScnW72PdJdlIlMixLPouyVAbBA9IXRBdom8A4Eh0nmTwZf2W7sZ
         eGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pnbeDbs9odK7UGlTOGaavm27rWSmHXYWHCMTdzHtR7w=;
        b=DvdJpSXJ3XadxY2ihh0IqSqxnvGhxPtCs0bNp8ZVZHZSNfNpJKOCVsGRNAbE/hKxwa
         wse+/yaW4cIxp8tG5k/OxYUpf8ag+Fo41mczEKsga0YZStCoTk/VnwvXInZeUzlvJ/Cc
         OWUeqNGiioH4TONpvRTk9IVTvl85W7OkxYuiZO6PP5XGZTxTFzT7OI2wNjAInO0KT2Xi
         4CG3JLW0B/v0XxfCBm89pfFOZZ7LJfIcUFhHVm0myzv+mDyJHHdmVojZ8OXvK+2IAVgb
         wRfQUP81XXdeAKCCjIm7bEfbLxxFPIO8i/Bc3jRqLfBoGtZ2xglBe2N3B6hxiPi9q8iE
         ibKA==
X-Gm-Message-State: AOUpUlEKIuF52VA73Hls0WgYvH3dZBWLs6EOItNEPRwaNEBAP2c09Tmg
        cY+HoioG6gZsBa/NoYewvmE=
X-Google-Smtp-Source: AAOMgpdawNmbgzZmMYny9GBRfZ7nXYhTkMiFZRDWD30YA+rdMdHOyjVkIDYLZfpdz29WpYtalg+Hqw==
X-Received: by 2002:a65:4384:: with SMTP id m4-v6mr3099338pgp.265.1533291644926;
        Fri, 03 Aug 2018 03:20:44 -0700 (PDT)
Received: from parths.sibshivalik.com ([219.65.63.222])
        by smtp.gmail.com with ESMTPSA id g184-v6sm10422695pgc.22.2018.08.03.03.20.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Aug 2018 03:20:44 -0700 (PDT)
From:   Parth Y Shah <sparth1292@gmail.com>
To:     fbarrat@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com,
        arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Parth Y Shah <sparth1292@gmail.com>
Subject: [PATCH] misc: cxl: changed asterisk position
Date:   Fri,  3 Aug 2018 15:50:38 +0530
Message-Id: <1533291638-22224-1-git-send-email-sparth1292@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolved <"foo* bar" should be "foo *bar"> error

Signed-off-by: Parth Y Shah <sparth1292@gmail.com>
---
 drivers/misc/cxl/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
index 70dbb6d..d45f3e6 100644
--- a/drivers/misc/cxl/fault.c
+++ b/drivers/misc/cxl/fault.c
@@ -33,7 +33,7 @@ static bool sste_matches(struct cxl_sste *sste, struct copro_slb *slb)
  * This finds a free SSTE for the given SLB, or returns NULL if it's already in
  * the segment table.
  */
-static struct cxl_sste* find_free_sste(struct cxl_context *ctx,
+static struct cxl_sste *find_free_sste(struct cxl_context *ctx,
 				       struct copro_slb *slb)
 {
 	struct cxl_sste *primary, *sste, *ret = NULL;
-- 
2.7.4

