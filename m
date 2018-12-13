Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BD1C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5E920873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:52:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E5E920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbeLMGwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 01:52:30 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58240 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbeLMGwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 01:52:30 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBD6pxsr059201;
        Thu, 13 Dec 2018 00:51:59 -0600
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBD6pxWe044868
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Dec 2018 00:51:59 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 13
 Dec 2018 00:51:59 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 13 Dec 2018 00:51:59 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBD6puR1018748;
        Thu, 13 Dec 2018 00:51:57 -0600
Subject: Re: [PATCH 0/2] Graph fixes for using multiple endpoints per port
To:     Tony Lindgren <tony@atomide.com>
CC:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
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
 <01e3f547-318e-8988-b48a-e10c0a2904d6@ti.com>
 <20181212145022.GB6707@atomide.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <34191403-3c56-47ac-77d9-e900d88f2ae5@ti.com>
Date:   Thu, 13 Dec 2018 08:53:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181212145022.GB6707@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/12/2018 16.50, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [181212 13:03]:
>> On 12/12/2018 2.19, Tony Lindgren wrote:
>>> In my McBSP case there is only a single physical I2S port
>>> that can be TDM split into timeslots.
>>
>> So what is missing from the McBSP driver is to configure the TDM. We
>> never had a hardware which would require it so it is _not_ implemented.
> 
> Curiously.. Nothing needs to be done in the McBSP driver for the droid
> 4 TDM configuration AFAIK.

So you always have 4 timeslot and that's it?

> The CPCAP PMIC is the clock master, and only the PMIC registers need to
> be configured in this case for the timeslot to switch between codecs
> connected to McBSP3.

The McBSP TDM configuration is not master only.
You basically tell McBSP on which timeslot to transmit/receive.
Let's say you have two codecs connected to a single McBSP.
codec1 is configured to listen for timeslot 0/1
codec2 is configured to listen for timeslot 2/3

If you open a stereo stream to codec1 then you tell McBSP to
send/receive the data under timeslot 0/1 and ignore any other timeslots.

If you open a stereo stream to codec2 then you tell McBSP to
send/receive the data under timeslot 2/3 and ignore any other timeslots.

For codec1 you don't really need anything regarding to TDM configuration
as McBSP will send/receive right after the start condition on the FS,
but for codec2 you need to configure the TDM mode of McBSP to ignore
timeslot 0/1

>> imho the 'only' thing is to implement the set_tdm_slot callback for the
>> McBSP DAI. In DT you would have single card with two dai_link section
>> and each section would set different tdm slots to use for the codecs
>> listening on different slots.
>>
>> There is one issue for sure with this setup: the two PCM can not be used
>> at the same time. But we have one DMA channel so if you would open both
>> the PCM stream need to be set up in a way to match with the HW or create
>> a asound.conf file to do some mapping.
> 
> Yes in the droid 4 TDM case only one device can be used at a time
> and all that configuration is done in the PMIC codec .set_tdm_slot
> function.

Hrm, do you have two DAIs on the PMIC side or different timeslots from
the TDM stream is routed to different outputs, similarly to twl6040
where timeslot 0/1 is Headset, timeslot 2/3 is Handsfree and timeslot 5
is to drive a vibra?

> I think it's possible to do more complex configurations where McBSP
> is the master and would implement a .set_tdm_slot function. But I
> don't know anything about that and I'm not aware of any such use
> cases in the mainline kernel.

No, the set_tdm_slot is applicable for both master and slave mode of McBSP.

> 
> Regards,
> 
> Tony
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
