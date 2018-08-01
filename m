Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A59AC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 03:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC86220894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 03:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC86220894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731932AbeHAFbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 01:31:20 -0400
Received: from mga04.intel.com ([192.55.52.120]:3452 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbeHAFbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 01:31:19 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2018 20:47:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,430,1526367600"; 
   d="scan'208";a="245002270"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga005.jf.intel.com with ESMTP; 31 Jul 2018 20:47:48 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fki71-000Tny-FE; Wed, 01 Aug 2018 11:47:47 +0800
Date:   Wed, 1 Aug 2018 11:46:48 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Rohit kumar <rohitkr@codeaurora.org>
Cc:     kbuild-all@01.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz,
        srinivas.kandagatla@linaro.org, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rohit kumar <rohitkr@codeaurora.org>
Subject: Re: [PATCH v4 4/4] ASoC: qcom: add sdm845 sound card support
Message-ID: <201808011127.1snVqYkN%fengguang.wu@intel.com>
References: <1532945454-10437-5-git-send-email-rohitkr@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532945454-10437-5-git-send-email-rohitkr@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rohit,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on asoc/for-next]
[also build test WARNING on next-20180731]
[cannot apply to v4.18-rc7]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Rohit-kumar/Add-support-for-audio-on-SDM845-SoC/20180801-082203
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> sound/soc/qcom/sdm845.c:193:27: sparse: incorrect type in argument 2 (different base types) @@    expected unsigned int [unsigned] val @@    got restricted snd_unsigned int [unsigned] val @@
   sound/soc/qcom/sdm845.c:193:27:    expected unsigned int [unsigned] val
   sound/soc/qcom/sdm845.c:193:27:    got restricted snd_pcm_format_t [usertype] <noident>

vim +193 sound/soc/qcom/sdm845.c

   181	
   182	static int sdm845_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
   183					struct snd_pcm_hw_params *params)
   184	{
   185		struct snd_interval *rate = hw_param_interval(params,
   186						SNDRV_PCM_HW_PARAM_RATE);
   187		struct snd_interval *channels = hw_param_interval(params,
   188						SNDRV_PCM_HW_PARAM_CHANNELS);
   189		struct snd_mask *fmt = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
   190	
   191		rate->min = rate->max = DEFAULT_SAMPLE_RATE_48K;
   192		channels->min = channels->max = 2;
 > 193		snd_mask_set(fmt, SNDRV_PCM_FORMAT_S16_LE);
   194	
   195		return 0;
   196	}
   197	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
