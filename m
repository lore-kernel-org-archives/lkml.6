Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9543AC4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 11:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E15204EC
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 11:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E15204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbeIHQJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 12:09:50 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:53022 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726315AbeIHQJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 12:09:49 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud8.xs4all.net with ESMTPA
        id ybLZfmGeQxO9BybLdfE1hs; Sat, 08 Sep 2018 13:24:20 +0200
Subject: Re: [PATCH 0/2] Follow-up patches for Cedrus v9
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Paul Kocialkowski <contact@paulk.fr>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devel@driverdev.osuosl.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
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
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <3c4e5a98-4dbd-9a8c-8dab-612a923f0eb9@xs4all.nl>
Date:   Sat, 8 Sep 2018 13:24:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAGb2v67F2a-kYFRb_f+CyhzkHf5+Y+h01=SE-rxJ=-Oj-ma1BA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHYz3nCte9cMtscFrsrcsJDEdV6FVFFdGA4BRFpMFU+ge920snOOzmO3ZulyO0t+9lISgYOWuVaDo8MHaQ/LuPWrFT1ZXeXWKwXOEvLL5N5NMAdCRp4z
 tZSXlS22d6+ebWgo0rcmprQklXvO+fHRompUGy+bOT75+io5pIdnhynL/mjdgIlNw9g/jCzI7CDWoQpse9Ev1t19zUyMkWuyIEQ9zsStRQQFJDODivl01w6z
 wDOpH4swWQ4KFKwY6TZfH7ss9pzsUAPhE9ev8jEJOKQg7kpakW0349mfFeKLTDufm7ySesg97/nAiI3OCkZ4G1oE3HWdHJ65BpZnuJiVds/ZwpN0adV5Mj/E
 PLiTsWWL0Gw6deeZPPnSvF4KuSM/XQB9PjlGreoXV2Ee3xGqo6CSGnkbDRSFLyD6m1U26boIm497G9WSL1QwJX6Uvx4/D1dMOIohnesp+0WeT8aIC+dQoEBQ
 wyYMT9xIFnxOBfyn9HGtCuRWD7NUDtnZXiTkHmLci4gdVmMG+vNwyRA7QcyOY2BxQYyqa6/Ua5A7jKi7qGt2a0OxFmRVxe7Hz4D3I+wRZetYCUo5IS3+qoXZ
 tkA26ko4u80ERsbntM4ntFLs3lP/8uEjGzQDbCV6IP33gc4DxvBNclTT6BLXYhROnhutTkVhK9KUNFIlVCjZpXRwcSaj969IDjscH1NtBNpLJgdynW1TSKGL
 sfuHx+4SbmYkNlyE4wbDnqOVx3PautfvmlsSua5kShIfz4OjoN/f3QKsxUtAOw3D+b5KKgFjfLKG0RrHi0UQc5BGBl4WNehuJIY0UIdXS+3uo3gqcCKSHQ+t
 O/FQ+6Cc0UBzODyopxk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2018 12:22 PM, Chen-Yu Tsai wrote:
> On Sat, Sep 8, 2018 at 6:06 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>>
>> On 09/07/2018 06:33 PM, Paul Kocialkowski wrote:
>>> This brings the requested modifications on top of version 9 of the
>>> Cedrus VPU driver, that implements stateless video decoding using the
>>> Request API.
>>>
>>> Paul Kocialkowski (2):
>>>   media: cedrus: Fix error reporting in request validation
>>>   media: cedrus: Add TODO file with tasks to complete before unstaging
>>>
>>>  drivers/staging/media/sunxi/cedrus/TODO     |  7 +++++++
>>>  drivers/staging/media/sunxi/cedrus/cedrus.c | 15 ++++++++++++---
>>>  2 files changed, 19 insertions(+), 3 deletions(-)
>>>  create mode 100644 drivers/staging/media/sunxi/cedrus/TODO
>>>
>>
>> So close...
>>
>> When compiling under e.g. intel I get errors since it doesn't know about
>> the sunxi_sram_claim/release function and the PHYS_PFN_OFFSET define.
>>
>> Is it possible to add stub functions to linux/soc/sunxi/sunxi_sram.h
>> if CONFIG_SUNXI_SRAM is not defined? That would be the best fix for that.
>>
>> The use of PHYS_PFN_OFFSET is weird: are you sure this is the right
>> way? I see that drivers/of/device.c also sets dev->dma_pfn_offset, which
>> makes me wonder if this information shouldn't come from the device tree.
>>
>> You are the only driver that uses this define directly, which makes me
>> suspicious.
> 
> On Allwinner platforms, some devices do DMA directly on the memory BUS
> with the DRAM controller. In such cases, the DRAM has no offset. In all
> other cases where the DMA goes through the common system bus and the DRAM
> offset is either 0x40000000 or 0x20000000, depending on the SoC. Since the
> former case is not described in the device tree (this is being worked on
> by Maxime BTW), the dma_pfn_offset is not the value it should be. AFAIK
> only the display and media subsystems (VPU, camera, TS) are wired this
> way.
> 
> In drivers/gpu/drm/sun4i/sun4i_backend.c (the display driver) we use
> PHYS_OFFSET, which is pretty much the same thing.
>

OK, in that case just put #ifdef PHYS_PFN_OFFSET around that line together
with a comment that this will eventually come from the device tree.

Regards,

	Hans
