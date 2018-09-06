Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A5DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F46D20844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVeEvmgs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F46D20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbeIGBlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:41:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42314 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728917AbeIGBlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:41:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id y4-v6so5829331pgp.9;
        Thu, 06 Sep 2018 14:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4QH5NCNTGP3b5T3hH8mzRrazsujy1Kmc8Rc+YUUH468=;
        b=OVeEvmgsXyKC9hrhVe692n02S/g/7X2r/QeoITR1b+sVDXo/55WxC7O+rE5Rx9NiGz
         b0lQN9bYwMI+1kHdVXEm25FyUa85n9Mis2/q2cydBCbs544GRj+S5LKqJL0NT/mcSD1a
         OcAqZn50RPRIIMLbsGJHOVXOotBrnWUkHLBUfpzWe98HxsDh92xw7Asu6pmNXEE0RdMC
         8jbNRZ4HIJj2jlOfiLp5ClcgMdRtU3XJywsb1RnhuwHwhrmf9RrIHRKnlewkp+UVIj35
         sP2KnR5GJv9S0i13JizUjgrSs1lRMJvur9EP0TwnwC+zAAWbCtk7V8FW9zoCh45hul14
         Bl6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4QH5NCNTGP3b5T3hH8mzRrazsujy1Kmc8Rc+YUUH468=;
        b=mgBL19TGLfXTUDQfvcfubkQukQt5EmTVNjrJr3fWs5PB7MUe3qT2FDUuLD/1ZlttsT
         VZYlBdHYFeHvc77Z/tjRIFsSNA6gWCcn+gzYdBLAcZrBYjP433Z3cAN4kNxngH1qj1Mg
         C3QHE6EL9WwVeZHT52kSOpo06txZBj70hrBLmLwmkPkTw0IG/pLRbp1qlWstZWydfMKq
         oG2egDlBJ+EcK/iVg7zDg7tMpa4Rv7ZreimRx6Vdoqjm0Q3AnzRldRoiKzORJmWtr8MT
         66DWVcTus3vdltAfmkH14lbX2x0mbPzZy2cECeHWZrMv7uxLggPXJfYQ6G7eIxmLzdhE
         KgdQ==
X-Gm-Message-State: APzg51AeOZDFuOLHmCNGDkcn1brXGQoHF/8WX4q8IQ0PXxU8sojHFc85
        6oxVccGhlpGGt9WJ68w5z0s=
X-Google-Smtp-Source: ANB0VdaiLwXm1QdwXAubKj5cevkq49ykL9N8owIaOrB8vTNUA44gB0RsJYXODW9gf/hIxYdg4zr7ig==
X-Received: by 2002:a63:e647:: with SMTP id p7-v6mr4699093pgj.218.1536267834951;
        Thu, 06 Sep 2018 14:03:54 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id v6-v6sm9826878pfa.28.2018.09.06.14.03.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 14:03:54 -0700 (PDT)
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
 <00433395-ec1e-8a2c-cb88-5db659967643@gmail.com>
 <CAL_Jsq+yfaTzvMefUwzjapvyEYqwFndR5r7KAMPvApDKm=jGFw@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <b1b9e5bc-42b7-8359-bae2-78c5cca4e6ab@gmail.com>
Date:   Thu, 6 Sep 2018 14:03:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+yfaTzvMefUwzjapvyEYqwFndR5r7KAMPvApDKm=jGFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 09/05/18 14:31, Rob Herring wrote:
> On Wed, Sep 5, 2018 at 4:10 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 09/05/18 13:06, Rob Herring wrote:
>>> On Wed, Sep 5, 2018 at 1:19 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>>>
>>>> On 09/05/18 04:51, Rob Herring wrote:
>>>>> On Tue, Sep 4, 2018 at 8:49 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>>>>>
>>>>>> On 08/30/18 12:05, Rob Herring wrote:
>>>>>>> Scan the root node properties (#{size,address}-cells) earlier,
>>>>>>
>>>>>>                                                         ^^^^^^^
>>>>>>                              before mdesc->dt_fixup() is called
>>>>>>
>>>>>>> so that
>>>>>>> the dt_root_addr_cells and dt_root_size_cells variables are initialized
>>>>>>> and can be used.
>>>>>>                  by mdesc->dt_fixup()
>>>>>
>>>>> That's an ARM specific detail. Granted, ARM is the only caller.
>>>>
>>>> The dt_root_addr_cells and dt_root_size_cells variables are being
>>>> initialized earlier in this patch series so that of_fdt_limit_memory()
>>>> can use them.  The only caller of of_fdt_limit_memory() is
>>>> exynos_dt_fixup(), which is an mdesc->dt_fixup() function.
>>>>
>>>>
>>>>>
>>>>>>>
>>>>>>> Cc: Frank Rowand <frowand.list@gmail.com>
>>>>>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>>>>>> ---
>>>>>>>  drivers/of/fdt.c | 7 ++++---
>>>>>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>> Moving early_init_dt_scan_root() to inside early_init_dt_verify()
>>>>>> puts something that has nothing to do with verifying the fdt
>>>>>> into a function whose purpose is the verify.  It hides the side
>>>>>> effect of initializing the dt_root_addr_cells and dt_root_size_cells
>>>>>> variables.
>>>>>
>>>>> It already has the side effect of setting initial_boot_params which
>>>>> every subsequent function needs.
>>>>
>>>> And that side effect should probably also be moved.
>>>
>>> So 2 functions? One to set the blob and one to verify it. Then we can
>>
>> No, I would not add yet another function.  All of these side effects are
>> an argument in favor of a single setup_machine_fdt(), as I suggested below.
>> Then all of these side effects could be in setup_machine_fdt() instead
>> of hiding them in sub-functions that are called by all of the different
>> architectures.
>>
>>
>>> just let arches decide if they want to do any verification or not.
>>>
>>> Perhaps it should be called fdt_init(blob) and then it is vague enough
>>> I can do whatever I want.
>>>
>>>>>> I suggest creating a new function early_init_dt_scan_init_pre_dt_fixup(),
>>>>>> move the chunk of code there instead of to early_init_dt_scan_nodes(),
>>>>>> and call the new function from setup_machine_fdt(), just before
>>>>>> calling  mdesc->dt_fixup().  This would be a little bit more code,
>>>>>> but more clearly showing the intent.
>>>>>
>>>>> I'm trying to reduce the number of functions arches call
>>>>
>>>> I like that goal.
>>>>
>>>>
>>>>> and renaming
>>>>> would need a bunch of arch changes. This change will also let me make
>>>>> early_init_dt_scan_root private as powerpc is the only user. I need to
>>>>> dust off a patch for that.
>>>>>
>>>>> I'd be more inclined to push exynos to remove this altogether. After
>>>>
>>>> Not a bad idea.
>>>>
>>>>> all, if they claim their bindings are unstable, they can't really
>>>>> claim their bootloader is stable/fixed.
>>>>
>>>> It seems that this series is showing us that maybe the three architecture
>>>> specific (arc, arm, arm64) versions of setup_machine_fdt() should be
>>>> consolidated so that we have consistent behavior for FDT.
>>>>
>>>> If we had a single setup_machine_fdt() then some of he hidden side
>>>> effects of functions called by setup_machine_fdt() could instead
>>>> be hoisted into setup_machine_fdt().
>>>
>>> Those functions are all quite a bit different. ARM matches the machine
>>> desc while arm64 doesn't have any such thing. How the DTB gets mapped
>>> into virtual space also varies.
>>
>> I argue that they _should be_ made to be more alike than different.  You
>> have only pointed out two differences.  Of those, the mapping could be
>> cleanly handled by an mdesc-> callback.  (I would have to look at the
>> match to see if that could be handled easily, but I would expect so.)
> 
> The machine desc is in no way common and only used on a few arches
> (and not even common across those arches). So there's no way the core
> DT code can just call a mdesc callback without addressing making that
> common first. And callbacks are just another way to call arch specific
> functions which are another thing I'm trying to remove.
> 
>> On the other hand, in a previous reply you considered removing
>> of_fdt_limit_memory(), which is only used for an exynos fixup.  If
>> you do that, then patch 1 disappears, and we can continue to
>> sweep under the rug the side effects that you reminded me of
>> with patch 1.
> 
> I'm inclined to just drop the patch. Seemed like a simple clean-up and
> I'm not interested in doing more right now (did you look at the stack
> of stuff in dt/testing branch). Maybe someone else will care (spoiler:
> they won't).

I would agree with just dropping patch 1 and 2.  Patch 3 is still fine.

> 
> Rob
> 

