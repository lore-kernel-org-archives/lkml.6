Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3ABC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1AD020861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s1hssAhi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1AD020861
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409668AbeKWW2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:28:39 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47096 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388614AbeKWW2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:28:38 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wANBiJ9r007511;
        Fri, 23 Nov 2018 05:44:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542973459;
        bh=KMGf+luPj1FpsSomJe8CPFq96J9BRFLeuBVBKB1hwgk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=s1hssAhi232ZieUfMn+e/IsdRllIE3ZXsZEyNXg/Fsri09yNHZDTKSA5bgyOM91zR
         PDBvgNYJYgEMWRIIYgBtn1VoFnb18tn4oCJzWSJZ6VGFYgKO6dt5hgVng4fthnhzHo
         DB+iJy8uabv5bB8RYwoVq7LqPzgyW66nuaRcORko=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wANBiJ2m065236
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 23 Nov 2018 05:44:19 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 23
 Nov 2018 05:44:18 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 23 Nov 2018 05:44:18 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wANBiGeJ027964;
        Fri, 23 Nov 2018 05:44:16 -0600
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Configure LCH_TYPE for OMAP1
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tony@atomide.com>, <linux-omap@vger.kernel.org>,
        <rmk+kernel@armlinux.org.uk>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
References: <20181119104040.12885-1-peter.ujfalusi@ti.com>
 <20181119184649.GE16897@darkstar.musicnaut.iki.fi>
 <6af8c6e7-bf5c-5555-161b-5d3fb7ecae43@ti.com>
 <20181120210406.GB24888@darkstar.musicnaut.iki.fi>
 <4eb3b03e-0a97-6195-f162-e03e32705fe0@ti.com>
 <20181122220114.GB11423@darkstar.musicnaut.iki.fi>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <cb1355b5-0d2e-1f83-5ea1-7615350ca0ec@ti.com>
Date:   Fri, 23 Nov 2018 13:45:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181122220114.GB11423@darkstar.musicnaut.iki.fi>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/11/2018 0.01, Aaro Koskinen wrote:
> Hi,
> 
> On Thu, Nov 22, 2018 at 10:31:31AM +0200, Peter Ujfalusi wrote:
>> On 20/11/2018 23.04, Aaro Koskinen wrote:
>>> On Tue, Nov 20, 2018 at 09:28:37AM +0200, Peter Ujfalusi wrote:
>>>> On 19/11/2018 20.46, Aaro Koskinen wrote:
>>>>> On Mon, Nov 19, 2018 at 12:40:40PM +0200, Peter Ujfalusi wrote:
>>>>>> When the channel is configured for slave operation the LCH_TYPE needs to be
>>>>>> set to LCh-P. For memcpy channels the LCH_TYPE must be set to LCh-2D.
>>>>>>
>>>>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>>>>
>>>>> I don't have the documentation, but based on what omap_udc driver (still
>>>>> using the legacy OMAP DMA API) does this seems to be correct.
>>>>
>>>> They are hard to fine, true. From the omap1710 TRM:
>>>>
>>>> Logical channel types (LCh types) supported are:
>>>> - LCh-2D for nonsynchronized transfers (memory transfers, 1D and 2D)
>>>> - LCh-P for synchronized transfers (mostly peripheral transfers)
>>>> - LCh-PD similar to LCh-P but runs on a dedicated physical channel
>>>> - LCh-G for graphical transfers/operations
>>>> - LCh-D for display transfers
>>>
>>> (I found a public document "OMAP5912 Multimedia Processor Direct
>>> Memory Access (DMA) Support Reference Guide", documenting these; easy
>>> to confuse with "OMAP5910 Dual-Core Processor System DMA Controller
>>> Reference Guide".)
>>>
>>>> Looking at other part it looks like hat LCH-2D channel mode can happily
>>>> service a peripheral. LCH-P supports the same features as LCH-2D, but it
>>>> lacks support for Single/Double-indexed addressing mode on the
>>>> peripheral port side.
>>>>
>>>> So, this patch might not be needed at all. Can you test the omap_udc
>>>> with s/OMAP_DMA_LCH_P/OMAP_DMA_LCH_2D
>>>>
>>>> If USB works, then we can just drop this patch.
>>>
>>> Unfortunately omap_udc does not seem to work at all anymore with DMA on
>>> my 770 setup. :-(
>>>
>>> I had switched to PIO mode in 2015 since the WARNs about legacy DMA
>>> API were too annoying and flooding the console. And now that I tried
>>> using DMA again with g_ether, it doesn't work anymore. The device get's
>>> recognized on host side, but no traffic goes through. Switching back to
>>> PIO makes it to work again.
>>
>> After some tinkering I got omap_udc working with DMA (not DMAengine,
>> yet) on 770 - using nfsroot. Configuring the channels to OMAP_DMA_LCH_2D
>> works as expected.
> 
> Would be interesting to know how you got it working with DMA. Which
> gadget driver were you using?
> 
> I bisected my issue, and got:
> 
> commit 387f869d2579e379ee343f5493dcd360be60f5c6 (refs/bisect/bad)
> Author: Felipe Balbi <felipe.balbi@linux.intel.com>
> Date:   Wed Mar 22 13:25:18 2017 +0200
> 
>     usb: gadget: u_ether: conditionally align transfer size

I just:
commit 0d61d79625202c1c4fcf07fb960e27984a3657a3
Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date:   Thu Nov 22 10:36:55 2018 +0200

    usb: gadget: omap_udc: HACK: Make RX dma work
    
    partial packets do work...
    
    Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index 94128eb69d97..0748c3841a25 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -886,14 +886,14 @@ omap_ep_queue(struct usb_ep *_ep, struct usb_request *_req, gfp_t gfp_flags)
 
        /* this isn't bogus, but OMAP DMA isn't the only hardware to
         * have a hard time with partial packet reads...  reject it.
+        * Wait a minute, it does work :o
         */
        if (use_dma
                        && ep->has_dma
                        && ep->bEndpointAddress != 0
                        && (ep->bEndpointAddress & USB_DIR_IN) == 0
                        && (req->req.length % ep->ep.maxpacket) != 0) {
-               DBG("%s, no partial packet OUT reads\n", __func__);
-               return -EMSGSIZE;
+               DBG("%s, partial packet OUT, might not work?\n", __func__);
        }
 
        udc = ep->udc;

> With that reverted, the DMA works OK (and I can also now confirm that
> OMAP_DMA_LCH_2D works). I haven't yet checked if we actually need that
> quirk in OMAP UDC,

The omap_udc driver is a bit of a mess, need to check it myself, but for
now we can just set the quirk_ep_out_aligned_size and investigate later.

> or if this is related to RMK's findings of potential
> bugs in the driver. Anyway, there is clearly yet another regression.

I'll check Russell's mail.

> 
> A.
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
