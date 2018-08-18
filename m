Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69926C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 14:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF6A21757
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 14:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRrT//9l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF6A21757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbeHRRcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 13:32:01 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37640 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbeHRRcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 13:32:01 -0400
Received: by mail-pf1-f194.google.com with SMTP id a26-v6so4723848pfo.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 07:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=XdQ8FVmW3444r3BVNXAff1EPdVB0f6ObPDRCXRcCTs4=;
        b=CRrT//9l+j4jhFMOalOgwFmX/r3+d2MD5WW+hHnx8I5+2wOLElf8+Yn0faNclJDvlW
         TvVWcaytJJ15etJHIl+thfPak1+3cSGesG5xacMgsMWXpkFCCt3P47lVMImBuxx0kmLQ
         +JLaLFl2OOY76z9vgxvK4nqH2pBgITg8V0ZYpl17+Wr56VsIVGTY4XhBJGe+v5AVXEAu
         m8IF0mw5Q87KyzdmnlBlGsghr93xTWw7eL49MTre/YvxEih33eaau8XVPUsNxNXj03Hn
         juNDc27e/eleQFmysH2a5Nwp+x/cTvuDu91c33Id+LU8fG313e09y2fhdIXTa6cCxIrt
         iNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XdQ8FVmW3444r3BVNXAff1EPdVB0f6ObPDRCXRcCTs4=;
        b=sSNn+BhCG+a1KDEDARDjl6sJmFDkXj+4zK1X2qD/euZRekZYnwKDHRytzqR2a3lxHT
         NQ9YP18C5u5hkqkLrkWhSUsOmmiVAvLyZ9TVKgBq+rY8YEJRSMsInZqTIzyPZcp6+zDM
         d1yKpEMS1bLycsWngpt7GVgNkVdsseYf7g3qEwNQkPz+NZbGQ/sCLrGH1gKxt4V4Ucms
         jjEiwYWDpqtUlkkNRhbtKcawzK/f7D9bZ4mXY9DIZfcDcySHJB/YrBhUfI8n2Ln0fnfW
         3VcawfBrEc3jrT6eqieqFtzZrVf1dpzsdSaZVLSMp9QqLPXWROFENtioEOHpsjnh5KdL
         EOYQ==
X-Gm-Message-State: AOUpUlFtI/mEbNWZ2Xhg26FPSeB9zg4J2ckLV26O/GVQZcMCIFengJE7
        a/ey4Pe06qJQqhCsCo11nYU=
X-Google-Smtp-Source: AA+uWPzoQZt8TjlFs2LkC3R+8O+fLQtsZLQ6zQsMzZQCyN8o7mp7qqjDgk039lcXd+95gZyFfn7/Xw==
X-Received: by 2002:a62:4494:: with SMTP id m20-v6mr40623479pfi.205.1534602248876;
        Sat, 18 Aug 2018 07:24:08 -0700 (PDT)
Received: from Gentoo-PC ([117.204.240.63])
        by smtp.gmail.com with ESMTPSA id 9-v6sm7254926pfc.20.2018.08.18.07.24.06
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Aug 2018 07:24:07 -0700 (PDT)
Date:   Sat, 18 Aug 2018 19:54:09 +0530
From:   Bhaskar Singh <bhaskar.kernel@gmail.com>
To:     devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        bhaskar.kernel@gmail.com
Subject: [PATCH] staging: rtl8188eu: Type cast function argument
Message-ID: <20180818142409.GA17122@Gentoo-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch might suppress some warrning.

The function prototype of rtw_malloc2d is

void *rtw_malloc2d(int h, int w, int size)

This patch also resolves the checkpatch.pl warning

WARNING: line over 80 characters

Signed-off-by: Bhaskar Singh <bhaskar.kernel@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_efuse.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_efuse.c b/drivers/staging/rtl8188eu/core/rtw_efuse.c
index 0fd306a808c4..735d654b2844 100644
--- a/drivers/staging/rtl8188eu/core/rtw_efuse.c
+++ b/drivers/staging/rtl8188eu/core/rtw_efuse.c
@@ -91,7 +91,8 @@ efuse_phymap_to_logical(u8 *phymap, u16 _offset, u16 _size_byte, u8  *pbuf)
 	if (!efuseTbl)
 		return;
 
-	eFuseWord = (u16 **)rtw_malloc2d(EFUSE_MAX_SECTION_88E, EFUSE_MAX_WORD_UNIT, sizeof(u16));
+	eFuseWord = (u16 **)rtw_malloc2d(EFUSE_MAX_SECTION_88E,
+			EFUSE_MAX_WORD_UNIT, (int)sizeof(u16));
 	if (!eFuseWord) {
 		DBG_88E("%s: alloc eFuseWord fail!\n", __func__);
 		goto eFuseWord_failed;
-- 
2.16.4

