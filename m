Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D124C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 12:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB6F20843
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 12:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nltJ8sQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB6F20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbeJ1Vnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 17:43:31 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36376 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbeJ1Vnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 17:43:31 -0400
Received: by mail-lj1-f193.google.com with SMTP id s15-v6so5224872lji.3;
        Sun, 28 Oct 2018 05:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xYy1WKAbtC+bLTvu93oFushNxSY5ujZsJKK45wvq15s=;
        b=nltJ8sQe7yey0wtncJiJiNW5puOcK9q7NVUX5evo5AMUL8W+GKdEibpllA5a4pXXtz
         SgYZ10+vYAwQQla5dpkd8nH1xVQrO6KvV21SWGWativixq+3vxWHoK0vyfaY8AkpS/p7
         nnbTp2B6hafke53YhdVWuRR5Jx9FzuSIlXDmVK/nRWi9llEKAfx2kfuoHY7LgVogbmfw
         8RuUsf8jvAqHjgvq2mdzQRVePkJuR0tU55aYkCHVdf4cdYVOPfA8lfVofRn6y3JeALkw
         gbktmu91qAflEYUb+bxN79dZQEAdMI4buKmUx/KXlMaeimvsPqE/Idq3nTSX+bthVilA
         fa4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xYy1WKAbtC+bLTvu93oFushNxSY5ujZsJKK45wvq15s=;
        b=lncpAu0MsmotO2u+cewAkRSkVdhH5yP+7882eRzH4cmA1+DxcmOtjX672FX3vq7mrQ
         V6t4NMeedoMJVDUM32PLdzcbuS3bILZPkE7wJE5keUyVUP5PcT9fTeJjpJWJn8OwdqZm
         C22FZExzFdB7/wJndl9XEqhVHnKC05DSNQnLsEqWgC85VZQXufcOhcaWo7AXJDzoPzNK
         Q8jICdXchzI/S5wP4yeQVYLXjqmw82uQorrq5Tna0Az8ZCUygACK4law3D39cuN8xTKz
         OhyaO39mGpDwgfDA09Czi/y+gSdVrrawcXaC95bWheyRA6/ALkfZiMcxXfJJ1Y7i8R8u
         T/hw==
X-Gm-Message-State: AGRZ1gItwvrXzXIwt/PDwK5aUsmFDEjYFuIPsrir1VXpWpw4m6cqWK1J
        819yK6SNvJTN9KTDsPmj8UKpjxmo
X-Google-Smtp-Source: AJdET5dIg/B5YEbwi7EPHVU3s8AwgB/8ki7yRWdC8g3Uz8bOaVtojfjHgnzuQ0HP83N3+L9oUcxW9w==
X-Received: by 2002:a2e:8596:: with SMTP id b22-v6mr4616463lji.122.1540731533898;
        Sun, 28 Oct 2018 05:58:53 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.91.118])
        by smtp.googlemail.com with ESMTPSA id p63-v6sm2686093lfg.46.2018.10.28.05.58.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 05:58:53 -0700 (PDT)
Subject: Re: [RFC PATCH v2 01/17] OPP: Allow to request stub voltage
 regulators
To:     Lucas Stach <l.stach@pengutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>
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
 <ba782346-6ac0-7bf3-e187-00d2634b145b@gmail.com>
 <1540568255.2245.11.camel@pengutronix.de>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <bd3a57ee-6131-22bb-1954-3d97bba5276a@gmail.com>
Date:   Sun, 28 Oct 2018 15:58:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1540568255.2245.11.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/18 6:37 PM, Lucas Stach wrote:
> Am Freitag, den 26.10.2018, 15:03 +0300 schrieb Dmitry Osipenko:
> [...]
>>> On the other hand, the tegra20 cpufreq driver is common across a lot of boards.
>>> What will happen if the DT for some of the boards isn't correct and missed the
>>> necessary regulator node ?
>>
>> AFAIK, there is assumption that bootloader should setup regulators in
>> a way that kernel could work properly at max clock rates. Otherwise
>> things won't work.
> 
> This isn't true. The assumption is that the bootloader sets up the
> regulators such that stable operation at the CPU speed used by the
> bootloader is guaranteed.
> 
> Often the bootloader doesn't know about specific SKUs, so drives things
> at a rate/voltage that is safe across all SKUs [1], in which case the
> bootloader is totally unaware of the voltage needed to run the CPU at
> highest possible clock frequency.
> 
> Regards,
> Lucas
> 
> [1] http://git.denx.de/?p=u-boot.git;a=commit;h=2364e151e432b4ccf32dc9e6147121253d4ff86d
> 

Oh, okay. Thank you for pointing at [1], though the assumption is true for T20. 

I agree that it's better not to rely on configuration left from bootloader in general.
