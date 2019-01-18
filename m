Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D52AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 05:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D7C2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 05:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dS68gl2F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfARFiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 00:38:06 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46708 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfARFiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 00:38:06 -0500
Received: by mail-pg1-f193.google.com with SMTP id w7so5487800pgp.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 21:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5y8w1pVMReoNI1u5UbmvDgYsHgUjlFQXnVFUfI892u8=;
        b=dS68gl2F5dcNKW2mpw0rvtGmo+jRqRaZf2Qnr6QvI1anw9T5c5bmCdeW66EeYWV43c
         x8P6cJOwO1Hy8YFauXXul7ydACUlnKbpedPxRum+6ACnDqUZMJBbDs5ZA4UUVrfYJIsg
         PNOh2kWWHaO4bscxRYvF7VrgRjwjNLjy0fABE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5y8w1pVMReoNI1u5UbmvDgYsHgUjlFQXnVFUfI892u8=;
        b=ei2hY2QcMe61L/jnKdr/s51MRkZDigFL16SpU4Fp/dyNKf35FoRshFUyUmXZWRQxBs
         PFWf1BFv0sPQqWyuOmpKlCGZlqDPPZUhwbh1y3iTY1VtYwcg8vwxcvVJHIeOYJxNyHHn
         7k2nf763shZL6G/opaCyhpOmgEMwFaXuOEid35rlTCQzYMUPV0QoK6Dntu/jwMz8IW16
         NiQUkCJ6bNgm1P6l/HwKcjjGyt8q8wwuxtzyWVaOHv17eI4hRWoi2gKE9owyeC5CMuqC
         qujaQa5o038uHzSjCO8Qnmd/ypO5Z8nZBj1UxS/NDMMGGePMRaai65m0ED+nxEN4KHVY
         IAgQ==
X-Gm-Message-State: AJcUukfLpCZ0hbrVk2e8gvrvNhfqy/mOb0qR3VQzOT8Qm/1a9viCjzCR
        a4gJrmT63IB1hC/zJ1EpaMT4i4i/8us=
X-Google-Smtp-Source: ALg8bN4Pb8IrG7UYLfFtbhSUbUf8PpEwx3zsRU8e6VwL3hY+8FuRY9wzX/mY9KHSMuW+LDYsepgdog==
X-Received: by 2002:a62:3006:: with SMTP id w6mr18086196pfw.258.1547789884734;
        Thu, 17 Jan 2019 21:38:04 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id x11sm10215485pfe.72.2019.01.17.21.38.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 21:38:03 -0800 (PST)
Date:   Fri, 18 Jan 2019 11:08:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the cpufreq-arm tree
Message-ID: <20190118053802.rm7fc5z7wk3agc2f@vireshk-i7>
References: <20190118163307.03bd6710@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118163307.03bd6710@canb.auug.org.au>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-01-19, 16:33, Stephen Rothwell wrote:
> Hi Viresh,
> 
> In commit
> 
>   3ca12c96ef5e ("MAINTAINERS: use common indentation")
> 
> Fixes tag
> 
>   Fixes: 46e2856b8e188949757c9123fd7f9ce36edd1a52
> 
> Fixes tags should be in this format:
> 
>   Fixes: 46e2856b8e18 ("cpufreq: Add Kryo CPU scaling driver")

Fixed and pushed again.

I missed looking into that. You must be running some sort of sanity
checks on the branch itself, can I know what exactly are you doing so
that I can try the same.

-- 
viresh
