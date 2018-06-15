Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 607A5C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D42E208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eyVq7aRQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D42E208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965736AbeFONi4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 09:38:56 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:63786 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936211AbeFONiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 09:38:54 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelnx193.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5FDcLwd021850;
        Fri, 15 Jun 2018 08:38:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1529069901;
        bh=yRd4P1uDLKk+QA1pgL8+HspCdeDQs3bfBKUhTW2wEbE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=eyVq7aRQpTD9oIT1VXtV95bOnIwwjh9z+Vhm/Rv7Za8f/F2Wy/SCnzOs5pv3B2Rmb
         RCVb+c7VM3Ysk4jYAXqRfNWj7hWpyywMejNgj0XzGudzqaqVWGWYG6QkJXHRsxf2mu
         n8buZdKX9zUGhue5ie+m+np53xMqwMZcfP8IHh8Y=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5FDcLmq015447;
        Fri, 15 Jun 2018 08:38:21 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 15
 Jun 2018 08:38:20 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 15 Jun 2018 08:38:20 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5FDcE63022639;
        Fri, 15 Jun 2018 08:38:15 -0500
Subject: Re: [RFC PATCH 5/6] arm64: dts: ti: Add Support for AM654 SoC
To:     Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>
CC:     Mark Rutland <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vignesh R <vigneshr@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Tero Kristo <t-kristo@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20180605060510.32473-1-nm@ti.com>
 <CAL_JsqJusWTvr4A_-Bk81meYddMHBMJ4=Fch6L0MFoF7HfBW2w@mail.gmail.com>
 <20180607233853.p7iw7nlxxuyi66og@kahuna>
 <20180614123805.GF112168@atomide.com>
 <20180614130435.j2bmzam6corrjylx@kahuna>
 <20180615050108.GG112168@atomide.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <a69fcb7a-f7a1-481b-8a02-1da7d1e20671@ti.com>
Date:   Fri, 15 Jun 2018 19:08:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180615050108.GG112168@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On Friday 15 June 2018 10:31 AM, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [180614 13:07]:
>> On 12:38-20180614, Tony Lindgren wrote:

>> From A53 view, a more accurate view might be  - from an interconnect
>> view of the world (still simplified - i have ignored the sub bus
>> segments in the representations below):
>>
>> msmc {
>> 	navss_main {
>> 		cbass_main{
>> 			cbass_mcu {
>> 				navss_mcu {
>> 				};
>> 				cbass_wkup{
>> 				};
>> 			};
>> 		};
>> 	};
>> };
>>
>> From R5 view, the view will be very different ofcourse:
>> view of the world (still simplified):
>>
>> cbass_mcu {
>> 	navss_mcu {
>> 	};
>> 	cbass_wkup{
>> 	};
>> 	cbass_main{
>> 		navss_main {
>> 			msmc {
>> 			};
>> 		};
>> 	};
>> };
> 
> Well if we follow the hardware representation of the interconnects,
> it should not matter from which processor view you're looking at things.
> There are just different ranges provided.

AFAIK, the root node needs to have the CPU which is using the DT. So,
the hierarchy will change based on CPU view (if we describe it fully).

How well we can reuse individual interconnect segments is something I
have to think about / experiment. Will have to be wary of any "short
paths" or "cross connections".

Thanks,
Sekhar
