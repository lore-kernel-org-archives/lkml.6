Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB43C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1ED2183E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Mz4MrAAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbfBSRG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:06:58 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55294 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbfBSRG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 12:06:58 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1JH6o8Z002982;
        Tue, 19 Feb 2019 11:06:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550596010;
        bh=i3wNaCeeUAm8mGUCtOfmfH1KCr+lu9CK3eNHhWZLiU4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Mz4MrAAVgAUCd//kesI8OVg3Q8ECfppfMVMOOsSU3q8Ga7OA+aMu1EV6/1ZPQfZ8b
         mvL+CuWbEE3L+i9t7bpQMyUAJmwGXIT6gFLRrNh42BmqWA73iGKEISGb0f3F3OXs3G
         yoFlSySsiZtFD93zQaVHUNxT+jw+ZwUzyp4KpYfA=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1JH6omd018678
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Feb 2019 11:06:50 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 19
 Feb 2019 11:06:49 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 19 Feb 2019 11:06:49 -0600
Received: from [172.22.103.104] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1JH6mgl027767;
        Tue, 19 Feb 2019 11:06:49 -0600
Subject: Re: [PATCH v2 2/2] ASoC: codecs: pcm186x: Fix energysense SLEEP bit
To:     <Codrin.Ciubotariu@microchip.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>
CC:     <dannenberg@ti.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
References: <20190219162840.7244-1-codrin.ciubotariu@microchip.com>
 <20190219162840.7244-2-codrin.ciubotariu@microchip.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <eba29760-9ef7-9490-9f46-b3dbdf43ee05@ti.com>
Date:   Tue, 19 Feb 2019 11:06:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190219162840.7244-2-codrin.ciubotariu@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/19/19 10:29 AM, Codrin.Ciubotariu@microchip.com wrote:
> From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> 
> The ADCs are sleeping when the SLEEP bit is set and running when it's
> cleared, so the bit should be inverted.
> Tested on pcm1863.
> 

Did this work for you before? Strange it would if reversed, I wonder if
the SLEEP bit is really doing anything here. Can investigate later, for
this patch:

Acked-by: Andrew F. Davis <afd@ti.com>

> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---
> 
> Changes in v2:
>  - none;
> 
>  sound/soc/codecs/pcm186x.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/pcm186x.c b/sound/soc/codecs/pcm186x.c
> index c36a391fec8a..c5fcc632f670 100644
> --- a/sound/soc/codecs/pcm186x.c
> +++ b/sound/soc/codecs/pcm186x.c
> @@ -158,7 +158,7 @@ static const struct snd_soc_dapm_widget pcm1863_dapm_widgets[] = {
>  	 * Put the codec into SLEEP mode when not in use, allowing the
>  	 * Energysense mechanism to operate.
>  	 */
> -	SND_SOC_DAPM_ADC("ADC", "HiFi Capture", PCM186X_POWER_CTRL, 1,  0),
> +	SND_SOC_DAPM_ADC("ADC", "HiFi Capture", PCM186X_POWER_CTRL, 1,  1),
>  };
>  
>  static const struct snd_soc_dapm_widget pcm1865_dapm_widgets[] = {
> @@ -184,8 +184,8 @@ static const struct snd_soc_dapm_widget pcm1865_dapm_widgets[] = {
>  	 * Put the codec into SLEEP mode when not in use, allowing the
>  	 * Energysense mechanism to operate.
>  	 */
> -	SND_SOC_DAPM_ADC("ADC1", "HiFi Capture 1", PCM186X_POWER_CTRL, 1,  0),
> -	SND_SOC_DAPM_ADC("ADC2", "HiFi Capture 2", PCM186X_POWER_CTRL, 1,  0),
> +	SND_SOC_DAPM_ADC("ADC1", "HiFi Capture 1", PCM186X_POWER_CTRL, 1,  1),
> +	SND_SOC_DAPM_ADC("ADC2", "HiFi Capture 2", PCM186X_POWER_CTRL, 1,  1),
>  };
>  
>  static const struct snd_soc_dapm_route pcm1863_dapm_routes[] = {
> 
