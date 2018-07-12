Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9987C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E1D20BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="YnlVAY8D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q8lp17qf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E1D20BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403919AbeGLCiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 22:38:25 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:43211 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391264AbeGLCiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 22:38:24 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0A18020CE1;
        Wed, 11 Jul 2018 22:23:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 11 Jul 2018 22:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=qn6PBtC81EbM35DLubQjcloXHmbW3
        YBAloIg0G1np3s=; b=YnlVAY8Dgy0gBjHd1YZ0D851vYJlKWTONPcC/MHjLjvS6
        zTqyn8s1bgQpzoSGYa+Xp8Xo9afGu2P7JEtXj02bnwO8tAdAtfX0pGl6CuW00cJ+
        SLP7YCqmL/151142Pda5mWG/9wHLk8pL5WxrRTSgaHHbWKkx/lOP6gGeKGJRNHwR
        jLEN0Kl5Kug0NZvY9V4/QPmRnMUHG4pFpiCdjURkZ0bs25JrUk3XmnaegpvCJaLx
        vYgQIPvmWda/bWGTlqC+6Zw08jKWeZ+zuZV3RVP1JNaZhds1WvzoRrngRIvGBjg0
        6uAdkd1X0Al2yks3qQA0Vs0YQ3snGXZ5bZlOB4RAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=qn6PBt
        C81EbM35DLubQjcloXHmbW3YBAloIg0G1np3s=; b=Q8lp17qfWiFVWyDb2rZjye
        HB56gg0jmCLyRYG4+dlHjkfFYAUABrNlCG25A/IlUdu53RjYea4h8NIRDYkiAlP2
        Die69TvAudqlbBcVBwzCniEIPefLQK1qwjWOcbjdgnqBGHvVOBR2wlqXivkRAMMy
        aEKbutQY+fDRXmf/yY1Rf2f0qvvzeWB30zKgKggsMaD6c6PGmPYMyQzKBR5O1Tvb
        VEQ4waEicxlOTpJqYhR+7pADlMLXLKK83xzUES1VqdNnqRiT1Tp1sgRHlqbq6pnG
        wxT4wDTkJmg2AtLIWymrfEG4YhmY3ULMHV9AdxQcO5sWxwBJ9oAFjRZEu0SA8bbg
        ==
X-ME-Proxy: <xmx:q7tGW843uLgQ8Nzvhz_KMXw8JeZgZc8Ibew91OQSVUlg3VwABc54rw>
    <xmx:q7tGWxPFDDVSbu8xTtrtii7C0_ZOK2ICpg-DzuMFPxHQAT_2B0ODGA>
    <xmx:q7tGW_ikOkUPaL6_Vt_v0-NDWNr3a2f-jLbifOPo6mVbK42BVWZdZQ>
    <xmx:q7tGW3hXnoOHxAb7-aAT4PAWhI5mDzQ73YPbuh_g9YXfrQYVU6feBg>
    <xmx:q7tGW2FRdU8naGSxzqWEr7CS7PNCOP51suuCfgFNaZPMeQtKmHRKng>
    <xmx:q7tGW-sAWM9uacQvz1rfTDKTxFgsL0oZEsZSoEU0_UDjbMN6_RdT5g>
X-ME-Sender: <xms:q7tGWx1y93KLox1a6oKYz6amsUBwuyE-_wg89htVwZrpqknWh_HSMg>
Received: from [192.168.43.79] (mobile-107-77-172-88.mobile.att.net [107.77.172.88])
        by mail.messagingengine.com (Postfix) with ESMTPA id 004D6E4072;
        Wed, 11 Jul 2018 22:23:37 -0400 (EDT)
Subject: Re: [PATCH 0/2] Allwinner A64 timer workaround
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Mark Rutland <Mark.Rutland@arm.com>
References: <20180511022751.9096-1-samuel@sholland.org>
 <2c16d5ab-38f7-8f3e-875c-19e8032f440a@arm.com>
 <bdfb1a31-2c4a-d258-7bf6-aaab8cee4663@sholland.org>
 <5283f98e-6443-db7a-fe51-6379ed19002c@arm.com>
 <d72937af-cb46-27cf-809a-507ba5e47568@linaro.org>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <903c9e71-dde1-78d5-ed52-fcf47821918e@sholland.org>
Date:   Wed, 11 Jul 2018 21:23:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <d72937af-cb46-27cf-809a-507ba5e47568@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/18 03:41, Daniel Lezcano wrote:
> On 04/07/2018 10:16, Marc Zyngier wrote:
>> On 03/07/18 19:42, Samuel Holland wrote:
>>> On 07/03/18 10:09, Marc Zyngier wrote:
>>>> On 11/05/18 03:27, Samuel Holland wrote:
>>>>> Hello,
>>>>>
>>>>> Several people (including me) have experienced extremely large system
>>>>> clock jumps on their A64-based devices, apparently due to the architectural
>>>>> timer going backward, which is interpreted by Linux as the timer wrapping
>>>>> around after 2^56 cycles.
>>>>>
>>>>> Investigation led to discovery of some obvious problems with this SoC's 
>>>>> architectural timer, and this patch series introduces what I believe is
>>>>> the simplest workaround. More details are in the commit message for patch
>>>>> 1. Patch 2 simply enables the workaround in the device tree.
>>>>
>>>> What's the deal with this series? There was a couple of nits to address, and 
>>>> I was more or less expecting a v2.
>>>
>>> I got reports that people were still occasionally having clock jumps after
>>> applying this series, so I wanted to attempt a more complete fix, but I haven't
>>> had time to do any deeper investigation. I think this series is still beneficial
>>> even if it's not a complete solution, so I'll come back with another patch on
>>> top of this if/once I get it fully fixed.
>>>
>>> I'll prepare a v2 with a bounded loop. Presumably, 3 * (max CPU Hz) / (24MHz
>>> timer) ≈ 150 should be a conservative iteration limit?
>>
>> Should be OK.
>>
>> Maxime: How do you want to deal with the documentation aspect? We need
>> an erratum number, but AFAIU the concept hasn't made it into the silicom
>> vendor's brain yet. Any chance you could come up with something that
>> uniquely identifies this?
> 
> I went through the different pointers provided in the description but I
> did not find a clear statement that is a hardware issue or may be I
> missed it.
> 
> Are we sure there isn't another subsystem responsible on this
> instability ? (eg PM or something else)

This issue has been observed on kernels with and without DVFS, across several
Linux, U-Boot, and Trusted Firmware versions. It has not been observed on any
other Allwinner SoC, including the A64's twin, the H5.

In fact, this workaround was recently successfully used in U-Boot [1] to fix
issues with an MMC driver that needed reliable numbers from CNTVCT.

So while the vendor hasn't confirmed it (and I wouldn't count on that
happening), everything I've seen points to it being a silicon bug, not a
software issue.

[1]:
https://git.denx.de/?p=u-boot.git;a=commit;h=be0d217952222b2bd3ed071de9bb0c66d8cc80d9

>>> Also, does this make sense to CC to stable?
>>
>> Probably not, as the HW never worked, so it is not a regression.
>>
>> Thanks,
>>
>> 	M.
>>
> 
> 

