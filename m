Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D358C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 09:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC9120865
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 09:04:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC9120865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbeIINxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 09:53:55 -0400
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:47829 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726590AbeIINxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 09:53:55 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud9.xs4all.net with ESMTPA
        id yveEf5zx5MsEFyveHf7t4p; Sun, 09 Sep 2018 11:04:54 +0200
Subject: Re: [PATCH 0/2] Follow-up patches for Cedrus v9
To:     Paul Kocialkowski <contact@paulk.fr>, Chen-Yu Tsai <wens@csie.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devel@driverdev.osuosl.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Randy Li <ayaka@soulik.info>, ezequiel@collabora.com,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20180907163347.32312-1-contact@paulk.fr>
 <11104c03-97ac-8b36-7d75-dfecb8fcce10@xs4all.nl>
 <CAGb2v67F2a-kYFRb_f+CyhzkHf5+Y+h01=SE-rxJ=-Oj-ma1BA@mail.gmail.com>
 <3c4e5a98-4dbd-9a8c-8dab-612a923f0eb9@xs4all.nl>
 <e17313d436b8b8b778218f0ab309274e2ae2f1c4.camel@paulk.fr>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <7386a631-1753-22cb-955e-fd0f1ca7a2d1@xs4all.nl>
Date:   Sun, 9 Sep 2018 11:04:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <e17313d436b8b8b778218f0ab309274e2ae2f1c4.camel@paulk.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfN9WAFNe4FYraX8N3BfKIAfqjShjiBFK/Aghrhe6IuUHroApWIa0CTigop75rr2pVgO4ypw3PsgmNGaV17BUMTGb7GbsZiO2HMANyuHzYzgfKU7P8CGO
 svuxKmgc0zyqMlWGR4E0ZeTpA5L5hlszPIKekvSqt1SuqmE4VBF9RCoGHn9bOKmKfw9ei1EebxM2EZ/bShsNF24DxhcV5knYFM8aQfQnNcidg19BXRzQsKqz
 GZHtLBHKn57O6uNcfE3f4zymKscHRH6h2QolbA7GR/3pxdt87DKDkmdYoYmSTsW6PURJAcJ7tqr4lA1svq+KZpMkQhQofnsuXN+bwi28KSfGx+X1GaxwaL4t
 nZf3wEEYp1eOBpmw2OUKACjFtip5myoCg+QLOwRZeFMY75Ft0kqorGyACnXYCxUWAUXmAOJW+HYO8omlESPuiT3IG5QdnildFIn2DCIDbe0ZL/cEr/odeNMz
 48ThGSuLIKw6caF1yInTfCC139ZGygwyw54Id0c8yKWQgiWu5FVAjtJgeLzO0KsI5/K+uoc1JzBVHPR4lVxfosmWJiGNgzq29roSotDcvo2qFraR6uVE6Q48
 uKLNrSjFJ4+rXywbjBdEC1IXtxBmj459ENMQyHiqQysxMGUDXDz5EGfjKaa19cRFvWkkCOFAeCMjIp5HjoLwdq/6LZqAsBUO45ZjUqmwulxbRGcLiUA2sFpu
 os4sFpz9XtQCZ9nY6CAmoREhZ67APC6YKiSWZAtOfxsGqKEhQC3KxVqGo0vuAwlXR7riQ9MsWR/UK/7VnxVXZbSSc/5iyWpk
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2018 09:42 PM, Paul Kocialkowski wrote:
> Hi,
> 
> Le samedi 08 septembre 2018 à 13:24 +0200, Hans Verkuil a écrit :
>> On 09/08/2018 12:22 PM, Chen-Yu Tsai wrote:
>>> On Sat, Sep 8, 2018 at 6:06 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>>>>
>>>> On 09/07/2018 06:33 PM, Paul Kocialkowski wrote:
>>>>> This brings the requested modifications on top of version 9 of the
>>>>> Cedrus VPU driver, that implements stateless video decoding using the
>>>>> Request API.
>>>>>
>>>>> Paul Kocialkowski (2):
>>>>>   media: cedrus: Fix error reporting in request validation
>>>>>   media: cedrus: Add TODO file with tasks to complete before unstaging
>>>>>
>>>>>  drivers/staging/media/sunxi/cedrus/TODO     |  7 +++++++
>>>>>  drivers/staging/media/sunxi/cedrus/cedrus.c | 15 ++++++++++++---
>>>>>  2 files changed, 19 insertions(+), 3 deletions(-)
>>>>>  create mode 100644 drivers/staging/media/sunxi/cedrus/TODO
>>>>>
>>>>
>>>> So close...
>>>>
>>>> When compiling under e.g. intel I get errors since it doesn't know about
>>>> the sunxi_sram_claim/release function and the PHYS_PFN_OFFSET define.
>>>>
>>>> Is it possible to add stub functions to linux/soc/sunxi/sunxi_sram.h
>>>> if CONFIG_SUNXI_SRAM is not defined? That would be the best fix for that.
>>>>
>>>> The use of PHYS_PFN_OFFSET is weird: are you sure this is the right
>>>> way? I see that drivers/of/device.c also sets dev->dma_pfn_offset, which
>>>> makes me wonder if this information shouldn't come from the device tree.
>>>>
>>>> You are the only driver that uses this define directly, which makes me
>>>> suspicious.
>>>
>>> On Allwinner platforms, some devices do DMA directly on the memory BUS
>>> with the DRAM controller. In such cases, the DRAM has no offset. In all
>>> other cases where the DMA goes through the common system bus and the DRAM
>>> offset is either 0x40000000 or 0x20000000, depending on the SoC. Since the
>>> former case is not described in the device tree (this is being worked on
>>> by Maxime BTW), the dma_pfn_offset is not the value it should be. AFAIK
>>> only the display and media subsystems (VPU, camera, TS) are wired this
>>> way.
>>>
>>> In drivers/gpu/drm/sun4i/sun4i_backend.c (the display driver) we use
>>> PHYS_OFFSET, which is pretty much the same thing.
>>>
>>
>> OK, in that case just put #ifdef PHYS_PFN_OFFSET around that line together
>> with a comment that this will eventually come from the device tree.
> 
> That seems fine, although I'm less certain about what to do for the
> SRAM situation. Other drivers that use SUNXI_SRAM have a Kconfig select
> on it (that Cedrus lacks). Provided that the SRAM driver builds fine
> for non-sunxi configs, bringing-in that select would remove the need
> for dummy functions and also ensure that the actual implementation is
> always used on sunxi. Otherwise, there'd be a risk of having the dummy
> functions used (if the SRAM driver is not explicitly selected in the
> config), causing a hang when accessing the VPU.

You should certainly select this kernel config.

But the real problem seems to to be drivers/soc/Makefile where it says:

obj-$(CONFIG_ARCH_SUNXI)       += sunxi/

I think this should be:

obj-y       += sunxi/

Now all compiles fine on i686 with the cedrus driver selecting SUNXI_SRAM.

Regards,

	Hans
