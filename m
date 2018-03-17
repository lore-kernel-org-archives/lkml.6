Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752467AbeCQLT4 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 07:19:56 -0400
Received: from mga17.intel.com ([192.55.52.151]:47799 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751829AbeCQLTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 07:19:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,319,1517904000";
   d="scan'208";a="28791803"
Date: Sat, 17 Mar 2018 19:19:51 +0800
From: kbuild test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@bootlin.com>
Cc: kbuild-all@01.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexandre.belloni@bootlin.com, thomas.petazzoni@bootlin.com,
        mylene.josserand@bootlin.com, michael@amarulasolutions.com
Subject: Re: [PATCH v3 1/2] ASoC: codecs: Add support for PCM1789
Message-ID: <201803171907.vbmkB7Z8%fengguang.wu@intel.com>
References: <20180315161825.5524-2-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180315161825.5524-2-mylene.josserand@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mylène,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v4.16-rc4]
[also build test WARNING on next-20180316]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Myl-ne-Josserand/ASoC-codecs-Add-support-for-PCM1789/20180317-174449


coccinelle warnings: (new ones prefixed by >>)

>> sound/soc/codecs/pcm1789.c:265:1-3: ERROR: test of a variable/field address

vim +265 sound/soc/codecs/pcm1789.c

   260	
   261	int pcm1789_common_exit(struct device *dev)
   262	{
   263		struct pcm1789_private *priv = dev_get_drvdata(dev);
   264	
 > 265		if (&priv->work)
   266			flush_work(&priv->work);
   267	
   268		return 0;
   269	}
   270	EXPORT_SYMBOL_GPL(pcm1789_common_exit);
   271	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
