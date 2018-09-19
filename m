Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5439C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91956208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eu4E7aXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91956208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733216AbeITAWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 20:22:19 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36450 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732190AbeITAWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 20:22:19 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8JIgYC3114845;
        Wed, 19 Sep 2018 13:42:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537382554;
        bh=2VrCJnl4+ZqvBMi9kiAY6iyDgYiNKhGh7+xPhZTZDL4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=eu4E7aXUEKADiTxrcJz5GDFYLgtghTZ1QIcNo1ZLxx/yFquVCi0+/UphRvAZ+04J0
         GavdDtiUBkIZlIeTMGJqtG4OCFSmhX1MwVAHNMLbvRYYwiSLedaRA4eGVpAQ+6oUak
         NaW4PMmFufHqT+IY/A+Ot3PZrVfDKP0mAlU3+Mic=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8JIgYQp023175;
        Wed, 19 Sep 2018 13:42:34 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 19
 Sep 2018 13:42:34 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 19 Sep 2018 13:42:34 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8JIgULD011039;
        Wed, 19 Sep 2018 13:42:31 -0500
Subject: Re: [PATCH 0/3] arm64: dts: ti: am654: Enable additional nodes
To:     Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh R <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
References: <20180905162024.28243-1-nm@ti.com>
 <20180905203313.GE5662@atomide.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <44d45b6c-5daa-aa54-da3a-efb388e4fef0@ti.com>
Date:   Wed, 19 Sep 2018 21:42:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180905203313.GE5662@atomide.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/18 23:33, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [180905 16:24]:
>> Nishanth Menon (3):
>>    arm64: dts: ti: am654: Add uart nodes
>>    arm64: dts: ti: am654: Add secure proxy instance for main domain
>>    arm64: dts: ti: k3-am6: Add Device Management Security Controller
>>      support
> 
> All look good to me:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>
> 

Queuing up for 4.20, thanks.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
