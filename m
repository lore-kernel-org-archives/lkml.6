Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703E3C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F288120659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpvrcv8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F288120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbeIFBmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 21:42:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33590 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeIFBmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 21:42:09 -0400
Received: by mail-pf1-f195.google.com with SMTP id d4-v6so4112609pfn.0;
        Wed, 05 Sep 2018 14:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bLxx4+BtfCVbb+iBGRJl8fInfXNLFvBN+tvCisdL0E0=;
        b=gpvrcv8r/CD1bBubsXwFRTUazQTWHKKPXZa3c/u1VJBz5l5FLkkP2/qwV7nHyyqIN2
         KucI2XwmRNQN7ZSMKxjJMFomtkJuxuvo5KdGdhol+eccwDqn/E33XsjxTElNFoeXzh5B
         X4GC3tRFbzdYnXgLAJmYlQ4t1QqOCHY3sUWQiik2ewc9BKmKpNB3+7mquUPwUC10yWv6
         an91nwNM3gikWKgbBvsbeXleVk3sVQnnrSkCyhJb4BPIqXMK1GNEp09FTvUilYR1F3Us
         NQNxZxs5kVrPNcgdqBbXqO/BUvZFaZEU7KRLu16syjeImCG4GiSoLFpLUPaIO/ed6sQ0
         SipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bLxx4+BtfCVbb+iBGRJl8fInfXNLFvBN+tvCisdL0E0=;
        b=FGQJW4Ev02Wm4HiYaNeDvEd86S/7HKybGD3fh9oJXjqK+6nc6hp0LC6VCIjQyZhyFl
         3i0DJvI8NjIpAZoivcjj55cxmbULDJYorHTjHTV17t1hVyybt0gMyTUlihGfqRbW+jQ+
         tO7dYMs1vmETBVwpQRNaptzAs5owJzWnJz1C/6lN87GFwetHrzBPuMitI/BqqLRbwsiF
         oDzJrdVhfidrxgETDs7Rh9QQ21EdB3E/TOeawMErEqRza7tdyqUQnV1GjL1X7L2Sea03
         pNX6DSv8YYF9CzxgmyoxzM4ptrhIKSk0H/HmHc+yvcouDHK1N8BO+TA8gNPzljZyCmNp
         BNSQ==
X-Gm-Message-State: APzg51BAXscFibV67HkS7B8t44jOUdzZH/SPhO1EK99TVG8Ysfskx3dU
        /oVJ2do0VLQzU1USKfeFIQQ=
X-Google-Smtp-Source: ANB0VdZNM1r0XLDdU3PzdDmC1IV8AGx72R3RxE+55yjsmGNUWcmTkYKbYj5vwA5+/6lnvDHyuuwSyQ==
X-Received: by 2002:a62:2646:: with SMTP id m67-v6mr42798690pfm.254.1536181810178;
        Wed, 05 Sep 2018 14:10:10 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id n9-v6sm7826589pfg.21.2018.09.05.14.10.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 14:10:09 -0700 (PDT)
Subject: Re: [PATCH 1/3] of/fdt: Scan the root node properties earlier
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180830190523.31474-1-robh@kernel.org>
 <20180830190523.31474-2-robh@kernel.org>
 <b86ed9cf-d5fd-09fb-eb82-0143c759f5cf@gmail.com>
 <CAL_JsqJy0kDYCC35GR5TGLYyYU-UjOys_r2sFMQZuFto5HkExg@mail.gmail.com>
 <5da7b4ab-acd3-977a-6ac2-275911d7c436@gmail.com>
 <CAL_JsqKRsXN-MKdP1ts=QexwuwkXO5tbFkORf4xDyYt04FUuUA@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <00433395-ec1e-8a2c-cb88-5db659967643@gmail.com>
Date:   Wed, 5 Sep 2018 14:10:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKRsXN-MKdP1ts=QexwuwkXO5tbFkORf4xDyYt04FUuUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/18 13:06, Rob Herring wrote:
> On Wed, Sep 5, 2018 at 1:19 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 09/05/18 04:51, Rob Herring wrote:
>>> On Tue, Sep 4, 2018 at 8:49 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>>>
>>>> On 08/30/18 12:05, Rob Herring wrote:
>>>>> Scan the root node properties (#{size,address}-cells) earlier,
>>>>
>>>>                                                         ^^^^^^^
>>>>                              before mdesc->dt_fixup() is called
>>>>
>>>>> so that
>>>>> the dt_root_addr_cells and dt_root_size_cells variables are initialized
>>>>> and can be used.
>>>>                  by mdesc->dt_fixup()
>>>
>>> That's an ARM specific detail. Granted, ARM is the only caller.
>>
>> The dt_root_addr_cells and dt_root_size_cells variables are being
>> initialized earlier in this patch series so that of_fdt_limit_memory()
>> can use them.  The only caller of of_fdt_limit_memory() is
>> exynos_dt_fixup(), which is an mdesc->dt_fixup() function.
>>
>>
>>>
>>>>>
>>>>> Cc: Frank Rowand <frowand.list@gmail.com>
>>>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>>>> ---
>>>>>  drivers/of/fdt.c | 7 ++++---
>>>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>>>>
>>>> Moving early_init_dt_scan_root() to inside early_init_dt_verify()
>>>> puts something that has nothing to do with verifying the fdt
>>>> into a function whose purpose is the verify.  It hides the side
>>>> effect of initializing the dt_root_addr_cells and dt_root_size_cells
>>>> variables.
>>>
>>> It already has the side effect of setting initial_boot_params which
>>> every subsequent function needs.
>>
>> And that side effect should probably also be moved.
> 
> So 2 functions? One to set the blob and one to verify it. Then we can

No, I would not add yet another function.  All of these side effects are
an argument in favor of a single setup_machine_fdt(), as I suggested below.
Then all of these side effects could be in setup_machine_fdt() instead
of hiding them in sub-functions that are called by all of the different
architectures.


> just let arches decide if they want to do any verification or not.
> 
> Perhaps it should be called fdt_init(blob) and then it is vague enough
> I can do whatever I want.
> 
>>>> I suggest creating a new function early_init_dt_scan_init_pre_dt_fixup(),
>>>> move the chunk of code there instead of to early_init_dt_scan_nodes(),
>>>> and call the new function from setup_machine_fdt(), just before
>>>> calling  mdesc->dt_fixup().  This would be a little bit more code,
>>>> but more clearly showing the intent.
>>>
>>> I'm trying to reduce the number of functions arches call
>>
>> I like that goal.
>>
>>
>>> and renaming
>>> would need a bunch of arch changes. This change will also let me make
>>> early_init_dt_scan_root private as powerpc is the only user. I need to
>>> dust off a patch for that.
>>>
>>> I'd be more inclined to push exynos to remove this altogether. After
>>
>> Not a bad idea.
>>
>>> all, if they claim their bindings are unstable, they can't really
>>> claim their bootloader is stable/fixed.
>>
>> It seems that this series is showing us that maybe the three architecture
>> specific (arc, arm, arm64) versions of setup_machine_fdt() should be
>> consolidated so that we have consistent behavior for FDT.
>>
>> If we had a single setup_machine_fdt() then some of he hidden side
>> effects of functions called by setup_machine_fdt() could instead
>> be hoisted into setup_machine_fdt().
> 
> Those functions are all quite a bit different. ARM matches the machine
> desc while arm64 doesn't have any such thing. How the DTB gets mapped
> into virtual space also varies.

I argue that they _should be_ made to be more alike than different.  You
have only pointed out two differences.  Of those, the mapping could be
cleanly handled by an mdesc-> callback.  (I would have to look at the
match to see if that could be handled easily, but I would expect so.)

On the other hand, in a previous reply you considered removing
of_fdt_limit_memory(), which is only used for an exynos fixup.  If
you do that, then patch 1 disappears, and we can continue to
sweep under the rug the side effects that you reminded me of
with patch 1.

> 
> Rob
> 

