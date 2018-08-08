Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E4CC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284E62174A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 284E62174A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbeHHOah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 10:30:37 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:60616 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbeHHOah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 10:30:37 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 41lqwt57JMz1qwdt;
        Wed,  8 Aug 2018 14:11:10 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 41lqwt4J6tz1qrVf;
        Wed,  8 Aug 2018 14:11:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id LBbHvSYK6hes; Wed,  8 Aug 2018 14:11:09 +0200 (CEST)
X-Auth-Info: ZVMDG5+3xEdYBxy+cZvGhtlmjFF0028Dd4YOFig1bQk=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed,  8 Aug 2018 14:11:09 +0200 (CEST)
Subject: Re: [PATCH] ARM: dts: socfpga: use stdout-path for chosen node
To:     Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180808090944.861-1-simon.k.r.goldschmidt@gmail.com>
 <f27a5e90-9783-761e-a87b-9b8a2d46d2a4@denx.de>
 <CAAh8qsyHxMjwBtBa5pYejkOxwFRbbFbt+myC4ynQQonK8MAo-w@mail.gmail.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <ba66504e-c002-7dc6-daed-633fee896131@denx.de>
Date:   Wed, 8 Aug 2018 14:11:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAAh8qsyHxMjwBtBa5pYejkOxwFRbbFbt+myC4ynQQonK8MAo-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2018 02:02 PM, Simon Goldschmidt wrote:
> On Wed, Aug 8, 2018 at 1:32 PM Marek Vasut <marex@denx.de> wrote:
>>
>> On 08/08/2018 11:09 AM, Simon Goldschmidt wrote:
>>> Use stdout-path dts property for kernel console.
>>>
>>> There were two socfpga boards left not using stdout-path:
>>> socrates and vining. Make sure they match the other boards.
>>>
>>> Signed-off-by: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
>>> ---
>>>  arch/arm/boot/dts/socfpga_cyclone5_socrates.dts    | 3 ++-
>>>  arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts | 3 ++-
>>>  2 files changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts b/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
>>> index 53bf99eef66d..6f5255a7d192 100644
>>> --- a/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
>>> +++ b/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
>>> @@ -22,7 +22,8 @@
>>>       compatible = "ebv,socrates", "altr,socfpga-cyclone5", "altr,socfpga";
>>>
>>>       chosen {
>>> -             bootargs = "console=ttyS0,115200";
>>> +             bootargs = "earlyprintk";
>>> +             stdout-path = "serial0:115200n8";
>>>       };
>>>
>>>       memory@0 {
>>> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts b/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
>>> index f50b19447de6..e61efe16e79c 100644
>>> --- a/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
>>> +++ b/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
>>> @@ -54,7 +54,8 @@
>>>       compatible = "samtec,vining", "altr,socfpga-cyclone5", "altr,socfpga";
>>>
>>>       chosen {
>>> -             bootargs = "console=ttyS0,115200";
>>> +             bootargs = "earlyprintk";
>>
>> Why this earlyprintk ?
> 
> The reason is Dinh added that to all socfpga boards in his commit [1]
> and I wanted the remaining two boards to be the same.

Isn't earlyprintk mostly a debugging aid ?

-- 
Best regards,
Marek Vasut
