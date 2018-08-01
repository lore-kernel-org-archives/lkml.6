Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5462C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690DC20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 690DC20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387663AbeHAVe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 17:34:26 -0400
Received: from gateway22.websitewelcome.com ([192.185.46.233]:26729 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387414AbeHAVe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 17:34:26 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id B9BC7BEB8
        for <linux-kernel@vger.kernel.org>; Wed,  1 Aug 2018 14:47:04 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id kx5MfGnTCRPojkx5Mfm31a; Wed, 01 Aug 2018 14:47:04 -0500
X-Authority-Reason: nr=8
Received: from [189.250.61.218] (port=37620 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fkx5M-0049WO-0e; Wed, 01 Aug 2018 14:47:04 -0500
Date:   Wed, 1 Aug 2018 14:47:01 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        patches@opensource.cirrus.com, Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 00/11] ASoC: codecs: Mark expected switch fall-throughs
Message-ID: <cover.1533151956.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.61.218
X-Source-L: No
X-Exim-ID: 1fkx5M-0049WO-0e
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.61.218]:37620
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

In preparation to enabling -Wimplicit-fallthrough, this patchset aims
to add some annotations in order to mark switch cases where we are
expecting to fall through.

Thanks

Gustavo A. R. Silva (11):
  ASoC: wm8961: Mark expected switch fall-through
  ASoC: rt5640: Mark expected switch fall-through
  ASoC: rt5677: Mark expected switch fall-through
  ASoC: wm8955: Mark expected switch fall-through
  ASoC: wm8960: Mark expected switch fall-through
  ASoC: wm8904: Mark expected switch fall-through
  ASoC: wm8996: Mark expected switch fall-through
  ASoC: wm8962: Mark expected switch fall-through
  ASoC: wm8995: Mark expected switch fall-through
  ASoC: wm9081: Mark expected switch fall-through
  ASoC: wm8994: Mark expected switch fall-through

 sound/soc/codecs/rt5640.c | 2 ++
 sound/soc/codecs/rt5677.c | 1 +
 sound/soc/codecs/wm8904.c | 1 +
 sound/soc/codecs/wm8955.c | 1 +
 sound/soc/codecs/wm8960.c | 1 +
 sound/soc/codecs/wm8961.c | 1 +
 sound/soc/codecs/wm8962.c | 1 +
 sound/soc/codecs/wm8994.c | 1 +
 sound/soc/codecs/wm8995.c | 1 +
 sound/soc/codecs/wm8996.c | 1 +
 sound/soc/codecs/wm9081.c | 1 +
 11 files changed, 12 insertions(+)

-- 
2.7.4

