Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8829AC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594C32087E
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uEPbh9ge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbfAYTXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 14:23:39 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35433 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfAYTXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 14:23:39 -0500
Received: by mail-wr1-f66.google.com with SMTP id 96so11524777wrb.2;
        Fri, 25 Jan 2019 11:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G5R2pie8ysDgMnM6Xn5W4DVLQqSqb9WshWg9azW97Tc=;
        b=uEPbh9geNLdi69OLIftXdtpFW2eKqkkZm/MSLRUruPzeuX9sfS1zv8MjOS/oHTB6Uy
         HAFAYmVybHuDa14OpvVo+HJ/wn/p+0W80hgPSGcE+0tOfFCFPGTVT/UWAJn6BeIte9LE
         +wtGstuS6tojRLM5wlk4NgrnwZRADVNFSr2Mo+Kse/u9Pdbf9clBxtt1R6aFY00p0TrS
         pxppBh2A+Sjm3d2YcN9blR5aO/vifulqeNVyVSdKRr1Y2TVRS7g0OjOpapbljM7LIKX9
         lVesNPzuoAHVJIaIZlPXJCetGEbr3BzLK9mvEVeqIhsLE91bLoHTrN2kXm33pMN8BoFg
         ZXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G5R2pie8ysDgMnM6Xn5W4DVLQqSqb9WshWg9azW97Tc=;
        b=ALr807qCtN7pkS6rtYwOUQX62QHcKdqaee3lVUrG3eiUd034y6sVuMd+mCSXaVl/G7
         4CbN878A20UIYbIvIh8VdvNYQDKRTP9K/kJb+HKPvsI8cf4KtRijsrg9HF3JaNNMOdqx
         BpBRvGfyH3xzBFvPbv3lhiMuNR1fxlrQ/1syL9p3Mug/ymhh0L0a4ZA/opMKKcfEVT0E
         m8BTyXfMoAIdnAK52HGQ+i7PpdUgOsW/KTgbA4rJA4UCceHKDxajmTuj66O2TJucCk+F
         KwgZLrwNsBA0CXfW2CkyiaslMZHnB+kDg/gH0ieTH5PuBKrpiGZ65G2wyMVn7ZBzvkr4
         6spA==
X-Gm-Message-State: AJcUukeRqCXtAtV36oaRSBtiOzMBTEGsi/LhhT1gT1vTb4ALOwBVLrjj
        nqUapqYi2IeB+mVlIA79BkqtYKT3
X-Google-Smtp-Source: ALg8bN43nT0U/+yMt8Q5LahkqRCPsTvVwkxE2PUqBM4U8c6f4vMy5DWSKkf8DJ3230QpDFIkRzpT5A==
X-Received: by 2002:adf:e407:: with SMTP id g7mr12422089wrm.277.1548444217079;
        Fri, 25 Jan 2019 11:23:37 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:fc07:c732:1a36:65ad? (p200300EA8BF1E200FC07C7321A3665AD.dip0.t-ipconnect.de. [2003:ea:8bf1:e200:fc07:c732:1a36:65ad])
        by smtp.googlemail.com with ESMTPSA id x186sm83935785wmg.41.2019.01.25.11.23.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 11:23:36 -0800 (PST)
Subject: Re: [PATCH] r8169: Load MAC address from device tree if present
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190125101814.6262-1-thierry.reding@gmail.com>
 <20190125145711.GF12962@lunn.ch>
 <42d32783-c433-b859-6ba4-f2864f034871@gmail.com>
 <20190125190715.GG22211@lunn.ch>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <39547002-74f3-66c4-93ce-9adf72841b8e@gmail.com>
Date:   Fri, 25 Jan 2019 20:23:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125190715.GG22211@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.01.2019 20:07, Andrew Lunn wrote:
>> Andrew, for my understanding: What do you think is wrong with the 
>> alignment requirement? It was introduced because we do a 32 bit access
>> to the start address of the array and want to avoid an unaligned access.
> 
> Hi Heiner
> 
> Because you are doing pointer aliasing, the compiler will by default
> generate bad code, doing unaligned access. Adding the attribute works
> around this. But it is just a work around. Since this is very slow
> path code, i would just avoid the pointer aliasing, write a bit more C
> code as Thierry suggested, and the optimiser will probably figure out
> what is going on and produce reasonable code.
> 
> Also, in general, by avoiding pointer aliasing, you allow static code
> checkers to work better. They are more likely to discover buffer
> overruns, etc.
> 
>     Andrew
> 

Thanks, good to know.

The following doesn't hurt us here, but things like this have to be
considered too. According to chip spec:

"The ID registers 0-5 are only permitted to write by 4-byte access.
Read access can be byte, word, or double word access."

Heiner
