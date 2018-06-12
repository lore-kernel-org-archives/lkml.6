Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7EEABC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E142208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eLWKMoAH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Q2+lI2Pr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E142208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754300AbeFLMXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 08:23:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45640 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754057AbeFLMXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 08:23:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4F80B60795; Tue, 12 Jun 2018 12:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528806197;
        bh=/Enex8GMRp6HzNyAmJ16F6MSWBsVpch4attSdVKfHls=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eLWKMoAH1LopyJa2RupxfBSlaHjWEZK+oTsW81g1pFzGvkfSboMKPj37omtzyWJvX
         Iud/pd5D/Ou8/UTEoyztItkgz0s+yT8NF0B4F208ttDeT0EtfEE62lJql4FayJSEX6
         iiGvSKK1Mok/AW+9g9OlifCKwlGf+W7DNCOe8e6U=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 3AF9160795;
        Tue, 12 Jun 2018 12:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528806196;
        bh=/Enex8GMRp6HzNyAmJ16F6MSWBsVpch4attSdVKfHls=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q2+lI2PrK99tOAD/Gvbjtwl2NJb+e+uo1YwPlb303iAnOwrAo5IX9evU/ZrE6+mFY
         4QaVwn+/IExNAb0/grkfRLAkr1PpsfFOWuMJU0b2MT8I4dD/UBOYlk95PJ9V0TZsJl
         cmGO+X4zaJcst3mc+gIiKhKYMtdXY4pgcq027z+I=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 12 Jun 2018 17:53:16 +0530
From:   poza@codeaurora.org
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>, linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH v2 2/5] PCI: iproc: Fix up corrupted PAXC root complex
 config registers
In-Reply-To: <2bafb8ae70029279a1849fb68a020d18@codeaurora.org>
References: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
 <1528762867-16823-3-git-send-email-ray.jui@broadcom.com>
 <2bafb8ae70029279a1849fb68a020d18@codeaurora.org>
Message-ID: <1f059e9b5ebeabf6f5a7e11a134221ae@codeaurora.org>
X-Sender: poza@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-12 13:57, poza@codeaurora.org wrote:
> On 2018-06-12 05:51, Ray Jui wrote:
>> On certain versions of Broadcom PAXC based root complexes, certain
>> regions of the configuration space are corrupted. As a result, it
>> prevents the Linux PCIe stack from traversing the linked list of the
>> capability registers completely and therefore the root complex is
>> not advertised as "PCIe capable". This prevents the correct PCIe RID
>> from being parsed in the kernel PCIe stack. A correct RID is required
>> for mapping to a stream ID from the SMMU or the device ID from the
>> GICv3 ITS
>> 
>> This patch fixes up the issue by manually populating the related
>> PCIe capabilities
>> 
>> Signed-off-by: Ray Jui <rjui@broadcom.com>
>> ---
>>  drivers/pci/host/pcie-iproc.c | 65 
>> +++++++++++++++++++++++++++++++++++++++----
>>  drivers/pci/host/pcie-iproc.h |  3 ++
>>  2 files changed, 62 insertions(+), 6 deletions(-)
>> 
>> diff --git a/drivers/pci/host/pcie-iproc.c 
>> b/drivers/pci/host/pcie-iproc.c
>> index 3c76c5f..680f6b1 100644
>> --- a/drivers/pci/host/pcie-iproc.c
>> +++ b/drivers/pci/host/pcie-iproc.c
>> @@ -85,6 +85,8 @@
>>  #define IMAP_VALID_SHIFT		0
>>  #define IMAP_VALID			BIT(IMAP_VALID_SHIFT)
>> 
>> +#define IPROC_PCI_PM_CAP		0x48
>> +#define IPROC_PCI_PM_CAP_MASK		0xffff
>>  #define IPROC_PCI_EXP_CAP		0xac
>> 
>>  #define IPROC_PCIE_REG_INVALID		0xffff
>> @@ -375,6 +377,17 @@ static const u16 iproc_pcie_reg_paxc_v2[] = {
>>  	[IPROC_PCIE_CFG_DATA]		= 0x1fc,
>>  };
>> 
>> +/*
>> + * List of device IDs of controllers that have corrupted capability 
>> list that
>> + * require SW fixup
>> + */
>> +static const u16 iproc_pcie_corrupt_cap_did[] = {
>> +	0x16cd,
>> +	0x16f0,
>> +	0xd802,
>> +	0xd804
>> +};
>> +
>>  static inline struct iproc_pcie *iproc_data(struct pci_bus *bus)
>>  {
>>  	struct iproc_pcie *pcie = bus->sysdata;
>> @@ -495,6 +508,49 @@ static unsigned int iproc_pcie_cfg_retry(void
>> __iomem *cfg_data_p)
>>  	return data;
>>  }
>> 
>> +static void iproc_pcie_fix_cap(struct iproc_pcie *pcie, int where, 
>> u32 *val)
>> +{
>> +	u32 i, dev_id;
>> +
>> +	switch (where & ~0x3) {
>> +	case PCI_VENDOR_ID:
>> +		dev_id = *val >> 16;
>> +
>> +		/*
>> +		 * Activate fixup for those controllers that have corrupted
>> +		 * capability list registers
>> +		 */
>> +		for (i = 0; i < ARRAY_SIZE(iproc_pcie_corrupt_cap_did); i++)
>> +			if (dev_id == iproc_pcie_corrupt_cap_did[i])
>> +				pcie->fix_paxc_cap = true;
> 
> and I think this code will try to fix up every time config space is 
> read.
> Does this get corrupted often, randomly ?
> Can it not be solved by using one time Quirk ?
> and if not Quirk, you dont want to be setting pcie->fix_paxc_cap =
> false somewhere
> 
> besides, pcie->fix_paxc_cap = true; is set if PCI_VENDOR_ID is read 
> first.
> and rest cases stay with the assumption that PCI_VENDOR_ID will be read 
> first.
> which is infact read first during enumeration
> (that is the assumption code is making), but that is safe assumption
> to make I think.
> 

ok I see that Bjorn has suggested to fix it this way instead of Quirks.
will just mark

Reviewed-by: Oza Pawandeep <poza@codeaurora.org>

>> +		break;
>> +
>> +	case IPROC_PCI_PM_CAP:
>> +		if (pcie->fix_paxc_cap) {
>> +			/* advertise PM, force next capability to PCIe */
>> +			*val &= ~IPROC_PCI_PM_CAP_MASK;
>> +			*val |= IPROC_PCI_EXP_CAP << 8 | PCI_CAP_ID_PM;
>> +		}
>> +		break;
>> +
>> +	case IPROC_PCI_EXP_CAP:
>> +		if (pcie->fix_paxc_cap) {
>> +			/* advertise root port, version 2, terminate here */
>> +			*val = (PCI_EXP_TYPE_ROOT_PORT << 4 | 2) << 16 |
>> +				PCI_CAP_ID_EXP;
>> +		}
>> +		break;
>> +
>> +	case IPROC_PCI_EXP_CAP + PCI_EXP_RTCTL:
>> +		/* Don't advertise CRS SV support */
>> +		*val &= ~(PCI_EXP_RTCAP_CRSVIS << 16);
>> +		break;
>> +
>> +	default:
>> +		break;
>> +	}
>> +}
>> +
>>  static int iproc_pcie_config_read(struct pci_bus *bus, unsigned int 
>> devfn,
>>  				  int where, int size, u32 *val)
>>  {
>> @@ -509,13 +565,10 @@ static int iproc_pcie_config_read(struct pci_bus
>> *bus, unsigned int devfn,
>>  	/* root complex access */
>>  	if (busno == 0) {
>>  		ret = pci_generic_config_read32(bus, devfn, where, size, val);
>> -		if (ret != PCIBIOS_SUCCESSFUL)
>> -			return ret;
>> +		if (ret == PCIBIOS_SUCCESSFUL)
>> +			iproc_pcie_fix_cap(pcie, where, val);
>> 
>> -		/* Don't advertise CRS SV support */
>> -		if ((where & ~0x3) == IPROC_PCI_EXP_CAP + PCI_EXP_RTCTL)
>> -			*val &= ~(PCI_EXP_RTCAP_CRSVIS << 16);
>> -		return PCIBIOS_SUCCESSFUL;
>> +		return ret;
>>  	}
>> 
>>  	cfg_data_p = iproc_pcie_map_ep_cfg_reg(pcie, busno, slot, fn, 
>> where);
>> diff --git a/drivers/pci/host/pcie-iproc.h 
>> b/drivers/pci/host/pcie-iproc.h
>> index 814b600..9d5cfee 100644
>> --- a/drivers/pci/host/pcie-iproc.h
>> +++ b/drivers/pci/host/pcie-iproc.h
>> @@ -60,6 +60,8 @@ struct iproc_msi;
>>   * @ep_is_internal: indicates an internal emulated endpoint device is 
>> connected
>>   * @has_apb_err_disable: indicates the controller can be configured 
>> to prevent
>>   * unsupported request from being forwarded as an APB bus error
>> + * @fix_paxc_cap: indicates the controller has corrupted capability 
>> list in its
>> + * config space registers and requires SW based fixup
>>   *
>>   * @need_ob_cfg: indicates SW needs to configure the outbound mapping 
>> window
>>   * @ob: outbound mapping related parameters
>> @@ -85,6 +87,7 @@ struct iproc_pcie {
>>  	int (*map_irq)(const struct pci_dev *, u8, u8);
>>  	bool ep_is_internal;
>>  	bool has_apb_err_disable;
>> +	bool fix_paxc_cap;
>> 
>>  	bool need_ob_cfg;
>>  	struct iproc_pcie_ob ob;
