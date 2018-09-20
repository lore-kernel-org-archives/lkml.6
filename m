Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78331C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBDE21531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECBDE21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732441AbeITRVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 13:21:43 -0400
Received: from mga11.intel.com ([192.55.52.93]:12787 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbeITRVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 13:21:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 04:38:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,398,1531810800"; 
   d="gz'50?scan'50,208,50";a="91758919"
Received: from unknown (HELO lkp-server01) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 20 Sep 2018 04:38:37 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1g2xGw-000Cht-21; Thu, 20 Sep 2018 19:37:26 +0800
Date:   Thu, 20 Sep 2018 19:36:37 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
        dgreid@chromium.org, ryans.lee@maximintegrated.com,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: Re: [alsa-devel] [PATCH 2/2] ASoC: max98927: Add reset-gpio support
Message-ID: <201809201913.3T3u3Gey%fengguang.wu@intel.com>
References: <20180912121955.33048-2-cychiang@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <20180912121955.33048-2-cychiang@chromium.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Cheng-Yi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on asoc/for-next]
[also build test ERROR on v4.19-rc4 next-20180919]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Cheng-Yi-Chiang/ASoC-max9892x-Add-documentation-for-reset-gpio-support/20180914-010006
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
config: x86_64-randconfig-s3-09201857 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   sound/soc/codecs/max98927.c: In function 'max98927_i2c_toggle_reset':
>> sound/soc/codecs/max98927.c:884:2: error: implicit declaration of function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
     gpiod_set_value_cansleep(max98927->reset_gpio, 1);
     ^~~~~~~~~~~~~~~~~~~~~~~~
     gpio_set_value_cansleep
>> sound/soc/codecs/max98927.c:902:2: error: implicit declaration of function 'devm_gpiod_put'; did you mean 'devm_gpio_free'? [-Werror=implicit-function-declaration]
     devm_gpiod_put(dev, max98927->reset_gpio);
     ^~~~~~~~~~~~~~
     devm_gpio_free
   sound/soc/codecs/max98927.c: In function 'max98927_i2c_probe':
>> sound/soc/codecs/max98927.c:950:25: error: implicit declaration of function 'devm_gpiod_get_optional'; did you mean 'devm_gpio_request_one'? [-Werror=implicit-function-declaration]
     max98927->reset_gpio = devm_gpiod_get_optional(
                            ^~~~~~~~~~~~~~~~~~~~~~~
                            devm_gpio_request_one
>> sound/soc/codecs/max98927.c:951:24: error: 'GPIOD_OUT_LOW' undeclared (first use in this function); did you mean 'GPIOF_INIT_LOW'?
       &i2c->dev, "reset", GPIOD_OUT_LOW);
                           ^~~~~~~~~~~~~
                           GPIOF_INIT_LOW
   sound/soc/codecs/max98927.c:951:24: note: each undeclared identifier is reported only once for each function it appears in
   cc1: some warnings being treated as errors

vim +884 sound/soc/codecs/max98927.c

   873	
   874	static int max98927_i2c_toggle_reset(struct device *dev,
   875					     struct max98927_priv *max98927)
   876	{
   877		/*
   878		 * If we do not have reset gpio, assume platform firmware
   879		 * controls the regulator and toggles it for us.
   880		 */
   881		if (!max98927->reset_gpio)
   882			return 0;
   883	
 > 884		gpiod_set_value_cansleep(max98927->reset_gpio, 1);
   885	
   886		/*
   887		 * We need to wait a bit before we are allowed to release reset GPIO.
   888		 */
   889		usleep_range(MAX98927_MIN_RESET_US, MAX98927_MIN_RESET_US + 5);
   890	
   891		gpiod_set_value_cansleep(max98927->reset_gpio, 0);
   892	
   893		/*
   894		 * We need to wait a bit before I2C communication is available.
   895		 */
   896		usleep_range(MAX98927_RELEASE_RESET_DELAY_US,
   897			     MAX98927_RELEASE_RESET_DELAY_US + 5);
   898	
   899		/*
   900		 * Release reset GPIO because we are not going to use it.
   901		 */
 > 902		devm_gpiod_put(dev, max98927->reset_gpio);
   903	
   904		return 0;
   905	}
   906	
   907	static bool max98927_is_first_to_reset(struct max98927_priv *max98927)
   908	{
   909		struct max98927_priv *p;
   910	
   911		if (!max98927->reset_gpio)
   912			return false;
   913	
   914		list_for_each_entry(p, &reset_list, list) {
   915			if (max98927->reset_gpio == p->reset_gpio)
   916				return false;
   917		}
   918	
   919		return true;
   920	}
   921	
   922	static int max98927_i2c_probe(struct i2c_client *i2c,
   923		const struct i2c_device_id *id)
   924	{
   925	
   926		int ret = 0, value;
   927		int reg = 0;
   928		struct max98927_priv *max98927 = NULL;
   929	
   930		max98927 = devm_kzalloc(&i2c->dev,
   931			sizeof(*max98927), GFP_KERNEL);
   932	
   933		if (!max98927) {
   934			ret = -ENOMEM;
   935			return ret;
   936		}
   937		i2c_set_clientdata(i2c, max98927);
   938	
   939		/* update interleave mode info */
   940		if (!of_property_read_u32(i2c->dev.of_node,
   941			"interleave_mode", &value)) {
   942			if (value > 0)
   943				max98927->interleave_mode = 1;
   944			else
   945				max98927->interleave_mode = 0;
   946		} else
   947			max98927->interleave_mode = 0;
   948	
   949		/* Gets optional GPIO for reset line. */
 > 950		max98927->reset_gpio = devm_gpiod_get_optional(
 > 951				&i2c->dev, "reset", GPIOD_OUT_LOW);
   952		if (IS_ERR(max98927->reset_gpio)) {
   953			ret = PTR_ERR(max98927->reset_gpio);
   954			dev_err(&i2c->dev, "error getting reset gpio: %d\n", ret);
   955			return ret;
   956		}
   957	
   958		/*
   959		 * Only toggle reset line for the first instance when the
   960		 * reset line is shared among instances. For example,
   961		 * left and right amplifier share the same reset line, and
   962		 * we should only toggle the reset line once.
   963		 */
   964		if (max98927_is_first_to_reset(max98927)) {
   965			dev_info(&i2c->dev, "%s: toggle reset line\n", __func__);
   966			ret = max98927_i2c_toggle_reset(&i2c->dev, max98927);
   967			if (ret)
   968				return ret;
   969		}
   970	
   971		/* regmap initialization */
   972		max98927->regmap
   973			= devm_regmap_init_i2c(i2c, &max98927_regmap);
   974		if (IS_ERR(max98927->regmap)) {
   975			ret = PTR_ERR(max98927->regmap);
   976			dev_err(&i2c->dev,
   977				"Failed to allocate regmap: %d\n", ret);
   978			return ret;
   979		}
   980	
   981		/* Check Revision ID */
   982		ret = regmap_read(max98927->regmap,
   983			MAX98927_R01FF_REV_ID, &reg);
   984		if (ret < 0) {
   985			dev_err(&i2c->dev,
   986				"Failed to read: 0x%02X\n", MAX98927_R01FF_REV_ID);
   987			return ret;
   988		}
   989		dev_info(&i2c->dev, "MAX98927 revisionID: 0x%02X\n", reg);
   990	
   991		/* voltage/current slot configuration */
   992		max98927_slot_config(i2c, max98927);
   993	
   994		/* codec registeration */
   995		ret = devm_snd_soc_register_component(&i2c->dev,
   996			&soc_component_dev_max98927,
   997			max98927_dai, ARRAY_SIZE(max98927_dai));
   998		if (ret < 0)
   999			dev_err(&i2c->dev, "Failed to register component: %d\n", ret);
  1000	
  1001		list_add(&max98927->list, &reset_list);
  1002	
  1003		return ret;
  1004	}
  1005	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--cNdxnHkX5QqsyA0e
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICCKFo1sAAy5jb25maWcAjFzdc9u2sn/vX6FJX9o5k9Z2HDW9d/wAkqCEiiQYAJQsv3Ac
W8nx1LFzZPm0+e/vLkCKALhUb6Zzjold4nOx+9sP6scffpyx18Pz19vDw93t4+P32Zfd025/
e9jdzz4/PO7+d5bJWSXNjGfC/ALMxcPT69+//v1h3s4vZ5e/nP/+y9nb/d272Wq3f9o9ztLn
p88PX16hg4fnpx9+/AH++xEav36Dvvb/M/tyd/f2t9lP2e7Tw+3T7Ldf3sHb5z+7P4A1lVUu
Fm2atkK3izS9+t43wUO75koLWV39dvbu7OzIW7BqcSQNzbLSRjWpkUoPvQj1sd1ItRpakkYU
mRElb/m1YUnBWy2VGehmqTjLWlHlEv6nNUzjy3ZVC7tRj7OX3eH12zD5RMkVr1pZtbqsvaEr
YVperVumFm0hSmGu3l3g3vTzLWsBoxuuzezhZfb0fMCO+7cLmbKiX+SbN1Rzyxojo4W1mhXG
41+yNW9XXFW8aBc3wpueT0mAckGTipuS0ZTrm6k35BThEgjHDfBm5a8/ptu5nWLAGZ6iX98Q
2xvMddzjJfFKxnPWFKZdSm0qVvKrNz89PT/tfn4zvK+3ei3qlJxNLbW4bsuPDW84yZAqqXVb
8lKqbcuMYemS5Gs0L0RCklgDd5aYuj0FptKl44BpghQVvVjDHZm9vH56+f5y2H0dxHrBK65E
aq9QrWTCvbvpkfRSbsL7lsmSiYpqa5eCK5zHlu6rZEbBJsHcQMzhItNcimuu1szgFShlxsOR
cqlSnnXXWFSLgaprpjRHJv/M/Z4znjSLXBM7mMKMVlo20He7YSZdZtLr2W6tz5Ix490an7Jm
hQAqbwumTZtu04LYV6ue1sMxRWTbH1/zyuiTRNRMLEthoNNsJZwMy/5oSL5S6rapccq9vJiH
r7v9CyUyRqQr0IMcZMLrqpLt8gb1XSkrf+ehsYYxZCZSYsfdWyKz+3N8x7aSsr8UiyWKht08
RZ1hrTgvawN9VEGffftaFk1lmNrS99dxneg3lfB6v0lp3fxqbl/+nB1gt2a3T/ezl8Pt4WV2
e3f3/Pp0eHj6Em0bvNCy1PbhpPY48looE5HxeIiZoAxb2aE7SnSGNznloGeAw5DrRIOnDTPB
DtolqbSZaerQq20LNH8keATzCqdL7Zd2zP7rURNOoQ2anHFLRHXhQQSxcn+MW+wyh+ZCYg85
6CqRm6uLs+HkRGVWYDNzHvGcvwt0ZwPYwmGFdAnKxV6e6Prrpq4BSOi2akrWJgxQShqoH8u1
YZUBorHdNFXJ6tYUSZsXjV5OdQhzPL/44KmThZJNrf39BquRLmirYpndvE8x1CLTp+gqm7Cy
HT2HS3DD1SmWZbPgsNhTLBlfi3TCPDoOuAeTotsvhav89CCg5UkGNOtgJeCCUCZgydNVLeE0
UM2AdQqUiBMMRGR2ELJ7UOi5huFBYYB5mzgPxQu2JYZPihVuj4WVKgthpmIldOwsjAf+VBZh
PmiIoB60dAhvmEAWQSafAoCJmJslBOAOwLusQRWJG44W2Z6JVCXcCU5tbcSt4Q/PboMdNJ4Z
ZKDAYdlg+T3z566pyM7n8YugiFJeW7QAG5Xy6J061fUKJlgwgzP0VE6dDw9OmQ3P0UglAEMB
wEwFIgHiXoIqaztDTqlCKxGDofdFBac+/Wa+ZFXmYweHL53x81qthouf26oUvm4NrES0IZQo
MoBReeNDk7wx/Dp6BJ3ibWAtfX4tFhUrck+O7cxtw3EmFp7kGbVvS9B4PisTkhRZlq0FTLbb
R1rDQVcJU0qE2qt3CfC1beltad/SBtjs2Go3By+xEetAQ4A8nThPFB7rX/h7Yu3AkmlvitBF
Bags0j6Aaz8SncJbPMt4Fos8DNXG+NE2wizadWnxdygS52eXIzzQBQDq3f7z8/7r7dPdbsb/
u3sCkMMA7qQIcwAnDkCBHNYqY2rwHvyU7hWHrgLZRg+agTX1vXtdsCS4R0VDGxxdyIQSLHgf
dlsteO/vhX1bO1cIgO4K7p8MZBAwRy4KsPlEv1bzWOPhLWB+mQiv/2sbYgmefTXvohuoxjKe
gvLzvCPZmLoxrdWw4P3vHj/PL9/+/WH+dn75JpAlWFMHmd7c7u/+jVGdX+9sAOeli/C097vP
rsWPOazAaPWAxNsQ8FFXdmVjWlk2kRyXCHZUhSjO+RxXFx9OMbBrjJeQDP3J9x1N9BOwQXfn
85E7qVmb+QGOnuB04rjxeLNbe5iBPPZsyw0HX8TEy2fb3uC0eeZJuNpoXrbX6XLBMkAQxUIq
YZbluF/QHCJR6DtmiBEINYFOAk7wmqIxQCgtiCePzOuRA4QXFtTWCxBkE6kMzY1DVs4RAd/a
8+84IJ+eZFUOdKXQu1021WqCr2ZwxUg2Nx+RcFU5Hx8smxZJEU9ZN7rmcMoTZIu0EXK2dZmB
wWCK5LCby4oenA4sN+Alomy889CSjZ7Yl6eweg9jMIAIez12AI6cneKDbYg03oppVuGEM7lp
ZZ7D1l+d/X3/Gf7dnR3/0Z02NlDjyWQOmIAzVWxTDJZwT6qyLaBdkKp6udUCRKstXaSzV2YL
5/AUoH0LfXXpQTWUFZgid/cfhYWnLlhjzUK9f77bvbw872eH79+c6/t5d3t43e9enGcc7i+t
ncuaUKKoIHPOTKO4g+qh7ry+YLVIw7aytkEf7zLJIsuF72wpbgCbiDAmgHe7AFxLOxrYM782
IH0o0QRQCjhdX0WtafiBLKwc+jnlBAmp87ZMxMTmHOWgiyLmTBQN5afIEuQ4B7fhqMeoqOEW
LivAJwDki4b7wSHYU4ZRiXGLE2vvDHgVPLT1OnwGG3oWcyzXZdj0/vxikYRNGrUS4YfZPu3V
yie22w1BQT3AGv1Ch5DwuiT7i9c9DrvEHH3Q4Nj1H3A6S4mox45Kx8ASKU2EdcvVBxrH1poO
PZcIF+kYOuAFSUH8o82pm/BCWWFB36szKC5cMvdZivNpmtHRBU3LGk1fhHsw7LiObjJo07Ip
rfHIQXMV26v5pc9gTwmcplIHXlgX8EKvkhc8pbYZu4Sr4y6qhy+7Zric48YUMClrPAy2rLmT
griNg3OIRlsZb+mZdcCGIDQDARESQBMduABUwOA+jzh6ObE2VSMmBXuX8AVgonOaCDprTOqh
bkwYGmDFdhEYbQjPxWak2rHmFZJoVFwBVnVOfpc2QwHHwGWkzEvfUe8aMERX8AVLtyNSfHZ9
c3B2fSPmBvQSDAHVzR8gI2G7WXLA1UW7Ds2c5/Z8fX56ODzvg6Cu5+10FqCpOrdtkkOxujhF
TzEwO9GDNSFy44sfTr7PInRiKKSfmPkQ6CNAA3BX4GpPWBd3sfxLWjcicNix8b1FDBNdZELB
JraLBHGPd+K+owsimqpt7eNnWFpIGPz7kAQa2ILzZNvLNDEROxiqXXhRcXQWQsDrIJXFDa5r
RoDPI3nkJjq61TW9HcYsVRDecR6BI1rIRgXzC5T1ojfQmDlqOCLB3e39mfcv3H4bpQSXR2oM
EqjGBr4mTsMl0jD0vUFdOgiCURQesJM+ur0+7IA9HFsJEPhSkO2g8mOp6QjHHUFIidh/xbe0
Gec5BYI0T9Hp83tf3rTnZ2d0yuimvXh/RiGfm/bd2dm4F5r36p1/CCt+zWkzbCnoZU3lf5kG
D70hoe8RpYMGUOgPnIduAHh9mDLtJHWIC9nTwrAqhqVO9Qu+5aKCfi8imep86HWmqcCv08ax
kgmmELNg9o1ef5lZ7xQMQkFjFZmJfNsWmTkRR7PeagE6oMYkC6Fh0MmmtI+75r0ILqWpiyZ2
3kY8oD7kOtYNHZeuCwDZ6HzWhsgXdVzod1pfuBQLFelnn88s64DF2aDnv3b7Gdig2y+7r7un
g3W2WFqL2fM3LMcJHK7OX6b2rHO2EdMVRQJOnR8XLFtdcF4HLZjn6FsHpFWCS73iNtlNiVoZ
MY/yMAMpLbzt2nx0hg3ufC5SgcHACaXbuz+4BR5t9NQLpb0vGvSfXDV11FmJMZyucgJfqf2Y
jW0BITRgANzcrGXWXhxs0PXIa9e6IN0s11edqtZEhsbOtBbj3hDT5tqNPNWj4usWZFMpkXE/
RhL2BAppuujBcrB42QkzYI62cWtjTJjet81rGJ1SHJaYs/ELhtFpMbeLIFpTnVm/QHGQFa2j
uQ0uQAygIrLIRvt/JI5mKupSTE916JQtFgrEDaDj1NQ7gEkpK7clqACaGi5/Fk8vphFSd2KO
qcA4OB3jcJsqwcsBpUzndS1Lpyk7pTi1xJ5LyM4pCDvRCW3l3bsTmVI3w0aDBwujm6U8waZ4
1mBZ0JKpbMMUb2VVUJMd7juruac1wvYufxYOgQRyAllt8vFd9TShwPQnyEiE1EZHAX+T9xQB
FCjN3vkcNH6Ikfq6lFm+3/3ndfd09332cnf76LyWwQx394h8U9w/7ryqTWANr0zf0i7kGhzG
LMhSBMSSV15kwcG/ri87WvL60hux2U8gqLPd4e6Xnz33KvVOBwXZuRZhW1m6h7A1iEnZV21x
mqc13HsYZjg/WwZWC7jTKrk4g1V8bIRa0ScKRgqtQNLQUm2npin8ihTbr45Hnb7K9habhspm
2VhXKrBsIFdwldH5D1aOtrrAcqDjPgXdCrmeHLJWtLRbGtOCAhp2SJaEvlCvGvCQY5nDtrvn
p8P++fERkM79/uG/LqXoJPL2fofuN3DtPDYsTfv27Xl/6Pmy3cvDl6fN7d6yztJn+EOHLNjO
n+6/PT88HfzbgDOGXbM+GDm7l78eDnf/picZHtEG/hOASc2Ee4C5qEhiPEpWMoynhE5xlfjH
mTIVHG+ZChaeKLbAmbOsTQVZ4gI9wBSO8DJ9e3e7v5992j/cfwmj91sMf9Hnn81/u/idXuGH
i7Pf6TikgrVlgkIK1sHc6jw5aoaHp9v99xn/+vp424PcfgD27oIMdGA7k00U2Ln2czudozNu
GrFg8KqZXzqXCfRY1CveNjwtWcflKX1QdWHBpl1M/rD/+hcKZnaUmu4NnoW1EOC2yDwnNigX
qrQmDSywc8QHy8PB4VIJFTLM0gxcwoC5FIK2oEBxlSpUP0hLWdWWLF2i+4bFOeCcg/J0rkSQ
VdGpBq2S5LCJoqIHyzdtmi/G4w2xUikXBT8ue3Qrze7L/nb2ud9Ydx2HfXUV6evAGcH4fAPH
ecPiaElQ948p84fD7g5zWW/vd992T/fodA2+lj+EdOUAnnHsWxA9xJHiP8DtP6rG3nwDVgVp
wRAIxpNyE+RgRqk+O+rgIjWVlU8sSksRiUboEuNfWFRpRNUmesPiLwOEpEJjbvPIkVeYR6MI
sqbbu27wu4mcKszKm8rFgMCHQWxuI7PBtbZsQSnTUOhue1yCYxcR8WYiqhWLRjZE8l7DOViQ
4grICUwO199gHKIrtxszaN4H/siJue9LXDVHu1kKY+tJon4wN62POVpjq8jsG1GXgBrBS6gy
l4vtjjo0FI5P849RU+Bj25blpk1gcq7IMaKV4hpEaSBrO3TEhEVMmE9tVAV6AHZJBNmQqPaI
ODqE54hJbJWmSyvbN6hOiPH7MiLVbQcG06gzoG6b26a06VwqrPOZJIqqL+MfHb+TSFdS3OW2
4n13rS5xMkHLZDNR0dDZIFGnrfucof9GiOCVRebxUxvRxUu70g9P9Uy0u1qQOO3fm8euNCAg
j6rtQ/KkC2YXIQyYlO4sbbY6PnC8yfza2Nu+CtKuljxROR+rOrJqntIoFYb9eVdXglG7/y9f
WzdxEZ6TF6xPWZcj7esOR4KdBLfGxHqklFmfheApXDLvaIHUYEgL1TuYDFsNRCyXXwuDitd+
wGPYKDiJ52hf7+PH1PyCeq3YDuEApAoN3xpKwIh+vfqtqU58FqKrjmzZMQI+lp9622tkU8RU
J3jdVR9bHthb4SK9xzo4D3I6NB+qYryQWiy6SOy7EbLs6Cyyc0domgiXYqZOA6Vo8izBdgiw
Nt33bWrjFYidIMWvO+Ga4FFYWtj4dqNviUqFhynXsIMAzLvcBSz56HksUrl+++n2ZXc/+9NV
mX7bP39+eAwyrMjUzZuYj6X2iCv8jOo0xVVRtpftb54zBQ4qfr4mtUnTqzdf/vWv8AtL/FjV
8QSQ2mumquZhR7FO2pdKWz2ssQj2ykvCdLea6KO/7wbM1RDHHmqOi4mIqa7OPShZ2WI1TFnA
Ipvq1NctWC8CiASwNwEo7ceNme3GZgGmWdSGYrCy1tc3twnP8f/Qnoef+Xm8Lqe0Afex9u1U
9zVKL078793d6+H20+POfuI8s4n7g4fYE1HlpUGVN7p1FAkewlR+x6RTJfzEdddcCh2EPPHd
OM9n51nuvj6Da1sOCZ2Rb0EnlnviMStdsqphFCU2JX3GlevAkfXS39eY5eIUae08zlGGfMQx
HjQJZSxobm15UfCaK16GbQR8SLw+lbQL27t5+ScRMfSf+Ep7HaY+Fghyf1QS2iX+bNLPldFc
BjIVaXci8YdZWUxUqtbEReKu2Ey2SRPEKxsCb6+0X+7ZLc0emPvgM1NXl2e/z+l7Pl1BGFLo
WvcTQImER6zYsG2gOkm20n3OMVWb4JwmzJSGDm3cl83/2hK1gScoTl4F0YG04Kyy7BN5azoQ
hvI/QDhizje1lEEk9CZpqKjpzbs8qFW60cQXGl25LpxuHX2BMHTfvWcDCydq/my9cB8ACMI3
6Bfbg+jx9tRJoHJ2Bb62lnVsB7T7XhdAS5sXzHfk4AxsjR1+ghrYUvAJE16ly5Ip0qT149aG
O2Ds67+KH7/MrXaHv573fwKUoLLkcD1XnNodMJJB1Qo+w9Eyeq9NQSZqchVIFj5b+0ZXqiLV
1v7kbKIe2LLoJmmxgjmlP1y2PE7JnOoEg03aiJQOusH+YSCKCk67rR2EpHZfw+Fn53QUuMav
svBLQIABWA1IOYHAVFf+j2nY5zZbpnU0GDZjDSH9yWXHoJii6bguUU/8AoUjLhSKcdlcU4WX
lqM1TVXx6Pu9CpS9XAk+vZ+iXhs6h4LUXNK1oB1tGJYeAI+lZfQvSFga1xM75qaGlmritIfl
+o1OzNByO3UbfA0Uc5zuIOE8fhcvWtRk0rpvDiffZPX0xbQcim3+gQOpcOrg+Ej6VuHo8Ofi
KMuUIex50ibxnfTeFvf0qzd3r58e7t6EvZfZe/AFybuxnoeXYD3vbhICOfrbZ8vkvk7BW95m
E3UWuPr5KcGZn5ScOSE64RxKUc8nBGv+z0I0/wcpmo/FKJrfQLdb1n2wMwr8h5OOLqpP0sKM
DgPa2rmiRMKSK0SyFuWabc1Hb7t1ndhBVK81hqht+dIJRrvCabrmi3lbbP5pPMsGZpdOW8Km
4g8sYchwwjLjfapNjT/cpLXIt/6C+7cB8drIBpihchLAALMLSJLUpD5BBG2ZpemkjdDphP1Q
E7+KYKZ+5ocZ+kOg4mJihESJbEFBWhdLRl2kWbRl2ER2ti5Y1X44uzj/SJIznlactspFkdKZ
WWZYQZc5XF+8p7tiNf3Nbb2UU8PPC7mp2cQN5Jzjmt5fTknFiZ+3yFKqMCKrMGClJf6UVhAv
geNj6BvRdQ+y5tXaZfHp7df4ozpm0uSDV7maNjxlPWHLcYWVpodcalrg7a7YmQIEn+Qo3uFn
f2g4TnFVqaZxSveDGvaCq4kv8D0epwAotWiN8jU6tds2/KGA5GMRAffZYfdyiIqW7AxWJvpV
nPDKKAk2VVYiyjoMO8lKxbKpVUzIZjJRPJfDctSUisjbVUp9dLURihcuVTsMnC9Q9s/H5Vg9
4Wm3u3+ZHZ5nn3b/x9iVdLeNK+u/otU73Yu8FilRoha9oEBKQszJBCTR2ei4Y98Xn+tOcmL3
vel//6rACQALZC8yCF9hIMaqQlVh8fwVlVxPqOBawIatCAbdUZeCzD6KSuiUXDfewJqy8coh
ld4MD3ecNLrG/t2VhrQFv5Wughf23gVAPTFOu6kALSzijtAuSXm6ucKi5QdHSDYBh43DGl9x
wQcao47MbmNBf2ZTswDzH5qXpmK0iScX3BAorW70oJSlLYWeEdUuaNbrOjASDDPxkffSbvz8
n5fPunnJYNHw8rlNXhS2lvHcxFw4JamhVjWSQVSWJy3aDDRWZuXBtClp02DhnXMyFpSM8jhK
mzvCbliqppresEUFf/rdtph5/fb4pBt2HK7KtElvL+ouo74cra09bXNbbH8nCesWLd1SiZQt
+qXX6OrfjrqWq4E6zmR0Lo0rfnGwLi1BcqkcvF5DgNYhbTE3p2pSc+tUNvyOuH4IX84pesbv
ecol168oquRo6Gab3zeuR+Zq00Sp3/C3iVdvlJRlvBgXWGkWC2i2oXz4YwzSddAHC6FDkrOk
D+/TG5A+qclv6Hfgn9x183zMdTMZ/AVcbWXokZpEXh1o5LyvR0AmY+MH2iIrp8cyqvSLTR1q
jFlRzdpouj94zgKUoY+6QEum6rnhHScaPZs0ndMN0Zao2vbJjTng44/3F9woFt8ff7xpu8kZ
fiyyb09/vT43sV/kj8evb4113iJ9/NuyhsTCi6Ikr7NkrOrkKI7BWDfMSdeAKsp+q4rst8Pr
49uXxecvL981Y0v9ow7c/JSPCXC+1lzH9CPax46TIT+ygEpcLswbvQ7OC1QxO74ACfbohIia
yKupQ+3wVMMnijkmRZbI6sEuornQBm7yymN5unmOIiwy3/xOC13PVBL+s0q8zUw5K4crevvJ
3PUxCvTHQ8VHDVepruYWsiTKQAN0OC6okqIMTnWKa+0I4BCLxkWeJU+tBRllVoIZQEituj1e
xI1vBh+/f0eNdTvfFYOnFsDjZwy2YS8vVMHA53TXAY64V7jYTg/oven4OPjy7aYmWsnZCZOd
xSZi70/h7C5cridLEGzv49WAQ+xBEuCh3p9fHU1P1+vlsR61W/kZXNAqiToAVI+kkWwGSnWq
eH791we07n58+QqMNVC0pwpl563yZywIPPd3pVC4q+rTaIbAHzsNft9kIdEXFDl3/QqvReHY
Fm2UH88PWz7w5e3fH4qvHxhOmhFTqNUYF+yoWabslRVNDrxF9ru3HqfK39fWzp4neUS6Gaox
Q1vFhDF7YLr0m8ioYLAdidk5KtNe9/I0imqQcTVxgqaxtr/BmA44oYKKEzIUxMVdkbMTL4kW
DGBzxPSK4n9GG1coCC7nSfEebbrI/V5eK2565Q50MNy0XqUnYdGB4iV7HP8SPCMaoQVVVJMw
LeG7Fv/T/OsvSpCC/2xMHshzXJGZxd6ruOzEmS1KPJSr0dEjQ+/nz4nl3uZT4tZaaTHNAPKI
N7uGKA2fLwOwJxNNMwoxiQ047/ko4XZNtSAV1gpXBPtk38aU95c2dgCmyeDQO+CYnpO98REF
5VBgu782pqamLn5IGKTpJunmin/ewlEdhtvdZpIGdi0qAnsH58jUatKGcVOorgmVRJTBCmod
vbvAVO/fPn971UMS5mXrHdxomC5ZYnsGZS9vnylBIooDP6hvcVlQci2Ie9mDHWqc77NbJOgz
rzyBLOk4D8URXbEYvUwlP2RKwqR1p0zsVr5YLymmCoSmtBAYTQvjQHCWGKzuCUSw1BFVs4zF
Llz6EXnLzUXq75ZL7RBpUnwt0BMwOQLW2U0CEgQEsD952y2RrqreLTULxFPGNqtA4wtj4W1C
7fdZ7FtV6O0got06NCI7COs8HkZEc/1yvdKAll03EJG05jDfXCnNb5gQUE9U3XxPfW1jlpaU
yAIN3mrduKj0WyR9LSpSm9jHv+nb2QJZVG/CbUANc0OwW7F6MyoPOPJbuDuViTCYJbbfesvR
tGr9a34+vi3417f3H3/9qcJ9vn15/AG80TtKffgli1fglRZPsHBevuN/jSgE7TimXKxQZ0Dt
P3iLEyFXXRp36l2MEPrY7lH4M0Mga5ri0qibLhnhici/Iq+ZcQbH14/nV/VciuVmOJCg7iHu
/I7sBqhAkuPo6oLxgyMjQmSeS1E6sgBC5hjaePr29j5ktECGbn8mqNrnpP/2vY/6J96hc3Qb
xl9YIbJfbRUktn3cbpDIr/f06CTsRO9G/SJ0nMIDDjuBtm8oY/i4Vxihb1rH24+WpHJcywrD
Je9wFpS3GF5XLbzVbr345fDy4/kKf37VChyy8ypBjT/5TR2IigbaACGLGEyoAkPGKKUftROD
hNQYYGkMjbqIsYLm7Ys8dl26qpOMHpB75TPnUFsqE43EsbdC4/Gqkl6FtQuBXMLhPAu1oTxS
OLT58kyXCOm3i+oR9fiKI/clkY77PnXBcXNdauZp5vLor+yL2GZm4PXGsI1a7s4gwr3/ePnj
L9x6RON2HGkeiWMeOsHAErluS5PFuqIVP/wCRxywvytmxTJufIVXLNjSbMdAENLOvhc49RL6
Hkk+lKeCjEqltSiKo1ImZqiIJknFQDpw0vZUL+CYmLM8kd7Kc1lxdZnSiKGsZIqOIgVRUDhW
2JBVJnYElCTnjjvA5oyTpDGrXmgWfdItgw3I2I3gZ+h53s01V0uccQ7VWzuYecZcSw+9zesj
GadMbxLsCLk0vc6je0cEMj1fxehPxAlcGFxpJFOXnUJKa10QoNc1Iq7hmZsn56qozO9UKbd8
H4ZknDAtc/Msj7ng9mt6ne1Zhrcy9Aazz2u6M5hr3kl+LPKVszB6vTaBjpCNdWUkg5caH8ys
+DT7PJrOgxlyZiotItKYw8h04WejX+XpnONFXo6hjum7Y53kMk+yPzp2NY2mOlLzp2kd2kLp
LUz5/dkR+0D/slOSCvMyvU26SXre9zA93D1Mz7sBvlA6Ar1lwF4Z7bI3PSILulDnxvJh9Q0f
RaFZkJy0yNYKjM2DojFSTTml19Zz2ZfrcerTpk4ChtbxdolWHkaeSAwxap/4s21PPpkaRA06
nD9yKc7EwXzILh+9cGaTOpmBEEtvbmM6naOrHvVIg3joB3VNQ23o1WEC0BVhsibRq5+J/ft2
uuoXkVyP+ww/ALZeEYNEx6LlcGBR6gk8x7RC8SdR7HpJHxofs5lZAFL+JTFfc8kumcuwSNwd
6XrE3YM/UxHUEuWFecmR1uubw7oGsMCtKQJUXCfhw3WmPZxV5kS4E2G4djzeCFDgQbG04emd
+ARZXRKdVWkhkoyetdlDZeg78be3dPT4IYnSfGZJ5ZFsKxs2myaJlgBEuAr9mVUH/8Vn8Izp
J3zHfLnUpLGoWVxV5EWWkD2S0x0VrnZLYpuJaqdsk/h3ziuUNndpCzlEcy5w9BkHQfN+o8XF
jjMWd8YgYPi3mUOn8eyBxXHkuaXpjFTwGvJTHhI04znwGQ72Pi2OZly7+zRa1TXNKtynTgbt
PnXMTqgMw3k585EeCHoLQVjHNxiNNkICnFoOy+4qmx2+Kja+udos1zOTvUpQ9DFO3chhGR16
q53DZBshWdArpAq9zW6uETADIkGuhApNeCsSElEGjIDhcCLU6TE7W0Wih1/RgSIFWRb+mDEy
HAaLkI5WaGxOnhI8NUNrCrbzlyvqDsDIZawK+LlzBE4GyNvNDLTIBCN2FJGxncccUcCSkjNX
sGYsb+d5DgkFwfXcRisKhmZFtaSHQqqzxOgCmcHi+AfDezYfNo3K8iGDie7iJY8JrRZjaB+d
O44STkb+1xrxkBelML1o4yu71enRWuHjvDI5naWxoTYpM7nMHBiDFViIyKWDs3QL4/Iu5kkA
P2/VyeWIjegFI0dw0rlWK/bKP+WmJ1CTcrsGrsnWE6zmWOaaV7TqDAG/pC1vDnFMDzIIAqXb
JVDs7RjkA2MD/OXUwzHl6cFlHV2mDvfHsnQ8Y0kLVnjN1hjaK3W03iUIgXBHb2oI3oHc4dBb
IVwmx0g4gmkiXsk09AK6Zwac3nMQh5m5DR1nNeLwx8UHIczLE71FXK1tuDPwv11jSpmI5IP6
M2uOSQqTJ/P8PE1F+pWnYMSpkYVmujOdDmn6KgLt5H8Csh7lsKFKcCsSKN750XOx4iILKKMA
vdBB9KLABDhNZ59WUasMoLCeZ6FAwWlAj+mmp0sH/aeHWGdJdEipVZM8p8J5VtEDG9/zJcoR
ZHF9QV+OX8Yu77+iw8jb8/Pi/UtHRdizXckdW7Gh6mZJjyrbZ9JgtJZPHHEeLxnKFrRuqtV7
3NzO01C64PQhinsQ5SUxiPYiJm7tvn7/6915/cfz8mx4ouJzi2kSG7tck3o4YOQHXOV05YoI
fZxcHlcNRROr5C5zrIeGKItkxWubqLfJfsXnAF7wFc5/PVrWK21+fH1quh0fi4dpguQyh1s7
k9bdLjvEJudd8rAvmpi2g16gTYP90fXIRk9QBkFIv5RlEVHSwkAi7/Z0E+6lt9zSh45G43ub
GZq4dQusNiHtUNlTpnfQlmkSyaLN2qPNq3SicO3N9E2ahSufXp8GzWqGBvaW7SqgLwkHIkfc
iYGgrDyfVnT3NHlylY4L154GXThRyTVTXSvqTRN1bwm28SxnSpTFNbpG9FX6QHXO54c482+y
OLOTFZCDoLym6+VqZvrV0qpxvEVoF8jqvbpS+EQScP56yOMhff8QU8moMoF/y5ICQZqJSgxH
MgmC4GcGQupJ2ENZGVFvtXr5IdkbkWEHTAW26eKfDtx1jycpnsQO91+tgQlyPg5VjVabGkVO
Wpb1RAeME2rfSA/wJVP/nyyi6yUre+OpNNFGkGPTRDVygmjPsmDnsBJoKNhDVDpiJBVNoEpg
dSxbMIvkIuq6jqYKGebEdEkDHbDu0wcfBsqg74MaEhV/wRHkpiHArhOsShwa+XaJcce7jVXG
17QN3unxx5NyguS/FQtkVYwIcZVu5EFY81oU6ueNh8u1byfC37aZbwMwGfps61HCcUMA7It1
brbpDNe8MxsIqcbm0qRW0dVOag0oCGJIysx3u5sMFTOpz1039C08Rlli33I3TNOXxx+Pn98x
uH9vCNzmkdIwxry4QkftwlspTeVM+wgRJtNytlqeGEC38ZKt6HMhLz4VruuH29Fhbty82u0M
v9Q+6m1IRP1pJ/WAtHpqGzmMNYZYhh4qwUiAREUA3DVRCVtvmx8vj69jS6a2K7qXjM2xBSD0
g6U919pkqAJOAuUe2Tn0OWZfl8EwJ9eBAwqtdzQ2fDTVBP2JcaMq/RUTHUjqqHJUJOj0DMSu
jO1pMK9uZ+XKuabQCoMeZ0lPQnZj997x1FRtPvY6S1JJPyQvr3Wi1HjIyfhUPtpYeqioo9Hy
zb99/YAopKjppYzrCIvMtiDshpRL6khtKczgn1oiNfdb+KNjJbawYCyvHfq2jsLbcLGtJ/qt
3RQ/yuiIH0G0wqLo2jtVb5sFySdqrhhVW8WoGsZEMD9V2MnfvVEZVek6LQA8CHxYu/1WF+Rc
m7hkPnmrYAQo3YXJMWkIk1WK2519VAwnAqqrcqm/pl4pfdeQkJbjVpUllD78PF1Yq0s10wy/
eExo3jMatGhNUq+bcWjPleWqe3DwdTNgGPI41etXqfjkR5ywIrZCV2X48A9aPylxiGZ4VH6l
pqYjG+p0umKtSRD8YCVd8ZXHuDiOW4LvbVkPpgxddG0jm1O6/YvhcFmtdhvDvxh5Ys7MrO1r
OaiPW3x28woY2ljJ+swM8QInO0YdWtMPjA7w2jzjWOWvaZ01LztNMyUWXKOLMXL4SjVBB4N/
bF6THT0sJhn8KaneA6mHmbF5YbRtFrLmafpAP3XUDAvwH2ch28fHG30R8PRjrZxvv00IKf1T
atpMgVQl66LzoDFTfNaGeaa7EWF8ksJUcGlodq67FmZ/vb6/fH99/gkjj61VjrbEIdNmu6WS
rVdLWlHT0ZQs2gVrWuvR0cDHTuJZWrMyJQV8oGhDm2AsELO/LMEak6L0WBixiLtEaKY+Tr1w
gq4pb/Y7WwsoGdK/oPvJ9KtZTfHcC1a0WqzHN7QGqsfrCTyLt4F7EFqjaicOQtMEKBxycwNm
7klXcl7TAjWiuTKRoW+z1NBxEQQ7d58BvnEohVp4t3HsKwBfOC2Ft1hZFaOdUb1I6xhgwTLC
2QpX+99v789/Lv7AMC5t0INf/oRJ8/r34vnPP56fnp6fFr+1VB+AwcNoCL8aewPG7+THXPl0
mRybBWqOuUbbNBKRRheHW5lVlsMkCsmSLLlQzIzatZRS0mwirCtn2wTPrIfkNBA2WJ73O1Py
E06jr8D3AvRbs/oenx6/v7tXXcwLVMmcSfc8RZDmvtVW20NYSwSp/niS9hdUxb6Qh/OnT7dC
cMrGGIlkVAjgJzKzXMnzB9OZq5l9sJV1Nwbqk4r3L81u3H62NpnMmdJukqNOnhl19DJ2u972
JLhHzpC4nooUJe1XbpognujHJEvzFclSjK+Jm025FIvPry+NL6d9yGI24FowINed9WiZBqWx
9caBhrWzgG5hR3QslS6mb8//qTfX3r+NX3MsZQmt/fb530RbZXnzgjC8dTyIfhfamkDgnZgz
6qh2Kfr49KSCHcG6UbW9/a+rHvs1OSgJRQRyPPEzLUOMFlFhsVR7vQ//fWlPz+wRtjfrTtbr
Qjbi7V9BSYMDSSz8tWnYaWIhfYroRN51zOq2LRSvj//R+VvIplZM86CxVWuDCFoN1OPYqGVA
ZlUQfWdl0Hj0aW+WQ4UgNih8zX1dB8JlQAPrledstnlFRlKEdKnbcOkCnNWFyZJmHkwib0sS
Nc+ZRxfyCXeF4VsheiiIIRH/loYw3j6Ofgah6YFObfYkDYujBtd0jG1Yuihm2uvjgzSCke9c
b6Ej/37ED4rLYLnRQs+1Bam+3Czp9NCVbvS9gdALqiOx3rm22gjouL79vb+tdc8LCzClIBs8
xfduMJa3cxmrd+tz/YjtPyjaLVdUF0C6HnBBS/cCgj6Lam/bSK80QpSlEN+rqY5urzXxORD6
4qTr0JIdYNDJ1deVVdWBMZhdVi5KbNnEaEELw52KcjHKPHXv2tGkZbj1t5Pl5+jCOnSNVrG3
DrZbqmbVqN10sUgRjouFWbEGWWkMAO+0WpO1yVJsguWO/tCuh48RPrkC4q6/c4iyPWV7lzA1
XDJYrrStufPb0X8CI2hwck1iy62d+NhWJn98B56QunVoY46A1Hs+nivDEWsE0sdOTxZv1x41
nQwCbViG9Mxb+h5ZtYJoQc+koSVck4a20DBoSAtyjWLnr6mQLbHc1p4DWLsBxzcDtKF3WYPG
YZlj0sz0nWDbjcPopKO5C9E1dprEW87S4FPzwWl8io3bhFfydJC0odloJ0z0qiiTJCY7Vdbl
1NDGYkMF78FAO75HpOOz0yLLCESdHHiQU83gwd0tyuhL+b6jth6wYLRaV6cJ/QOtFxuIgtU2
oO8CWwrBThnZXwcJzPFZ4sk5kf+YBl4oiF4AwF+SAHAiEVUhAPQtSAOf+GnjrYgR4vssSoiK
IL00PVV7hBfNhjnZeTwISF11h6NQjHOerEGG1PnUwR+ZYgdG2WBpVJ5PungMMYXyxHhrrAfU
4RNQxSqI9GXRKOBcJKY5Ar7nKnXt+1NDpiicTVr7m7km+RuiScgabJYbsliFeZSto0GxIc4g
BHZbR6GbuS1S0axmKt5sTOsTDaDCgylgtyWBlbfdUVlYuVpS21WW1lWCkdXzMSbZJliTg5Rt
KLZygLcrOtvMmQMEU6sDYGJ80iwkPhiNM8nUgEwlxzfNptcGHPmObNPsEBAE/ooWUw0aB8to
0kx3acnC7WpyPSHF2ic7IJesUWdwQQcN7wmZhLVDdDgC2y25JAECGXNqm0CK3ZKcgXnJMpc1
QPdZhzDYGWxUmTk1jW0mcZL+FC8A+Orn+CshmZEMG3EbYTMFWeJtV8RaTjLmrZdElwLge0ty
gQG0ufpkuMO+RZlg621G7AQdQk/qBt2vSPGqJ2KnYAOyNbraWi7dOgUp+RkUqw3RPinFljqK
gNna0Ls+sFqeH8ahw9p7IBPe0psTJcQ29GfKge4PJ+cPzyN/uSNYEkivaZYkj1b+zBkj2XZK
uJKnjFHHiMxKkHwc6eT8UggVWlwjWC+JIcJ06vRBP0ZWnl3cEsCbcEPFyukppOfTstJFhv5q
ut+u4Wq7XVGvzOkUoUeywQjtPOpq2aDw4/FXK4DsYIVMbRdAkG7DQApHbgA35MukGg2sv9PB
kR+w5GQIGJOXmP3MR/uDfyC/ybulR9rN/j9j19bcNq6k/4oedx+mViTFi8/WeYBISsKYtxCk
RPlF5YmVjKscO+skVWf+/aLBiwCwm85DYru/RhN3NIBGt1plmPEgbiARwTktpjRP631agEXp
YPsCGzF2vuSaH+mReebvZATAU7SKJNvUnHi9OrKOYQz35VHmMK0uJys272KKHeN1H9JjoUx6
AhWKRVTM9AmFcQ5H2H1UDHTRHlOZGcHk/n7hgHPLir3674NvGmVBcKsEcyZwNWQFje7di6qU
ccbM2aSLgkt1D0fleTXKwG8ke2/VZXxJVCjlGedtLEhWb7Pu4LLs/ZthtKtLA5bf+GIVHzCu
gUe/ALgNkwHUTMAsyszP5QQU5Ymdyxa7k5x4euM3FVt2iHCeoLLEWezmDzBPjz8///309pV8
46ZCQ8/zbpAhFBLcT5b648PhDAWzfAMo8CYIre88LR7Wwd0y0ylhMhcJbqHSWxcsC3jgvIab
pkUmxSEqlGlgGbzA4aU9LYsfrwmWq0NuJL3ug9LIVmiXcsniTy04a5U1dmsn5e8f3u0M5Eka
y3gORk1kBQNDKNUxm2GA0218ib1oY35OHYxFqf0xUYGTA6kfYf7lhJS0400V490pbetyLABm
n7ENpWQjE3DeJGp9JO7kPGZliQfeep2KLVl+noIGTaKyLAtgFDrubhEnwQPeFW91KVXpvsT4
zSnsIh2PxIuj3QwTFKznBR5HQNX6ZiXDPgT2CJ7jdLPmlpgXbsOFUoLCSWGjakTkRcJRGO7s
j0ry3UAmxlh8eCBR6IRpJXdMH0xcBb9be3S3KHgcrp2IyDkYRPe5HswQ+R9/Pf64Pt3maXB5
bUaCj3kVfzBLNhXiKrwVW0r4kFBy3ESPeZqYq/frz+dv17dfP1f7N7lovL7p6wayNoDKgC5N
GouuHxVliTnw+ChZBcbdyCprZkRJ/5jLEibAy0cpBN8advq6iRewiKrW3VCoVDEHvxF46hG1
iWCpbae6dUiDBZs2JcMQaU/KV+8+KDkmG3axGecMyTuQzb8ufX5jTnBPuJ6FGyBQ92gKv+Vx
lnSAwIHQJc4xZxA922DCcTOE/vLr9bMK/zYLljTOCbtkpp4BjQkvJAxuq1ypgJXvo7cAkFq9
RV3r1hKKmtz5oZOfjrOPdZW77ugHo5DHGgwQaTyHMJHY9lzlVllQaLmZiLr5BIgZlLrelsP4
gELwg5kRRu+GJtCbfckw0lC03pzTLFjseIN5Cb5YNmDfKXiMH/SCiF61/9Sy+l6ZOoLxG8qc
VTGEFCMx0pB62q2oio0PzYluqZ4ZXpWpvfrv8JEhoiTbn6x4kGOipBx7As+93G6hpvcARlGV
R2urJXqibzeGIkslgRCFWYQM9DAM7rCLigmONlYH6e1aMFnRnYsdzEyofh9zI0YzSU1gnaGa
cFrsXGeLxwGTuGHmq9FBSTcpo/mPNv4GynADbVMHI1QjO3USey7qNl6hoz2KmSb2Gz+iB4ZI
4wVPq8DAN2HQfcCT++gxt8Luz5HsEbNBDeohvuXYdv56HvBFT3oWsX7cALQGgiN6ni93+CK2
LvUBzyrvbkNXA5hARWiYxl52lre2xIplcoeBna5UInDWuvlSb5wUWmtBT40CjGpayo70iDIl
GXMpS+FR/UMJjgIsE3eOi1NNi74BkTOFp50ej3tb812D4h0Q1iZmZ5YAuOdc7lSnzHFDb6kf
ZLnnz3v8sYt8am5gNX8oC2ZmcyBiK14sNmHmYsf5Koe5bxzZjzRn1nin3DaFm8P4bcYAbyhn
ez3sOcuqA7D4ayLI0ZQDLcTTeB5iNmqd7uGsz4xtNxHnJv0zjh3vUtlCZdYYxhE3BngM2qoX
zIVorad+Ny44s1RHlhMfcVYyJpCL1j4iXhIZXDkeMeHGw+Imisz7LQ1MfI9oR42pkD+wTY/G
MvTILCkd4ksDh9Q1wHZ5UdpcE9UwTR+dt6elMpqIOaWbGGqQYLC4urGdhRBl3rHC93xCAb2x
cZHdeevf4Arc0MHU5RuTnGACvAJgOQkdEnFxJApdQloU+j6KNLHnR3d4hQAYhLhB5Y1r1Mh+
g00uD4v1AVpUsLnDMqqgAG3TmxaHQz5aWzM1zoYivFIWFE2NSep9VDdbsNTWmHbtQ9qbNmIi
jlG0Rs08LJ5oSQBq7nLjUR6zZ2HtB9A2Tr4hmj42w+Ti7juBRwzsUa9ZzBUwuR7eEXrVxvVo
8aAkfdBPR63pw1zYSpSFWssBzmQoRgZmKUEa1is9+Jf7ZRYv4ZIeDv5C1SMVzCXQ/v3x+9/P
n39gT7zZHlsbjnsmVxDtQGsgwOCRO49W/NsJtFNaCfZBK9O6xM7uE/OFlfzzklRS6+uwJ+sm
Wx8dFXXHM8EizXbwsEa7d5LYfS6GJ+Nz+m6LQrst+MxA7itvIHjqVHed/5aDW4ezkiUX2QwJ
xMNTwRmRIsfoM1gAmyY3P7dP84s6ESOKYGDTS+Tr6+e3p+v76u199ff15fu1j7yunWVB8t5X
QLheB6bY/q1u5gSbOb3oqksjF9+7qLPLZcCEZ2Pgq1mSEra6ALM8kT0Lu79d/Rf79fT8torf
qjFy43/LP16/PH/99f4IR3fje0spY5U9//X++P7P6v3t18/nV9OVKHynKNtjyloyH/zOwXYH
AB33qdVKR9kUdn0c89N+h89SqmFzhhskA9gmmS2OCfwSAbB8z/YuofkDHvO6bsXlk+zSJM+n
Dr/sBmxbxgdsB6uK2btl2VetWSUVK5Qj5TEO4PeXx39W1ePr9cXqhtuaJ7qSPyW+IYYMPnqH
XW3fn5++zltWKs7gp7GTv3Skj2xgPHDB5X/4uY0ajbw4J7XV1r3vGpOAehVW04FymEaI70tZ
1vCaWM00F7iTvRem+IxvBx8jY03s3h+/XVd//fryRQ7sxHbZstPm63EOUjOSRt7KeQN8uKYG
rSgbvjubbPLfjmdZncbNDIjL6iyFsxnAc7lt22bcTCLOApcFACoLAFzWTi6BfF9AtGOuG0FL
aFs2hxt9ag1A+H4A0C6xg/jkTZOlCJNVilL3GiqJSbpL61puWXUnhZKel0k6TM/CykzDM1Ws
xopiOm/hv0fnJIi5ClS4GtxUiaocf3gECc/btHYp9/ySgdX4SQFAcoGQVYRPSaoHiIYEpaJA
uPsFMBW4tw7ooBsHOz6EZXxv9pzJZ67Zn5xE3RBYTdFH9KE+WvMjifFwQ9ZelkZrP8R3+dA1
Zk/hjY/SiyTUfnN2CKvWHqUgQTgvlwg7MirI1BYsosk2SUs5QjnZU+7PNX7bIDEvIRZI6Adl
mZQlfq0GcBMFhKtnGFxy5aAceqmOjftIVeOFFBqzOqdCe0Ad5SJud9hmQYLWgg5dZyt1gK7Z
+PT4wx6XGnXQH4IhX1RL0tZyd6/1PS3eltEnt7JSiQUT5k8IqiAOKeFAVvWTvCJc86kaCh3s
3g987it/K5csTsbtyy3DQIwzJsTghk3PNGCjv5lFyZaAGT7Y62HQ/Pj4hvVHX4tfnp+B3TD1
NHIxdSV3ghvncupN+WawYHLnxDCEJVUUmV4CDChEIe3+CcmuOufCXkVpAkBTwXM0P1HQJB99
dx1mFYZtk8DRj4W0gtRxFxcFBg0H09rWVc4IpbUeD9Ah0Q9HpO5oXELA3/BODxyTyUGDlF7j
UEsbkTrO2sZFLwlE2eojVFh/XCwnNkCq4nxGuKRZMifyNL7zI5Oe5KwPKjeXI9JPs2EC9D+Z
7iJvpAz+oHsvkFOhAS2FgB00VtohYzMffSpn54LBxbicacuaePZTTJPERc6QchChDofgK3UZ
X3bCzPYRrmLBy7gEaWxwhmnmjbi3UCl77zOzar6I/bbdzaq4BRPRGql5CF1vkll8F17AdWU8
y08ftoisYm4nYIkTEbHPFZwJ26GjiQt+IKwQFNxwTvmDnWClEhNuZYGpjSJnIQcSdpdhwoeF
gk/EI3yJbZuIOFIENGZrh3B8qOCcU3YXaih05z3hTl2lFhs3It689HBArMkKbrod/emE1Rlb
qLG9ettEwhk7LybvxRNvIkfxNNyLp3E53+KqtwIJlR2wND6UHmERW4C9TMIJ/2Y3mIp+OzEk
f34ogW62UQTNkRbC8SiXEBNO95tdTnl6BPSQCHqoAkiPUbk0OOFCqylrpKijcz4y0J+4L+u9
4zr0cM3KjG79rAs2wYaIl9J3nY4RkeEBLnKXcLDZz6vdgXgwJdGaV43UNGg8Tz26WBK9o7+s
UCImXL+AEFfXaoHiLKJ0ew3/YH5WW45S0EPj2FlOBAz0nO8w8+ND8oc62jUeqal+yPrOQixx
gFcQ6iwr4cj6If13sDElUAEzBh0k5ugzRajLMrZWZ/kJtRQbTmZHZHzus6RYlco5K1jy2evy
CMUPckYNXecu7+4izw+VGTqdwTFN3fjBxlfMluoAAfKGoliazOT9k7vzl0DiLV71Z+1f3t5X
u/fr9cfnx5frKq7aH+MZe/z27dvbq8Y6hGlDkvxLe0I05BxcnTNRzzI2YoJROt3EofvaNoAq
4bbCNUCpFDtHeN6B6VHvGFmfplxwUxK4DhjEIG3O8z1KVAl5QWPG2ygdrBhcKsGZMMWhCkcK
71FaPBcNRI0ue0fmBbxBZGgTDFaqAuLByB3qMZ0/qBNN/vz5/e36cv388/3tFe4VJUnObWC2
/ah6xMzZ5Si+a3bVng21On38obs0CbaLn3IF7o3h94qPR+FKL0bcYOkDdtSdbSxh7aVteIY0
LWBOaLyJNpCORIIFxLYc0/FwvV6Y2IHpfrPx0VfcNwbf3yBfv98EjofTLb81E+J7Eb0MDSz+
cm6y2A/MK/wR2iYueXY38TQXgb//Ghhi4fmZh2a/h1BXJwbHhk6MPuaeODZuZnh+0QEfaf8B
oJq/h5dbv+fBjBkMjhCtcICCj4qknwcZdKJAoWMafepY10UkQKbyTHdQGqBbEt3ovpdhCeAw
B98uA5qK0KF8uNxYSBcuE0vkOUuNAQwuUgc9neoI+yYPcDcg07RclJf63lt7AZY+Z1Jt8AlP
qgZTgPry0Dnu3HCefYV4eCfr5aIua0YOkUd3TnA5xclwR4t8QeORGyTe6M+mRyapWjlBhPRL
AMII6S0DQFW8gu9mprEIl2EXbQEL0r11QFnV6lyyVAwVrxB85EjUd9z/kACeqs7kDIzUIKiS
ToDTKf6NP6eLfZP56zUyPqXimbNEP5m1ETzHE1qn8hdUhe5vH6RWXGV8x1HfujfWetfbm9Nz
hdKmlmSI3PXWWOElEKyRFWIAqI4i4Y0f4AaYE0/DPJfexY0shP3NjYVLFZs6OQSOhgnX95Ey
SGB4jDCTClCIvjsxONw1kViqI+jp+Mgh90YbBxndzY7dRSEGZEfPXTMeu4j+o4F4j5sYPKdD
Rv0NdjtE7TJgqsVvTIu1JjzmumGKfET0qyqBYOrgKY98B20BQNwltQkYImRIS3roIJMD0N2I
+FRIufnRWZaWKWDYEF/1qQKG/gcFDENk9gN6hIwFSY/WeB1LOt6rwLRzja6ggBCBlw2WZU0R
WIjQpgYL4RRLY4mWVMYHtWe+CyoX1cFBGwh91IHiyNEEHqYsF6yN/A3Sy4r+bgD7moKW546K
gbtRZjdiv2JAvCp0K3iDTaCLrF5i2YANiHZe1J9z8WS+KT5Yrp95cvO93tRpsW9wAwDJWDM8
cGELH5pXBoi+3XP3u/jv188QXxASIOZFkIJtyOjBCo7jlo6323PULb5iKdS+Ap+jHD9uVbgg
TJ8U2MLZIAlv0+ye49cyPdyU1YUKxyYZwM65xk1tepjLvxbwshZsoWhx2e4ZDVd1mfD7lAjE
qgQoc3Aa7sNNk7jsXfuyqCkfUsCSgg01XUEQJHkBTK2QdBaMnzEr7IEKI9738HzLicCzCt/V
9GcPZdakuHGQSluWezkhHFhOvSVTXE0QeTQsM788YO7PdJW3Mdi2Eu/bJX5imfVqzMzauVaW
piQDB/dFNNrQ2J9sW9O9rTnx4rDQHe7TQnA51y1kLYtpX3UKJyK99lhRHukeBXW6OMspE7dZ
1HKL5bzLGGGtBQx12g8pWgIH1w3ljnD1w9WFqFwYFjo/hJHmy72raPDr4h6rOX5tCmhZL42N
ihXg6CwrF8ZelRayEgu6gFUqd/zngl4uKjmpZvHCFyDavVyILceD1tTJpX6y0E5SwMIgqMs4
JsIvAiwn9aVqEiwXbUFXslhaM5Q7fIjHSXM0KaOnN4mmGcSFJS5HFU9bVNnCqloTkbvV9AJx
45lYWHVEzurmz/K8+ImGL4xVOb2JdGGoNwc5j9BV0BwgUGdvrUPPsqBaXSrCXLafZ5dWrxPn
ebkwV3ZcjgMSfUjrcrF+Hs6JVKoWZpLedefl0OK3n0o5yqr5xR9cl6JKqgQwRbXieDsM7NaT
rlu4TeMTUyoV3dOU2Cd5/Xl9WYEhLJVQXVdBSHdc8YXslIeYm/b9Nz0d8JnZKRAnl8gajdWx
/A4Tl0OcGIjJZplfqZRFISe/OL0U6WmwsZs3Qf784/P15eXx9fr264dqkOFiVS8wSBv9XIEt
I0edPikuw57OzGLZ7O0sStLldJATWEaLBJ5tpiwtRQN9bCb1stNDRQBxVosnVb1btiPIpoMm
1S8h/Gp8C786c0+pkgZht17PmubSQevj1GS7j1mFAEak+xv1Ft1Sg1JUvqLW4I1T1tKlaRC0
aaA3CLmXwNLOsjB+h8hG2bWusz5U86xAcCgn6AbAaPOdbDG45D7Ei2NnJrKc8mLnckKEPSpK
JP9GZtqBgciJyCLHmWdlIstylhhkhq8Geh2xIPDl/vxAaBNqDouVgy7MSGSEZ0UEoorvlvfh
xqcOPLhVjV8efyAxPdUEEc/qYwjDTmTglMwSNOZrtj5alFyL/rVStdGUNbzzeLp+v74+/ViB
BUcs+OqvXz9X2+xeBYsXyerb4z+jncfjy4+31V/X1ev1+nR9+t8VBJvUJR2uL9+Vzce3t/fr
6vn1y9uYEsrMvz1+fX79Og8sriaFJI7Mp/GSyivKlYtKomo4qWNrelHk3mueURsK2LNkT7xZ
mHgS8CZSW4Hle8eLL48/Zfm+rfYvv66r7PGf6/tYwlw1q+we396erpqjONVwvLyURXa2c5Sc
YuwIcoBchN292E79+ufcj09frz//J/n1+PKHnBKvKhOr9+v//Xp+v/YrR88yrpgQKlQ25FXF
Fn0ym0J9Rq4kvDrAw2Y0F2gVzdkoS9ibHNuMes7S1GBbnnMhUtCId9hNhZruD1yqIPqrQZ06
n5gmpE1iAsF6kYqsZx7NTj1c1Sw6mlshQj0GlRo1sor1K80bTbmoKXUXiRo2e52iYf0hJQox
XsdsS4H1vefod30a1h+N4dk8ePqpu4YoveGQsgZF4TYXDgvTLB30LKOKR+mVXImwuxCdpz+4
uuQR+qE0r9I9iuyahMvqsheIHjzKlaNGEV6xT0R2ieM7PTdy6rG9MSzxXRrM8E0vROS4nouX
L3J83Q2N3oHU2zWieCec3rYoHc4c5V4fop4StTJwfFTk+wyNAa1zlFsuO3iM96g8bi4tVRfq
iRuRv7wUYUhYtVtsEfG+U2fr2t9p4IIdc/RNscZTZa6nB4/RoLLhQeTjPf5TzFq82T/JKRv2
MPjEUcVV1Pk4xnYpUXsAXSomN3e03jRNTWktN9K8loNeUHP4yHvOt+Vs4RlA4sjKmBS2aQ0v
kpa/0skZscSr43SabQmHqq8GLyDYd8u84EVKbZU0CTEpooPd+iX/QMZJbm+3ZYHP5UK0RvxE
vQs0+ABpqySMduvQsxWwacJGA6/DkmduUdG1L815YH1XklxrtWFJ28x77lGks31pzUvcWwaA
WbovGzP+siLbu4Rx4YjPYRx4NjZGANfX/UQd+c42TLCO2JcberHg0iqRSkPGzlbhuJA/jntL
YclmezKpABVxeuTbmggHorJXnlgta6aepU4JZyH9FhLCXqsdyo53TUvq2lzAS8qdtTqcZQKr
ydIHVSud1eCw55U/Xd/p7C2S4DH84vn2bDcim0C/V1d1xIt7eDAEMXx7Jz9Tf6z+/ufH8+fH
l145xztkddCaoigrRezilBsPFxt2OJYAkVVSOd7aUn/67YXdBj31A2VXZwLfGP/P2JN0N24z
eZ9foZdT8t70RCJFLYccKJCSGHEzSS3Ohc+RmbZe25JHkifp79dPFcAFIAruHJK2qgorgUKh
UItBLauTmphpTbVbbHN8wNv/ZhHY+upWxtuoXGyXS3SGtaTprK6n95fqChPaqVvU2WxUBpoY
vcpqGHnXNnQ6PbjWtLemoh1VEUJtk24A84nNe2tw4bG6HvUul1MKTiSm1HaR5zj2ZGvI3I0k
cAJY1pQ2zGjxM7MosUo2dGQevr1W1tC8nbnH6KdKDPEnuWSKx1S1feOAsmApZYcvkFuWq1ME
v7Xw1Gp1PEQajxjVLrLi+3v1hYnI6++v1T/V9Vevkn4N8r9P9+OLrokWVUbbA9ywbeQhQ4eL
gP2a3dd7dT0/3atBhPdijSmIejD+WFjUmhr57hamQW250Q10T2vTIzrusx9h+ivJZ7qB9GLP
V2+X6/f8fjp+I0LON0W2MRe74PjaRj5V1Kwd7frZVFYEy6iMaFbTEv3OXyPj0p7RL2UtYQab
7pPxl2iDUfgbnFaJA/t7fK+VFNL4S0RpoGAlf1rtYRYZHlAxHunrPcaQi1dci8oHja/B2nzy
Yq4cqkpAcnsydpTrDIfzyA+U1NFh7V5VGCJBdg5ogcPRQas/Ze7cMbgDioIYjZqya6qxjiPn
bezj1BTsHZjSP7XYiUUUmjkGV9L6C/lwakZuQPnpdQOVI123UCVuKof2o8m2QKc/rXKYYWVd
eMBr9WE0Tk1ji5QkOU3BXAwu2auwCJkzV4xAObgLPaovG+cfTXTuViTXl/75ejp/+3n0C2da
2WoxqO0XPs4YuY8wzBr83D1v/tJb0wsUj6J+/8IDS1XZsoHD1Jm/J4ZNNmMxa81scSCHV1xP
X7/22I6YQdiqK98Q0AG1QpgfJAgDQ+iiAP4fBws3ps5+33NZCcsAn7lylsnvURylvexlBcOo
aioAE7dOZqOZjukxJQStWZHkjzSwiZ7x0/V+HP7UjQFJAF0ka+q4QGxzLkigeBf5bdw3AAxO
TfQ7iashISzupcjrplbA4RjqggD3onbI8HIb+KUhfgfvarZTxHB81cXuaRy3IRYxsw9qLxDh
LhbOH35u93sicIcZqQ1sCLwcxPEpVVRgSubHcMOhAvDJhNOxqYrp2Ji9SSKbTKkTsCHAfG1z
+XYuIXoBj2VEL3CxgqIk6YYiyx1mK5Gla0SQhyNrODMhVEPeBncADGUH3OB5wmbZvF5BKKlc
FIxtxEzIpcBRhvwU7dyMR8WMYu0NweLBtjZ6s3rGAwnTBPDVWsvh9J8PaUuXhmYZoVfbpyQZ
LHEyuapE4MzIHmBRyxDAvCbxI3toGUJ6N7VgDGlbY+c5CPTGHU144iL90/n5x5zAy23LJtea
wIhEr58vOWtkEdsm28Fg54ysW+D0utVr4acdZ1GS643C9rdUdxgJ45DxCmUCh9gGyFFmTrl0
o0B9P1QJfsiVDKF+JJKp9eNqpmPSEUCmmM0crZtiDDwCEwgb9MGvtEKLwR2JNTZ4NrYkXEb8
rKtNbil9Lxeb0bRwDSkZWvYyKwxu0TIJ6TwsEzhzguPn0cQaE0x78TCeDQl4ljpMVkQ1cFzm
xFEjxXXjK/5y/sLSbW+96+yrgL963Kl1ZMir8w3E2B9UIVmjYbwvYmo8zEfGbaG6bnewvlAk
YXbKPRqf4bVYuBiAS8TjUGro0ofAnTH2Q7VlrsyQVwneXzMXvtHKI01BavMzQE4UQaKGJ25B
l+OR+ddYroxWkaJB7FDUjO2xm6yXdKWGyrU0hL0n+Rq7zreIlieQvZ6q812aQDd/jFlZHGrC
rubI7SuZm0oW26VkslbT82pQwdn1N99zqDLR20OtNie6m9YBpeWfGDGDy/bDHjhLeGOOChYq
gjKC24aSV0ZgedrkBvfTTw0SY9OHPaspQ2woXFafRGUTobLliurg2ZEf6xHPeXiN2+Wv+2D9
/b26ftkNvn5Utztl/7h+TP1MN7U8VOfmwqmp0dBhaYGBc9RnKQmMGpwkeyzXSZGGZNw7JOYX
LpjAlbx9EcFD6O8Kto5VOIZoVJykALjM+32A5Z+6hcCRU83bhsuWGDq+3Rs6CP+hMlx3zkLk
Ki7EJUiDlWIl91CZG/NghyLPOYlE/qEi832QFOFCDRyOJWBbYl3djCijS3cMKup6bpyGhrCu
xzAPKSxLFmmtRMxH7wdDoTVG0Ux3UbRVe+5ui6Q8hMADenDBOZVvFPUWBq9zl8pV5oULPFp5
9IMF4Hv0q2+G+ZL1/RLAprzda3Oz9kAS+QCOx+q1ul7eqrsMPT+9Xr6iVdTz6evp/vQ6OF7O
UIygaQj+PH15Pl0rkSdUp2ZP709HIDwfK2O1DavzpiPVS5VDKPEFENPxpGXTvH34R9Sdfz/f
X6rbqe1DXN3/vly/8Z5//091/e9B8PZePfM+MbkjUsPO3NYvAC6M8v/QXKy6fv0+4FOHUxsw
taw/nTljrXBW3S6vyHhM09DWIOICG/zVAXlY6fHC8vfq6dvHO9Z4Q8u323tVHV+k00asJ5EP
pZk49/x8vZwku7cmvLKed85bxZSOZgWbMV25eE4op0EcACfKU4OzXpQYHmNXmf+4MFj588wK
i+TAo9YSpn+3b9VdMqpsyzUjX7n5xi+Ad7iRv08yyiriEISlewgwJv9SMok6zCatcW7ZCWaS
sg7ToxMmHQrF2qPdAtFfswzdlM5s5vlhCKthESRqNo0ODP+QSWCQQlRLFExmM1OQ7e3vQQFi
kN4jjaRAQzrDh0y9Mk0Yn3CTi1sqbN9MyE8nFMQTN0eXps/6iXrhTep65kyxQgzPMWpeSjck
BFaQRsKEdizmn+8HHz8Nyr3BRQhddwo3+3QYSb4OFi4GgMqWmyCkZ6yhWptGwrvBopR+shXj
5K6kO1OYeEGzWxT0B61l+08nMo0+ydWE8d+zgoxsKDzEiPXcYB4MIXK54Um5igzu1qJXmYEd
1c8j6J8FkNhnNFm6SzEP+g+GHRhmPt9mS8zHCAK6XS62RUFqeup6gLEWWJP0hBoeSM8B1Edx
10coCissLgK3oO6a2DV8KehqbA+BNEgVQx+2zkAEaVuj5PkI2IsbJwfCGUM8sTSyswaXbVBZ
uEEpEETuzVZyQ+FiEuAwwCUcLZKgJd77ENccbXUsRvZ6OX4TuUNQBJDPha4MD80wNqh9JLI8
cGyHfvRTqca0VkYiYh7zp4bwyTJZjslISmbwXt7naQCMSbXwE2Pk484vH1cqbTtUDfeQMphZ
sq4NoIvQ60PxDRNOXXkdpIwSBRqVgCBuViGMZSs9N4mzGgWo03HAkYP06Wt1R/t73QJFlOY6
DfU+hFE+RWldynq73Kv36+VIaC199ECsX34E9fvb7StBmEa5InpzAL/2UoosjuTqiRU3yYrd
Au67ksapTwCAPra9CDdcAePf47HSKpMvH+fnPUi6kkqn4yENtR4bVhRO2ODn/PvtXr0NEtgV
L6f3X1BEPJ7+gu/g9a4GbyDfAxjjmPZuDYvr5en5eHmjcPEh/bULcvpwuQYPFNnpf6IDBX/4
eHqFmvtVtwNkZdEq1g+n19P5H5oSZLggPpQ7pmSdTrngtsz8B+q19IDsvanc/+cOQnTjmqS5
1AliTD3exP9vG2lQIsGssSE50buG6KVy7xBqRs8anhWz+dR2NXgeOY763C80F9TBIq86+FGb
v1Gwki1IMFqadEmHJfwG5ehS0RkguH759j2yLfGn/GgrldFIeas5+um0JJZMku+JFCk1oi5A
XPN6d+P2ZncIbTm0Ww1QoxotInekJiddRAwutrq024jkriWHkPLcXn5VD+QPb0g/XHAc+VbG
5yeD64HPRMt14jVtHooabePNh2xkc8g9uvnNgf2+GQ1HlPlMxGxLjkYZRe50LKfqrQG9ROkA
VJLhAmCmZEgBwNxxRo2qt1vhAk71hGPUbOcHNh4aMh0DbmKRedDzYjOz5bymCFi4XGnxb/Qn
smLDmlNdBcR8rhy2jI1ABBghw6FXgDvHxbVKewQNOowtLCtXGRbMGk+p5jlGfbniIFMCdmBk
NpmwGiWqiRwALWKpPbbkz+jH5R+j2azuXA2N3e1Uedzhp+YOuW3fpqtN4lsGShUdfKfAQRKG
38PZSLXuRGgOS5j63oiMbNs5qJ2s89TCIHvQCUL5l+jAOxCis0WC4bTczuq2XijL6+V8H/jn
Z+nwfX+FQ1nWoL1Ub9yUW7wuqeuoCF1gfuv6Ikt+pEXkT0gTAMbymfyJAvdBfT7Z/TGbtxaq
69Nz876FakUhX0uiGurs8/ZCLfa0kD3ytClIFQL+oxaicXXPatn+4yzrGBvFH2y7JzGvtHrR
Gcr5WzHjvMx34fd4rLxaA8SZ25TIB5iJHO8Mf88n6gC8fDy2pPaiiWXLnlmwRZzRVNkh46nl
KAvWc5nj8HDDrT73+ePt7Xst9vRmUoRma/LlqFxewokbPnV70yjb8/m/RArG6n8/qvPxe6ti
/Q/a4Hle/msahu165VcPLuM/3S/XX73T7X49/fkhZ6NNX55u1ZcQCKvnQXi5vA9+hhp+GfzV
tnCTWuh/56/fr5fb8fJeQd+bLdEu9tVIyfDFf/eOmHRrD52hBuhHpKxX4OoxS/TDsaEpVrY1
bPn/unp6vb9IO7WBXu+DTBhen093pcfu0h+PZc8OWBf2sJcfvYZZmqiy/ng7PZ/u36WZkC5J
lj2ij7i1h6cKZUa2LnLLkpiC+K1O4LrYyiR5MB0qMV/ht9VOSQDr4I5mm2/V0+3jWr1VwPE+
YBaUrxb0vlqgfbVNdJADyQfxDr/bhH83RYSVEQRDCfNo4uUHE1zmXOHp68udnFlUpbkhtSBc
73evzHsSnBvaGNOUIk+9fG7LlnAcMldmYz2aOr3fMuNikW2N5NjPCJA5Dfy2ZXs0+D2ZOEoP
V6nlpvDV3OGQ1lK3PDoPrflwZAiVqRAZ0nFy5MiiztvfcxdT3Mh342zoKGutbkEzNC8yZ6ja
du9gw4wZqaRyD+PxUN1hSVrAZ6BkohT6ZA0RKS/x0UjNCIiQMb3ZQEi0bVJGh2W33QW5zPRb
kLp4C5bb45FiSsFBpJVlM0kFzLQjGxVywKwHmMqGkQAYO7bizeWMZpb0RrxjcdifvJ0fgewz
pYa4CycjebH+ARMN09keadHT13N1F1ctaqvVd6fIXcWGaOGAgu2m3BiY7VhjpYf1JufVmC86
7XNAxBy4hvcbFB3uHHJaBh+cj6+nszYIjmvsvwdf8Cn2/AzyyblSD24eziTbpgV9y+UmzBJK
OQvfL3dgqKfuripLLxa5PEDcnclOhih4wI5WAcoiKNIQTx9T2zAumZuHUTofDbtDMb1WN+T8
+mntLtLhZBgpqrZFlFqkuLpOlU6n4Wjk9H/3D/rQFkTdQZo7E9IAERH29Lf+qcC9Y2loX1wo
nPGQugqtU2s4kXr1R+oCd55oAO3kOePbcm81pdfLP6c3PPDRsPT5dBMv69rMcibryCwrDDx8
ZgoKv9zJHHaJT+mqrig/zGnP4jxbcmPpf/eeLZZ/9faOgqD6/bvvER7mw8mI1pcLpE2t4SJK
h0NpDvnvqczHHnP1POAQizYZiQvajW0X+aXpOTrdRxpvCLKHwfHl9K7bFrlZVK4CHgS6jLPf
Ru13SjGqS8+rTtwWi5QFlin1ZBOnImEFme0YFqhfoH6syJIwVHOKChyGu3/MGfnYtIyk9Qo/
yqW78RWrIAQCR9opkVsQuM9whfmoZVeeoxCH+nMq/l26fhzkH3/euH5aMkaoE4gpfsoLFpWb
JHa5G3WN6r7J+hE9Z0trFkfcb5o6zmUarKSrG1EsZW5aO+Yp9XK1gvDHNtQqUQSsX7x5p8QW
DeULwIH4I51kPLgrUzM7BF6IWv7fe4+RLetWOg4/DZaOiAnTzgu4uqK1N2cmb+KOQlnVZS69
GYr1NvZQzRHq9o+dkUl3NMVelpBhCT1Xksy5zZkMaFx/2t7whMbdahNXov3gfn06cuapZdsq
5Ax0RaRflhGYJ9uM+U30IVJua4nWvpsVCyXCj4RdYtQmSaMiXnGLtfJBa5gxSlRLYPAobvGr
Yq03Bd2hoLAa6U4Y4oq0BKaMv2gGJN1ixGNgmpV18DKFF2Cms2iVNVRsZ7AzQbpFFngrQ/50
xHtL2h5CmCCJGEYmHp730pE24DCIeiwZQWKDsyLT39eWJzS54vxLNrVmLlv75T7JvNqhT+KV
OezuPDgAQuKg/gHfSdW3zgZWLvClFy4qFP9B094S8cJmsBWNYw+dQR8NeKjUj1n22ERzacFx
UgRLZV94AkQuP47hLpLKV3aNRR62SaHYTnMAhgTgz6NcHkabCPrgxfB/dYm9m8VBTC1Hge9Z
ygtgkfnSlnxYRkW5G/UBVq8UK0IdUtvkSst+WyTLfKwk2BYwBbSEuVIATIRUqX8lOz8L3cdS
XQcdFMNmBxkcAKUXUNpJitIN9y5shyVIA8meagrT7/oHQ4MxrpRDP6aTTneAxcAHbKgn8mHe
kvRR20Ds6fgieyksc753lPUkQGjPV9DbuaFYB3mRrDKXMotraJqVoRVOFni0lv1gr+KUvFUf
z5fBX7Dbtc3eJVaXViqANobQjRyJEpi8sDgQLccxOmyguHFzFFsHoZfJRtMbP4uVlO2qvyvI
xWqfOKBjPbRojV/SLQqp9fV2BZtzIVddg3h3JZbjR0uvZJmvGEKLf5pd0IknQS5cINAJ2CcN
ioAnoLGmTCXJA719hb/lnct/K2oaATGMnCPHffJ879LHkyAvaYMgHuLWZKkv+s3XmxGPLEK8
2ALvJWemJsIVAEczEPV6TslXq4ybmoFcnUg6HTwY+j/FTEht9d/fQJzNZEM08btcKY7hKct9
Dis32UK5idfk5mBAzE/XdFQfFqjLCH8LtkCJ1hyL/gd7tITz2TbziadwTrX33Q1c7DCUNZ0s
gFNtU3QuMOP51jF1ROM7HZT29uvwKKympTG/iSD8F/37bOWxxHNLw6p1eVkSNU/pLxXLfmTw
o4nQ/dtPp9tlNnPmX0ZSOAAkwNRznAGObfrNWSGi02GpJFNl2Sm4mUNpOXokljoCCeMYMVNz
k2Q+yB7JyFTxxNgZ1Ymzh6PCpfRIjGOZTIyYuQEzt01l5vI7Rq+MaWjzsamd2XSsYkDWx0VV
zgwFRpaxfUD1Zt3NWRDQ9Y/6c90g6C0sU1AaQhk/NlVNvZfI+And1SkNnhsGZhvghoke9ZbN
JglmZdYfAoduDf1HZ0y4vcuBJhsw88NCjvDbweGCsM0SApMlbhGQdT1mQRiqepkGt3L9MKCt
a1oSuDNQHiMNPmAY/NCjag/ibUDbjSvDD8jYiQ1Jsc02gRztCRHbYqkExPBCXSWZV8ePK+qL
Nf9TPEhkOfIx164zdR4FmG7Ew71rpeop63Lk4OqLpe9pJF2LpbeG+6wv8i/JQiye0kEB+MjP
ucKyyAKmeBg1JOTzl0DJkiHf49xfBddu6KoXXm5YzpWTMfQXL7J4SRFOi3Uwpe7pvE9GXTLg
ooRXYqEFUtVL0DTjZTHC2toPUzKSfZPJopsJVzYt6WFl11yc9KTRhbHr9/f7ZXDEOPSX6+Cl
en2XrUYEMYxz5cpOigrY0uG+65FAnXQRbhiPn27G6IXWSlgzCaiTZrI2o4ORhK3soXXd2BPX
1PtNmurUANRrwC1FdCd3NZinaAVroM+8NSVKCiywDXdFdK+GW0SF/UBWZMHSC3K+V9ChPdeq
Xy1H1izahhoi3oY0UJ8BvNQ9bP2tr2H4Px7R9UhgaLm1nu5tsfZJR8WaIA8ife2uwi0qcnEr
1mksheL64/6C75vHp3v1PPDPR9xM6OX69+n+MnBvt8vxxFHe0/1J21SMRXpDBIytQRh3rWGa
hI8jJXdyu7NWAQZUMSL0KecYy5kYi8AfeRyUee5T27uu9odE0IJKo32xJNvmE0O88B4Nr+OT
lYlkI8VQuo/h3/ETNDmQDu3uDjo69x+CnQb14YsFMUcItwhu8obJJm76Olgw/ZsvFzqs0Pcx
Izafz/SyYbbXYCnV8IGoEM7hfcbfmMTzydPtxTSUyNWrXPcCbDQtQfPmr7kThRprgup21xvL
mG0RU8fB4jmCRtLQ/2/syJrjtnl/xY/tTJvJ2k6bPPiBkri7/KzLOrK2XzRJup/rae1mfMy0
/74ASEo8QLkPTmwC4gmCAAgCMB8lx7IAOGzeF2qbhqQ+3bEHVXIfWwA9J3YdUS0lFlzZB25b
KaA/fJWaEFrtIVMVG98HK4b/Eu8nKOZYBxSfncbY/V5s2ELYbr0840DINiww7DOAP2xONXht
bNRCxd/a+y29iYTtVVx0a68ebiAfNhzTAwCn5FloFc/JsOs2n7iqDi00ka6LCHAi4pxqNe8J
LflRvOp4DwsZcwAo04+r4uKZVqOTVvZzm6sncj1mrOeshXd5TPZZ2Ry2itlcFhAZI0N4st+5
wCeqivPFDDBS+3SG66MPjo3/jnmaRu2H1KAQxrEBKnfaXxtSP8QUTKVr/S8YWoGys0kWMj3D
W/p/jSYu9+JWrMpxvSh7cco+WvClJm5aDIiZlaiZIGlmCO1aUH0ZmYDKSZ5ITZ3FWZldB+U0
PZt9tT6CVuZ85lPLW+QKqQ+Hht1mpjxFkBacGJgPns4O4oYZmMXi6de+4f6OvoP37puRmQ63
fqwdKwrdNkxjHxOh9OaPVicZwPvVk/a2H+IUnd2Xx9/+ejipXx++Hp/sewg9lJhJ9mrK2469
ybYD7jJ6NDXGWxIhe0420xBOSiEIJ3IiICr8nxowxzI6k7XcWqJSOYlWrVycBIi90az/E3KX
yA0c4qENYg1xn4rgcVNhbiSVk00Ko+DHpIiPGP5PquAzhap+vr971F6N334/fvvj/vHOe49N
N5VOSlBjPmOWN1O16G60V8P2Yvb//Pr05emfk6e/Xl/uH11RPFNDJzGYmvu+nMxZrieedZ3r
h67O2xsMmFVZBw0GpZR1AlrLYRoH5V7jWNBW1QX808HooFMxvM0VvtF384haUFBM6WPxKjOv
2ut8ry8gO7kNMDDB7BbPSQpr0ZbKt3zkoHKrwWPX+eYXHyMW9aEzwzj5X/k6BCoPvSy3Jraz
X16qXGY3H/094UBSfIVQRHcQiYzIGiNTnL8FwHyu60tQuR99XWVaZeIr8gMqi7poKme4zDe3
UCHGHveZL5VGLBl4MZmUfR9qLC0kV37ul8/9ur5FAGsltejT7lY5FOUAMgCcspDythIJwHlM
s64x2M6XpFSMZeMdkm4p1urSYJbvvT/Ix3DAkI3C9WvoRKGuyU9J03rTFS6ti75vckVBJmBn
dG5GJdwjsLtcL0ldRIn0vF2H5YU7AzV1XMf7BI7geRMSjKJyipaM2M4y0+akIH9F0U0DnOQe
P0CIcUJqWtfIr2MAOgW7MowTWFy5TK1sPOdW/HuNVOvS92HJy1u8AnAKYF7d+yXovlu/6q5Q
aec8RapWeTHxG0wCjyaxobsJJganWccOcZMNzqAW1mryrO8zaNQ+g9O2HPu9dYdKIVW5yU9n
J3OAo6eQbeNe53SqohRHmXTzXuPlSr1zeRydQZfHp8fjnye/f7GnG5V+f7p/fPlDvz54OD7f
xfdKdJJdUmhbd6rJlxbjKpZwfJWzMf7XJMbVqORwcT5PuY5CGtdw7lxIodONab+QQczU5ZrM
5P/ms7mh0Hn/5/Hnl/sHc7Y/02i/6fKneMDaOQN4onMhuZShC96YS8+g7UB7OMc44nVQioPo
tp5usCsyjDKqWvYVr6zJdl+NqFLupZtvh4LfkdfkxcfNp1OXAlpgK5WNTbkcCSBSUW0AZJoa
65HS0VKiwvC6rTnULteyabocDgSVY/COoJMasQeGoTD0ieorMbh8M4TQeGxiYZf8p88CX72E
qQpNRxp00NYePxjapOUuqCuBjzZAmuuulrqdwvkmTs/5xfu/NxxWmOJW90A7btntpjMXnRTH
r693d3rDuZMprwcJWgI3EoQT3+TdZfHrtlEYLY8VQJdKJi1zBdV3DUyhSCfQ01jabTIRuVEv
aCk4KxvdvZoJAV5YwoLEfbCQZPf1eo8mhnHw9WeOdGcOanB0+GvmYw1YGZgJCqxqdiMbKPlC
g8Q6ya5rOvOAwz2M51mgoaDP7Nbz1F0F0uc0okvRu+4P3J9IS53nfq2LmxHdrzlfVQ1XdelF
DZ9n8DJv3DuSXJ95ooZiSlsN9OddESB+eiX3ijabvhvA3XCCcQJev2s2vP/yeOe+NQRNYWzh
0wGm05XN+mY7xEDvpCCpy0Vswyh+byIjhxnlEmobnQMMnJganYKwZpX3hMfBsn1LkBcCpz2+
GxpEz1H/4Qq4H/DAotm53Be7Bhyy8QQur9j0fOMDsbtABsuAehhGETstUnHkiO19o3ekBB3R
svdg22Bbl1K2AVfS+i/ep82s8OSH5+/3j3jH9vzTycPry/HvI/xyfPn27t27H31a0HVTvNco
x1HbwcZxHkEsOhJ+iKNJEiXKzuMgr72A/JpcTQS+sDyBfjhoCHDD5tAKV8TWCNSXQAomf1zZ
cqhMsU37VEr+E5wbMsEYea+PpgLoEXOgRizf0tw8hkgr1rsdNjBogjtPxARiCN5C0akNI8VE
fqBdAMlo/ZPh/vpwSa4O/HzGx2euTcSMV7m9MyedYov9gH+6zDLttWMtB/lOYnRNPxyENgHm
I3ugEyF2uWPKc6fc0QPzEYWTrS1exDIAvLFKhGJm3PtOXvXJR1yGSK+MdNSRXORogdwhFsgk
bcWj8R5wkgLLv/mBFV9J1mKb3QpVhhKGB9QSTlpOIpwt0vXbDbuy7LJ1QCmu8xs+jDPZKJdd
EDMnzL9LIPfRBZ7q27HWba5Dd51o9zyO1XfCx4gMcDqoYU/JacJ2NLjKm7EeAAFV5wAF37Lg
diZMEDjrIaoELcg3QWFuatNVB6ykowfTQb91V3Kf65IKG4YTpEBHhO89e4P/YJkHtECg+hBO
mlOVeTeAT0Dcc0TKqh3QPMCONWrPmpDChgxiTAzhSsU0sJAtRwDsc6O50zr801I7lIFcs2Uq
1yd5ss79AWie65OhcU0QbJJdvbh9Ldp+38SrbgFWNQtWQNefYULwvUlsEhzpHkzC7mLlWgsW
NXAggb6q+jsZryYDMW2Eq6oFn7B0hLYyGc19UBrZKPRU8gzLrrwZBS9D2rUYBJwWbVqLqyrV
RG0FU+CbD/Faw+awDJaGdsSUATvcV6Ljd6kHXg4oB+HNPuuhSZBkySyJk8A9eUI1xK70vLOW
8woOY1XIqdnnanP26ZzslaEut6wLmjlBgkg/W+qAi6GZDXutEy7UrGVBVuGhTmo0nC2obQNH
xIAwquFDrfcCg7RxO8vRBHeFZy7Fv9f04DFDJQ9+1KBu6aR0qDfTauRcWYzM9lOjiVLt6iqI
Kh82D3IAmkKVeasli3C7W6kyZpd4fWwEQNLV3JjhUnSluV3zY/U65VOR7fgnfh4Whna4Lli3
NsoQMdD7LD+E4gKINAE30EEzZmXonWy0pDIj+29was7bNZ4N1WjbJ11kTu+vP75f1LkQBrO8
4WEj/e7E0vWgyE8vzhxTuYVic+xMOhisz8UMNw3/w3ya4OLWBud1cem50RHINGzvWZZ7tlas
7OUGdmCF9E2mjzXzWSDZGPWhUoyOhCRh5MfWj1FNwf1RfUvK52N9wGfa3QTiubcdbbk28BL/
9Q+EfwGJM4X7MaABAA==

--cNdxnHkX5QqsyA0e--
