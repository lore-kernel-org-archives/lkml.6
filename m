Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFA1ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1439C20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hubclQcv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1439C20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388426AbeGXNLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:11:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38121 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388265AbeGXNLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:11:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id v14-v6so3893121wro.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 05:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HMFXbq9HmlunDb3y5wniFuWXMqkJkyU4pGvMKRm/eb0=;
        b=hubclQcvRnThZOG0HsYhzWtegBGkereMDcCf+dnrPD/R7W/IvhTS/RcxAuE26Ee1Vt
         b7cXhtiMZqwEdUPMsAZh1jWODoBUgQFcdTNV2OlEftfcUqtwL2AWndTxrfF3nPP63crb
         xL8OnqdvpvYlpDX9T8LLw8D+9TL5bdXqyHnlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HMFXbq9HmlunDb3y5wniFuWXMqkJkyU4pGvMKRm/eb0=;
        b=MkSzH59G0Vucdx6C5dJLzkdanRFOsqzrnh1Epa9KBGbuCuzkpEHflAtOYWrVbiA9lA
         ZjhmRPmddCjFcisFxBarfo3FU7k/RUn2qE6nXhgJQMx6cFoWtOaYjOhUqIeqHZFno84d
         4kN0QK1oWwNoWk9OfwLdco1L6ka5RKL2QZH9atjNHQW7CGgw4rllPuuT3TKd5p8MPXeO
         zyCSGhTktIKe2zItj6DakSkUW/dbsE7uEH1BKcNtEGEmkTX0y61+D3UiOHz0+YI5ziki
         K6f3PFQbJY/fBpJajcaB/0Y+v12ELPUzUNtUBU7B1nwEW+WEYTqNYTwJJTNksesLyPi9
         X3PQ==
X-Gm-Message-State: AOUpUlHQleahUmKF3n1lBirrQeCm6HIG43I1LhFg72WsCMZqcj7RhSLS
        yb1DxAxOengtvnwmxrbqOn5+jA==
X-Google-Smtp-Source: AAOMgpfQqk77L69Zo5ZaihOTX7FCcp2XvoXTNSzw2uS4UrTyLqAEzpJZdL5bW499Cm/Ffh90q50qAA==
X-Received: by 2002:adf:fc86:: with SMTP id g6-v6mr11168502wrr.216.1532433928872;
        Tue, 24 Jul 2018 05:05:28 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id q188-v6sm2584679wmd.36.2018.07.24.05.05.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 05:05:28 -0700 (PDT)
Subject: Re: [PATCH 07/12] ASoC: wcd9335: add CLASS-H Controller support
To:     Mark Brown <broonie@kernel.org>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, tiwai@suse.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
References: <20180723155410.9494-1-srinivas.kandagatla@linaro.org>
 <20180723155410.9494-8-srinivas.kandagatla@linaro.org>
 <20180724115908.GC2414@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <7c54601c-f445-99d6-9092-2fccf16cbd24@linaro.org>
Date:   Tue, 24 Jul 2018 13:05:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180724115908.GC2414@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review!

On 24/07/18 12:59, Mark Brown wrote:
> On Mon, Jul 23, 2018 at 04:54:05PM +0100, Srinivas Kandagatla wrote:
> 
>> +static inline int wcd_clsh_get_int_mode(struct wcd_clsh_ctrl *ctrl,
>> +					int clsh_state)
>> +{
>> +	int mode;
>> +
>> +	if ((clsh_state != WCD_CLSH_STATE_EAR) &&
>> +	    (clsh_state != WCD_CLSH_STATE_HPHL) &&
>> +	    (clsh_state != WCD_CLSH_STATE_HPHR) &&
>> +	    (clsh_state != WCD_CLSH_STATE_LO))
>> +		mode = CLS_NONE;
>> +	else
>> +		mode = ctrl->interpolator_modes[ffs(clsh_state)];
>> +
>> +	return mode;
> 
> This looks like it wants to be a switch statement.
Yep, Will do that in next version.

> 
>> +static void wcd_clsh_state_hph_lo(struct wcd_clsh_ctrl *ctrl, int req_state,
>> +				  bool is_enable, int mode)
>> +{
>> +	struct snd_soc_component *comp = ctrl->comp;
>> +	int hph_mode = 0;
>> +
>> +	if (is_enable) {
>> +		/*
>> +		 * If requested state is LO, put regulator
>> +		 * in class-AB or if requested state is HPH,
>> +		 * which means LO is already enabled, keep
>> +		 * the regulator config the same at class-AB
>> +		 * and just set the power modes for flyback
>> +		 * and buck.
>> +		 */
>> +		if (req_state == WCD_CLSH_STATE_LO)
>> +			wcd_clsh_set_buck_regulator_mode(comp, CLS_AB);
> 
> This seems like there's a pretty confusing state machine, or possibly
> that we might end up in different states depending on how we transition.
> Whatever is going on it really feels like this code is more complex than
> it needs to be.  Some of this is the use of lots of nested if statements,
> some of it is the lack of any clear description of what we're trying to
> achieve.  It's hard to tell if the code is doing what's expected because
> it's hard to tell what it is expected to do.

I agree, I will rework and simplify this code/state-machine before 
posting next version!
> 
>> +		else {
> 
> If there's braces on one side of an if/else there should be braces on
> both sides.
Opps! will fix that and any such instances in next version!

> 
>> +			if (req_state == WCD_CLSH_STATE_HPHL)
>> +				snd_soc_component_update_bits(comp,
>> +					WCD9XXX_A_CDC_RX1_RX_PATH_CFG0,
>> +					WCD9XXX_A_CDC_RX_PATH_CLSH_EN_MASK,
>> +					WCD9XXX_A_CDC_RX_PATH_CLSH_ENABLE);
>> +			if (req_state == WCD_CLSH_STATE_HPHR)
>> +				snd_soc_component_update_bits(comp,
>> +					WCD9XXX_A_CDC_RX2_RX_PATH_CFG0,
>> +					WCD9XXX_A_CDC_RX_PATH_CLSH_EN_MASK,
>> +					WCD9XXX_A_CDC_RX_PATH_CLSH_ENABLE);
>> +		}
> 
> Switch statement?
Okay!

thanks,
srini
> 
