Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60848C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA5D20839
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huhIrhrw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA5D20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbeIEWuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 18:50:21 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44667 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbeIEWuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 18:50:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id k21-v6so3872220pff.11;
        Wed, 05 Sep 2018 11:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UDamL8VRf4EKSWN6s8tYmN/72+iNqHxtE93eS1Bvfx0=;
        b=huhIrhrwYCO6Kw+45xaSzghCrG5b0GFaN+ByaQ5I3PzCYQmtp+XSg7eVqKnHQSmq23
         vJC+F+voCKoNqOIYhIGzu3Vew6E6ci0u7Vgp9OWHYTVG7sU1Yoyi21oBBOy8mStAAvqv
         dTgtX/NkEWM1JBle/GklBLoRhwXgabQqD00zddXavOO/IaDynHh0R2yYvGFU+oQvZDd4
         0rCebnDaqM/A57ltmDrtwpVOB0XGXwOpN4qNb+uNjbrC5kcQy6yz9554+7vdctnvBveh
         /o1CyoYgM0uzLGk1IyRG5HX2fgwbibrp9ZH3vw5wblyA6/N4CattPLhCXBs3DWCfK/bG
         ChQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UDamL8VRf4EKSWN6s8tYmN/72+iNqHxtE93eS1Bvfx0=;
        b=iHdkMdIRuq+1SI1KXkJ8ewR6+h6m0ZPAI3EWvM3aHLdaAO65rGhc8XhoTYJJD2K2qU
         EbLNSuTVQ54VeOsvbj0ONr1ZtfJ+HJfkXpUOP0HkjM2d03f3Sq7vNepAzPkFtBCExewT
         g5O7czMiA12R2c3Lb23eM7i0ei5reeWuV3i9gAX+o8CAu7Wj8DqESa6fWsfPFAMN4EM1
         XbNtfD7OOr7cz15fwW8eahkukswFsJnVivmk1Bt/MJsXdm25vqq/JoTWZoIDxShp+6US
         MerBuvcYRdd/HHNoNROOo6JAZMZuERmOZqTBHG6+2vwBjna1BHMMBF8g1698lORiiYT4
         5Mlw==
X-Gm-Message-State: APzg51A6Ohvyu9tiBjo/08CM/g6t2j+v4Hnk6hhjzHMn+Ibmfgvw6IGB
        22EmhAI8R1vK4/RqdtJ4/L8=
X-Google-Smtp-Source: ANB0VdYRE52pAi3KLpS+lePc+YtCShw2nQb0VKwQOXOjcEThATmAne2Em862scPRc0PDuBZAJAIdmA==
X-Received: by 2002:a63:ad44:: with SMTP id y4-v6mr37320595pgo.138.1536171540120;
        Wed, 05 Sep 2018 11:19:00 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id c1-v6sm2979552pgp.34.2018.09.05.11.18.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 11:18:59 -0700 (PDT)
Subject: Re: [PATCH 1/3] of/fdt: Scan the root node properties earlier
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180830190523.31474-1-robh@kernel.org>
 <20180830190523.31474-2-robh@kernel.org>
 <b86ed9cf-d5fd-09fb-eb82-0143c759f5cf@gmail.com>
 <CAL_JsqJy0kDYCC35GR5TGLYyYU-UjOys_r2sFMQZuFto5HkExg@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <5da7b4ab-acd3-977a-6ac2-275911d7c436@gmail.com>
Date:   Wed, 5 Sep 2018 11:18:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJy0kDYCC35GR5TGLYyYU-UjOys_r2sFMQZuFto5HkExg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/18 04:51, Rob Herring wrote:
> On Tue, Sep 4, 2018 at 8:49 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 08/30/18 12:05, Rob Herring wrote:
>>> Scan the root node properties (#{size,address}-cells) earlier,
>>
>>                                                         ^^^^^^^
>>                              before mdesc->dt_fixup() is called
>>
>>> so that
>>> the dt_root_addr_cells and dt_root_size_cells variables are initialized
>>> and can be used.
>>                  by mdesc->dt_fixup()
> 
> That's an ARM specific detail. Granted, ARM is the only caller.

The dt_root_addr_cells and dt_root_size_cells variables are being
initialized earlier in this patch series so that of_fdt_limit_memory()
can use them.  The only caller of of_fdt_limit_memory() is
exynos_dt_fixup(), which is an mdesc->dt_fixup() function.


> 
>>>
>>> Cc: Frank Rowand <frowand.list@gmail.com>
>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>> ---
>>>  drivers/of/fdt.c | 7 ++++---
>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>> Moving early_init_dt_scan_root() to inside early_init_dt_verify()
>> puts something that has nothing to do with verifying the fdt
>> into a function whose purpose is the verify.  It hides the side
>> effect of initializing the dt_root_addr_cells and dt_root_size_cells
>> variables.
> 
> It already has the side effect of setting initial_boot_params which
> every subsequent function needs.

And that side effect should probably also be moved.


>> I suggest creating a new function early_init_dt_scan_init_pre_dt_fixup(),
>> move the chunk of code there instead of to early_init_dt_scan_nodes(),
>> and call the new function from setup_machine_fdt(), just before
>> calling  mdesc->dt_fixup().  This would be a little bit more code,
>> but more clearly showing the intent.
> 
> I'm trying to reduce the number of functions arches call

I like that goal.


> and renaming
> would need a bunch of arch changes. This change will also let me make
> early_init_dt_scan_root private as powerpc is the only user. I need to
> dust off a patch for that.
> 
> I'd be more inclined to push exynos to remove this altogether. After

Not a bad idea.

> all, if they claim their bindings are unstable, they can't really
> claim their bootloader is stable/fixed.

It seems that this series is showing us that maybe the three architecture
specific (arc, arm, arm64) versions of setup_machine_fdt() should be
consolidated so that we have consistent behavior for FDT.

If we had a single setup_machine_fdt() then some of he hidden side
effects of functions called by setup_machine_fdt() could instead
be hoisted into setup_machine_fdt().

> 
> Rob
> 

