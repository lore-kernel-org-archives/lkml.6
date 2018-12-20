Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744E6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DCD21741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NF1qpuTC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbeLTIr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 03:47:59 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:40721 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbeLTIr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 03:47:58 -0500
Received: by mail-wm1-f53.google.com with SMTP id f188so1137667wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 00:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oRqCSI+wOC4AW0FQlEjLKsMs4pQUhUWfg5qZTFQyx8w=;
        b=NF1qpuTC8qzsBR6Mv0Ilsh1gihf29epyFafdjXeTXn7WZB73xv+i9VsWpbfyNBq3sb
         r81D9cDHJr8PcMld6FgNwvUeeJySHQoD0PtheHo80+MXez3VpRH/PGsTgnj9ce2BkMIX
         hYXyTHCefJjZOkh/F7hpmpiBhNX5wNI07QG2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oRqCSI+wOC4AW0FQlEjLKsMs4pQUhUWfg5qZTFQyx8w=;
        b=b50+Moiy/6deNSGLMpEJOSubJK7fZSwsoIjcc6lrdax/8E4N9fNw4yXgzHd0L+U3tP
         d0L/1ucyDe+IdbZDjmY3qq9lkC+eseoKl7GE1OiS+Rg/bPdGFttMreYBCPUxuhPFatTQ
         dfl5LUYRFol/93ni2kSnoXRb1PHVTLFeR3xDvJ6rvpLDz5VoIjHhJDZ8QkEuT0WjDois
         pre2AaCUeZUkrv2IwJ7A5YLugi/MbKKFypdlq4pcmu1EHMmnDJIStDK7SI2+wo0UbTFU
         gn8KA8qRsgjcJ1tzxOOVzg08iFAQJFBOq94aJkVQZJfE9J3CminWtl/JTuLecRrkWoUN
         Vlmw==
X-Gm-Message-State: AA+aEWb2W+JwLnz3ABriR04zn8gp5riiKDbCwmCjwzmBzK07cOENEqaG
        RiVBm0lZGAY5zKDK5j/cCKNK3sV+5y0=
X-Google-Smtp-Source: AFSGD/XJaC0B9jnik+pLgJcF0Ggp1AhrW1Q6kwfJJEQq4BVqYiVTaw7cStPB2S0UJD/zEopIgEl9gA==
X-Received: by 2002:a1c:9e4a:: with SMTP id h71mr10859544wme.82.1545295676084;
        Thu, 20 Dec 2018 00:47:56 -0800 (PST)
Received: from [192.168.0.40] (197.26.136.77.rev.sfr.net. [77.136.26.197])
        by smtp.googlemail.com with ESMTPSA id y13sm7985838wme.2.2018.12.20.00.47.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 00:47:54 -0800 (PST)
Subject: Re: linux-next: please clean up the clockevents tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181220161504.5720655d@canb.auug.org.au>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <bcd7f298-c223-0d40-dbf5-edc8e1650794@linaro.org>
Date:   Thu, 20 Dec 2018 09:47:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181220161504.5720655d@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2018 06:15, Stephen Rothwell wrote:
> Hi Daniel,
> 
> It looks like all the changes in the clockevents tree appear as other
> commits in other tree(s).  Could you please reset your tree to somewhere
> in your upstream tree as it is beginning to produce conflicts.

Done.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

