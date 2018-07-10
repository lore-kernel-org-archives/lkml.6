Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B54AC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE40120883
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mu2dRemo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE40120883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933376AbeGJK7c (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 06:59:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45823 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933169AbeGJK7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 06:59:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id c4-v6so1447124wrs.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 03:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ULpRqxsIaVeIa5zs2Ht4zbKmFIx52nKkmq+W8TNbpXA=;
        b=Mu2dRemo6Ghbu1mYGZhstOqh13Vq4e54Wiem6rk8K7zsHAMoIDGsw4SLvAUTJs6RhJ
         l+7dfkvr3MAG2SkTx1drSAR97C3ekzR1Vhi7JZbk90z7dQ/9Edji8mhkqbhaEktOEH0+
         gBFpIshNzzeX5W2gZj8WAHm/ST9bfMs0WDJ84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ULpRqxsIaVeIa5zs2Ht4zbKmFIx52nKkmq+W8TNbpXA=;
        b=kAZnO0URpVKcfd+oFlYDExWs3r7oZUT5MqDhVT0c7D9ExZLcOcu+KzU+FCDC/QJAkD
         niiZKyK/D47Ny8r2DvqpTGxHdz4iNVA5cJNE0ZKr4n0jIUgPM+ZhYvNQfWSFYHxA9Ymr
         1Y2cRG46q8wdvzYHsdoBBBGTefDjYsmPyVTTRSw4+skTh52LsbVQMFqtyh7RqQgB05jJ
         8vLm0B4JE4NZOMirdmsTsjFGQwgKJ5kSLPjY92jlo2bjNcjO1FSkuouGJv6ozf6boT+8
         75A0E70uHWcNE13mk57dtoU0k19+luWnpId1kj/5GWekZE6xifVA45uxFWYfC7hzR/IB
         l+UA==
X-Gm-Message-State: AOUpUlEIbxipdJ5MWTb2L/pq27e6bsZTt+MsR35kE1LAtVbxJfnVuL7W
        oZm4qvxTw/Tg2SLqTE9cKf6KuWOoLTc=
X-Google-Smtp-Source: AAOMgpdnhnuSzIqCZ3Cu50YM5+6Sik12Z+mVVMVgH+g3pWzqXkcnQU2h+LqKjUBKcMgzzIAhhclyhw==
X-Received: by 2002:adf:b60a:: with SMTP id f10-v6mr10640839wre.54.1531220368689;
        Tue, 10 Jul 2018 03:59:28 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id w135-v6sm49415862wme.7.2018.07.10.03.59.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 03:59:28 -0700 (PDT)
Subject: Re: [PATCH v3 3/5] ASoC: qcom: add sdm845 sound card support
To:     Mark Brown <broonie@kernel.org>
Cc:     Rohit kumar <rohitkr@codeaurora.org>, lgirdwood@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
 <1530870195-13576-4-git-send-email-rohitkr@codeaurora.org>
 <20180709111437.GB16082@sirena.org.uk>
 <b5a3f0e2-d420-603d-f9a0-f93bdbd2619f@linaro.org>
 <20180709124117.GG16082@sirena.org.uk>
 <887331ff-8892-66a7-20bc-0fce447c792f@linaro.org>
 <20180709163326.GI16082@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <ed7aa899-c8c8-f878-61ce-21af07b50fa7@linaro.org>
Date:   Tue, 10 Jul 2018 11:59:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180709163326.GI16082@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/07/18 17:33, Mark Brown wrote:
> On Mon, Jul 09, 2018 at 03:02:11PM +0100, Srinivas Kandagatla wrote:
>> On 09/07/18 13:41, Mark Brown wrote:
>>>> AFAIU, The issue with that mechanism or EPROBEDEFER is that it works only
> 
>>> This is not the case, the card will be unbound at the ASoC level when
>>> any of the components are removed and then probed again when they
>>> reappear.
> 
>> I did try this and It works only for first time! May be am missing
>> something!
> 
>> snd_soc_component_del_unlocked() unregisters the sound card totally. so for
>> the second time (After DSP stop) there is no registered sound card in
>> place.. Am not sure how this is supposed to work?
> 
>> The reason I think it works for the first time is because of EPROBEDEFER
>> from the machine driver.
> 
> Ugh, right - we ripped out that code because there's no sensible use
> case for it so now we don't keep the cards on a list.  The expectation
> is that if someone is going around removing bits of the card they can
> probably figure out that they should be removing the card first.
> 
> In any case the place to implement this is in the core, there's nothing
> special about your cards here.  Either the core should be using the
> component framework or the card list should be resurrected and we open
> code it.  This isn't something that's unique to your device.
I totally agree with you, this functionality belongs to core!

I will explore both options and see how it goes.

thanks,
srini
> 
