Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65385C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 04:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348CB2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 04:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bsnes2cI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfBUEo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 23:44:27 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36420 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfBUEo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 23:44:27 -0500
Received: by mail-pg1-f193.google.com with SMTP id r124so13146407pgr.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 20:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+HG+2c9z1DCmIyJ9+MtumAT38x+S8zE+I7N2uBb+9pU=;
        b=bsnes2cIyfUpajTYeAetVd5jRjP7tDjRVxxu1JSX1FP+8Jz2TWILvBUZybW0HHja/7
         mvZIsu03DOa0B1bFl8lALdYOHCyPD87hCdkY5Rj9E3ddfhqMiHXPcaFjjeTxnVqYnbVY
         sir/BpUR/JA+whSKeG/rj/iJUq19QstaTfYInzzu+iuGwiy3THxOXveCpa2VcwRMr8hZ
         6CE3Zz1Mlk6oXaxhTRERghRLiSPTBndrudQymIGggqnW9fpRRjzwwmvBDLKd5a5HWyjD
         nNLmcUcpmzmOYKolzxuwJ2y/TOAksHix9rauWfDcErJOCFPEloEeJdWR2kzv6T8J9xnC
         5ZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+HG+2c9z1DCmIyJ9+MtumAT38x+S8zE+I7N2uBb+9pU=;
        b=A2jdkcw4oqNOFfvPENUjvIKtZNdLEDqhfAHDHHPcC9flnWdEWKIk5OdaFK5McRIkIC
         E6luJqrBjvlxhxxXWTnBYfHkNOlZbOWhtnHx3/dY89cklj6yO+kSl/dKxKpGwTZNywS4
         rKDKhQcKzZ9D7/JfhFICieGnw4IqIIwCuATR3Lu/A474tRH+B7SFHs6GX2h7of7xrdln
         AXaLlyychFkdEA0I3V6M9GH1UbWTdxmg78LT8eI+iX8a0z4MY7gBJVgxljYD1cJnrbHN
         +Xhc6zKnhCEZdwdaZKXZizCfmt8/G2AioN3zG+Ggdn1nVBtSlRSxdZbh6wVCSpL3WXjR
         ObLg==
X-Gm-Message-State: AHQUAuaYUSGrBeEgfd7t4O7ROWPcp+TkMt/vy1jJZZYyj4IfBzpIP7oq
        y5UpkpfHI9iNxkX0+s0kjFAjL0XDzXc=
X-Google-Smtp-Source: AHgI3IZxFz/ZLPbRt1yZLrmV9M6vBSTEzQ2GURV4JwZhUNdDi6DC/C0xJeQGeG9ds9xYWKDQF+HXpQ==
X-Received: by 2002:a62:2bc4:: with SMTP id r187mr38408016pfr.25.1550724266062;
        Wed, 20 Feb 2019 20:44:26 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id u24sm2560425pfm.140.2019.02.20.20.44.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 20:44:25 -0800 (PST)
Date:   Thu, 21 Feb 2019 10:14:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, Ilia Lin <ilia.lin@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: kyro: Reduce frame-size of
 qcom_cpufreq_kryo_probe()
Message-ID: <20190221044423.utea76twxplxusna@vireshk-i7>
References: <5919a74b74f466e803e07f70136517119dcd4560.1550661235.git.viresh.kumar@linaro.org>
 <CAP245DWuJTXfAc3QyqXjePqy32GHQsEqHbuSvjiS4EE3-TV1PA@mail.gmail.com>
 <20190221034534.n5jli3bj4mwtoudd@vireshk-i7>
 <CAP245DV9m-foV8vAWSq5ZpvPHa_dLJyBQzRkta5B_yO2+bwL2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP245DV9m-foV8vAWSq5ZpvPHa_dLJyBQzRkta5B_yO2+bwL2A@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-02-19, 10:02, Amit Kucheria wrote:
> Perhaps I was just unfamiliar with the dev_pm_opp_set_supported_hw()
> API where the actual allocation happens 3 levels deep. Maybe the
> comment should apply to dev_pm_opp_set_supported_hw(). I leave it to
> you to decide.

I think we are fine without any comments here :)

Thanks for your reviews Amit.

-- 
viresh
