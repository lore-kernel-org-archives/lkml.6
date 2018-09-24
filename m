Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0240CC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B30A62098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r2j0pIcC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30A62098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbeIYAnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 20:43:16 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38534 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbeIYAnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 20:43:16 -0400
Received: by mail-lj1-f194.google.com with SMTP id p6-v6so19216949ljc.5;
        Mon, 24 Sep 2018 11:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=En6PoCc+9vwtAGAI+JiCIXhW89xB3mw0ywppkj1YwQU=;
        b=r2j0pIcC1g9VllRNCuX6A73C8p34nM6nVmKc3Ubq5xqQR1gYdStEnEO9lTwEbQZg2N
         c6x+TThURwlhd3FV89KlAHHGZ70kNyxQZtkIihLwvjqzCdx4Ouuu7AgkmAfv/wHzvPl5
         KYE3Yvdh0rAZKRnG8btwLzo1Jcejkst+5OmxhYqOkfeEwPsLpCl8hO++CJ9NYuTpGo6Y
         7L6uL+nqUJY0qRdFRwcnw0UsBWl9m1B4sZ5Kf6JpC3BpFbmOq7PTdd2Z3XBXsKrh0cOg
         Qrfffu5Ls9ufh0vLMDDi9SN8mUhGb0o32blsWD6hpuoHhpT8hzPADJFKAbKZr36vLUqP
         98ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=En6PoCc+9vwtAGAI+JiCIXhW89xB3mw0ywppkj1YwQU=;
        b=gdhs5Bg1wkQK0mWbbukEAOTW2VU7atFTv2GUyuPFjQG4ZEDYz4+TLH+whBrZKdOWN7
         mxtml5M+E7fzR3o9hEmsmf1xeyI+T7SDrTL+k1DA8hy1Dl6k5EQ6qDyti2xH2qAB76sL
         /jirPzciO+v1jaYSrACbq18NtyviMxpCsDCRVNTZ67/DDfgCIljFWCG4BAAKwR2Ojxzy
         XcfcUQjA5sY4IFBU8TW7D/SCpbURWLzEKj7o5w8TOqk7XKbMDWiL6FHqVYjahZAPdFl4
         oDod5fj/IXOdqSlfc9MnmrU/WydbQBB4ziasDbK7Paf4ERW0mL+Eluw5gP8JgG8hF64G
         lPWA==
X-Gm-Message-State: ABuFfoigGR1Ev7kovOQB6jgfhabU2bkStcFotPyN8tv08Slimpfvgsus
        Kx0xsn8ytnBSv36ewbyAAXUZSPjK
X-Google-Smtp-Source: ACcGV63tSWNfDBJCmSMw+YIu8KNCDO6ZdQTVSkv9R8DaDb0s0vrRB29grsmOfCKZFBajI83fWc6f0Q==
X-Received: by 2002:a2e:7014:: with SMTP id l20-v6mr371ljc.141.1537814385138;
        Mon, 24 Sep 2018 11:39:45 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.googlemail.com with ESMTPSA id y16-v6sm9504lje.30.2018.09.24.11.39.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 11:39:44 -0700 (PDT)
Subject: Re: [PATCH v4 11/20] memory: tegra: Use of_device_get_match_data()
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-12-digetx@gmail.com> <20180924101354.GH21032@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <dcf439a0-249c-ff9f-292d-c807a736672a@gmail.com>
Date:   Mon, 24 Sep 2018 21:39:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180924101354.GH21032@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/18 1:13 PM, Thierry Reding wrote:
> On Mon, Sep 24, 2018 at 03:41:44AM +0300, Dmitry Osipenko wrote:
>> There is no need to match device with the DT node since it was already
>> matched, use of_device_get_match_data() helper to get the match-data.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/memory/tegra/mc.c | 10 ++--------
>>  1 file changed, 2 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
>> index 5454ffe5b2e0..cdc33f93cf7c 100644
>> --- a/drivers/memory/tegra/mc.c
>> +++ b/drivers/memory/tegra/mc.c
>> @@ -11,8 +11,7 @@
>>  #include <linux/interrupt.h>
>>  #include <linux/kernel.h>
>>  #include <linux/module.h>
>> -#include <linux/of.h>
>> -#include <linux/platform_device.h>
> 
> It's better not to remove these two because the code still uses
> functions declared in them. If ever we were going to remove code using
> linux/of_device.h and then remove the linux/of_device.h include, we'd
> break the build and have to reintroduce the includes.

That doesn't sound like a good argument. You're way too picky here ;)

> The same would happen if linux/of_device.h were ever to stop including
> linux/platform_device.h or linux/of.h. That may sound unlikely, but it
> has happened in the past with other includes. It can also happen that
> some restructuring takes place in some headers that is not so obvious
> and then things can still start falling apart miles away.

Restructuring will be somebody else problem. Not sure that we really
should care about it, I think it is unnecessary. But since you're
insisting..
