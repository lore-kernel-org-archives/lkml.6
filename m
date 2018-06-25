Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAE2C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E7725E47
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NEgnNl4r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E7725E47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755478AbeFYQa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:30:57 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:54710 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754699AbeFYQa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:30:56 -0400
Received: by mail-wm0-f41.google.com with SMTP id i139-v6so3024717wmf.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 09:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E1nfmAa8oxhSlDJm+idkoI/+k3HMc8UqX6zbwPg2O5o=;
        b=NEgnNl4rTiUYJxDrG/jaoujrTTZgCyG+BDn1Cj1n9aoJVw0Q2WDBYQ2dSZgBqAwzoS
         ImFGb+eMct6X6ZOGOqRRhPryfX5IHPnlWUG6M98N2979Pn492vu/JgeiY6+9DI80FdDL
         O16sjcbYXseY9+g/7l7oz/f3CYaDFbBVeE2CA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E1nfmAa8oxhSlDJm+idkoI/+k3HMc8UqX6zbwPg2O5o=;
        b=PObp2b+QUi29ikU407Ju1sqIGAYeV2ZXDDUoQX1rgIiRzsJq8X9tUizUSiKm6HPGAU
         Xte5kUi0jCm/GbQFpvCNz4IyJzl2n7itLu+MXRmbRnpUdMK6vWObOYiRT8CYITBA1vY2
         GpCpfTet6QK9uqdgrFTb5yujWahRATjolNwv18J1aFAaQJy9pf+Nv77QnSd6MQQQEPA/
         cRaOpmaUnj6Lh2KZ9dT3EPab+vtdEM8XDe25YfNgi0FmBv4vrA3osefn0h3oMV4rE7dw
         BMw+lnIKmiKTpkErPbmKdcWI16d3pbaS9we8QemRIs+RcJcJg8NLiEbtpk4Lcv/cVp4t
         m5jA==
X-Gm-Message-State: APt69E1TfTMy3BkuAOwSHh07ma7Zib1pN98No8OUF5hVq1I5FQ15nlq3
        N3PzBmo8oDGdP3cTgnDuttaH5w==
X-Google-Smtp-Source: ADUXVKKEX5Iwb8FH7b+PyXVsnN6KirR8LoXxIljzdgA6AiJHa83kYOKQZxKakXYJNmhYEMwiJcKzaQ==
X-Received: by 2002:a1c:33c4:: with SMTP id z187-v6mr1696792wmz.114.1529944254888;
        Mon, 25 Jun 2018 09:30:54 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id 137-v6sm16188432wmv.28.2018.06.25.09.30.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 09:30:54 -0700 (PDT)
Subject: Re: [PATCH 1/2] slimbus: stream: add stream support
To:     Vinod <vkoul@kernel.org>
Cc:     gregkh@linuxfoundation.org, broonie@kernel.org,
        sdharia@quicinc.com, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        ctatlor97@gmail.com
References: <20180621134009.27116-1-srinivas.kandagatla@linaro.org>
 <20180621134009.27116-2-srinivas.kandagatla@linaro.org>
 <20180622125050.GO27187@vkoul-mobl>
 <a922d359-2096-48ed-c442-affc5b0c4ccf@linaro.org>
 <20180625162156.GC2404@vkoul-mobl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <531e49bb-cdc9-610f-1bad-bd40f633e90d@linaro.org>
Date:   Mon, 25 Jun 2018 17:30:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180625162156.GC2404@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/06/18 17:21, Vinod wrote:
>>>> +/*
>>>> + * slim_stream_enable() - Enable a prepared SLIMbus Stream
>>> Do you want to check if it is already prepared ..?
>> Yep, I think most of the code needs similar state machine check, I will add
>> this in next version.
> so if you are tying to snd stream states then I don't think you need a
> state machine here. ALSA already does that for you so you can skip it :D
Stream state machine looks redundant, I will try to skip it and see how 
things look at the end! before sending next version.

thanks,
srini
