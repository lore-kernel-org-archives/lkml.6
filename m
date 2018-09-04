Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FEBC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B64120645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="w3NgjW7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B64120645
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbeIDTrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:47:48 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:60342 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbeIDTrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:47:48 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w84FLo3J092040;
        Tue, 4 Sep 2018 10:21:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536074510;
        bh=VAjn56SGTMKkEawwxnXhFvDFiQZadVSWb/nQrzC4iK4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=w3NgjW7uAFzCGPYnSev9oBoRWp+q0kXtMiyzuE3QDAxR4qdxILDKZb5RfEJM/rY2f
         pppzqo2JvgMeo8uSS6VNs2UU3qGeJ5ZRfAjmXl71o6jMms+67FOXYhRA614QtF0GCa
         1bru4+m2XcOjtgZ1OIZORuDB4VHZTlSXNLmyOJvI=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w84FLooW020071;
        Tue, 4 Sep 2018 10:21:50 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 4 Sep
 2018 10:21:49 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 4 Sep 2018 10:21:49 -0500
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w84FLjZ7021846;
        Tue, 4 Sep 2018 10:21:46 -0500
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am65: Change #address-cells and
 #size-cells of interconnect to 2
To:     "Menon, Nishanth" <nm@ti.com>, KISHON VIJAY ABRAHAM <kishon@ti.com>
CC:     Tony Lindgren <tony@atomide.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Nori, Sekhar" <nsekhar@ti.com>, "Kristo, Tero" <t-kristo@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20180903095235.13853-1-kishon@ti.com>
 <20180904134142.npoxfimfsllmxdwb@akan>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <921e9705-1ac4-29fa-61bb-e6f4261b125e@ti.com>
Date:   Tue, 4 Sep 2018 20:52:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180904134142.npoxfimfsllmxdwb@akan>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday 04 September 2018 07:11 PM, Menon, Nishanth wrote:
> On 15:22-20180903, Kishon Vijay Abraham I wrote:
> 
>> AM65 has two PCIe controllers and each PCIe controller has '2' address
>> spaces one within the 4GB address space of the SoC and the other above
>> the 4GB address space of the SoC (cbass_main) in addition to the
>> register space. The size of the address space above the 4GB SoC address
>> space is 4GB. These address ranges will be used by CPU/DMA to access
>> the PCIe address space. In order to represent the address space above
>> the 4GB SoC address space and to represent the size of this address
>> space as 4GB, change address-cells and size-cells of interconnect to 2.
>>
>> Since OSPI has similar need in MCU Domain Memory Map, change
>> address-cells and size-cells of cbass_mcu interconnect also to 2.
>>
> 
> Please add Fixes
> 
> Vignesh, Sekhar, Tony,
> 
> Do we agree this is the right way to go forward? if yes, please
> ack.
> 
>

LGTM, thanks kishon!

Acked-by: Vignesh R <vigneshr@ti.com>



-- 
Regards
Vignesh
