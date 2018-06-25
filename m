Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D7AC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 318FE25AA2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:42:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 318FE25AA2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934194AbeFYNl6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:41:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:20588 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933976AbeFYNki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:40:38 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2018 06:40:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,270,1526367600"; 
   d="scan'208";a="235403596"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga005.jf.intel.com with ESMTP; 25 Jun 2018 06:40:24 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fXRjE-000Lg6-0J; Mon, 25 Jun 2018 21:40:24 +0800
Date:   Mon, 25 Jun 2018 21:39:29 +0800
From:   kbuild test robot <fengguang.wu@intel.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     kbuild-all@01.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] ASoC: dpcm: soc_dpcm_fe_runtime_update() can be static
Message-ID: <20180625133929.GA8885@lkp-wsm-ep2>
References: <20180625082923.25636-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625082923.25636-1-jbrunet@baylibre.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 8d13e13e7869 ("ASoC: dpcm: improve runtime update predictability")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 soc-pcm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 330de23..63f96cd 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2597,7 +2597,7 @@ static int dpcm_run_old_update(struct snd_soc_pcm_runtime *fe, int stream)
 	return ret;
 }
 
-int soc_dpcm_fe_runtime_update(struct snd_soc_pcm_runtime *fe, int new)
+static int soc_dpcm_fe_runtime_update(struct snd_soc_pcm_runtime *fe, int new)
 {
 	struct snd_soc_dapm_widget_list *list;
 	int count, paths;
