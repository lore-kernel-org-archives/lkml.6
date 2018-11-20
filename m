Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B06C41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7CE42087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7CE42087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbeKTVFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:05:53 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43848 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbeKTVFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 16:05:53 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAKAarA7129761;
        Tue, 20 Nov 2018 04:36:53 -0600
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAKAarBg078560
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Nov 2018 04:36:53 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 20
 Nov 2018 04:36:52 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 20 Nov 2018 04:36:52 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAKAamug017135;
        Tue, 20 Nov 2018 04:36:49 -0600
Subject: Re: [PATCH] mmc: core: Remove timeout when enabling cache
To:     Wolfram Sang <wsa@the-dreams.de>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Sjoerd Simons <sjoerd.simons@collabora.co.uk>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        <kernel@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hongjie Fang <hongjiefang@asrmicro.com>,
        Bastian Stender <bst@pengutronix.de>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Harish Jenny K N <harish_kandiga@mentor.com>,
        Simon Horman <horms+renesas@verge.net.au>
References: <20181106133007.12318-1-sjoerd.simons@collabora.co.uk>
 <9051c212-6e2a-bc39-3686-693e6cd87f1d@ti.com>
 <303b49cbb5b687d6b6a7ad4048eda459586c0806.camel@collabora.co.uk>
 <20181107084741.GA31092@kunai>
 <CAPDyKFpedP1f4XZYvebFCuooYrBa2ux9F9mYRNi1Q=M-5eJ0Rg@mail.gmail.com>
 <20181120102300.GA1056@kunai>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <568297e2-9fe2-1d34-beda-35d4906e3b8b@ti.com>
Date:   Tue, 20 Nov 2018 16:09:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181120102300.GA1056@kunai>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20/11/18 3:53 PM, Wolfram Sang wrote:
> 
>>>> That also happens to be one of the cards we deploy; However i did
>>>> wonder about adding a quirk but decided against it as it was not clear
>>>> to me from the specification that CACHE ON really is meant to complete
>>>> within GENERIC_CMD6_TIMEOUT. That and i fret about ending up in hit-a-
>>>> mole games as the failure is really quite tedious (boot failure).
>>>
>>> I agree that we should use the more defensive variant as a default. I
>>> mean there should be no performance regression since most cards will
>>> respond just faster, or? The only downside I could see is that we might
>>> miss a real timeout with no bounds set and might get stuck?
>>
>> Well, you have a point, but still it's kind of nice to know which
>> cards are behaving well and which ones that doesn't. Hence I think I
>> prefer to stick using a quirk, unless you have a strong opinion.
> 
> No strong opinion. Especially not if you say it is in the spec (although
> "must be sufficient" would be better than "should be" ;)). Also, I
> assume this failure is reproducible and should turn up during
> development? Compared to "happens once in a while randomly"?

At least for me, the failure happens only on some units but is
consistent for a given unit.

> 
> Yet, if we add a quirk for that, then we should probably mention it in
> an error message when we hit -ETIMEDOUT for cache on ("does your card
> need this quirk?")? It can be pretty time consuming to track this down
> otherwise, I'd think.
> 

The QUIRK needs to be card specific. The software should automatically
detect the card (from the CID) and apply the quirk. Please see patch in
my original reply.

Thanks,
Faiz
