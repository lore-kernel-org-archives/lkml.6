Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97079C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530232409F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S2Ya0PrR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 530232409F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753764AbeGERjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 13:39:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39543 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753405AbeGERjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 13:39:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id h10-v6so1683751wre.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 10:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+03n6e92YvRh9Qo7RxfeWw+BeEIv+BFacL5hdfS1qI0=;
        b=S2Ya0PrRUkl7LN8Zrvg1LDHbfNdPgtq2kTKV0nR/BOu15Duo1OGx7RjbyDMdLXP0WN
         EJggGLXyZnmZMcLvFvU/tVmbOsZsNZCw9Q5ETI+lrpVjc2ExWP8mQX/FRSlmk8U9rc2I
         qVlETL4f4ueFa6fS+0ZD61nRGLp/NHZ/2cTpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+03n6e92YvRh9Qo7RxfeWw+BeEIv+BFacL5hdfS1qI0=;
        b=TYR3mEcEUOyn1/EUT9LCOO13dQshU1/3Q/BwlzidDkeEbWLAI6WLetmboGHDShpaVg
         /YZGrOIrAU51lLmAlEpmKJKSxqFA2cGqvzJOKqXYS+bmv/MO3kkRaZRV33sjpF4Zl82h
         /fmph7OM61vRyCu6KY6O60vBJB1BcBXF0DQqvT9qfFtG/qwAszNqzSgzk/iL9Gud6KGF
         Ff/y/gFOU/dQaRM13kzDsXP+SIO6OiwM0ncxVIZlP2CpOa1TvKW6cPGzj7uYDL3B16E5
         /I/khCLlwm2x/C07nk+GqXA8RmIqOFy1yGZ+O+znhHKMWylVDv05+gWibyDep0rEb0PW
         OKRQ==
X-Gm-Message-State: APt69E2+ps+MNrLcaE9WnR4R3gigNw5kq9Qgw/+2N08LWdVvZMut17d8
        VxTv7zPs7XgWPTviPkeIZt1g5w==
X-Google-Smtp-Source: AAOMgpcCF1SxzXeyAPzddPri5x43z1teAkoag1cCwatfC6m4tviemf+3nsHa4VmH3AiaQENjxj4YgA==
X-Received: by 2002:adf:ba01:: with SMTP id o1-v6mr5551857wrg.249.1530812355714;
        Thu, 05 Jul 2018 10:39:15 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id t10-v6sm5361551wre.95.2018.07.05.10.39.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 10:39:15 -0700 (PDT)
Subject: Re: [PATCH] regmap: slimbus: add support to raw read/writes
To:     Mark Brown <broonie@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
References: <20180705113700.32465-1-srinivas.kandagatla@linaro.org>
 <20180705150857.GA6227@sirena.org.uk>
 <3c958e52-d720-c008-913b-4ff29ea35c00@linaro.org>
 <20180705165011.GC6227@sirena.org.uk>
 <5c3bfd3c-f84a-3fa2-f6fd-5624fd052e87@linaro.org>
 <20180705173059.GF6227@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <2d2ea16e-c8b4-53b9-259e-d75e6ead4362@linaro.org>
Date:   Thu, 5 Jul 2018 18:39:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180705173059.GF6227@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/07/18 18:30, Mark Brown wrote:
> On Thu, Jul 05, 2018 at 06:20:50PM +0100, Srinivas Kandagatla wrote:
> 
>> Access to codec registers is done in 2 steps.
> 
>> 1> Write page number in page register.
>> 2> access register within the page.
> 
>> This seems to exactly what struct regmap_range_cfg gives.
> 
>> Adding ranges to regmap_config along with read/write bus callbacks works for
>> me.
> 
> OK, great - that's what I was expecting.
> 
Thanks, I will respin the patch removing reference to raw in commit log 
and patch.

Are reg_read/reg_write callbacks in bus regmap redundant to read/write 
callbacks?

By the looks of it, it seems redundant, reg_read/reg_write will never be 
used if bus regmap has read/write callbacks. Just wanted reconfirm 
before replacing them with just read/write callbacks.

thanks,
srini

