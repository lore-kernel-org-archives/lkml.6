Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FA2ECE560
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E588A2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MBMThXYS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E588A2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbeIRRui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 13:50:38 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38198 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbeIRRui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 13:50:38 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8ICI5T8107317;
        Tue, 18 Sep 2018 07:18:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537273085;
        bh=7M+nWyn9sCnXECsOD8q9L7/WZftrAIA2YCu8xdv7BbQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=MBMThXYS73QAFk1fyvgyHQuD75cgXoJMAcgOG61CkvCAPuS01TTiXZBqTqingZw8m
         UawaUnAsi6Gd9ZnWbp2fh5cX8xRIhKnYM3AyUCVSVIgGvawCcW1NUdFb7hItgLDNZJ
         ntFMnDEDRyxzpQp7CptASgCXZfnT3FdCqMPyOpGs=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8ICI5Mk025416;
        Tue, 18 Sep 2018 07:18:05 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 18
 Sep 2018 07:18:05 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 18 Sep 2018 07:18:05 -0500
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8ICI2tO025677;
        Tue, 18 Sep 2018 07:18:02 -0500
Subject: Re: [PATCH v4 2/2] pci: dwc: pci-dra7xx: Enable errata i870 for both
 EP and RC mode
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180917180635.26996-1-vigneshr@ti.com>
 <20180917180635.26996-3-vigneshr@ti.com>
 <20180918094147.GA26886@e107981-ln.cambridge.arm.com>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <cec970cf-7284-3788-0965-2d9c1aeb7314@ti.com>
Date:   Tue, 18 Sep 2018 17:48:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180918094147.GA26886@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 18 September 2018 03:11 PM, Lorenzo Pieralisi wrote:
> On Mon, Sep 17, 2018 at 11:36:35PM +0530, Vignesh R wrote:
[...]
>>
>> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
>> index ce9224a36f62..43711561a199 100644
>> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
>> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
>> @@ -542,7 +542,7 @@ static const struct of_device_id of_dra7xx_pcie_match[] = {
>>  };
>>  
>>  /*
>> - * dra7xx_pcie_ep_unaligned_memaccess: workaround for AM572x/AM571x Errata i870
>> + * dra7xx_pcie_unaligned_memaccess: workaround for AM572x/AM571x Errata i870
>>   * @dra7xx: the dra7xx device where the workaround should be applied
>>   *
>>   * Access to the PCIe slave port that are not 32-bit aligned will result
>> @@ -552,7 +552,7 @@ static const struct of_device_id of_dra7xx_pcie_match[] = {
>>   *
>>   * To avoid this issue set PCIE_SS1_AXI2OCP_LEGACY_MODE_ENABLE to 1.
>>   */
>> -static int dra7xx_pcie_ep_unaligned_memaccess(struct device *dev)
>> +static int dra7xx_pcie_unaligned_memaccess(struct device *dev)
>>  {
>>  	int ret;
>>  	struct device_node *np = dev->of_node;
>> @@ -695,6 +695,10 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>>  	if (dra7xx->link_gen < 0 || dra7xx->link_gen > 2)
>>  		dra7xx->link_gen = 2;
>>  
>> +	ret = dra7xx_pcie_unaligned_memaccess(dev);
>> +	if (ret)
>> +		dev_err(dev, "WA for Errata i870 not applied. Update DT\n");
> 
> Hi Vignesh,
> 
> I am not sure you want this code merged into an -rc given that without
> a DTS update is basically pointless (and for that bindings should at
> least be merged too as a fix).
> 

Ok, I will wait for next -rc1 to post DT changes.

> I would also like to understand why a dev_err() is sufficient, can the
> controller work without the WA applied ?
> 

W/o this errata WA, I see that non 32-bit aligned accesses to
configuration space of PEX 8606 switch card[1] returns corrupted data
with dra7xx PCIe controller (unaligned access seems to work fine for
other all other cards that I have tested with) and therefore fails to
enumerate. Other than that, I am not aware of any other impact on
functionality due to this issue in RC mode.
Also, since current DTBs do not have "ti,syscon-unaligned-access" DT
property in PCIe RC node, I chose not to fail driver probe as that would
break DT backward compatibility.

I see that in current driver code, probe used to fail in EP mode if DT
property was absent. Therefore, will modify patch so to retain that
behavior in v5, but keep WA optional for host mode.

> Nit: Lastly, in the dev_err() message, it is your call/code but I would not
> print "update DT", kernel log is not a command prompt but that's just my
> opinion so it is up to you.
> 

Ok, I will drop that part in next version.

[1]PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express
Gen 2 (5.0 GT/s) Switch (rev ba)

Regards
Vignesh

> 
>>  	switch (mode) {
>>  	case DW_PCIE_RC_TYPE:
>>  		if (!IS_ENABLED(CONFIG_PCI_DRA7XX_HOST)) {
>> @@ -717,10 +721,6 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>>  		dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_DEVICE_TYPE,
>>  				   DEVICE_TYPE_EP);
>>  
>> -		ret = dra7xx_pcie_ep_unaligned_memaccess(dev);
>> -		if (ret)
>> -			goto err_gpio;
>> -
>>  		ret = dra7xx_add_pcie_ep(dra7xx, pdev);
>>  		if (ret < 0)
>>  			goto err_gpio;
>> -- 
>> 2.19.0
>>


