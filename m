Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3771DC64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 22:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED46214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 22:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="D9alW4SX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EED46214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbeJJFXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 01:23:21 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:37736 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbeJJFXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 01:23:20 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w99M4FsS081320;
        Tue, 9 Oct 2018 17:04:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539122655;
        bh=EkDmqP7bOAjaKM/bm2IenIXa9GWK+IZmOWK0gEqvN6o=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=D9alW4SX4W3kllh6PZI61vgHC7cRELH5qNXGbG90amXx6xTplZf5FyhczeoKWeR5x
         bu72EGcfImQ9ZqfCtG09Nr2zqVN9i8jFViexNxkY2tld1eYDR/us2knQJ7xG4dqORC
         qRHfdgPvqyoDZqbOcj36UbIgOKFD5Mpwkb9LXplE=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w99M4EiR002779;
        Tue, 9 Oct 2018 17:04:14 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 9 Oct
 2018 17:04:14 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 9 Oct 2018 17:04:14 -0500
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w99M4EOX020754;
        Tue, 9 Oct 2018 17:04:14 -0500
Subject: Re: [RFC PATCH 02/11] dt-bindings: phy: add cpsw port interface mode
 selection phy bindings
To:     Tony Lindgren <tony@atomide.com>
CC:     "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20181008234949.15416-1-grygorii.strashko@ti.com>
 <20181008234949.15416-3-grygorii.strashko@ti.com>
 <20181009144000.GL5662@atomide.com>
 <3fa09831-0f70-dfcc-3fd9-f877215a4631@ti.com>
 <20181009203017.GM5662@atomide.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <f9dfd775-0679-f82b-b53b-065e9f7be7c7@ti.com>
Date:   Tue, 9 Oct 2018 17:04:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181009203017.GM5662@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/09/2018 03:30 PM, Tony Lindgren wrote:
> * Grygorii Strashko <grygorii.strashko@ti.com> [181009 20:10]:
>>
>>
>> On 10/09/2018 09:40 AM, Tony Lindgren wrote:
>>> * Grygorii Strashko <grygorii.strashko@ti.com> [181008 23:54]:
>>>> +Examples:
>>>> +	phy_gmii_sel: phy-gmii-sel {
>>>> +		compatible = "ti,am3352-phy-gmii-sel";
>>>> +		syscon-scm = <&scm_conf>;
>>>> +		#phy-cells = <2>;
>>>> +	};
>>>
>>> Now that this driver can live in it's proper place in the
>>
>> right
>>
>>> dts, you may want to consider just using standard reg
>>> property for it instead of the syscon-scm. And also get
>>> rid of the syscon reads and writes.
>>
>> Could you help clarify how to get syscon in this case?
>> syscon_node_to_regmap(dev->parent->of_node)?
> 
> Hmm I don't think you need syscon at all now. You can just
> ioremap the register(s) and use readl/writel and that's it.
> Or use regmap without syscon if you prefer that.

It will overlap with already remapped SCM syscon and i'd like to avoid this.
+ it seems common practice to use syscon for devices/drivers which are
child to SCM node - makes overall system more consistent.

> 
> The ioremap in this case should be hitting cached ranges
> anyways, so no extra overhead there.
> 
>> Also, there are could be more then one gmii_sel registers in SCM in the future,
>> so I hidden offsets in of_match data.
>> As result, "reg" not needed at all now.
> 
> But then you have to patch driver for various SoCs
> instead of just configuring the standard reg property
> in the dts file :)

Problem is that they are not guarantee to be standard between SoC's families 
(number of regs and fields placement), as result it might require to change
driver any way for various SoCs to handle properly new fields placement.

I prefer to fix driver then fight with DT ;) as it's static for SoC family
and need to be changed only once when new SoC family introduced.

-- 
regards,
-grygorii
