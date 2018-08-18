Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF05C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 19:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5CF21748
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 19:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1N4KNcw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5CF21748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbeHRWPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 18:15:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32871 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeHRWPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 18:15:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id r64-v6so3782609pgr.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 12:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=5IB53Xs/2hKp0H8hmKzOCHq/U8/msP66BqnWbS1nqPA=;
        b=C1N4KNcwbgN5NzUSlgwIWPwc74NxsyZWHWoGggI/LnemKcL8o6Ub75czIdyiQ/s2sX
         fMq5qqjPDRqkawnGk65Kd25++Ofs0FXchsCWGfe5pHW/LCDZXkDkPgIIcV3LURI//TPR
         RxAaaIydNM6LNVk2dz6tvDhS4Pqb0RWwdwCH9OPiOUa1zD1FYLLggrSOvQfz4NVd4pOn
         iAMyN+dGLnEGTzLvTyL0szB8TJXg2F1bBnTf+3j+CTFm+bW1DQ8SEvrae0FoF8zEZdKX
         +kWyqmK+3vjvyMs7ps77NAR76uJHcNHR9MPEr3g68KZyrw40+jcuwXX76NUjydXRNNXs
         pYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=5IB53Xs/2hKp0H8hmKzOCHq/U8/msP66BqnWbS1nqPA=;
        b=VFv1TfBpE9ysItSKeYyA87NtOPW3bFgTx914cdRMYnMteu84iuJKqfoY25gtotr4Kj
         suoR+2e9Qaz2/A/E1jg57/ESoxc6JXO9oIAJSAezspE5FJ9PSGkkQDM+YzZ7P66C4kKy
         eWdWPKq6KolyQDmiq3ntb5T5BFGND2oXonT9S5MLiKkpmWUW21JIH6Warm3ozvq2gYZF
         tUmY8PvTNkNV1jtJHFsYLaPIn0ejCexpoKxf1fiyo9oRteSj/vk+l6NC3c0pDQ7IrhKJ
         3K+qrMBjom8audNQsVK55FWiaKu8t87JDr1IdYMn6L46oR06G7XC4wb9Uuspmv4lXh5K
         2QSg==
X-Gm-Message-State: AOUpUlG0vY/4o4y+CPw5f6JWw22l36i/G5SbJ//G76OpHzyQTThRb2SA
        CPot/KIqp6V4xK7zHz6PNWk=
X-Google-Smtp-Source: AA+uWPyvBsrR4/hn5iYIopdpYFPJacWqhOkIJNluR7bqn08tSRNHpsjGXwVGYEm7MakIA8Y1ahbf6A==
X-Received: by 2002:a62:4f5b:: with SMTP id d88-v6mr41747153pfb.225.1534619198814;
        Sat, 18 Aug 2018 12:06:38 -0700 (PDT)
Received: from Gentoo-PC ([117.204.240.63])
        by smtp.gmail.com with ESMTPSA id a17-v6sm8859358pfg.106.2018.08.18.12.06.37
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Aug 2018 12:06:38 -0700 (PDT)
Date:   Sun, 19 Aug 2018 00:36:40 +0530
From:   Bhaskar Singh <bhaskar.kernel@gmail.com>
To:     devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        bhaskar.kernel@gmail.com
Subject: [PATCH] staging: rtl8188eu: Removed a function and coded inline
Message-ID: <20180818190640.GA11687@Gentoo-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removed function named rtw_malloc2d.

I removed this function because this function is used exactly once and
function call have some overhead also.

Maybe this will improve code runtime slightly.

Signed-off-by: Bhaskar Singh <bhaskar.kernel@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_efuse.c        | 10 +++++++++-
 drivers/staging/rtl8188eu/include/osdep_service.h |  2 --
 drivers/staging/rtl8188eu/os_dep/osdep_service.c  | 14 --------------
 3 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_efuse.c b/drivers/staging/rtl8188eu/core/rtw_efuse.c
index 0fd306a808c4..befc99c197b1 100644
--- a/drivers/staging/rtl8188eu/core/rtw_efuse.c
+++ b/drivers/staging/rtl8188eu/core/rtw_efuse.c
@@ -86,12 +86,20 @@ efuse_phymap_to_logical(u8 *phymap, u16 _offset, u16 _size_byte, u8  *pbuf)
 	u16	**eFuseWord = NULL;
 	u16	efuse_utilized = 0;
 	u8 u1temp = 0;
+	int z;
+	void **a = NULL;
 
 	efuseTbl = kzalloc(EFUSE_MAP_LEN_88E, GFP_KERNEL);
 	if (!efuseTbl)
 		return;
 
-	eFuseWord = (u16 **)rtw_malloc2d(EFUSE_MAX_SECTION_88E, EFUSE_MAX_WORD_UNIT, sizeof(u16));
+	a = kzalloc(EFUSE_MAX_SECTION_88E * sizeof(void *) + EFUSE_MAX_SECTION_88E * EFUSE_MAX_WORD_UNIT * sizeof(u16), GFP_KERNEL);
+	if (!a)
+		goto out;
+	for (z = 0; z < EFUSE_MAX_SECTION_88E; z++)
+		a[z] = ((char *)(a + EFUSE_MAX_SECTION_88E)) + z * EFUSE_MAX_WORD_UNIT * sizeof(u16);
+out:
+	eFuseWord = (u16 **)a;
 	if (!eFuseWord) {
 		DBG_88E("%s: alloc eFuseWord fail!\n", __func__);
 		goto eFuseWord_failed;
diff --git a/drivers/staging/rtl8188eu/include/osdep_service.h b/drivers/staging/rtl8188eu/include/osdep_service.h
index fbcba79a0927..cfe5698fbbb1 100644
--- a/drivers/staging/rtl8188eu/include/osdep_service.h
+++ b/drivers/staging/rtl8188eu/include/osdep_service.h
@@ -64,8 +64,6 @@ static inline int rtw_netif_queue_stopped(struct net_device *pnetdev)
 u8 *_rtw_malloc(u32 sz);
 #define rtw_malloc(sz)			_rtw_malloc((sz))
 
-void *rtw_malloc2d(int h, int w, int size);
-
 void _rtw_init_queue(struct __queue *pqueue);
 
 struct rtw_netdev_priv_indicator {
diff --git a/drivers/staging/rtl8188eu/os_dep/osdep_service.c b/drivers/staging/rtl8188eu/os_dep/osdep_service.c
index 78daef6704ac..105f3f21bdea 100644
--- a/drivers/staging/rtl8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/rtl8188eu/os_dep/osdep_service.c
@@ -18,20 +18,6 @@ u8 *_rtw_malloc(u32 sz)
 	return kmalloc(sz, in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
 }
 
-void *rtw_malloc2d(int h, int w, int size)
-{
-	int j;
-	void **a = kzalloc(h * sizeof(void *) + h * w * size, GFP_KERNEL);
-
-	if (!a)
-		goto out;
-
-	for (j = 0; j < h; j++)
-		a[j] = ((char *)(a + h)) + j * w * size;
-out:
-	return a;
-}
-
 void _rtw_init_queue(struct __queue *pqueue)
 {
 	INIT_LIST_HEAD(&pqueue->queue);
-- 
2.16.4

