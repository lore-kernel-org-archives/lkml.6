Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043D4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 05:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C612D218B0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 05:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aCmp6aeo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbfBRFAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 00:00:06 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33259 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfBRFAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 00:00:05 -0500
Received: by mail-pl1-f195.google.com with SMTP id y10so8157557plp.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 21:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xi5+ETcUvNp3zPA1uIJm5loWlmDmevDNXr5dM08a4fc=;
        b=aCmp6aeoopyxEgHVmGEc7gF3F4C1gyLQIqAipGPFylXkxiUCn2x/+2UjXuNK7f5DDx
         6XkPZ2SP60N2B0KBmyzWJtGaC1IxWCBXAhXakmRtRq6z++CU1mOL2ZN0nm2n+8My6mlA
         fy8Ng16UVczaSX00vjeEYWf2erZqDhJKGPnFKKjfZ1Nh6O+icJFJlLl8gMzaxvolVzEW
         9OSzbltnF+hGii0gdOBSI8Nz/VyYTWewpKJqgX+chburSlSbGS7LRRqyRSvLATAJDPJG
         POCPJXMWmkKFJDZQ+2NsmDt3e6Nu/hIZi3OOkC66Wt4IaflBklJtLaVGsj9ZdpN/51Rj
         85tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xi5+ETcUvNp3zPA1uIJm5loWlmDmevDNXr5dM08a4fc=;
        b=Ywasv8hT7g/XuVMA2OPgsdTayWVEcdqwLspCoTivunR/CxsnXRadQEl5761lPGuYTA
         4LW+Yobe4yIs+QNGmXhYC7wwlLGllJZwkjKuJ9dw2nOXnDaNGOLFhedYFBN3DHyzix+q
         DOm8U8P3uwjM5fN7T7jPi14DSTJJAMaoEg5klVJBn5ymHVGG7IlEVeHMGTqTT9jREVIk
         RYaXfpt9tbj7wbYWfYpP9LGVo4RZsQw1WFqfQSU8dS7fs7ysoOfaYicVK3qLLbL0a4BI
         gPsXLeKpqAsGID0AQ9TuHV+VYXjPDiiN9LVGu96aSowJlTF4EpRIhG5LeuuhC7+O1M/e
         Pmaw==
X-Gm-Message-State: AHQUAuaOwWrtY8h+kREhdWOVASkHiq8P4mU3/UL8RukredyhcuaFLNR2
        HhwArzVsSprr2zz7HQTJeMAl/F4G3FE=
X-Google-Smtp-Source: AHgI3Ia0vE74Z6rj47ir8Xgw0Qik0iZ6iU98mDRnxUkDRM0vxsM3aRxVLmJJLny2Q1okYgPa0ECQ3g==
X-Received: by 2002:a17:902:2f:: with SMTP id 44mr14990491pla.44.1550466005250;
        Sun, 17 Feb 2019 21:00:05 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id s16sm30175468pfk.166.2019.02.17.21.00.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 21:00:04 -0800 (PST)
Date:   Mon, 18 Feb 2019 10:30:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] cpufreq: do some cleanup
Message-ID: <20190218050002.a2xb2o6w3s63xfv6@vireshk-i7>
References: <20190216155527.11839-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190216155527.11839-1-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-02-19, 10:55, Yangtao Li wrote:
> The informations come from the coccinelle tool.
> 
> drivers/cpufreq/longhaul.c:854:2-3: Unneeded semicolon
> drivers/cpufreq/pcc-cpufreq.c:271:2-3: Unneeded semicolon
> 
> Yangtao Li (2):
>   cpufreq: pcc-cpufreq: remove unneeded semicolon
>   cpufreq: longhaul: remove unneeded semicolon
> 
>  drivers/cpufreq/longhaul.c    | 2 +-
>  drivers/cpufreq/pcc-cpufreq.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied. Thanks.

-- 
viresh
