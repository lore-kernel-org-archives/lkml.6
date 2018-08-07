Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE979C4646D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 01:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8224D21A5E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 01:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HB1jAl6O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8224D21A5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732799AbeHGDwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 23:52:45 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35446 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729786AbeHGDwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 23:52:45 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w771diQ9059581;
        Mon, 6 Aug 2018 20:39:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1533605985;
        bh=LFvVnGnjITwzVA6fdTvDN7SZLJsjGq/6kKA5hYJUu5w=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=HB1jAl6OJ0psg7TiL29Xw9wzQWycVRd6JXD0aSl+yoEjaL1tiHjI6Jcu03VZlJmIa
         AUg0ejYtGYEYc3zfnUZqd4Ze23ZUKZ8Hi5bELatWzM9hHvQOEq2SL2Go0nqVck1aZ8
         zZy6JMSRu7EP0Z0ApghCO4OQ6j/XHsqgqZaAepSo=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w771dixc031289;
        Mon, 6 Aug 2018 20:39:44 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 6 Aug
 2018 20:39:44 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 6 Aug 2018 20:39:44 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w771dihk007208;
        Mon, 6 Aug 2018 20:39:44 -0500
Subject: Re: New remoteproc driver for TI PRU
To:     David Lechner <david@lechnology.com>,
        Roger Quadros <rogerq@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>
References: <20180623210810.21232-1-david@lechnology.com>
 <e0a883af-8228-5b06-3186-f57d8f898aaa@ti.com>
 <8fc18d40-72f5-9215-26f0-1492e3a6c0e7@lechnology.com>
 <536d28bd-bcdd-1665-e1c8-828572051cfb@ti.com>
 <5bd5e388-959c-cff7-df38-d267e06d4d96@lechnology.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <a377163f-e7a5-1f35-02ad-f223fc2c6e9d@ti.com>
Date:   Mon, 6 Aug 2018 20:39:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5bd5e388-959c-cff7-df38-d267e06d4d96@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 08/06/2018 11:32 AM, David Lechner wrote:
> On 06/29/2018 07:17 PM, Suman Anna wrote:
>> Hi David,
>>
>> On 06/29/2018 12:44 PM, David Lechner wrote:
>>> On 06/29/2018 04:58 AM, Roger Quadros wrote:
>>>> +Suman & Tero
>>>>
>>>> Hi David,
>>>>
>>>> On 24/06/18 00:08, David Lechner wrote:
>>>>>
>>>>> Date: Sat, 23 Jun 2018 15:43:59 -0500
>>>>> Subject: [PATCH 0/8] New remoteproc driver for TI PRU
>>>>>
>>>>> This series adds a new remoteproc driver for the TI Programmable
>>>>> Runtime Unit
>>>>> (PRU) that is present in some TI Sitara processors. This code has
>>>>> been tested
>>>>> working on AM1808 (LEGO MINDSTORMS EV3) and AM3358 (BeagleBone Green).
>>>>
>>>> This is great. We have been working on something similar and I think
>>>> it would
>>>> be great if we can collaborate to get all our needs addressed.
>>>
>>> Yes, I have used the PRU with the TI kernel on BeagleBone so I've seen
>>> the TI
>>> implementation. My primary interest is in the AM1808, which has a far
>>> simpler
>>> PRU than other SoCs. So, I was hoping I could get away with just
>>> implementing
>>> the basic stuff that I need and let TI add the more complex stuff later.
>>
>> Thanks for the series. PRUSS is present on many SoCs now, and each with
>> their own integration quirks, both in terms of SoC connections as well
>> as internal sub-modules within the subsystem. We currently support
>> AM335x, AM437x, AM57xx, Keystone 2 based 66AK2G and a newer generation
>> AM65x as well. It should be relatively straight-forward to scale this
>> for AM1808/OMAP-L138 as well. The move to the standard Common Clock and
>> Reset frameworks for clocks with the Davinci chips should make it
>> relatively straight-forward for the architecture pieces.
>>
>> I will take a look at your series in detail sometime next week, and
>> mostly post our series to the upstream lists as well within the next
>> couple of weeks so that it is easier for discussion on the upstream
>> lists.
>>
> 
> Have you had time to look at this yet? If you are too busy, I can submit
> a v2 with the interrupt controller broken out into a separate driver.

Yeah, I worked on it a bit around -rc4 time, but didn't get a chance to
complete the cleanup & testing before I had to shift to some other
tasks. If you are interested, I can share my branch. I will mostly get
back to this towards the latter half of next week. Anyway, I am
expecting 4.19-rc1 to be in a better shape w.r.t Davinci platform as the
genpd and CCF stuff comes in, and the pm_runtime usage for clocking in
my PRUSS drivers will fit well with those available.

regards
Suman


