Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FE5ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB72B2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kaPcbQ+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB72B2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731873AbeGSQmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:42:11 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59498 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730053AbeGSQmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:42:11 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6JFwG52115260;
        Thu, 19 Jul 2018 10:58:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1532015896;
        bh=fdtbsz7j3PNhboGrAlyQ1M/Ljs2UYWmFCk+2Gkgq6+M=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=kaPcbQ+8zxGy0yrDYWfOoWvuEFClSCJ1b6uEUm+R3T+YEhInBVZeusFwVr2Rv6op+
         FVrEpz5kFMXP5P8c0nMpOrvFGckrxmNIjWdzdNOcOBUh4E98j9K2w7NAPU+nFRULQ2
         MFKtkkU3bc6Mpbqlhb8fnNO+ps33oeb9MnOmkNwE=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6JFwGxc001672;
        Thu, 19 Jul 2018 10:58:16 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 19
 Jul 2018 10:58:15 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 19 Jul 2018 10:58:15 -0500
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6JFwC16026921;
        Thu, 19 Jul 2018 10:58:13 -0500
Subject: Re: [PATCH v2 2/4] pci: dwc: pci-dra7xx: Enable errata i870 for both
 EP and RC mode
To:     Tony Lindgren <tony@atomide.com>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        KISHON VIJAY ABRAHAM <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20180627122919.23926-1-vigneshr@ti.com>
 <20180627122919.23926-3-vigneshr@ti.com> <20180718110250.GA21589@red-moon>
 <b7f1cef7-b0d8-733a-c450-163299d281d0@ti.com>
 <20180719111556.GB9213@e107981-ln.cambridge.arm.com>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <c9d953f8-bc60-5243-bd11-a3a053c08340@ti.com>
Date:   Thu, 19 Jul 2018 21:29:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180719111556.GB9213@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday 19 July 2018 04:45 PM, Lorenzo Pieralisi wrote:
> On Thu, Jul 19, 2018 at 04:04:34PM +0530, Vignesh R wrote:
>> Hi Lorenzo,
>>
[...]
>>>> +	ret = dra7xx_pcie_unaligned_memaccess(dev);
>>>> +	if (ret)
>>>> +		dev_err(dev, "WA for Errata i870 not appplied. Update DT\n");
>>>
>>> Hi Vignesh,
>>>
>>> Nit: s/appplied/applied
>>>
>>
>> Oops, let me know if you want me to resend with this fixed.
> 
> I can fix it, no problem but see below.
> 
>>> Two questions:
>>>
>>> - Current code applies the unaligned_memaccess() workaround for all
>>>   compatible variants. This is fine for current controllers (since
>>>   they are all affected), the code path above will have to be
>>>   reworked if there is any other compatible IP re-using the driver
>>>   that does not require the workaround.
>>
>> There are no compatible IPs that don't require this workaround. Also, I
>> don't see this IP being re-used in future. If you insist, I can add a
>> errata flag
> 
> I do not insist, I just pointed this out ;-)
> 
>>> - How do you want this series to go upstream ? If it goes via arm-soc,
>>>   which I think it should, here is my ACK on this patch:
>>>
>> Patch 1 and 2(dt bindings update and driver patch) can go in via PCI
>> tree. And DT changes(patch 3 and 4) can be picked up by Tony via
>> omap/arm-soc tree. They are mostly independent and should not cause any
>> problems. Does that sound good?
> 
> It should be fine but technically as soon as patch (2) is applied we
> would have a regression if patches (3) and (4) are applied separately.
> 

Right, although not a regression, I see your point. It would be good to
merge patch 3 and 4 before patch 2.

Tony,
Let me know if you are okay with taking this series via omap tree. I can
resend re-ordering patch 2 to come at the end of the series.

Regards
Vignesh

> 
>>> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>>
>>
>> Thanks!
>>
>>> Please let me know if I can drop this series from the PCI patchwork.
>>>
>>> Thanks,
>>> Lorenzo
>>>
>>>> +
>>>>  	switch (mode) {
>>>>  	case DW_PCIE_RC_TYPE:
>>>>  		if (!IS_ENABLED(CONFIG_PCI_DRA7XX_HOST)) {
>>>> @@ -717,10 +721,6 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>>>>  		dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_DEVICE_TYPE,
>>>>  				   DEVICE_TYPE_EP);
>>>>  
>>>> -		ret = dra7xx_pcie_ep_unaligned_memaccess(dev);
>>>> -		if (ret)
>>>> -			goto err_gpio;
>>>> -
>>>>  		ret = dra7xx_add_pcie_ep(dra7xx, pdev);
>>>>  		if (ret < 0)
>>>>  			goto err_gpio;
>>>> -- 
>>>> 2.18.0
>>>>
>>
>> -- 
>> Regards
>> Vignesh

-- 
Regards
Vignesh
