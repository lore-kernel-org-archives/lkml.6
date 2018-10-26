Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A85AC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 12:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE82120873
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 12:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InF0fbNg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE82120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbeJZUkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 16:40:42 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36013 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbeJZUkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 16:40:42 -0400
Received: by mail-pl1-f195.google.com with SMTP id y11-v6so417935plt.3;
        Fri, 26 Oct 2018 05:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ANRKLCsHHwR7eib38zAD/OCx5I7PXx4q/aI1rdMoOFs=;
        b=InF0fbNgYwT4zUtsDMuhDrRArT0lH9qwrfOEIoUWYlEP+bQwI4ArnAeQQFi3yZwzCd
         PHoHBpU+7Xz3prrSQzUcCuSDFJ3Myp9UULCByylI3pPMvw8FAXboSiikzl9/ihSTDl2j
         TIbT1/TLRaaE68R3xuC9XZyd53UtJVNcdbZRve5jrV222zgewlI9dITdG0Ub9sY7mRcM
         t6rCBywaAeg2V1BYZvRK8pA9jnSkxQqeZ1sEIlLyhZxaRWzPBOUpDCrc9Ks6tSRVr/9W
         fIToXObJWg/IBE/+f+/6bY0V0BSxTNbMy06cKCYUyEQtwP7EU8jYevH0DtkSDxY2oSk0
         t3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ANRKLCsHHwR7eib38zAD/OCx5I7PXx4q/aI1rdMoOFs=;
        b=FcKsS+jD63CbP41v6Ke90mmZqjmtwfxJze0CA7AUT6TFs7LbMlYYKVChwwjt7YsGVp
         8z3oRqmrwiIfGgPe4INEAqPyWcBWfti8ADHBQoLcZLUrsgK3KBxPHK2uLjQEJh+tv/e3
         I5TNM8Wnpo+n2gyHtn9Biyk1gbqUS/ptVNPnnoJsqrOmVZe2yEIq2QPmAPbYOSJW07HP
         dMxQnmYolzCqzMEek1DeLbvPGBDlkRdJiFog9i/bBuQ7xQ7KeSxIBxw+RjwXO7ucO8ZF
         IsUTpK321f2OA+ikwImoLHFIJKb2LuuEtxE8cxZEtZIg7LmTDWIdOtHHesHU/GzwqoQ2
         sv/w==
X-Gm-Message-State: AGRZ1gLi+19wWUL+6BOpittbVJ1aZbkCHx4inCNt0NmmsV7cCa+mJt7k
        HgPNJh8clOsjLMQTIjaRoxizhgaJ
X-Google-Smtp-Source: AJdET5eazylpIzNzoWwSrb6SNEQzzQg7zJ9hL5CBtzwTPe2aNKuXLj/LnBG4KYraUQLSU99Nhwm0rw==
X-Received: by 2002:a17:902:b690:: with SMTP id c16-v6mr3218926pls.284.1540555431155;
        Fri, 26 Oct 2018 05:03:51 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.91.118])
        by smtp.googlemail.com with ESMTPSA id h123-v6sm29231469pfg.138.2018.10.26.05.03.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 05:03:50 -0700 (PDT)
Subject: Re: [RFC PATCH v2 01/17] OPP: Allow to request stub voltage
 regulators
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181021205501.23943-1-digetx@gmail.com>
 <20181021205501.23943-2-digetx@gmail.com>
 <20181022053636.ag62j3rj3vovbz53@vireshk-i7>
 <e4027793-9436-413d-2a7b-34cf519218c3@gmail.com>
 <20181022113224.b5fiebgy2aap66nd@vireshk-i7>
 <29f893be-feed-c4c5-8468-51f7228dd468@gmail.com>
 <20181024064123.lbpbeervghp35fe7@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ba782346-6ac0-7bf3-e187-00d2634b145b@gmail.com>
Date:   Fri, 26 Oct 2018 15:03:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181024064123.lbpbeervghp35fe7@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/18 9:41 AM, Viresh Kumar wrote:
> On 22-10-18, 15:12, Dmitry Osipenko wrote:
>> Because there is one Tegra20 board (tegra20-trimslice) that doesn't declare
>> necessary regulators, but we want to have CPU frequency scaling. I couldn't
>> find board schematics and so don't know if CPU / CORE voltages are fixed on
>> Trim-Slice or it is just preferable not to have DVFS for that board, it is an
>> outlet-powered device [0]. Hence tegra20-cpufreq driver will request a dummy
>> regulators when appropriate. 
> 
> We have been using the regulator_get_optional() variant until now in the OPP
> core to make sure that we don't do DVFS for the CPU without the mandatory
> regulators being present, as that may make things unstable and cause harm to the
> SoC if we try to take CPU to frequency range over the currently programmed
> regulator can support.
> 
> Now coming back to tegra-20 SoC, which actually requires a regulator normally by
> design. On one of the boards (which is outlet powered), you aren't sure if there
> is a programmable regulator or not, or if DVFS should really be done or not.
> Isn't it worth checking the same from Tegra maintainers, or whomsoever has
> information on that board ?

I'll try to find out more detailed information for the next revision of the patchset.

 What would happen if there actually was a regulator
> and its default settings aren't good enough for high end frequencies ?

Usually this causes kernel/applications crashes and/or machine hang.

> On the other hand, the tegra20 cpufreq driver is common across a lot of boards.
> What will happen if the DT for some of the boards isn't correct and missed the
> necessary regulator node ?

AFAIK, there is assumption that bootloader should setup regulators in a way that kernel could work properly at max clock rates. Otherwise things won't work.

 And because you are moving to regulator_get() API for
> the entire SoC (i.e. its cpufreq driver), people will never find the missing
> regulator.

Regulators core prints info message when dummy regulator is being used.

> If we can do it safely for all tegra20 boards, why not migrate to using
> regulator_get() instead of regulator_get_optional() in the OPP core API itself
> for everyone ?
> 

This should be a platform-specific decision. For Tegra we know that regulators should be in a good state at kernel boot time, I don't think that this applies to other platforms.
