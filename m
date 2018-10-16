Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA059C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34B021477
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfHrpF4D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34B021477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbeJQBEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:04:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbeJQBEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:04:41 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37F4D2098A;
        Tue, 16 Oct 2018 17:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539709998;
        bh=MwZkWSfpphUA48rb4LlAInZeTEttD43J/tmPL4Br0/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kfHrpF4D+cmWzcCVC9Lk3BfXTM+jDxMzhLQlJsBJDSAoKbg74byFjFPCj5n2n0P/z
         I4XJDjeNOvGsJOQH0RPwkbLApyf30NHE9NIvae7Re/b6B4LraUga1i5vNJ3tRSl6vR
         jJF/mK8rQx442eo76q9EIers7L2OipUGNfEsZg+g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ryan Lee <ryans.lee@maximintegrated.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 068/135] ASoC: max98373: Added 10ms sleep after amp software reset
Date:   Tue, 16 Oct 2018 19:04:58 +0200
Message-Id: <20181016170519.270818105@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ryan Lee <ryans.lee@maximintegrated.com>

[ Upstream commit ca917f9fe1a0fab3dde41bba4bbd173c5a3c5805 ]

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/max98373.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -729,6 +729,7 @@ static int max98373_probe(struct snd_soc
 	/* Software Reset */
 	regmap_write(max98373->regmap,
 		MAX98373_R2000_SW_RESET, MAX98373_SOFT_RESET);
+	usleep_range(10000, 11000);
 
 	/* IV default slot configuration */
 	regmap_write(max98373->regmap,
@@ -817,6 +818,7 @@ static int max98373_resume(struct device
 
 	regmap_write(max98373->regmap,
 		MAX98373_R2000_SW_RESET, MAX98373_SOFT_RESET);
+	usleep_range(10000, 11000);
 	regcache_cache_only(max98373->regmap, false);
 	regcache_sync(max98373->regmap);
 	return 0;


