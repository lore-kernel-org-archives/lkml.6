Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E076C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 334C5218A7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="LNqYVCM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 334C5218A7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbeHQUJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 16:09:03 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:52264 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbeHQUJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 16:09:03 -0400
Received: by mail-it0-f65.google.com with SMTP id d9-v6so12204675itf.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 10:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A8Si7Cedm6xy6n3dBSAK/QJluLitmXkmJpJYK2+4rK4=;
        b=LNqYVCM+kCsenABAkfYGXPC7WNR/UMsGH5YOebzVjNpFriIkkylhd8Eb3T57zj6WMp
         fNmyCe7jzM9TvWspfaYDUHlp3k1fkVUVs4NqR6jBevkt64MhnPR+T9VVEwseH+jmkGEu
         7h78mlnbbS5+7Pkt2Nzy2/hLx6gSMF5tXeuGeNK9/OYzE51yc6diVG48Nju7lCGhu2J2
         jQ7kz59CkZ+uMfFA2j5gOueqcfeA0zCAIEOvycfOHSxHPeP4YauFdyxBbkHVOOYreNBQ
         LaVXK09zO2/WG5H8Sf+3H5PaCpGS0RQKMBWICyrBuUrCrWXsJAgPsFgZAaQ80elRG7oO
         yyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A8Si7Cedm6xy6n3dBSAK/QJluLitmXkmJpJYK2+4rK4=;
        b=eLATNO00WzvoLvvyosegR6biiu4GEYPfV76auCo3eoEcMVZ3nGWpjB8S6elwCzbP53
         kY7oNYgSbxMQW46OYf6m2Hx2AWCSS5MTkHrURranlhG7GdXTnjMT79KGhfG69ubU3gIj
         pvjLNw1AUTjFrGwAia3UdgCzrWsg2Cs5x9dA3I9SUSddQHE45VNnZE1AzZHipk3ncjNe
         45h1jzXK6Trl7BpS52SuDafhNds1ceCqsAFBkmFO9yny1lIG99fgTKMMGoOGLCKz/qoz
         CnEcqtVd3FDPF1LGrGj58hIsXbJOleRjoAqlK6fmZmHOD9d9DS6nggihCp7nauCv13WB
         VYAQ==
X-Gm-Message-State: AOUpUlGrGuIyAfqSbO0winZ5jU78HHTkiUQPhYhewGtS85S4uNBZExdC
        1yekQNZepsPuApYEiteaoYoaIg==
X-Google-Smtp-Source: AA+uWPzJobt7TaQy+5xEWvpDgmkVe+0dOKgxzlsTQ+xCPpGwzABJJg6GIzD4TUZIgqt1rUkQoKu6bQ==
X-Received: by 2002:a24:4c0b:: with SMTP id a11-v6mr25285138itb.123.1534525493858;
        Fri, 17 Aug 2018 10:04:53 -0700 (PDT)
Received: from [192.168.43.158] ([172.58.139.10])
        by smtp.googlemail.com with ESMTPSA id c18-v6sm985490ioi.3.2018.08.17.10.04.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 10:04:53 -0700 (PDT)
Subject: dmaengine for sh7760 (was Re: use the generic dma-noncoherent code
 for sh V2)
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>, dalias@libc.org,
        Rich Felker <dalias@libc.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
References: <20180724120147.15096-1-hch@lst.de> <20180724202115.GA4685@lst.de>
 <18df6608-61c1-963d-bb1a-d46320232f40@landley.net>
 <CAK8P3a3bwFupzM14eigXfoQsLtj3cq_xv_p3=O924cgSceLE0g@mail.gmail.com>
From:   Rob Landley <rob@landley.net>
Message-ID: <418f3fa1-036f-d775-f1bc-e96778b4a4d8@landley.net>
Date:   Fri, 17 Aug 2018 12:04:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3bwFupzM14eigXfoQsLtj3cq_xv_p3=O924cgSceLE0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/31/2018 07:56 AM, Arnd Bergmann wrote:
> On Fri, Jul 27, 2018 at 6:20 PM, Rob Landley <rob@landley.net> wrote:
>> On 07/24/2018 03:21 PM, Christoph Hellwig wrote:
>>> On Tue, Jul 24, 2018 at 02:01:42PM +0200, Christoph Hellwig wrote:
>>>> Hi all,
>>>>
>>>> can you review these patches to switch sh to use the generic
>>>> dma-noncoherent code?  All the requirements are in mainline already
>>>> and we've switched various architectures over to it already.
>>>
>>> Ok, there is one more issue with this version.   Wait for a new one
>>> tomorrow.
>>
>> Speaking of DMA:
>>
>> I'm trying to wire up DMAEngine to an sh7760 board that uses platform data (and
>> fix the smc91x.c driver to use DMAEngine without #ifdef arm), so I've been
>> reading through all that stuff, but the docs seem kinda... thin?
>>
>> Is there something I should have read other than
>> Documentation/driver-model/platform.txt,
>> Documentation/dmaegine/{provider,client}.txt, then trying to picking through the
>> source code and the sh7760 hardware pdf? (And watching the youtube video of
>> Laurent Pinchart's 2014 ELC talk on DMA, Maxime Ripard's 2015 ELC overview of
>> DMAEngine, the Xilinx video on DMAEngine...)
>>
>> At first I thought the SH_DMAE could initialize itself, but the probe function
>> needs platform data, and although arch/sh/kernel/cpu/sh4a/setup-sh7722.c looks
>> _kind_ of like a model I can crib from:
> 
>> B) That platform data is supplying sh_dmae_slave_config preallocating slave
>> channels to devices? (Does it have to? The docs gave me the impression the
>> driver would dynamically request them and devices could even share. Wasn't that
>> sort of the point of DMAEngine? Can my new board data _not_ do that? What's the
>> minimum amount of micromanaging I have to do?)
> 
> The thing here is that arch/sh is way behind on the API use, and it
> has prevented us from cleaning up drivers as well. A slave driver
> should have to just call dma_request_chan() with a constant
> string to identify its channel rather than going two different ways
> depending on whether it's used with DT or platform data.

I got the DMA controller hooked up to DMAEngine and the dmatest module is happy
with the result on all 8 channels. (Finding
arch/sh/kernel/cpu/sh4a/setup-sh7722.c helped a lot, finding it earlier would
have helped more. :)

The config symbols are:

CONFIG_SH_DMA=y
CONFIG_DMADEVICES=y
CONFIG_SH_DMAE_BASE=y
CONFIG_SH_DMAE=y
CONFIG_DMATEST=y #optional

The platform data is:

#include <cpu/dma-register.h>
#include <cpu/dma.h>
#include <linux/sh_dma.h>

/* DMA */
static struct resource sh7760_dma_resources[] = {
	{
		.start  = SH_DMAC_BASE0,
		.end    = SH_DMAC_BASE0 + 9*16 - 1,
		.flags  = IORESOURCE_MEM,
	}, {
		.start  = DMTE0_IRQ,
		.end    = DMTE0_IRQ,
		.flags  = IORESOURCE_IRQ,
	}
};

static struct sh_dmae_channel dma_chan[] = {
	{
		.offset = 0,
		.dmars = 0,
		.dmars_bit = 0,
	}, {
		.offset = 0x10,
		.dmars = 0,
		.dmars_bit = 8,
	}, {
		.offset = 0x20,
		.dmars = 4,
		.dmars_bit = 0,
	}, {
		.offset = 0x30,
		.dmars = 4,
		.dmars_bit = 8,
	}, {
		.offset = 0x50,
		.dmars = 8,
		.dmars_bit = 0,
	}, {
		.offset = 0x60,
		.dmars = 8,
		.dmars_bit = 8,
	}, {
		.offset = 0x70,
		.dmars = 12,
		.dmars_bit = 0,
	}, {
		.offset = 0x80,
		.dmars = 12,
		.dmars_bit = 8,
	}
};

static const unsigned int ts_shift[] = TS_SHIFT;

static struct sh_dmae_pdata sh7760_dma_pdata = {
	.channel = dma_chan,
	.channel_num = ARRAY_SIZE(dma_chan),
        .ts_low_shift   = CHCR_TS_LOW_SHIFT,
        .ts_low_mask    = CHCR_TS_LOW_MASK,
        .ts_high_shift  = CHCR_TS_HIGH_SHIFT,
        .ts_high_mask   = CHCR_TS_HIGH_MASK,
        .ts_shift       = ts_shift,
        .ts_shift_num   = ARRAY_SIZE(ts_shift),
        .dmaor_init     = DMAOR_INIT,
	.dmaor_is_32bit = 1,
};

struct platform_device sh7760_dma_device = {
        .name           = "sh-dma-engine",
        .id             = -1,
        .num_resources  = ARRAY_SIZE(sh7760_dma_resources),
        .resource       = sh7760_dma_resources,
	.dev = {.platform_data = &sh7760_dma_pdata},
};


And then add sh7760_dma_device to your struct platform_device array.

> If you hack on it, please convert the dmaengine platform data to use
> a dma_slave_map array to pass the data into the dmaengine driver,

The dmatest module didn't need it? I don't see why the ethernet driver would?
(Isn't the point of an allocator to allocate from a request?)

> mapping the settings from a (pdev-name, channel-id) tuple to a pointer
> that describes the channel configuration rather than having the
> mapping from an numerical slave_id to a struct sh_dmae_slave_config
> in the setup files. It should be a fairly mechanical conversion.

I think all 8 channels are generic. Drivers should be able to grab them and
release them at will, why does it need a table?

(I say this not having made the smc91x.c driver use this yet, its "conversion"
to device tree left it full of PXA #ifdefs and constants, and I've tried the
last half-dozen kernel releases and qemu releases and have yet to find an arm
mainstone board under qemu that _doesn't_ time out trying to use DMA with this
card. But that's another post...)

> The other part I noticed is arch/sh/drivers/dma/*, which appears to
> be entirely unused, and should probably removed.

I had to switch that off to get this to work, yes. I believe it predates
dmaengine and was obsoleted by it.

>          Arnd
> 

Rob
