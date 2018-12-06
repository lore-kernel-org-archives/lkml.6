Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045CEC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C591A20878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C591A20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbeLFFEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 00:04:43 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:42085 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbeLFFEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 00:04:43 -0500
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gUlq1-0007aU-Rq from Jiada_Wang@mentor.com ; Wed, 05 Dec 2018 21:04:37 -0800
Received: from [172.30.112.134] (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Wed, 5 Dec 2018 21:04:34 -0800
Subject: Re: [PATCH linux-next v3 6/7] ASoC: rsnd: add avb clocks
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "vladimir_zapolskiy@mentor.com" <vladimir_zapolskiy@mentor.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20181205074932.28098-1-jiada_wang@mentor.com>
 <87va48bbpa.wl-kuninori.morimoto.gx@renesas.com>
 <612ee648-c217-e9b4-224c-87183e43d83d@mentor.com>
 <878t13jx6y.wl-kuninori.morimoto.gx@renesas.com>
From:   Jiada Wang <jiada_wang@mentor.com>
Message-ID: <011cfbf7-70d0-a649-52de-1689cdb5a10b@mentor.com>
Date:   Thu, 6 Dec 2018 14:04:32 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <878t13jx6y.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SVR-ORW-MBX-07.mgc.mentorg.com (147.34.90.207) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Morimoto-san

Thanks for your comments

On 2018/12/06 9:59, Kuninori Morimoto wrote:
> Hi Jiada
>
>>>> +	avb = devm_kzalloc(dev, sizeof(*avb), GFP_KERNEL);
>>>> +	if (!avb)
>>>> +		return ERR_PTR(-ENOMEM);
>>>> +
>>>> +	parent_name = __clk_get_name(adg->clkadg);
>>> This parent_name is very strange to me.
>>> AVB parent clk is "AUDIO_CLK_A/B/C/I" (= clk_a/b/c/i in this driver)
>>> or "AUDIO_CLK_OUT_A/B/C/D" (= audio_clkout/1/2/3 in this driver).
>>> And we don't have "adg" clock.
>>> Please double check it.
>> I have some local device-tree change, which expends 'adg' register
>> range and add
>> "adg" clock to rcar_sound node which refer to newly added 'adg' clock
>> (S0D1ϕ) in this patch-set
> (snip)
>> -                       clocks = <&cpg CPG_MOD 1005>,
>> +                       clocks = <&cpg CPG_MOD 922>, <&cpg CPG_MOD 1005>,
>>                                   <&cpg CPG_MOD 1006>, <&cpg CPG_MOD 1007>,
>>                                   <&cpg CPG_MOD 1008>, <&cpg CPG_MOD 1009>,
>>                                   <&cpg CPG_MOD 1010>, <&cpg CPG_MOD 1011>,
>> @@ -1856,7 +1856,7 @@
>>                                   <&audio_clk_a>, <&audio_clk_b>,
>>                                   <&audio_clk_c>,
>>                                   <&cpg CPG_CORE R8A7795_CLK_S0D4>;
>> -                       clock-names = "ssi-all",
>> +                       clock-names = "adg", "ssi-all",
>>                                        "ssi.9", "ssi.8", "ssi.7", "ssi.6",
>>                                        "ssi.5", "ssi.4", "ssi.3", "ssi.2",
>>                                        "ssi.1", "ssi.0",
> Noooo !!
> It breaks sound clock / module stop controling !!
Can you let me know how it breaks sound clock / module stop
so that I can come up with a fix
> OK, now I checked more detail of ADG for EAVB/IF.
>
> 1st, I don't think we need to add "adg" clock.
> It is not exist on Gen2, and default ON on Gen3.
> If you want to add it, please add it to "last" of clocks, not "first".
> "first" clock is handling whole SSI power.
as this device-tree change is only local, I will move 'adg' clock to 
'last' of clocks,
when I submit it.
> 2nd, it is "Module stop clock", not "S0D1ϕ".
> We already handling it as "clk_i".
SMSTPCR922 controls input of two clocks "S0D1ϕ" and "S0D4ϕ",
"S0D4ϕ" is input to BRGA,
"S0D1ϕ" is input to avb_counter8
>
> 3rd, we need to create new clock/handler for
> avb_counter8 / audio_clk_div3 / avb_div8 for "internal" purpose,
> and need to create avb_adg_syn[] clock for "external" purpose for EAVB/IF.
> Your code is creating / registering adg->clkavb[],
> but it is for avb_counter8 in my understanding.
> We don't need to register it as formal clock IMO.
I agree, besides avb_counter8 there are other clocks which need to be 
added as you have mentioned,
in this patch-set, I only added avb_counter8, because I want to keep the 
patch-set simple,
other clocks can be added later.

avb_counter8 is registered as formal clock is because,
there is use case that EAVB-IF may use avb_div8, and avb_counter8 is 
input to avb_div8.
if keeps avb_counter8 'internal', I am not sure how EAVB-IF can set 
clock rate for avb_counter8
> 4th, EAVB driver need to get clock from AVB via DT
> as "avb_adg_syn[]" clock, not "avb_counter8".
>
> I'm not sure EAVB side driver, but please double check these.
yes, EAVB driver only needs to get 'avb_adg_sync[]' clock,
and avb_adg_sync clock is child clock of audio_clk_div3 / avb_div8


Thanks,
Jiada
>
>
> Best regards
> ---
> Kuninori Morimoto

