Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D84AECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 03:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C974220856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 03:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C974220856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbeGUE3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 00:29:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:13419 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726957AbeGUE3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 00:29:15 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jul 2018 20:38:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,382,1526367600"; 
   d="scan'208";a="56706280"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga008.fm.intel.com with ESMTP; 20 Jul 2018 20:38:04 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fgiia-000NlC-6K; Sat, 21 Jul 2018 11:38:04 +0800
Date:   Sat, 21 Jul 2018 11:37:52 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Daniel Kurtz <djkurtz@chromium.org>
Cc:     kbuild-all@01.org, Dylan Reid <dgreid@chromium.org>,
        Jimmy Cheng-Yi Chiang <cychiang@google.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: da7219: Allow pdata to specify a VDDIO
Message-ID: <201807211137.jmWeBTni%fengguang.wu@intel.com>
References: <20180721001235.164891-1-djkurtz@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180721001235.164891-1-djkurtz@chromium.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on asoc/for-next]
[also build test WARNING on v4.18-rc5 next-20180720]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Daniel-Kurtz/ASoC-da7219-Allow-pdata-to-specify-a-VDDIO/20180721-082411
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   sound/soc/codecs/da7219.c:440:44: sparse: cast to restricted __le16
   sound/soc/codecs/da7219.c:461:13: sparse: incorrect type in assignment (different base types) @@    expected unsigned short [unsigned] [usertype] val @@    got  short [unsigned] [usertype] val @@
   sound/soc/codecs/da7219.c:461:13:    expected unsigned short [unsigned] [usertype] val
   sound/soc/codecs/da7219.c:461:13:    got restricted __le16 [usertype] <noident>
   sound/soc/codecs/da7219.c:817:57: sparse: dubious: x & !y
   sound/soc/codecs/da7219.c:1427:16: sparse: incorrect type in assignment (different base types) @@    expected unsigned short [unsigned] [usertype] offset @@    got  short [unsigned] [usertype] offset @@
   sound/soc/codecs/da7219.c:1427:16:    expected unsigned short [unsigned] [usertype] offset
   sound/soc/codecs/da7219.c:1427:16:    got restricted __le16 [usertype] <noident>
>> sound/soc/codecs/da7219.c:1637:61: sparse: incorrect type in argument 3 (different base types) @@    expected char const **val @@    got uchar const **val @@
   sound/soc/codecs/da7219.c:1637:61:    expected char const **val
   sound/soc/codecs/da7219.c:1637:61:    got unsigned int *<noident>
   sound/soc/codecs/da7219.c: In function 'da7219_fw_to_pdata':
   sound/soc/codecs/da7219.c:1637:53: error: passing argument 3 of 'device_property_read_string' from incompatible pointer type [-Werror=incompatible-pointer-types]
     if (!device_property_read_string(dev, "dlg,vddio", &of_val32))
                                                        ^
   In file included from include/linux/acpi.h:28:0,
                    from sound/soc/codecs/da7219.c:14:
   include/linux/property.h:49:5: note: expected 'const char **' but argument is of type 'u32 * {aka unsigned int *}'
    int device_property_read_string(struct device *dev, const char *propname,
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +1637 sound/soc/codecs/da7219.c

  1607	
  1608	static struct da7219_pdata *da7219_fw_to_pdata(struct snd_soc_component *component)
  1609	{
  1610		struct device *dev = component->dev;
  1611		struct da7219_pdata *pdata;
  1612		const char *of_str;
  1613		u32 of_val32;
  1614	
  1615		pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
  1616		if (!pdata)
  1617			return NULL;
  1618	
  1619		pdata->wakeup_source = device_property_read_bool(dev, "wakeup-source");
  1620	
  1621		pdata->dai_clks_name = "da7219-dai-clks";
  1622		if (device_property_read_string(dev, "clock-output-names",
  1623						&pdata->dai_clks_name))
  1624			dev_warn(dev, "Using default clk name: %s\n",
  1625				 pdata->dai_clks_name);
  1626	
  1627		if (device_property_read_u32(dev, "dlg,micbias-lvl", &of_val32) >= 0)
  1628			pdata->micbias_lvl = da7219_fw_micbias_lvl(dev, of_val32);
  1629		else
  1630			pdata->micbias_lvl = DA7219_MICBIAS_2_2V;
  1631	
  1632		if (!device_property_read_string(dev, "dlg,mic-amp-in-sel", &of_str))
  1633			pdata->mic_amp_in_sel = da7219_fw_mic_amp_in_sel(dev, of_str);
  1634		else
  1635			pdata->mic_amp_in_sel = DA7219_MIC_AMP_IN_SEL_DIFF;
  1636	
> 1637		if (!device_property_read_string(dev, "dlg,vddio", &of_val32))
  1638			pdata->vddio = of_val32;
  1639	
  1640		return pdata;
  1641	}
  1642	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
