Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01943C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3CF02173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lTDOW0YR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfBZORW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 09:17:22 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:36640 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbfBZORW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 09:17:22 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1QEGS5Z004277;
        Tue, 26 Feb 2019 08:16:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551190588;
        bh=EHXVkBWsgB0gtyzRSSNnv68pzSVSTrk2//m4mAtiaZE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=lTDOW0YRCDQt0hywOyeTKoPhQyTrk4heBvVolYm+kUujwLkPWaTG+rrt2tGdpb7YE
         pR0yNv25A/zgm5V7txkWZaStZwDiir0zIyUk4dfXxXiWufTQx68T0st39S9bfi4sF3
         vB1hypf2bIvdUATWoisr9W+NWuWfZntH9Hol2X9M=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1QEGS1P022295
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Feb 2019 08:16:28 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 26
 Feb 2019 08:16:27 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 26 Feb 2019 08:16:27 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1QEGOp7018304;
        Tue, 26 Feb 2019 08:16:25 -0600
Subject: Re: [PATCH 2/4] bus: ti-sysc: Add support for PRUSS SYSC type
To:     Rob Herring <robh@kernel.org>
CC:     <tony@atomide.com>, <s-anna@ti.com>, <nsekhar@ti.com>,
        <linux-omap@vger.kernel.org>, <t-kristo@ti.com>,
        <nsaulnier@ti.com>, <jreeder@ti.com>, <m-karicheri2@ti.com>,
        <david@lechnology.com>, <woods.technical@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1549295637-24890-1-git-send-email-rogerq@ti.com>
 <1549295637-24890-3-git-send-email-rogerq@ti.com>
 <20190225212600.GA12346@bogus>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <7b762f7d-75af-a615-a18d-6f3854bc099a@ti.com>
Date:   Tue, 26 Feb 2019 16:16:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190225212600.GA12346@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/02/2019 23:26, Rob Herring wrote:
> On Mon, Feb 04, 2019 at 05:53:55PM +0200, Roger Quadros wrote:
>> The PRUSS module has a SYSCFG which is unique. Add
>> support for it.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  drivers/bus/ti-sysc.c                 | 77 +++++++++++++++++++++++++++++++++++
>>  include/dt-bindings/bus/ti-sysc.h     | 11 -----
> 
> Did you intend to remove what you just added?

Yes, it was a mistake.

> 
>>  include/linux/platform_data/ti-sysc.h |  1 +
>>  3 files changed, 78 insertions(+), 11 deletions(-)

cheers,
-roger

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
