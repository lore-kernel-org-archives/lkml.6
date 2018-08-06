Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DB7C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A34421A57
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="N8JcsewU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A34421A57
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733203AbeHFSmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:42:21 -0400
Received: from vern.gendns.com ([206.190.152.46]:43627 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728671AbeHFSmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:42:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=g3GkhkdS4M82j/opwBMufkPIme0Vgts/kwDzhSz/YSw=; b=N8JcsewU2MGMbcWk9FKoHem2rD
        AaCYZWf6tbRTqn46DZvDlRe51Sh1+iAEMOO4w718WtQOUmXbamCHCZ5wFin3ONCdhwCACOsGCf/WZ
        bHah10dUJFwobCYNxnUaGPPknzLnGfA7X/C4b6T5ANRYR7oLCVim5qmMmp6HOz9T5NUUrsGIguOeE
        ZaexW0gbFYR7+6Kl9fAZVKQARX5JnW+zpV9OjPL/CoaNV4zkFrcdyj/wAd+STpN4Ucm4HfhxFkZmt
        voUuDN5L/Jh+0CC7zRgTOUXdo3W1eE+Hnjv7IZrbMDTPp/0Ck3AtJZNLiIkf55DClW2a0IYoDLy9Y
        q6xMRNfQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:49116 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fmiQk-0089Vo-Li; Mon, 06 Aug 2018 12:32:26 -0400
Subject: Re: New remoteproc driver for TI PRU
To:     Suman Anna <s-anna@ti.com>, Roger Quadros <rogerq@ti.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
References: <20180623210810.21232-1-david@lechnology.com>
 <e0a883af-8228-5b06-3186-f57d8f898aaa@ti.com>
 <8fc18d40-72f5-9215-26f0-1492e3a6c0e7@lechnology.com>
 <536d28bd-bcdd-1665-e1c8-828572051cfb@ti.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <5bd5e388-959c-cff7-df38-d267e06d4d96@lechnology.com>
Date:   Mon, 6 Aug 2018 11:32:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <536d28bd-bcdd-1665-e1c8-828572051cfb@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/29/2018 07:17 PM, Suman Anna wrote:
> Hi David,
> 
> On 06/29/2018 12:44 PM, David Lechner wrote:
>> On 06/29/2018 04:58 AM, Roger Quadros wrote:
>>> +Suman & Tero
>>>
>>> Hi David,
>>>
>>> On 24/06/18 00:08, David Lechner wrote:
>>>>
>>>> Date: Sat, 23 Jun 2018 15:43:59 -0500
>>>> Subject: [PATCH 0/8] New remoteproc driver for TI PRU
>>>>
>>>> This series adds a new remoteproc driver for the TI Programmable
>>>> Runtime Unit
>>>> (PRU) that is present in some TI Sitara processors. This code has
>>>> been tested
>>>> working on AM1808 (LEGO MINDSTORMS EV3) and AM3358 (BeagleBone Green).
>>>
>>> This is great. We have been working on something similar and I think
>>> it would
>>> be great if we can collaborate to get all our needs addressed.
>>
>> Yes, I have used the PRU with the TI kernel on BeagleBone so I've seen
>> the TI
>> implementation. My primary interest is in the AM1808, which has a far
>> simpler
>> PRU than other SoCs. So, I was hoping I could get away with just
>> implementing
>> the basic stuff that I need and let TI add the more complex stuff later.
> 
> Thanks for the series. PRUSS is present on many SoCs now, and each with
> their own integration quirks, both in terms of SoC connections as well
> as internal sub-modules within the subsystem. We currently support
> AM335x, AM437x, AM57xx, Keystone 2 based 66AK2G and a newer generation
> AM65x as well. It should be relatively straight-forward to scale this
> for AM1808/OMAP-L138 as well. The move to the standard Common Clock and
> Reset frameworks for clocks with the Davinci chips should make it
> relatively straight-forward for the architecture pieces.
> 
> I will take a look at your series in detail sometime next week, and
> mostly post our series to the upstream lists as well within the next
> couple of weeks so that it is easier for discussion on the upstream lists.
> 

Have you had time to look at this yet? If you are too busy, I can submit
a v2 with the interrupt controller broken out into a separate driver.
