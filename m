Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC679C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F4120839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fzFwecR2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79F4120839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbeLLM0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 07:26:32 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54959 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727155AbeLLM0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 07:26:31 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so5568537wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 04:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TIuAEWKGYfnEAmKBppn2ZJzu1SPSqVplPfalT8CBgyc=;
        b=fzFwecR2Yu/IxpH/QVunJB092HtFccU1EnxfSww7598ePIMCHKD7x3hV6t1dAXIR/h
         4h7sG+ImO710Mvf6tXkj9Pxok5X+8Nd2NQkJWhnR6VJ8MV5qaWer4MoKiCslgKcV+D33
         VSKYQEOUq/B6Aq4HBDsxaF0uEt6r8klqXNHSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TIuAEWKGYfnEAmKBppn2ZJzu1SPSqVplPfalT8CBgyc=;
        b=Tn5aRATvwXdO1G6qo9spKFZqEPvn6uSn26HGPhHLb7Nry0yzYw3C2H9ZFczzcx5IIv
         v3r0paOSyD70WPw/HqkqOqEE5ZKCfnX2ZUEnWzWed30+ixo3k+pYDzozLeKSPCRQ4XC5
         xty46UgBWjr+YXBQehzGUB5neyczMTTbCVs6tmah68BEPXVHaWdjNkidqrNCO3kX7AMt
         UhthAu8TX8K59gy8YWRw6gF9BRRX79H/yT86kWOSZPkIJBBiC818eZotEc18Jyffcodb
         CGCSnauzNCP06zRA7IipnpfgmkgBblS4/R3G4Dvnw29X2Ivq6Jf1V2wxwAA2a50QTBQd
         7svg==
X-Gm-Message-State: AA+aEWYADiEDABAXs9ilUWv4PWWTU2acooVsIGaMm8U4H3SGEcoCHAVJ
        EhAaR2WPevpPtuZn0bBXJi1CZw==
X-Google-Smtp-Source: AFSGD/XxwiGS40FsOSYxZVMTVXTZ6nPQ5mW7FCyfyjt7oO4R2gIRgd7cyLjJJvhA0Uad2cZ+9h9Q2g==
X-Received: by 2002:a1c:58ce:: with SMTP id m197mr6467980wmb.31.1544617588190;
        Wed, 12 Dec 2018 04:26:28 -0800 (PST)
Received: from [192.168.86.29] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id f130sm2678433wme.41.2018.12.12.04.26.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 04:26:27 -0800 (PST)
Subject: Re: [PATCH v2 6/6] misc: fastrpc: Add support for compat ioctls
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, arnd@arndb.de, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        bkumar@qti.qualcomm.com, thierry.escande@linaro.org
References: <20181207163513.16412-1-srinivas.kandagatla@linaro.org>
 <20181207163513.16412-7-srinivas.kandagatla@linaro.org>
 <20181212105932.GA1990@kroah.com>
 <864aaef3-8d60-3beb-ce20-a9f41f78a32f@linaro.org>
 <20181212115037.GA31075@kroah.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <9867e420-de78-abc3-ab9d-deea3cf2491e@linaro.org>
Date:   Wed, 12 Dec 2018 12:26:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181212115037.GA31075@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>>>
>>> What prevents you from doing that and requiring compat support?
>>>
>> I removed most of the compat IOCTLS except this one.
>> The reason is that this ioctl takes arguments which can vary in number for
>> each call.
> 
> Then do not do that :)
> 
> Remember, you get to design the api, fix the structure size to work
> properly everywhere.
> 
>> So args are passed as pointer to structure, rather than fixed
>> size. I could not find better way to rearrange this to give a fixed size
>> data structure. In theory number of arguments can vary from 0-255 for both
>> in & out.
>>
>> current data structure looks like this:
>>
>> struct fastrpc_invoke_args {
>> 	__s32 fd;
>> 	size_t length;
>> 	void *ptr;
>> };
> 
> Make length and ptr both __u64 and you should be fine, right?  If you do
> that, might as well make fd __u64 as well to align things better.
> 

That is fine for the args structure, but below "args" pointer in "struct 
fastrpc_invoke" is still not fixed size, unless we change that to __u64 
pointing to array of struct fastrpc_invoke_args. I have seen such usages 
in i915_drm.h.
Is that the preferred?

>> struct fastrpc_invoke {
>> 	__u32 handle;
>> 	__u32 sc;
>> 	struct fastrpc_invoke_args *args;
>> };
>>--srini
