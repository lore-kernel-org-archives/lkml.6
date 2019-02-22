Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D41C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 03:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC242086A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 03:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfBVDtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 22:49:25 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:35815 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfBVDtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 22:49:25 -0500
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gx199-00071w-8A from Jiada_Wang@mentor.com ; Thu, 21 Feb 2019 19:05:07 -0800
Received: from [172.30.112.120] (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Thu, 21 Feb 2019 19:05:03 -0800
From:   jiada <jiada_wang@mentor.com>
Subject: Re: [PATCH v1 0/2] rsnd: dts: change to use extended audio dmac
 register
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190220052435.20508-1-jiada_wang@mentor.com>
 <CAMuHMdX1OqmwtCAtx8mxQtrG0D6bxkJ-trkA50qw=t16kBfdTQ@mail.gmail.com>
 <871s427ux5.wl-kuninori.morimoto.gx@renesas.com>
Message-ID: <021012f9-f522-0efd-4bb2-c56917623266@mentor.com>
Date:   Fri, 22 Feb 2019 12:05:02 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <871s427ux5.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SVR-ORW-MBX-05.mgc.mentorg.com (147.34.90.205) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert


On 2019/02/20 17:10, Kuninori Morimoto wrote:
> 
> Hi Geert
> 
>>> According to user reference manual for R-CAR H3 and M3-W SoCs,
>>> in order to access busif4 ~ busif7, extended audio dmac registers
>>> (PDMASAREn, PDMADAREn, PDMACHCREn)
>>> need to be used, rather than basic audio dmac registers
>>> (PDMASARn, PDMADARn, PDMACHCRn)
>>>
>>> This patch set updates H3 (= r8a7795) and M3-W (= r8a7796)
>>> to use extended audio dmac registers
>>
>> The same change should be applied for M3-N and RZ/G2M, right?
>>
Currently only H3 and M3-W support to use busif other than busif0,
I feel currently it's only necessary to use extended audio dmac register 
for these SoCs

>> R-Car E3 and RZ/G2E already use the extended register set, as they do not
>> have the basic set.
>>
>> For SoCs having both, this feels a bit like describing software policy, instead
>> of hardware, to me. Would it make sense to extend the audio bindings, and
>> allow describing both the basic and extended register sets, and let the driver
>> make the decision which one to use?
> 
> I don't think we need to use basic register.
> This means extended register only is very enough.
> I'm not sure why datasheet is indicating basic...
> 
Extended audio dmac registers covers all function of basic ones,
so there is no need to use basic registers

Thanks,
Jiada

> Best regards
> ---
> Kuninori Morimoto
> 
