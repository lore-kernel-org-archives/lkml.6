Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF72C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0875125FE9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="CNM4nCzA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0875125FE9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965849AbeF0Qy4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 12:54:56 -0400
Received: from vern.gendns.com ([206.190.152.46]:41572 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965107AbeF0Qyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 12:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bxZtoUxHppEzvDJ8++z4JMFxocpoo4FjR2yNovxK8kY=; b=CNM4nCzAXxbIZhCjWs1hqINcoK
        vgJzp5kauzlp47gWl6fyFSj/dCBZeuwIBOPIxZmM1LnoaDH2Sd1DMgia42/To1s45FKk4ftla3JM2
        BV5yk6w/MEpY1go95c3UNEiQt7Y0newNgh+FsdJ2fKWcRhG26mJdv+Dv+MK5BklsDNqWxDjB1DYys
        fbc8rFOQMZJN74deP5MUHA4stge9kV3knR9e6qyGGOxaqvNO7NnMFFa464mTZ62NAa6aISgSuB7d6
        JQP+/Kjn6l6bAIs7SPSt7yqzUgXnctNSIHTYeBo+d6dyOnP269qDUfRsIFBbNG7DiO74OkFee9+8m
        HZbhUtaw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:49546 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fYDiW-00AnmB-4G; Wed, 27 Jun 2018 12:54:52 -0400
Subject: Re: [PATCH v2 04/13] clk: davinci: psc-dm646x: use two lookup entries
 for the aemif clock
To:     Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
References: <20180626092537.6737-1-brgl@bgdev.pl>
 <20180626092537.6737-5-brgl@bgdev.pl>
 <1da88059-2d5b-f035-1d4c-9e21ae141017@ti.com>
 <CAMpxmJXpAECkA7FTLx-nR_w0ZEBUw_A7qpu2P6e_mS6k=pTsUQ@mail.gmail.com>
 <28c47ca0-60ca-beb2-cd78-63ef6595fcd5@ti.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <af78c876-a801-e16a-4983-0efcf8f85f56@lechnology.com>
Date:   Wed, 27 Jun 2018 11:54:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <28c47ca0-60ca-beb2-cd78-63ef6595fcd5@ti.com>
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

On 06/27/2018 05:26 AM, Sekhar Nori wrote:
> On Wednesday 27 June 2018 03:33 PM, Bartosz Golaszewski wrote:
>> 2018-06-27 12:01 GMT+02:00 Sekhar Nori <nsekhar@ti.com>:
>>> On Tuesday 26 June 2018 02:55 PM, Bartosz Golaszewski wrote:
>>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>
>>>> We want to be able to get the clock both from the board file by its
>>>> con_id and from the aemif driver by dev_id.
>>>>
>>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>
>>> I see the DM365 and DM644x EVM board files getting reference to aemif
>>> clock using just the con_id, but don't see that for DM646x. Am I
>>> overlooking something?
>>>
>>> Thanks,
>>> Sekhar
>>
>> It's being done indirectly from mach-davinci/aemif.c. I guess we can
>> remove it again after last patch.
> 
> I see. One way to avoid that would be to merge this into 11/13. I prefer
> that, but it prevents clean separation of clock and machine patches. So
> okay with current way too.

I think da850 has a con_id-only lookup that can be removed as well. I'm
in favor of doing another series to clean these up later.


