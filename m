Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D95C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4794F20859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="K3c7mfIf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404197AbfAPLAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:00:15 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40682 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731772AbfAPLAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:00:14 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0GB08cR048366;
        Wed, 16 Jan 2019 05:00:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547636408;
        bh=2R5fWHqkPFLyQKAK2GNDYC8P3Ii+C6OezNPxqPK9GMY=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=K3c7mfIfTzP1GOGHU8jkMWn021NL5hKiLHXf1Wt5AqbZ595S3UOSw4mQrEgA6vwZq
         f4FoRlSLYZdLuiCS29dvA/x5UCULbDLejVl2jgCL4RfzGmPZZxcTFfROTIf0F2sTwD
         52vgGSknlRVVAVOpOz2tffZxQqthRCAUvMxZQ6r0=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0GB08jx011770
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 05:00:08 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 16
 Jan 2019 05:00:05 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 16 Jan 2019 05:00:05 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0GB03KX011830;
        Wed, 16 Jan 2019 05:00:04 -0600
Subject: Re: [PATCH 0/3] arm64: ti: k3-am654: USB support
To:     Nishanth Menon <nm@ti.com>
References: <1547200861-17795-1-git-send-email-rogerq@ti.com>
 <20190115143306.wub3y2c2zsq7byy5@kahuna>
CC:     <t-kristo@ti.com>, <nsekhar@ti.com>, <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5C3F0EB3.5090009@ti.com>
Date:   Wed, 16 Jan 2019 13:00:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20190115143306.wub3y2c2zsq7byy5@kahuna>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/01/19 16:33, Nishanth Menon wrote:
> On 12:00-20190111, Roger Quadros wrote:
>> Hi,
>>
>> The AM654 SoC supports 2 DWC3 USB controller instances. The
>> AM654 base board supports the 2nd (USB1) instance in high-speed.
>>
>> This series enables support for USB1 instance on the AM654-base-board.
>>
>> To test, you need to first apply the below 2 series.
>>
>> AM654 USB2 PHY support https://lkml.org/lkml/2018/12/5/908
>> AM654 DWC3 support https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1896101.html
>>
> 
> Please clarify if these have hit linux-next yet (I dont see anything in
> the threads as to being picked up yet, may be I am wrong). Once they do hit
> linux-next, please rebase to Tero's latest tip and repost.
> 
> 

They haven't yet. PHY patches were picked up today.

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
