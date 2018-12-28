Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E86CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B90A2148E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999351;
	bh=kvJoL1kGpnpo9zQ9ePM2KACY6rH47R+1Vq1p2c3KW8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u1KUNCO4ikfdUOiF2TacIDcYPIuibANtZCd6HyGBdhNFhu2tkCPKklBrhQenRTjwP
	 tos4Fxn69y2CczPd8RQy486vwKAJ31WquQ+cHqzPcKGMGwgFz6s1sE0FJgyei0QhvY
	 KmcHC1hjHgwsJrtYWeXw38OFkWksVgBrWBatLdPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732542AbeL1MPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:15:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:34844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732518AbeL1MPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:15:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1851C20866;
        Fri, 28 Dec 2018 12:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999347;
        bh=kvJoL1kGpnpo9zQ9ePM2KACY6rH47R+1Vq1p2c3KW8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SQoFXWYgxswitd/IsQbBel5uD6qeuHzA37DvQIds69bzLDCxcCZg7kmZO3My0D7ll
         T91z7Tmt5lXn7YqTDOxjVpSMbD/TC7R+NiKSfa64Wl3Kf4na+atw5OXuCH41pm2nIA
         N9cDc5JLH6a98GCK2qcrDesTEgnEVxPPORx5k55k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Mark Brown <broonie@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 03/36] ASoC: sta32x: set ->component pointer in private struct
Date:   Fri, 28 Dec 2018 12:52:19 +0100
Message-Id: <20181228113126.748366261@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113126.526729877@linuxfoundation.org>
References: <20181228113126.526729877@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

commit 747df19747bc9752cd40b9cce761e17a033aa5c2 upstream

The ESD watchdog code in sta32x_watchdog() dereferences the pointer
which is never assigned.

This is a regression from a1be4cead9b950 ("ASoC: sta32x: Convert to direct
regmap API usage.") which went unnoticed since nobody seems to use that ESD
workaround.

Fixes: a1be4cead9b950 ("ASoC: sta32x: Convert to direct regmap API usage.")
Signed-off-by: Daniel Mack <daniel@zonque.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/sta32x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
index 5b888476d9ff..b728140c79a9 100644
--- a/sound/soc/codecs/sta32x.c
+++ b/sound/soc/codecs/sta32x.c
@@ -879,6 +879,9 @@ static int sta32x_probe(struct snd_soc_codec *codec)
 	struct sta32x_priv *sta32x = snd_soc_codec_get_drvdata(codec);
 	struct sta32x_platform_data *pdata = sta32x->pdata;
 	int i, ret = 0, thermal = 0;
+
+	sta32x->codec = codec;
+
 	ret = regulator_bulk_enable(ARRAY_SIZE(sta32x->supplies),
 				    sta32x->supplies);
 	if (ret != 0) {
-- 
2.19.1



