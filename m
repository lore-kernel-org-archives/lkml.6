Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CE4C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2AD2176D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C2AD2176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbeHCSYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 14:24:40 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.212]:19193 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727171AbeHCSYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 14:24:40 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 2D159400D3A6A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Aug 2018 11:27:39 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id lcusfZCqWbXuJlcvDfyx8P; Fri, 03 Aug 2018 11:27:38 -0500
X-Authority-Reason: nr=8
Received: from [189.250.50.82] (port=51052 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1flcuq-003DA4-HH; Fri, 03 Aug 2018 11:27:00 -0500
Date:   Fri, 3 Aug 2018 11:26:59 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     linux-kernel@vger.kernel.org, Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linuxppc-dev@lists.ozlabs.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        linux-omap@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 0/7] ASoC: Mark expected switch fall-throughs
Message-ID: <cover.1533312229.git.gustavo@embeddedor.com>
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
X-Source-IP: 189.250.50.82
X-Source-L: No
X-Exim-ID: 1flcuq-003DA4-HH
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.50.82]:51052
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
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

Gustavo A. R. Silva (7):
  ASoC: davinci-i2s: mark expected switch fall-through
  ASoC: fsl_esai: Mark expected switch fall-through
  ASoC: Intel: skl-pcm: Mark expected switch fall-through
  ASoC: omap-dmic: Mark expected switch fall-throughs
  ASoC: omap-mcpdm: MArk expected switch fall-throughs
  ASoC: samsung: i2s: Mark expected switch fall-through
  ASoC: core: mark expected switch fall-through

 sound/soc/davinci/davinci-i2s.c   | 1 +
 sound/soc/fsl/fsl_esai.c          | 1 +
 sound/soc/intel/skylake/skl-pcm.c | 1 +
 sound/soc/omap/omap-dmic.c        | 2 ++
 sound/soc/omap/omap-mcpdm.c       | 4 ++++
 sound/soc/samsung/i2s.c           | 1 +
 sound/soc/soc-core.c              | 1 +
 7 files changed, 11 insertions(+)

-- 
2.7.4

