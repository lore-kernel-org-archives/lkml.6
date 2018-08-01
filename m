Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAAEC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F2920894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f9GCsXVj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F2920894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388863AbeHAKmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:42:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41285 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388831AbeHAKmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:42:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id j5-v6so19312494wrr.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 01:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5PyJN+u/I8Dok23/Kp1MQE2iwPReWVQA/zsgVmbKKG4=;
        b=f9GCsXVjYo4tKT63QRpNkgMvCa5JEmmgFdWVcAV3/Ahv0LctkaK/XqL7Nlv5QsDH2f
         CjM53lYNwJLMMBSWreaen1oMXnPlNDsL56Ff73fbygPo0wMp9BfujTVAAYDrivU5z5kW
         4yW2H4DVGRy+XGXUMpSHXzyBbRTs0AcnHRAZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5PyJN+u/I8Dok23/Kp1MQE2iwPReWVQA/zsgVmbKKG4=;
        b=PXUZoixiLROVm+Ir7BlXZf/NEN/HKoA3MxfXR9E/eBnFHrFZ0dK2BU8FpHYqa88+mq
         ozM/ZPN4i9RCMF2gIt0dIhALLyHB856n+fTZCGbcbo9qdi7dSHFM3Sr+npQRSHDWlvAB
         tRj80k6AFZS8isBnSrKBU+nXK1XlVY4Z3UcHRuNYqfYv3oDNf1JENnQSJsC/foix9eP/
         srxSA532pHYSt9x3muRWJdIys4XZGYX4hSg8dwP3OUzaaKhagfcydJG3aB4MktW8HiLY
         bjsIYdhNZmVqCV/HeutruRJjXa+dZdMZ6OOEpMuba2sQ85+GdCc1YBXygg4QNwUKCqru
         EUxg==
X-Gm-Message-State: AOUpUlHUMAe4QAqUDalXWtlUy4bAk06lchZjvRi7qZFB1eMSa3yBiNOd
        oRJj2AvOlGEaSh6kx0UVB8gypg==
X-Google-Smtp-Source: AAOMgpcUy9dZZTVeomohCMDnfrTyvnRAZkigxwJZZQoN1d9xQY/jFHK+Pa0GSmY2ou7fv2dZl2j/Jg==
X-Received: by 2002:adf:8bd7:: with SMTP id w23-v6mr22511182wra.208.1533113852582;
        Wed, 01 Aug 2018 01:57:32 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id a84-v6sm6194055wmh.27.2018.08.01.01.57.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 01:57:31 -0700 (PDT)
Subject: Re: [PATCH v2 05/10] ASoC: wcd9335: add CLASS-H Controller support
To:     Mark Brown <broonie@kernel.org>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, tiwai@suse.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
 <20180727121806.18209-6-srinivas.kandagatla@linaro.org>
 <20180731170557.GK5719@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <9f2ae979-1af1-2d80-f403-9220ec5c89a2@linaro.org>
Date:   Wed, 1 Aug 2018 09:57:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180731170557.GK5719@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review,

On 31/07/18 18:05, Mark Brown wrote:
> On Fri, Jul 27, 2018 at 01:18:01PM +0100, Srinivas Kandagatla wrote:
> 
>> +	res_val = WCD9XXX_CLASSH_CTRL_VCL_VREF_FILT_R_0KOHM;
>> +	switch (mode) {
>> +	case CLS_H_NORMAL:
>> +		res_val = WCD9XXX_CLASSH_CTRL_VCL_VREF_FILT_R_50KOHM;
>> +		val = WCD9XXX_A_ANA_HPH_PWR_LEVEL_NORMAL;
>> +		gain = DAC_GAIN_0DB;
>> +		ipeak = WCD9XXX_CLASSH_CTRL_CCL_1_DELTA_IPEAK_50MA;
>> +		break;
>> +	case CLS_AB:
>> +		val = WCD9XXX_A_ANA_HPH_PWR_LEVEL_NORMAL;
>> +		gain = DAC_GAIN_0DB;
>> +		ipeak = WCD9XXX_CLASSH_CTRL_CCL_1_DELTA_IPEAK_50MA;
>> +		break;
>> +	case CLS_H_HIFI:
>> +		val = WCD9XXX_A_ANA_HPH_PWR_LEVEL_UHQA;
>> +		gain = DAC_GAIN_M0P2DB;
>> +		ipeak = WCD9XXX_CLASSH_CTRL_CCL_1_DELTA_IPEAK_50MA;
>> +		break;
>> +	case CLS_H_LP:
>> +		val = WCD9XXX_A_ANA_HPH_PWR_LEVEL_LP;
>> +		ipeak = WCD9XXX_CLASSH_CTRL_CCL_1_DELTA_IPEAK_30MA;
>> +		break;
>> +	};
> 
> This is missing a default case for error checking, and you don't need
> the semicolon at the end either.
These states are validated before any calls are made to these functions.

However I agree without on default case for error checking and ;
I will fix this in next version.

thanks,
srini

> 
