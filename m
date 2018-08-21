Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2ACC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 01:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0654C2175D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 01:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxhpWU7z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0654C2175D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbeHUEUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 00:20:14 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40608 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725732AbeHUEUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 00:20:14 -0400
Received: by mail-pl0-f66.google.com with SMTP id s17-v6so7951678plp.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 18:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=J7IR1c2elDFWDAnSM4MPsm6zTi7GlE3DvX2Qvt8T3H0=;
        b=SxhpWU7z6vW1fFEgCl5iYRKLG6aTpMoGVJOYsGH89oh1W29DXiNqVNmHJETIHWR+Xa
         bj85iAFeHk2+aLVRta4fKhF6zmEF+Sdd4sSdZVP5zbdGM1yilfCXb9UZby0Eiu9Zrlmi
         Ei1lSYRdtByIJ6ndUuZuBSEcf2sXLXIgn00B6lmwehy4Pa80cnJRscof8F8HAadHQGsS
         EKD69FoSOL94CdLI4QetyiwDiv1eQ9bOd5muDeI4kegnPVzwY4BNwVGBeoLFxeaghrWm
         P3BmiV1pDZ0MEMFriufpJ6O0/eQGdY5P1iRbxnxSqedU6CwdMs/3LCAv2/bfDEV3fStw
         /2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=J7IR1c2elDFWDAnSM4MPsm6zTi7GlE3DvX2Qvt8T3H0=;
        b=C+V9rm4X6a5VbzdJY1APlC2WFqyU+fxlPdLZkl0yaBCl1rGVMoDzUTZ7CygsXgUKk7
         ZqTCrw6zOL32V5z0UY6D2kA5s/IExp6VvaD2G8HAqLsc7hsUYY17MbImLbj6uxXgxKbI
         4J/GMJORLQ1weWLnibLoyYloijWK9VoeR0KyrDYplM+Nm8x8H1f1tDhd0nXe1LI/Nm1f
         cYE/3TC/Muzp23v9bqUHz4D+z4S8kOaYFyBZE6QLGAEVQ1OboFKm7kHWhpjq9qH2ynJ+
         iN+fS2G0hDueTYof+gjWRi9ebEIbc9GsOESRVrDYrWA7Te2M29FpLJ7IJXHituAhRMDv
         oImw==
X-Gm-Message-State: AOUpUlFOvfTLj/LvfXcF/+uhxGEejMqQdy1bvBD6uhewheivmVfOLI3q
        gZZTja27p15mHt33A0hUX+U=
X-Google-Smtp-Source: AA+uWPwTsE5uajnD7GWsinB+wtdcum+pCan1LNgTdViaE7yLsb1TSzltzNF4JuP1eSTSD0k8g7TDyQ==
X-Received: by 2002:a17:902:7683:: with SMTP id m3-v6mr47585372pll.255.1534813340035;
        Mon, 20 Aug 2018 18:02:20 -0700 (PDT)
Received: from Gentoo-PC ([117.204.240.63])
        by smtp.gmail.com with ESMTPSA id o134-v6sm22303099pfg.74.2018.08.20.18.02.18
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 Aug 2018 18:02:19 -0700 (PDT)
Date:   Tue, 21 Aug 2018 06:32:22 +0530
From:   Bhaskar Singh <bhaskar.kernel@gmail.com>
To:     devel@driverdev.osuosl.org
Cc:     dan.carpenter@oracle.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, bhaskar.kernel@gmail.com
Subject: [PATCH v2] staging: rtl8188eu: Removed a function and coded inline
Message-ID: <20180821010222.GA6979@Gentoo-PC>
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

Changes in v2:
- Incorporated comments from Dan Carpenter.
---
 drivers/staging/rtl8188eu/core/rtw_efuse.c        |  8 ++++++--
 drivers/staging/rtl8188eu/include/osdep_service.h |  2 --
 drivers/staging/rtl8188eu/os_dep/osdep_service.c  | 14 --------------
 3 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_efuse.c b/drivers/staging/rtl8188eu/core/rtw_efuse.c
index 0fd306a808c4..ddd7f67fe5a2 100644
--- a/drivers/staging/rtl8188eu/core/rtw_efuse.c
+++ b/drivers/staging/rtl8188eu/core/rtw_efuse.c
@@ -86,16 +86,20 @@ efuse_phymap_to_logical(u8 *phymap, u16 _offset, u16 _size_byte, u8  *pbuf)
 	u16	**eFuseWord = NULL;
 	u16	efuse_utilized = 0;
 	u8 u1temp = 0;
+	void **tmp = NULL;
 
 	efuseTbl = kzalloc(EFUSE_MAP_LEN_88E, GFP_KERNEL);
 	if (!efuseTbl)
 		return;
 
-	eFuseWord = (u16 **)rtw_malloc2d(EFUSE_MAX_SECTION_88E, EFUSE_MAX_WORD_UNIT, sizeof(u16));
-	if (!eFuseWord) {
+	tmp = kzalloc(EFUSE_MAX_SECTION_88E * (sizeof(void *) + EFUSE_MAX_WORD_UNIT * sizeof(u16)), GFP_KERNEL);
+	if (!tmp) {
 		DBG_88E("%s: alloc eFuseWord fail!\n", __func__);
 		goto eFuseWord_failed;
 	}
+	for (i = 0; i < EFUSE_MAX_SECTION_88E; i++)
+		tmp[i] = ((char *)(tmp + EFUSE_MAX_SECTION_88E)) + i * EFUSE_MAX_WORD_UNIT * sizeof(u16);
+	eFuseWord = (u16 **)tmp;
 
 	/*  0. Refresh efuse init map as all oxFF. */
 	for (i = 0; i < EFUSE_MAX_SECTION_88E; i++)
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

