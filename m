Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BBAC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F27720849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dRyquj8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F27720849
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbeLLNEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:04:11 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:42398 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbeLLNEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 08:04:10 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBCD3c3q002289;
        Wed, 12 Dec 2018 07:03:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544619818;
        bh=9e943Fn+QzFmV1ZIL/4DepY3e9soRAMkzXZQIEEVAaA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=dRyquj8glg/d9I5Pn+JpOx1VP7Yf7JliAii1TumOSM5YEmcKIoeWYBeZLtByfiieH
         5/ZSGd1Pbeu1kLlkwpjJJrfvagapKY17ahsApDz7WCl9DUTp4kouOp/5W/HO6+YoJI
         XMms/Xj2r6I/K5TKs88q+mDvJyZrQHcJORouNM9I=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBCD3cT6055839
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Dec 2018 07:03:38 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 12
 Dec 2018 07:03:38 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 12 Dec 2018 07:03:38 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBCD3Zjk030552;
        Wed, 12 Dec 2018 07:03:36 -0600
Subject: Re: [PATCH 0/2] Graph fixes for using multiple endpoints per port
To:     Tony Lindgren <tony@atomide.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>
References: <20181211020557.61783-1-tony@atomide.com>
 <8736r4bvf3.wl-kuninori.morimoto.gx@renesas.com>
 <20181211045220.GI6707@atomide.com>
 <871s6obqkb.wl-kuninori.morimoto.gx@renesas.com>
 <20181211053536.GJ6707@atomide.com>
 <87wooga9an.wl-kuninori.morimoto.gx@renesas.com>
 <20181211141649.GL6707@atomide.com>
 <87ftv33bpg.wl-kuninori.morimoto.gx@renesas.com>
 <20181212001950.GX6707@atomide.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <01e3f547-318e-8988-b48a-e10c0a2904d6@ti.com>
Date:   Wed, 12 Dec 2018 15:05:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181212001950.GX6707@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/12/2018 2.19, Tony Lindgren wrote:
> * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> [181211 23:16]:
>>
>> Hi Tony
>>
>>> The issue I have with that it does not then follow the binding doc :)
>>>
>>> See this part in Documentation/devicetree/bindings/graph.txt:
>>>
>>>  "If a single port is connected to more than one remote device, an
>>>  'endpoint' child node must be provided for each link."
>>>
>>> Isn't the I2C TDM case the same as "single port connecected to
>>> more than one remote device" rather than multiple ports?
>>>
>>> To me it seems we're currently only handling the multiple ports
>>> case, and not multiple endpoints for a port. Other than fixing
>>> that, things should work just as earlier with my two patches.
>>> That is unless I accidentally broke something.
>>>
>>> So just trying to correct the binding usage. Or am I missing
>>> something?
>>
>> I'm not 100% sure your "I2C TDM case", but you can check
>> multi-endpoint sample on "Example: Multi DAI with DPCM" below.
>> "pcm3168a" is using multi-endpoint.
>> Does this help you ?
>>
>> 	https://patchwork.kernel.org/patch/10712877/
> 
> Hmm, so do you have multiple separate ports at the "&sound" node
> hardware? If so then yeah multiple ports make sense.
> 
> But if you only a single physical (I2S?) port at the
> "&sound" node hardware, then IMO you should only have one
> port and multiple endpoints there according to the graph.txt
> binding doc.
> 
> In my McBSP case there is only a single physical I2S port
> that can be TDM split into timeslots.

So what is missing from the McBSP driver is to configure the TDM. We
never had a hardware which would require it so it is _not_ implemented.

imho the 'only' thing is to implement the set_tdm_slot callback for the
McBSP DAI. In DT you would have single card with two dai_link section
and each section would set different tdm slots to use for the codecs
listening on different slots.

There is one issue for sure with this setup: the two PCM can not be used
at the same time. But we have one DMA channel so if you would open both
the PCM stream need to be set up in a way to match with the HW or create
a asound.conf file to do some mapping.

> 
> Regards,
> 
> Tony
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
