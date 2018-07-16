Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FE3ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94134208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94134208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbeGPJ52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 05:57:28 -0400
Received: from mout.web.de ([212.227.15.14]:49935 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727677AbeGPJ52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 05:57:28 -0400
Received: from lab-pc05.sra.uni-hannover.de ([130.75.33.87]) by smtp.web.de
 (mrweb004 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0MFeoH-1frLea18TN-00EfqU; Mon, 16 Jul 2018 11:30:45 +0200
From:   Matthias Wolf <der_wolf_@web.de>
To:     devel@driverdev.osuosl.org
Cc:     linux-kernel@i4.cs.fau.de, Matthias Wolf <der_wolf_@web.de>,
        Felix Siegel <felix.siegel@stud.uni-hannover.de>,
        Tim Cofala <cofala@stud.uni-hannover.de>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: fbtft: Fix line continuation
Date:   Mon, 16 Jul 2018 11:30:00 +0200
Message-Id: <1531733420-25438-2-git-send-email-der_wolf_@web.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531733420-25438-1-git-send-email-der_wolf_@web.de>
References: <1531733420-25438-1-git-send-email-der_wolf_@web.de>
X-Provags-ID: V03:K1:EvCKBAhJwz+o3UQiWQqtRF9DaL5GvGFDTPW0LcrADoI0kHq60ti
 CuMegf/ws18yMBK9HTnsETPRR4spGFungF/qlW/F4eEXfM9xQpcans1pWnib/Zym/C+1PW+
 WUxJMvQ10M2iZpVBNBrsua9diovR7GtDQxXwa/6BuNNTXaMWkys7nGB71/MfYFnZ0a18i7T
 dTbPudyI0ciMGK4poslBA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eBYXwcc/V9M=:ZazZWlJ8YzuseOiPWFrR9l
 AgqudQdfLvGg1OEV9sr4gDqe64vy4p3sba7jtv2aoOH7Kqg8+1g0eKBPxEirhnR91kfz96Wzy
 cp2xPs6P5EhIxqB0tC49icWcOc3T7hShyfB11DHwUZvpaP9UFHAtjtgTjP39dXHjykLWPbP4C
 m2V43mrRaBSLnoJaYJZLMTu3BV7GLfVmggY9DIqxc37JvB61TjhXfaPk7WFrIAEHgoL+VXMEO
 pIMCr/G0jzX0iW76nnbDVfOdzOUd70buw6bSFhqrqKiAebCWavWrwagpgI2+P7kL7LIlu5wuL
 4AMXFdIe8nEPV5GiiTineCZYedN7YWMWi3n85MFj93jSZq4b54kT1gC0n6ncuC5SyZppWEzrs
 j47/64UZ8lnZ/L7eBqDxR1emdT1VpoytHvqYs4WRkRqBi4W5EBqL07sLKO+95sr9WJI9U/YpR
 PrbKAuHakncptr1fSHwwq1wkweo30DcZI1D1pdkA78BG78Cb6i5Fdom1zdL5yKuIrRC7j6WVc
 MUitkG2gujEAUsxxQF0adcOxyh0/NPEbFKCbxeM49VmkgYez9KATwY3v83kfBVoDg1WXa08dY
 LiJA9LKd1RF7FuuJ8fNCTb34Cb/sAgvGQJ+TBbWQsxo2Fvwog6E0x5wVNPW94eIz1ewdEewej
 B2fajjciT3EY0UieS4nVKuBIr9IivxcjKgNI8NnrzRbCtDp/jFTmGvimS37son3I+WoKcL36L
 NgnDb9ccZM+T66xA+uK5gPuYKrhLTj+mvYTcqAG3ybpXB6VZihl1F1DTqBo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warning: avoid unnecessary line continuation
to allow grepping of whole error message.

Signed-off-by: Matthias Wolf <der_wolf_@web.de>
Signed-off-by: Felix Siegel <felix.siegel@stud.uni-hannover.de>
Signed-off-by: Tim Cofala <cofala@stud.uni-hannover.de>
---
 drivers/staging/fbtft/fb_ssd1351.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ssd1351.c b/drivers/staging/fbtft/fb_ssd1351.c
index b8ef75f..1b92691 100644
--- a/drivers/staging/fbtft/fb_ssd1351.c
+++ b/drivers/staging/fbtft/fb_ssd1351.c
@@ -126,16 +126,14 @@ static int set_gamma(struct fbtft_par *par, u32 *curves)
 	for (i = 0; i < 63; i++) {
 		if (i > 0 && curves[i] < 2) {
 			dev_err(par->info->device,
-				"Illegal value in Grayscale Lookup Table at index %d. " \
-				"Must be greater than 1\n", i);
+				"Illegal value in Grayscale Lookup Table at index %d. Must be greater than 1\n", i);
 			return -EINVAL;
 		}
 		acc += curves[i];
 		tmp[i] = acc;
 		if (acc > 180) {
 			dev_err(par->info->device,
-				"Illegal value(s) in Grayscale Lookup Table. " \
-				"At index=%d, the accumulated value has exceeded 180\n", i);
+				"Illegal value(s) in Grayscale Lookup Table. At index=%d, the accumulated value has exceeded 180\n", i);
 			return -EINVAL;
 		}
 	}
-- 
2.7.4

