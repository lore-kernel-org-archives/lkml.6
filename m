Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948C1C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 687D6218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SKEZD4Fm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfAaRdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:33:16 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33046 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbfAaRdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 12:33:15 -0500
Received: by mail-wr1-f66.google.com with SMTP id p7so4293922wru.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 09:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NwOgMqtXAmeu3Hhfy1xkKET1uCK14W1k/GI1EaHGhAw=;
        b=SKEZD4Fmb/cwvNyn4i932i9NaICweapyKrk078d07DwgZLfSO890u7ilnV4+KuIOGH
         w7Y8GezzHRlEuDl29pO3EvzUZMvzksgU/h9saWb6pNwS67LAEjRSue9w+VF2yL8rzFps
         NWAu+6x+4A8hS13GVUF0IKXB4D0owKSvwBJwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NwOgMqtXAmeu3Hhfy1xkKET1uCK14W1k/GI1EaHGhAw=;
        b=gZirfzVFJCSDGXj88zvcg1lKzlLEq8/IbxaDzwKR29/sc/60nwRSxzUjrAk2a4CgYl
         HVZPI6MlnyshwN7dGxg4tRN/FRMUbaOmg+rMaLMKO8EnKIvyuixXZ3+087rHkiUKE0Dq
         S5PJvetMWKaDYbVhTUOdnRk91FSvCfvAFrqKonaqCJLSocTDxaf6/5yjmuAGrl+StqEF
         pJwVOcnBWIuMPFm2Nn0VHHvS3hGCcjFhOJzvag6NMrFjgRaLAD2kdQEqebfiBbMz1p4D
         /Eu6UAk/q/baX/dFDUroZ81N6b3Qhg6SOam1hCAZKIaeJunRevQfjJGLtio6u5udBgta
         cnMg==
X-Gm-Message-State: AHQUAublPVNwor9sSR76PJGYjWTMC2KgGJ0F5mE1RNq8Vp9UcFqF0/fe
        BJhVaDwjd1Brve+S9UxGezuCNRxff+g=
X-Google-Smtp-Source: AHgI3IaqOscuIM06HsuUCvDO93mIEB9Gjf667U/Rjrqw+IqgDyuYx9Gf2VAbnp22+3ohbuPybToKVg==
X-Received: by 2002:adf:e509:: with SMTP id j9mr29749726wrm.76.1548955993688;
        Thu, 31 Jan 2019 09:33:13 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id k128sm9625690wmd.37.2019.01.31.09.33.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 09:33:13 -0800 (PST)
Subject: Re: [PATCH] qcom: apr: Make apr callbacks in non-atomic context
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, bgoswami@codeaurora.org,
        rohitkr@codeaurora.org
References: <20181115184904.27223-1-srinivas.kandagatla@linaro.org>
 <20190131011649.GA27190@builder>
 <7555094b-350b-b4c6-47c6-507f7ce99dc5@linaro.org>
 <20190131160551.GD2387@tuxbook-pro>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <49a8b982-356b-73ad-0f9a-46e0f496ce02@linaro.org>
Date:   Thu, 31 Jan 2019 17:33:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131160551.GD2387@tuxbook-pro>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2019 16:05, Bjorn Andersson wrote:
> Sure, but we want the design to allow for that still, either in future
> upstream or by additional downstream code.
> 
Yes, I agree, I don't have solution for this ATM.
It will be interesting to see how Intel handles this kind of usecase on 
there DSP.

The whole issue is the APR messaging is not really atomic in nature, it 
is basically request->response but the fact in existing code is that 
smd/glink callbacks run in interrupt context.

Trying to pretend that APR is atomic in nature is problem with audio.

As audio (dai-links) can be marked as atomic or non-atomic depending on 
which bus it links with, for example when it has to work with other 
buses like slimbus, soundwire, i2c whose transactions can sleep we mark 
the audio dai-link as non-atomic which means that the functions can sleep.
In the above case, invoking any audio functions as part of the rpmsg 
callback is an issue.

The only solution I found to address this is handle the callbacks in 
workqueue.

>> Also it depends on definition of "latency", is the latency referring to
>> "filling the data" or "latency between DSP command and response".
>>
> I'm referring to the latency between the message from the DSP until we
> give it a new buffer.
> 
>> For former case as long as we have more samples in our ring buffer there
>> should be no latency in filling the data.
>> For later case it should not really matter as long as former case is taken
>> care off.
>>
>> Low latency audio involves smaller sample sizes and no or minimal
>> preprocessing in DSP so am guessing that we should be okay with responses in
>> workqueue as long as we have good size ring buffer.
>>
> Relying on more buffered data will increase the latency of the audio,
> preventing you from doing really low-latency things.
My bad!.. Yes, in low latency case we would have very less buffers!

srini

