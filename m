Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BFBC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 14:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8628725255
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 14:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UmJlPFeH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Q30N30MU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8628725255
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751280AbeF3Op0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 10:45:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37416 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750802AbeF3OpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 10:45:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4C73560711; Sat, 30 Jun 2018 14:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530369924;
        bh=in7zi6kT+6yx0lZa0rDGVIvf3J/ihD2y2J1/LCXqPQY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UmJlPFeHrDYTFzctx+6AXennUy7AZbMYPVAW5FSq2r0gsUPuQgvfUnG7FcWGPOqH8
         1PEcPuOLdQvLz5lhp2jxkvsfm1BRyeLeXjxMzQCVvmt2KkFuvVTLAWlOGG2lyfOJgo
         7vjpSR4X3HjlK3cupzI+Zg8zBDLPwCaWZHXx5VG0=
Received: from [192.168.0.117] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2A54F60711;
        Sat, 30 Jun 2018 14:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530369923;
        bh=in7zi6kT+6yx0lZa0rDGVIvf3J/ihD2y2J1/LCXqPQY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Q30N30MU/LheQ4cTxdCsyPT4irKOaTFcpoVIU2b+aiSWPLILpPQgo4dgzmjRtB9LW
         74jO22BIE/Bm9uI9UywZOHL+bjAMlQUL0buwwgJItJPwVxP3+FT3oFDUubui7nq9+k
         wk7TWC6W7eO5BMkeHpsyH4cRwZdtVkrahRwboZMg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2A54F60711
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH V2] PCI: Enable PASID when End-to-End TLP is supported by
 all bridges
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, timur@codeaurora.org,
        linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <1529460886-23722-1-git-send-email-okaya@codeaurora.org>
 <20180630004912.GI40928@bhelgaas-glaptop.roam.corp.google.com>
From:   Sinan Kaya <okaya@codeaurora.org>
Message-ID: <568634cf-54d0-c67d-b0f8-766b67def610@codeaurora.org>
Date:   Sat, 30 Jun 2018 10:45:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180630004912.GI40928@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/2018 8:49 PM, Bjorn Helgaas wrote:
> On Tue, Jun 19, 2018 at 10:14:46PM -0400, Sinan Kaya wrote:
>> A PCIe endpoint carries the process address space identifier (PASID) in
>> the TLP prefix as part of the memory read/write transaction. The address
>> information in the TLP is relevant only for a given PASID context.
>>
>> An IOMMU takes PASID value and the address information from the
>> TLP to look up the physical address in the system.
>>
>> If a bridge drops the TLP prefix, the translation agent can resolve the
>> address to an incorrect location and cause data corruption. Prevent
>> this condition by requiring End-to-End TLP prefix to be supported on the
>> entire data path between the endpoint and the root port.
> 
> PASID is an End-End TLP Prefix (PCIe r4.0, sec 6.20).  Sec 2.2.10.2 says
> 
>   It is an error to receive a TLP with an End-End TLP Prefix by a
>   Receiver that does not support End-End TLP Prefixes. A TLP in
>   violation of this rule is handled as a Malformed TLP. This is a
>   reported error associated with the Receiving Port (see Section 6.2).
> 
> So I agree that we shouldn't enable PASID in an endpoint unless all
> the switch ports leading to it support End-End prefixes.  But I don't
> see how a bridge can drop a prefix and cause data corruption -- if it
> doesn't support End-End prefixes, shouldn't the bridge raise a
> Malformed TLP error instead of forwarding the TLP?

It should under normal circumstances. 

I remember reading that most PCIe switches don't support TLP prefixes.
I don't know if it is because of buggy behavior or if it is just plain
unsupported while dropping the request as Malformed TLP.

I was trying to be proactive and not enable PASID if the entire path
is incapable.

> 
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> ---
>>  drivers/pci/ats.c             |  9 +++++++++
>>  drivers/pci/probe.c           | 17 +++++++++++++++++
>>  include/linux/pci.h           |  1 +
>>  include/uapi/linux/pci_regs.h |  1 +
>>  4 files changed, 28 insertions(+)
>>
>> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
>> index 4923a2a..e1b2e6d 100644
>> --- a/drivers/pci/ats.c
>> +++ b/drivers/pci/ats.c
>> @@ -268,6 +268,7 @@ EXPORT_SYMBOL_GPL(pci_reset_pri);
>>  int pci_enable_pasid(struct pci_dev *pdev, int features)
>>  {
>>  	u16 control, supported;
>> +	struct pci_dev *bridge;
>>  	int pos;
>>  
>>  	if (WARN_ON(pdev->pasid_enabled))
>> @@ -277,6 +278,14 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
>>  	if (!pos)
>>  		return -EINVAL;
>>  
>> +	bridge = pci_upstream_bridge(pdev);
>> +	while (bridge) {
>> +		if (!bridge->eetlp_prefix)
>> +			return -EINVAL;
>> +
>> +		bridge = pci_upstream_bridge(bridge);
>> +	}
> 
> I was hoping to avoid even this loop by having the eetlp_prefix bit
> indicate that "End-End TLP Prefixes are supported from the Root Port
> to here".
> 

I see.

>>  	pci_read_config_word(pdev, pos + PCI_PASID_CAP, &supported);
>>  	supported &= PCI_PASID_CAP_EXEC | PCI_PASID_CAP_PRIV;
>>  
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index ac876e3..a7f7ac1 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -2042,6 +2042,22 @@ static void pci_configure_ltr(struct pci_dev *dev)
>>  #endif
>>  }
>>  
>> +static void pci_configure_eetlp_prefix(struct pci_dev *dev)
>> +{
>> +#ifdef CONFIG_PCI_PASID
>> +	u32 cap;
>> +
>> +	if (!pci_is_pcie(dev))
>> +		return;
>> +
>> +	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
>> +	if (!(cap & PCI_EXP_DEVCAP2_E2ETLP))
>> +		return;
>> +
>> +	dev->eetlp_prefix = 1;
> 
> I.e., here we would do:
> 
>   if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
>     dev->eetlp_prefix_path = 1;
>   else {
>     bridge = pci_upstream_bridge(dev);
>     if (bridge && bridge->eetlp_prefix_path)
>       dev->eetlp_prefix_path = 1;
>   }

Sure, let me make the changes and post a new version.

> 
>> +#endif
>> +}
>> +
>>  static void pci_configure_device(struct pci_dev *dev)
>>  {
>>  	struct hotplug_params hpp;
>> @@ -2051,6 +2067,7 @@ static void pci_configure_device(struct pci_dev *dev)
>>  	pci_configure_extended_tags(dev, NULL);
>>  	pci_configure_relaxed_ordering(dev);
>>  	pci_configure_ltr(dev);
>> +	pci_configure_eetlp_prefix(dev);
>>  
>>  	memset(&hpp, 0, sizeof(hpp));
>>  	ret = pci_get_hp_params(dev, &hpp);
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 340029b..cf88d47 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -350,6 +350,7 @@ struct pci_dev {
>>  	unsigned int	ltr_path:1;	/* Latency Tolerance Reporting
>>  					   supported from root to here */
>>  #endif
>> +	unsigned int	eetlp_prefix:1;	/* End-to-End TLP Prefix */
>>  
>>  	pci_channel_state_t error_state;	/* Current connectivity state */
>>  	struct device	dev;			/* Generic device interface */
>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
>> index 4da87e2..a617ab2 100644
>> --- a/include/uapi/linux/pci_regs.h
>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -636,6 +636,7 @@
>>  #define  PCI_EXP_DEVCAP2_OBFF_MASK	0x000c0000 /* OBFF support mechanism */
>>  #define  PCI_EXP_DEVCAP2_OBFF_MSG	0x00040000 /* New message signaling */
>>  #define  PCI_EXP_DEVCAP2_OBFF_WAKE	0x00080000 /* Re-use WAKE# for OBFF */
>> +#define PCI_EXP_DEVCAP2_E2ETLP		0x00200000 /* End-to-End TLP Prefix */
> 
> It looks like lspci doesn't decode this bit (and several others in
> DevCap2).  Would you be interested in adding that?  The source is at
> git://git.kernel.org/pub/scm/utils/pciutils/pciutils.git
> 
>>  #define PCI_EXP_DEVCTL2		40	/* Device Control 2 */
>>  #define  PCI_EXP_DEVCTL2_COMP_TIMEOUT	0x000f	/* Completion Timeout Value */
>>  #define  PCI_EXP_DEVCTL2_COMP_TMOUT_DIS	0x0010	/* Completion Timeout Disable */
>> -- 
>> 2.7.4
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
