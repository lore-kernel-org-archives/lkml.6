Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59013ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39AD20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39AD20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388121AbeGWPnG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:43:06 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.116]:42148 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387910AbeGWPnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:43:06 -0400
Received: from [85.158.142.194] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-b.eu-central-1.aws.symcld.net id 8D/72-07797-919E55B5; Mon, 23 Jul 2018 14:41:29 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRWlGSWpSXmKPExsUSt3Opsa7ky9B
  og3WTBS1Otexht7hy8RCTxdSHT9gsGmfMZ7X4dqWDyeLyrjlsFp27+lktNnxfy+jA4bHhcxOb
  R+ulv2wesxsusnjsnHWX3WPTqk42j31vl7F5rN9ylcXj8ya5AI4o1sy8pPyKBNaM06vmsBVcl
  atYdnU7YwPjfckuRi4OIYGljBI3Tyxn6mLk5GATsJCYfOIBG4gtIuAhsWL/AiaQImaBVUwSP3
  8eZwZJCAu4SJxu2csIUeQq0XrgClADB5BtJHHvsxxImEVAVaK3vxeshFcgQOLujslgtpCApUT
  n5udgYzgFrCTWH24FizMKyEp8aVwNFmcWEJe49WQ+2D0SAgISS/acZ4awRSVePv7HCmHLS2z/
  9psdwraXeH3vHQuErS/x6PEjRgjbUGLVtANQcXOJhv2bWCDm60gs2P2JDcLWlli28DUzxJ2CE
  idnPmGZwCg+C8kZs5C0zELSMgtJywJGllWMlklFmekZJbmJmTm6hgYGuoaGxrrmuoYm5nqJVb
  pJeqmlusmpeSVFiUBZvcTyYr3iytzknBS9vNSSTYzAVMAABDsYF/9JOcQoycGkJMr76lRotBB
  fUn5KZUZicUZ8UWlOavEhRhkODiUJ3o3PgXKCRanpqRVpmTnApASTluDgURLh/fgMKM1bXJCY
  W5yZDpE6xajL8ef91EnMQix5+XmpUuK8R0FmCIAUZZTmwY2AJchLjLJSwryMQEcJ8RSkFuVml
  qDKv2IU52BUEuZdATKFJzOvBG7TK6AjmICOEE0GO6IkESEl1cA4caFCBNcNxpvXTvc0Cd0xdp
  1YzXSUYfXFNz31Uyv2rtbm//LI/GrAlbhn2h/9o10KWR7XHMxufP2/ofNM8+ydn8p8hCwD/1k
  lhZ6q+ha0QuKt1HSTQ9wa92bJ7r18PV6tZsOa0jSj+uXB7dOdOlpc8o2tlJt+5f9+cXLxmyat
  s4cZfG3/H5RRYinOSDTUYi4qTgQABwyRvosDAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-25.tower-239.messagelabs.com!1532356888!3037333!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 21215 invoked from network); 23 Jul 2018 14:41:29 -0000
Received: from mailrelay2.diasemi.com (HELO sw-ex-cashub02.diasemi.com) (94.185.165.51)
  by server-25.tower-239.messagelabs.com with AES128-SHA encrypted SMTP; 23 Jul 2018 14:41:29 -0000
Received: from SW-EX-MBX01.diasemi.com ([169.254.3.46]) by
 sw-ex-cashub02.diasemi.com ([10.20.16.142]) with mapi id 14.03.0382.000; Mon,
 23 Jul 2018 15:41:27 +0100
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Daniel Kurtz <djkurtz@chromium.org>,
        Mark Brown <broonie@kernel.org>
CC:     Akshu Agrawal <akshu.agrawal@amd.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] ASoC: da7219: Allow pdata to specify a VDDIO
Thread-Topic: [PATCH v2] ASoC: da7219: Allow pdata to specify a VDDIO
Thread-Index: AQHUIhOzzaO18NsZukmvsqMji0Bfb6Sc34Fw
Date:   Mon, 23 Jul 2018 14:41:26 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337019830B8F8@SW-EX-MBX01.diasemi.com>
References: <20180722232822.34641-1-djkurtz@chromium.org>
In-Reply-To: <20180722232822.34641-1-djkurtz@chromium.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.24.43]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub02.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 23/07/2018 10:53:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 July 2018 00:28, Daniel Kurtz wrote:

> Some systems do not have software controllable regulators driving the
> DA7219's supplies, nor can they use device tree to create "always-on fixed
> regulators" to easily pretend like they do.
> 
> On these systems the call to devm_regulator_bulk_get() just creates
> a set of dummy registers.  Calling regulator_get_voltage() on a dummy
> regulator just returns -EINVAL, in which case the DA7219 is always set up
> to use the default VDDIO voltage range of 2.5-3.6V.
> 
> Provide a new device property to let such systems specify a different
> VDDIO if needed (e.g., 1.8V).

I'm not sure what the general view on this is. In the past it was suggested
the regulator framework was the way to go to pass this kind of information,
but obviously ACPI platforms don't tend to use it.

Mark, what is your feeling on this? Would you be in favour of some kind of 
fixed voltage regulator representation, similar to the patch for the AMD
platform (ASoC: AMD: Add a fix voltage regulator for DA7219 and ADAU7002),
albeit tweaked to avoid asynchronous probe() issues, or is this a reasonable
route? Personally in my mind, and in an ideal world, I'd prefer just one method
for retrieving this data in the codec driver, but that may not be sensible.

> 
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> ---
> Changes for v2:
>  - fix to use device_property_read_u32()
> 
>  include/sound/da7219.h    |  2 ++
>  sound/soc/codecs/da7219.c | 19 +++++++++++++------
>  2 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/include/sound/da7219.h b/include/sound/da7219.h
> index 1bfcb16f2d10ab..16ab125ad4adbf 100644
> --- a/include/sound/da7219.h
> +++ b/include/sound/da7219.h
> @@ -38,6 +38,8 @@ struct da7219_pdata {
> 
>  	const char *dai_clks_name;
> 
> +	u32 vddio;
> +
>  	/* Mic */
>  	enum da7219_micbias_voltage micbias_lvl;
>  	enum da7219_mic_amp_in_sel mic_amp_in_sel;
> diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
> index 980a6a8bf56d38..9893920b26f41f 100644
> --- a/sound/soc/codecs/da7219.c
> +++ b/sound/soc/codecs/da7219.c
> @@ -1634,6 +1634,9 @@ static struct da7219_pdata *da7219_fw_to_pdata(struct
> snd_soc_component *compone
>  	else
>  		pdata->mic_amp_in_sel = DA7219_MIC_AMP_IN_SEL_DIFF;
> 
> +	if (device_property_read_u32(dev, "dlg,vddio", &of_val32) >= 0)
> +		pdata->vddio = of_val32;
> +
>  	return pdata;
>  }
> 
> @@ -1717,8 +1720,12 @@ static int da7219_handle_supplies(struct
> snd_soc_component *component)
>  	/* Determine VDDIO voltage provided */
>  	vddio = da7219->supplies[DA7219_SUPPLY_VDDIO].consumer;
>  	ret = regulator_get_voltage(vddio);
> +	/* If regulator_get_voltage() fails, try to use vddio from pdata. */
> +	if (ret < 0 && da7219->pdata)
> +		ret = da7219->pdata->vddio;
>  	if (ret < 1200000)
> -		dev_warn(component->dev, "Invalid VDDIO voltage\n");
> +		dev_warn(component->dev, "Invalid VDDIO voltage: %d mV\n",
> +			 ret);
>  	else if (ret < 2800000)
>  		io_voltage_lvl = DA7219_IO_VOLTAGE_LEVEL_1_2V_2_8V;
> 
> @@ -1872,6 +1879,11 @@ static int da7219_probe(struct snd_soc_component
> *component)
>  	mutex_init(&da7219->ctrl_lock);
>  	mutex_init(&da7219->pll_lock);
> 
> +	/* Handle DT/ACPI/Platform data */
> +	da7219->pdata = dev_get_platdata(component->dev);
> +	if (!da7219->pdata)
> +		da7219->pdata = da7219_fw_to_pdata(component);
> +
>  	/* Regulator configuration */
>  	ret = da7219_handle_supplies(component);
>  	if (ret)
> @@ -1897,11 +1909,6 @@ static int da7219_probe(struct snd_soc_component
> *component)
>  		break;
>  	}
> 
> -	/* Handle DT/ACPI/Platform data */
> -	da7219->pdata = dev_get_platdata(component->dev);
> -	if (!da7219->pdata)
> -		da7219->pdata = da7219_fw_to_pdata(component);
> -
>  	da7219_handle_pdata(component);
> 
>  	/* Check if MCLK provided */
> --
> 2.18.0.233.g985f88cf7e-goog

