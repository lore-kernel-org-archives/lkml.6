Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75030C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207C020857
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rGdpuSdo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 207C020857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeICG4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 02:56:19 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33226 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbeICG4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 02:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8aXpBAgKvQuDVDLczrrpxprXJBDtjpCSkfQF58F0/wo=; b=rGdpuSdouDAhILtkDkz/nDckYo
        BLQEZZsBT3OsldbeRNdLi2DOqZHt/2/xY+8duf84a+ZaBHK1qn1NoV9i8eV/JwGAXSF6l3YfsXNFE
        LJRdqtb01LXa5Tg4adpVTNOVC5d3QQ38b/xyvkAOA5fIuBpkJ9zs/gl6ZJHCKIThs4wuSoFPIouBL
        f3RvHxNxiOCiqGoZMd0RRWoYRAqYr3a//9i2BKuo80nQJqysrU2iVtRFMVHnIZbxXZ9e/yWV7R478
        j/dKupjP8H9LM1wnDRQFWmV3Jj1KZq9EB/NEotkQvOMv2uO5abuw36i2n38OjtpFIT3+ETDSV0Wpz
        HRKcJ2wA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fwekl-0005VH-Dm; Mon, 03 Sep 2018 02:38:11 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] sound: soc: fix soc-core.c kernel-doc warning
Message-ID: <a75f4b8b-4e1c-bc73-1033-c49f4b30e4e5@infradead.org>
Date:   Sun, 2 Sep 2018 19:38:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc warning:

../sound/soc/soc-core.c:2918: warning: Excess function parameter 'legacy_dai_naming' description in 'snd_soc_register_dais'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c |    2 --
 1 file changed, 2 deletions(-)

--- lnx-419-rc2.orig/sound/soc/soc-core.c
+++ lnx-419-rc2/sound/soc/soc-core.c
@@ -2910,8 +2910,6 @@ static struct snd_soc_dai *soc_add_dai(s
  * @component: The component the DAIs are registered for
  * @dai_drv: DAI driver to use for the DAIs
  * @count: Number of DAIs
- * @legacy_dai_naming: Use the legacy naming scheme and let the DAI inherit the
- *                     parent's name.
  */
 static int snd_soc_register_dais(struct snd_soc_component *component,
 				 struct snd_soc_dai_driver *dai_drv, size_t count)


