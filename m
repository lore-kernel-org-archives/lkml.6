Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20E7C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5643B20894
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YlymbO+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5643B20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733081AbeG0LQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:16:22 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50705 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730976AbeG0LQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:16:21 -0400
Received: by mail-wm0-f66.google.com with SMTP id s12-v6so4691814wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 02:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OECSr1SGxQeWEh/oMWLr1DZFxK3AocHRZ+Dp6qFFwOA=;
        b=YlymbO+4SP8BsMJ81mVZ1OHABdjASGMaJb36rCQMviIKI13xOBAJtC9iHfIAoYboD6
         +qHqUzfTJh29w+X0QnwwErfV7R2lt0OLlZKj7JXcyYV4K7Vl8HulzXfaP9hPu2lo7cPL
         yXGM9a8+dKLSf1gIkzrV9tOajbyq4jBRJIZjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OECSr1SGxQeWEh/oMWLr1DZFxK3AocHRZ+Dp6qFFwOA=;
        b=FFiYigugmsrJWe0bpaR2WHIGVr9pkbCl5O3jS6+Qrosp6MOCr84GEWR4NWE08Ot31/
         qb03MONtChTLyShR51s6fKf7SOtm3TYTrqnCVLscxHyHc0VKxw01SGlyiERSh02tC1lc
         Ykk+0a3T2rAD8knKk21YIUnP0CIoG8VZbcS81yfh69AYuRDUdMnRLSAvxjC9gTNv9bvM
         T0P4uAQzIxqB0rO/xrPnb4gAVGol9hC2uwqeKRVUXdCDxrcRFq8qCQp166+chRmNl3N9
         cILifwl5RAh22Vu5sUtVxOt77++qVgOrauTvPK5nFP0Jd/za24M6zvh5Bhwr5F6rdYCz
         e2nQ==
X-Gm-Message-State: AOUpUlHZe51kytE+d4Xft3N7nPgPZ9I1XMmB8VdlvotfVzaa9JJ6frPi
        V1U/zxXbekt++FGHtwV9GalARlr2iq4=
X-Google-Smtp-Source: AAOMgpc15xa0UZOUFTvOyp7T5zErtZgB0X8ZopNyHez//ApePWvN5KlfyBKqP5rlD1zB1SNLsPj4oQ==
X-Received: by 2002:a1c:ae8d:: with SMTP id x135-v6mr3886604wme.20.1532685312886;
        Fri, 27 Jul 2018 02:55:12 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id l14-v6sm5107254wrw.65.2018.07.27.02.55.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 02:55:12 -0700 (PDT)
Subject: Re: [PATCH 08/12] ASoC: wcd9335: add basic controls
To:     Vinod <vkoul@kernel.org>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org,
        mark.rutland@arm.com, lgirdwood@gmail.com, tiwai@suse.com,
        bgoswami@codeaurora.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20180723155410.9494-1-srinivas.kandagatla@linaro.org>
 <20180723155410.9494-9-srinivas.kandagatla@linaro.org>
 <20180725120407.GO3661@vkoul-mobl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <01645941-995f-60ef-5bb1-27811547a555@linaro.org>
Date:   Fri, 27 Jul 2018 10:55:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180725120407.GO3661@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Vinod for review comments,

On 25/07/18 13:04, Vinod wrote:
> On 23-07-18, 16:54, Srinivas Kandagatla wrote:
> 
>> +static int wcd9335_set_compander(struct snd_kcontrol *kc,
>> +				 struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct snd_soc_component *component = snd_soc_kcontrol_component(kc);
>> +	struct wcd9335_codec *wcd = dev_get_drvdata(component->dev);
>> +	int comp = ((struct soc_mixer_control *) kc->private_value)->shift;
>> +	int value = ucontrol->value.integer.value[0];
>> +	int sel;
>> +
>> +	wcd->comp_enabled[comp] = value;
>> +	sel = value ? WCD9335_HPH_GAIN_SRC_SEL_COMPANDER :
>> +		WCD9335_HPH_GAIN_SRC_SEL_REGISTER;
>> +
>> +	/* Any specific register configuration for compander */
>> +	switch (comp) {
>> +	case COMPANDER_1:
>> +		/* Set Gain Source Select based on compander enable/disable */
>> +		snd_soc_component_update_bits(component, WCD9335_HPH_L_EN,
>> +				      WCD9335_HPH_GAIN_SRC_SEL_MASK, sel);
>> +		break;
>> +	case COMPANDER_2:
>> +		snd_soc_component_update_bits(component, WCD9335_HPH_R_EN,
>> +				      WCD9335_HPH_GAIN_SRC_SEL_MASK, sel);
>> +		break;
>> +	case COMPANDER_3:
>> +		break;
>> +	case COMPANDER_4:
>> +		break;
>> +	case COMPANDER_5:
>> +		snd_soc_component_update_bits(component, WCD9335_SE_LO_LO3_GAIN,
>> +				      WCD9335_HPH_GAIN_SRC_SEL_MASK, sel);
>> +		break;
>> +	case COMPANDER_6:
>> +		snd_soc_component_update_bits(component, WCD9335_SE_LO_LO4_GAIN,
>> +				      WCD9335_HPH_GAIN_SRC_SEL_MASK, sel);
>> +		break;
>> +	case COMPANDER_7:
>> +		break;
>> +	case COMPANDER_8:
>> +		break;
> 
> why not do:
> 
>          case COMPANDER_3:
>          case COMPANDER_4:
>          case COMPANDER_7:
>          case COMPANDER_8:
>                  break;
> 
> thereby clubbing all the ones not handled together..
> 
I removed the un-handled ones in v2.

>> +static int wcd9335_rx_hph_mode_get(struct snd_kcontrol *kc,
>> +				 struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct snd_soc_component *component = snd_soc_kcontrol_component(kc);
>> +	struct wcd9335_codec *wcd = dev_get_drvdata(component->dev);
>> +
>> +	ucontrol->value.integer.value[0] = wcd->hph_mode;
> 
> i think this is an enum so shouldn't value.enumerated.item[0] be used?
> 
Yep, there are one more instances like this, i fixed this in v2.
>> +
>> +	return 0;
>> +}
>> +
>> +static int wcd9335_rx_hph_mode_put(struct snd_kcontrol *kc,
>> +				 struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct snd_soc_component *component = snd_soc_kcontrol_component(kc);
>> +	struct wcd9335_codec *wcd = dev_get_drvdata(component->dev);
>> +	u32 mode_val;
>> +
>> +	mode_val = ucontrol->value.enumerated.item[0];
> 
> yaaay

--srini
> 
