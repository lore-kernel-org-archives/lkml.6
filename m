Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFCBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B742192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389084AbfBOPyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:54:03 -0500
Received: from gateway31.websitewelcome.com ([192.185.143.234]:22184 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726146AbfBOPyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:54:00 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id A607625DDC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 09:53:57 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ufoLgltpY2PzOufoLgFruc; Fri, 15 Feb 2019 09:53:57 -0600
X-Authority-Reason: nr=8
Received: from [189.250.119.20] (port=38128 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gufoL-002EpR-3z; Fri, 15 Feb 2019 09:53:57 -0600
Subject: Re: [PATCH] drm/nouveau/nvkm: mark expected switch fall-throughs
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
References: <20181017142851.GA15329@embeddedor.com>
 <7b562104-f151-0d9f-7cd6-3c72ff8895fa@embeddedor.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 VtSixD1uOgytAP7RWS474w==
Message-ID: <344749c4-9516-e422-64a1-3386843bff2c@embeddedor.com>
Date:   Fri, 15 Feb 2019 09:53:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <7b562104-f151-0d9f-7cd6-3c72ff8895fa@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.119.20
X-Source-L: No
X-Exim-ID: 1gufoL-002EpR-3z
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.119.20]:38128
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 23
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Friendly ping (second one):

Who can take this, please?

Thanks
--
Gustavo

On 1/10/19 1:33 PM, Gustavo A. R. Silva wrote:
> Hi,
> 
> Friendly ping:
> 
> Who can take this?
> 
> Thanks
> -- 
> Gustavo
> 
> On 10/17/18 9:28 AM, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>> where we are expecting to fall through.
>>
>> This patch aims to suppress 29 missing-break-in-switch false positives.
>>
>> Addresses-Coverity-ID: 1456891 ("Missing break in switch")
>> Addresses-Coverity-ID: 1324063 ("Missing break in switch")
>> Addresses-Coverity-ID: 1324063 ("Missing break in switch")
>> Addresses-Coverity-ID: 141432 ("Missing break in switch")
>> Addresses-Coverity-ID: 141433 ("Missing break in switch")
>> Addresses-Coverity-ID: 141434 ("Missing break in switch")
>> Addresses-Coverity-ID: 141435 ("Missing break in switch")
>> Addresses-Coverity-ID: 141436 ("Missing break in switch")
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   drivers/gpu/drm/nouveau/nvkm/engine/disp/hdmi.c    | 17 +++++++++++++++++
>>   drivers/gpu/drm/nouveau/nvkm/engine/dma/usernv04.c |  1 +
>>   drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv04.c    |  2 ++
>>   drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv40.c    |  1 +
>>   drivers/gpu/drm/nouveau/nvkm/subdev/bios/perf.c    |  1 +
>>   drivers/gpu/drm/nouveau/nvkm/subdev/bios/pll.c     |  1 +
>>   drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c     |  1 +
>>   drivers/gpu/drm/nouveau/nvkm/subdev/clk/mcp77.c    |  1 +
>>   drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv40.c   |  2 ++
>>   drivers/gpu/drm/nouveau/nvkm/subdev/mxm/nv50.c     |  1 +
>>   10 files changed, 28 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/hdmi.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/hdmi.c
>> index d131cca..10f2aa9 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/hdmi.c
>> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/hdmi.c
>> @@ -23,38 +23,55 @@ void pack_hdmi_infoframe(struct packed_hdmi_infoframe *packed_frame,
>>            */
>>       case 17:
>>           subpack1_high = (raw_frame[16] << 16);
>> +        /* fall through */
>>       case 16:
>>           subpack1_high |= (raw_frame[15] << 8);
>> +        /* fall through */
>>       case 15:
>>           subpack1_high |= raw_frame[14];
>> +        /* fall through */
>>       case 14:
>>           subpack1_low = (raw_frame[13] << 24);
>> +        /* fall through */
>>       case 13:
>>           subpack1_low |= (raw_frame[12] << 16);
>> +        /* fall through */
>>       case 12:
>>           subpack1_low |= (raw_frame[11] << 8);
>> +        /* fall through */
>>       case 11:
>>           subpack1_low |= raw_frame[10];
>> +        /* fall through */
>>       case 10:
>>           subpack0_high = (raw_frame[9] << 16);
>> +        /* fall through */
>>       case 9:
>>           subpack0_high |= (raw_frame[8] << 8);
>> +        /* fall through */
>>       case 8:
>>           subpack0_high |= raw_frame[7];
>> +        /* fall through */
>>       case 7:
>>           subpack0_low = (raw_frame[6] << 24);
>> +        /* fall through */
>>       case 6:
>>           subpack0_low |= (raw_frame[5] << 16);
>> +        /* fall through */
>>       case 5:
>>           subpack0_low |= (raw_frame[4] << 8);
>> +        /* fall through */
>>       case 4:
>>           subpack0_low |= raw_frame[3];
>> +        /* fall through */
>>       case 3:
>>           header = (raw_frame[2] << 16);
>> +        /* fall through */
>>       case 2:
>>           header |= (raw_frame[1] << 8);
>> +        /* fall through */
>>       case 1:
>>           header |= raw_frame[0];
>> +        /* fall through */
>>       case 0:
>>           break;
>>       }
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/dma/usernv04.c b/drivers/gpu/drm/nouveau/nvkm/engine/dma/usernv04.c
>> index 49ef7e5..7f1adab 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/engine/dma/usernv04.c
>> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/dma/usernv04.c
>> @@ -122,6 +122,7 @@ nv04_dmaobj_new(struct nvkm_dma *dma, const struct nvkm_oclass *oclass,
>>           break;
>>       case NV_MEM_ACCESS_WO:
>>           dmaobj->flags0 |= 0x00008000;
>> +        /* fall through */
>>       case NV_MEM_ACCESS_RW:
>>           dmaobj->flags2 |= 0x00000002;
>>           break;
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv04.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv04.c
>> index ad707ff..93493b3 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv04.c
>> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv04.c
>> @@ -117,8 +117,10 @@ nv04_fifo_swmthd(struct nvkm_device *device, u32 chid, u32 addr, u32 data)
>>       switch (mthd) {
>>       case 0x0000 ... 0x0000: /* subchannel's engine -> software */
>>           nvkm_wr32(device, 0x003280, (engine &= ~mask));
>> +        /* fall through */
>>       case 0x0180 ... 0x01fc: /* handle -> instance */
>>           data = nvkm_rd32(device, 0x003258) & 0x0000ffff;
>> +        /* fall through */
>>       case 0x0100 ... 0x017c:
>>       case 0x0200 ... 0x1ffc: /* pass method down to sw */
>>           if (!(engine & mask) && sw)
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv40.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv40.c
>> index 8c7ba32..47c1682 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv40.c
>> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv40.c
>> @@ -81,6 +81,7 @@ nv40_fifo_init(struct nvkm_fifo *base)
>>       case 0x49:
>>       case 0x4b:
>>           nvkm_wr32(device, 0x002230, 0x00000001);
>> +        /* fall through */
>>       case 0x40:
>>       case 0x41:
>>       case 0x42:
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/perf.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/perf.c
>> index c306835..7112992 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/perf.c
>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/perf.c
>> @@ -135,6 +135,7 @@ nvbios_perfEp(struct nvkm_bios *bios, int idx,
>>           break;
>>       case 0x30:
>>           info->script   = nvbios_rd16(bios, perf + 0x02);
>> +        /* fall through */
>>       case 0x35:
>>           info->fanspeed = nvbios_rd08(bios, perf + 0x06);
>>           info->voltage  = nvbios_rd08(bios, perf + 0x07);
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/pll.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/pll.c
>> index e6e804c..bda6cc9 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/pll.c
>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/pll.c
>> @@ -134,6 +134,7 @@ pll_map(struct nvkm_bios *bios)
>>               device->chipset == 0xaa ||
>>               device->chipset == 0xac)
>>               return g84_pll_mapping;
>> +        /* fall through */
>>       default:
>>           return NULL;
>>       }
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
>> index ba6a868d..40e5645 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
>> @@ -90,6 +90,7 @@ nvkm_cstate_valid(struct nvkm_clk *clk, struct nvkm_cstate *cstate,
>>               case NVKM_CLK_BOOST_NONE:
>>                   if (clk->base_khz && freq > clk->base_khz)
>>                       return false;
>> +                /* fall through */
>>               case NVKM_CLK_BOOST_BIOS:
>>                   if (clk->boost_khz && freq > clk->boost_khz)
>>                       return false;
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/mcp77.c b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/mcp77.c
>> index 1c21b8b..4f00023 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/mcp77.c
>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/mcp77.c
>> @@ -363,6 +363,7 @@ mcp77_clk_prog(struct nvkm_clk *base)
>>       switch (clk->vsrc) {
>>       case nv_clk_src_cclk:
>>           mast |= 0x00400000;
>> +        /* fall through */
>>       default:
>>           nvkm_wr32(device, 0x4600, clk->vdiv);
>>       }
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv40.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv40.c
>> index 2b12e38..5f4c287 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv40.c
>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv40.c
>> @@ -131,11 +131,13 @@ nv40_ram_prog(struct nvkm_ram *base)
>>           nvkm_mask(device, 0x00402c, 0xc0771100, ram->ctrl);
>>           nvkm_wr32(device, 0x004048, ram->coef);
>>           nvkm_wr32(device, 0x004030, ram->coef);
>> +        /* fall through */
>>       case 0x43:
>>       case 0x49:
>>       case 0x4b:
>>           nvkm_mask(device, 0x004038, 0xc0771100, ram->ctrl);
>>           nvkm_wr32(device, 0x00403c, ram->coef);
>> +        /* fall through */
>>       default:
>>           nvkm_mask(device, 0x004020, 0xc0771100, ram->ctrl);
>>           nvkm_wr32(device, 0x004024, ram->coef);
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mxm/nv50.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mxm/nv50.c
>> index 844971e..2a6150a 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/mxm/nv50.c
>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mxm/nv50.c
>> @@ -159,6 +159,7 @@ mxm_dcb_sanitise_entry(struct nvkm_bios *bios, void *data, int idx, u16 pdcb)
>>           break;
>>       case 0x0e: /* eDP, falls through to DPint */
>>           ctx.outp[1] |= 0x00010000;
>> +        /* fall through */
>>       case 0x07: /* DP internal, wtf is this?? HP8670w */
>>           ctx.outp[1] |= 0x00000004; /* use_power_scripts? */
>>           type = DCB_CONNECTOR_eDP;
>>
