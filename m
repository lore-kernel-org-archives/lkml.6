Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90683C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557E92173B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfBGQlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:41:20 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:46679 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfBGQlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:41:19 -0500
Received: from orion.localdomain ([77.2.6.87]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MV5nC-1giOYG0aBi-00S5EA; Thu, 07 Feb 2019 17:41:14 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-kbuild@vger.kernel.org, kernel-janitors@vger.kernel.org,
        yamada.masahiro@socionext.com, michal.lkml@markovi.net
Subject: [PATCH 3/4] scripts: mkdebian: fix dependencies
Date:   Thu,  7 Feb 2019 17:40:58 +0100
Message-Id: <1549557659-19137-4-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1549557659-19137-1-git-send-email-info@metux.net>
References: <1549557659-19137-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:AUoy8TkN5dDogJARMRk5ar9tO1L11+vfi5kral5QPfEme6pbtiP
 SHanJLdXxOp97fHKMaZ6dMSSlK/lXXNRawUk5rJ8Cye9fNyxz6CZgaub0evK0/3rZHDkgBJ
 WSeU8J3urd5nK0ILR9la1X+HDOJmTVanVbyat89mFy9bstjSBGID/N/en3pn07+imWco9JP
 g7RHyQad3N0dmaMWmo8Rg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BJL+FSEfAxY=:6cQ2kVxPBiR67I7G7sb5iv
 svGoCXxW76SFq2opn7rAZqDhIm1P3rIAZ+YjLTL8KRb4VNJew7Hip1KC12E0RnFgN04fjLV3g
 nIyqgSoXtNCTqqwq3eoXbWx60V8Zs/DFCYjrzwZl8n/UFwg2/P8nDsq6MSpuBurgmRdHoRWLN
 fs1G9wnKv4lhPLnQxP2yQmLlv01Nlcv69c4c7pl6cMmH7V84WoOxHczVUPSS0ansF6tDwM/MH
 aiZWN5Son8UVatPz4/iyiIz82Ux/8WJF/7YkhVAfPKOHCszqGk+UW2JxDlVlOOoAUV09xShvb
 3Zr5h007dZKEOgGxwjDnll2ue3DBU3c0GuiWtntM32QKMRK5PeVzeMRl8weL1gjDIn58denH3
 I3SeHidV2iUJryJ8b4s9bbGcAL0lbIzS9XzEWwCeMB5mFz/JyB7+56ybbe294zaavFT6G5TxZ
 3A4h5VO5GJ8ThNQpYLIVgOA+NEt9z5FVhepjUFlonppdR5VCXLwt7lhqllO0OnyYe31pVj5Mf
 0v5Or78RXFnJNfKIUM2kcB/6hKPpLjK//sRLtv0ASZX0VkXpFNnvZSS57gLEvDwHVTDpuSQ/h
 H3i9b+6nyurFI/tglgAgV/JAF0SCCYW5LR2kSYFEZfpDDEqBbeBBbLsfWa0PM1hqABDSKLyX6
 LDI9qojBGqDGL1sJqmlOBJ5YcpZUTPJRiLjNxxApY2KrSXtiF5Subpqf5Y67isoXyyVC61T+S
 Hc3H//z/XT7WDajB0DJUmfADw6dUOReAvAcO+Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We missed some build dependencies in the generated debian/control file.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 scripts/package/mkdebian | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index ff226be..1caaf0b 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -173,7 +173,7 @@ Source: $sourcename
 Section: kernel
 Priority: optional
 Maintainer: $maintainer
-Build-Depends: bc, kmod, cpio
+Build-Depends: bc, kmod, cpio, bison, libelf-dev, libssl-dev, flex
 Homepage: http://www.kernel.org/
 
 Package: $packagename
-- 
1.9.1

