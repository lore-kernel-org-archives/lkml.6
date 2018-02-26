Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751989AbeBZBhI (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 20:37:08 -0500
Received: from mga05.intel.com ([192.55.52.43]:37648 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751918AbeBZBhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 20:37:05 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,395,1515484800";
   d="scan'208";a="20249928"
Date: Mon, 26 Feb 2018 09:36:42 +0800
From: kbuild test robot <lkp@intel.com>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: kbuild-all@01.org, Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, kernel@collabora.com,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        linux-omap@vger.kernel.org
Subject: Re: [alsa-devel] [PATCHv5 2/5] ASoC: codec: cpcap: new codec
Message-ID: <201802260921.u5yCEY8U%fengguang.wu@intel.com>
References: <20180223200254.25685-3-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223200254.25685-3-sebastian.reichel@collabora.co.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

I love your patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on v4.16-rc2 next-20180223]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Sebastian-Reichel/Motorola-Droid-4-Audio-Support/20180226-063007
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> sound/soc/codecs/cpcap.c:1406:54: sparse: restricted snd_pcm_format_t degrades to integer

vim +1406 sound/soc/codecs/cpcap.c

  1396	
  1397	static struct snd_soc_dai_driver cpcap_dai[] = {
  1398	{
  1399		.id = 0,
  1400		.name = "cpcap-hifi",
  1401		.playback = {
  1402			.stream_name = "HiFi Playback",
  1403			.channels_min = 2,
  1404			.channels_max = 2,
  1405			.rates = SNDRV_PCM_RATE_8000_48000,
> 1406			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FORMAT_S24_LE,
  1407		},
  1408		.ops = &cpcap_dai_hifi_ops,
  1409	},
  1410	{
  1411		.id = 1,
  1412		.name = "cpcap-voice",
  1413		.playback = {
  1414			.stream_name = "Voice Playback",
  1415			.channels_min = 1,
  1416			.channels_max = 1,
  1417			.rates = SNDRV_PCM_RATE_8000_48000,
  1418			.formats = SNDRV_PCM_FMTBIT_S16_LE,
  1419		},
  1420		.capture = {
  1421			.stream_name = "Voice Capture",
  1422			.channels_min = 1,
  1423			.channels_max = 2,
  1424			.rates = SNDRV_PCM_RATE_8000_48000,
  1425			.formats = SNDRV_PCM_FMTBIT_S16_LE,
  1426		},
  1427		.ops = &cpcap_dai_voice_ops,
  1428	},
  1429	};
  1430	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
