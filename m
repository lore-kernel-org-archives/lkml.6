Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43799C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9582087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RjlGNrMW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF9582087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932862AbeGIMer (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:34:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43725 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932601AbeGIMep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:34:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id b15-v6so10817996wrv.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 05:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l/2MxonvopEWONdCS+HjFm18ncZiKRaEmp0t/Jmk3Ag=;
        b=RjlGNrMWdXR7NWSwpHk2VpH7puIFCSqr+M4n/28RzKE6188CIcttQb/son/AYw1dDh
         vCnf2tzdhA0+SE+nqgBk2e4OSPXVjjB5Bh+a/7Nz9K9Cmfqgdb8s8oRwG3fI9M0T+bGo
         ytpRFEBslumJ/fzgjjdHUzZj6HtBBLGhR8eFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l/2MxonvopEWONdCS+HjFm18ncZiKRaEmp0t/Jmk3Ag=;
        b=RnE4inlVeHXjgAS0KEfzFZOw+FmUEl6twj4LI2wdVOpzxmWEvTtEnD9tupfW6F69qK
         UOIV0O+XOCazTxcbwqqwwD8s8O9uWp24u8lZvG5XWxk54egdVH0U43Zun2FZbq5gn2EI
         cu6NcI84x/VAvqAAq/IaT6VphUt0Li1p2zFYZyK0nnZplcxhwRtTVaxkI2OHsyxRDhCx
         Mt5ZadAxOrvz4OMhvhd61Ogo2MjfmEZWCFOI8KDd7erb+BVFllT6qwxt7xCaswev1uyM
         MqRJQebWBBsbgGmlMm44lXmfdYoOEYEYrY+EAG7pG6HH13Ebp1p30dFtrxZwnv5WCS9U
         2NHA==
X-Gm-Message-State: AOUpUlE77fT01gOAzxc68EDY15g/2lZY6gTcRFlsBVE+6xnNdQI+dYyU
        M5BJxS++n/8r4JPDUQ0xun1/UFvq3fY=
X-Google-Smtp-Source: AAOMgpffw/qfcxPOU4o9NGf76m1AqRQRYdxa9NcvsKTZUH/ayzPDamMwh/+TyY6Cu3mVyvIZCtTWPw==
X-Received: by 2002:adf:f8c7:: with SMTP id f7-v6mr6702660wrq.237.1531139684345;
        Mon, 09 Jul 2018 05:34:44 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id q200-v6sm7281092wmg.8.2018.07.09.05.34.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 05:34:43 -0700 (PDT)
Subject: Re: [PATCH v3 3/5] ASoC: qcom: add sdm845 sound card support
To:     Mark Brown <broonie@kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
 <1530870195-13576-4-git-send-email-rohitkr@codeaurora.org>
 <20180709111437.GB16082@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <b5a3f0e2-d420-603d-f9a0-f93bdbd2619f@linaro.org>
Date:   Mon, 9 Jul 2018 13:34:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180709111437.GB16082@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/07/18 12:14, Mark Brown wrote:
>> +static const struct component_master_ops sdm845_ops = {
>> +	.bind = sdm845_bind,
>> +	.unbind = sdm845_unbind,
>> +};
> Why is this using the component stuff rather than the normal support for
> finding the components of audio cards?
Could you elaborate this please?
Do you mean something like snd_soc_lookup_component()?  Or in general 
audio card binding during startup.

AFAIU, The issue with that mechanism or EPROBEDEFER is that it works 
only for first time.. for the second time(restart usecase) there are no 
hooks like bind/unbind.

The reason why we chose to use component framework is because of bind 
and unbind functionality. Am more than happy to rework on this if there 
is already a alternative mechanism in ASoC which can provide this.

The design we are aiming at is:
1> audio card to deregister when any of the DSP audio services go DOWN.
2> re-register audio card only when all the DSP audio services are UP.

Usecase is something like DSP start-stop or restart due to fatal errors.

thanks,
srini


