Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063B0C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4EC52075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/VWom2j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4EC52075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbeIHAik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 20:38:40 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40025 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeIHAik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 20:38:40 -0400
Received: by mail-pl1-f194.google.com with SMTP id s17-v6so7033974plp.7;
        Fri, 07 Sep 2018 12:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qfYiLrSG1vooqMREq/0OM4vQWIoCCkQTprKcLZPtets=;
        b=F/VWom2jN0DV7byhXmW/lo2CajkuqdOo3/w2c7lmLyBi2xYBEnqh5v4ZTjoyUIc8Rv
         Kt5GCr0kxEUW4yid07WuTOJyBgTKQdAsiTMVzfPFo9S+joWONmIyzMKwplgmYlxTu/AR
         0bH6Uplb8d7uVp+paXCO0Yp6ODntqx2jnCGdK0tRCTL/WRfC9WOb8dXRAiCJNlHCp4eX
         TP3eyidzOy1A/8eLPHqrjAU+XFqpY0C/LR3WH2QiZnFEXm7n660cd2RqRBlA8wL2jK/X
         QywpfmBrUg0s0BtCGxY57IBh/Plaq0oiTucrbHQDIpyITV8+OYLE7YG4SCAmI21Nkga0
         8lbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qfYiLrSG1vooqMREq/0OM4vQWIoCCkQTprKcLZPtets=;
        b=CV953g1JpURaSPNgJQFxgAznL4LZine05l+yGTgrAe4b84taBCTTRBzOJ6x6eZir8p
         M72PgiGoEOd6EggNWo+BIEGOvnR17GtoZPPmUv9coG1+QzvmnEYXzB20UGZvrmvap1yF
         5XPaYTVIk5DTW07Bgvb6k058SUDdtARafRrEEdFEJ8VEe+HCz9Oq0cxtGdnKkGCukFaa
         4gpX5Z2HpW5k8qFYIRYoOHxC0NGdNVRYE8qwKzpZ7yp9UQGNYx706+W2Ib1KAshGxlRI
         R8p6rEuqDFvqVzFz6DZyNNS6g9xy2fdkVlQopeGUxyK1YLzA7srlm6YPf8eD1GNKsTkc
         PiBw==
X-Gm-Message-State: APzg51D//qOJXFWcVvVwV53tdWlIEdfQjNsf2TzrNKmRqONZKPSOARCj
        hcoWL9A1dJN1xTXAfNoWXfo=
X-Google-Smtp-Source: ANB0VdZYXg1pN3TTm+Bra7xbsp/MkIzHpQJKSB6MoGVVu9I8K5jIjdDyI/kjcc118XTUJRLg59adxw==
X-Received: by 2002:a17:902:583:: with SMTP id f3-v6mr9725294plf.115.1536350171062;
        Fri, 07 Sep 2018 12:56:11 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id t141-v6sm12931647pgb.27.2018.09.07.12.56.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 12:56:10 -0700 (PDT)
Subject: Re: [PATCH] of: Split up name & type in modalias generation
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180907142247.2931-1-thierry.reding@gmail.com>
 <CAL_JsqJ0VZftZ+Qve+=91tbvgYof68NW+dBf4bPv+b8uQ0y1hg@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <32ff0b7e-a710-2c23-75ad-8c527d3453c7@gmail.com>
Date:   Fri, 7 Sep 2018 12:56:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJ0VZftZ+Qve+=91tbvgYof68NW+dBf4bPv+b8uQ0y1hg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/18 11:49, Rob Herring wrote:
> On Fri, Sep 7, 2018 at 9:22 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>>
>> From: Thierry Reding <treding@nvidia.com>
>>
>> The kernel's vsnprintf() implementation discards all alpha-numeric
>> characters following a %p conversion specifier. This is done in order to
>> generically skip any of the various modifiers that the kernel supports.
>> Unfortunately, the OF modalias is generated with a format string that
>> violates the assumption made by vsnprintf():
>>
>>         of:N%pOFnT%s
>>
>> While processing the above format string, vsnprintf() will eat the 'T'
>> character, assuming that it belongs to the preceeding %p specifier. This
>> results in a modalias with an incompatible format, which in turn causes
>> the automatic loading of drivers based on modalias to no longer work.
>>
>> To fix this, split up the generation of the name & type fields into two
>> separate snprintf() calls to avoid confusing the parser.
>>
>> Fixes: 73813f8483b1 ("of: Convert to using %pOFn instead of device_node.name")
>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>> ---
>> Note that a more elegant fix would be to make the %p format specifier
>> parser report back the exact number of characters consumed. I briefly
>> tried to implement it, but quickly ran into numerous special cases
>> that make this solution rather involved.
>>
>> I can spend some more time to improve this in general if that's what we
>> ultimately want, but I think this patch is a better short-term fix to
>> workaround the issue.
> 
> See my reply on the original patch. I've updated the patch in my
> dt/next branch with the fix to use %c.
> 
> Rob
> 

Agreed, your updated patch is more compact and looks cleaner.

-Frank
