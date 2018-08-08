Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C82C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 03:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F08216F3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 03:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izAVgHyu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F08216F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbeHHGD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 02:03:56 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36186 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbeHHGDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 02:03:55 -0400
Received: by mail-oi0-f67.google.com with SMTP id n21-v6so1437470oig.3;
        Tue, 07 Aug 2018 20:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hHiPegLw5NXSxdODhlFZz5yBUol/u2qGPf/XjIht54g=;
        b=izAVgHyupDFGMn1dgHIbZ6AAsz8n6d88Xp1ZT06uz1BzKnr4gpJ9VtdVcORudZmZ1C
         S2mE0Q7XYlSyldAeWnUO4vktCHam/ERQE6+5sbdBXKIThPqEo6Zb839fiSAE7VPVHABP
         a+bC2di0NW0XKD8phEOQDKQgFombwovV++nRP60LYKRo2tem8FFRaIh6hY/WLhdfku07
         +nWD7vS6WBEvNaE9l1dP+T4THIH/xxiPSNZtUg1vUPAohuPyFJ31eBDoFU4ljZlREDbQ
         oNnZqbN2hjWSB0n5NEDl/ytNNFcXtZun0+ijyBiGoB6xDXOWRNn5V9eLEKq29DxI2n4v
         oFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hHiPegLw5NXSxdODhlFZz5yBUol/u2qGPf/XjIht54g=;
        b=b5+bZxuDmJPdV6/mfiyJlLkDpRAMiS67VRH4gQPkk/jFq0rBZmzrR1nzJkGUF59FYa
         dbW2/QtXcz7JxR9uM+XZkFrLG5vU6Y2xsj1OMlyJtVQ+1Mn+PnNdt4kinJ68gf7IVwLQ
         7FQf0Do2NPqZuIsLq7G9XFdBy0wKdqtGOqxSBNK0J3H7F8dlHzHO8X3wpEgUATlSu7x/
         H6UwnSKmPuuzonbq/N8bmirTXBkt69AHaQLTsNmwyDT+syvLjQYNDnvAY6+vd9IRluu4
         5FQh4VaK1ycy+HmPGWYfXfyWTZ7pqBHYNGAVpVXPviFY/8P7W3d59FhLF1+RuLEjzXKw
         VKow==
X-Gm-Message-State: AOUpUlFd22c/rAnUgMP9ieeAI1ZEAGm/lywjKthbvpXdj+VwlP24eu7q
        zKbcrigN+jYYnkt+imtYWKBSgEp54jg=
X-Google-Smtp-Source: AA+uWPyZlmd2y8Ip69kd7N3E575T0IKtMfl05h4aVAQ6psZF6L2dqsCBU6wOGri3pf1o9qSP5sb9FA==
X-Received: by 2002:aca:ab0c:: with SMTP id u12-v6mr1100133oie.143.1533699980686;
        Tue, 07 Aug 2018 20:46:20 -0700 (PDT)
Received: from nukespec.gtech (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id e204-v6sm6925240oif.21.2018.08.07.20.46.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 20:46:20 -0700 (PDT)
Subject: Re: [PATCH v3] PCI/AER: Do not clear AER bits if we don't own AER
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        keith.busch@intel.com, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        linux-kernel@vger.kernel.org
References: <3d05f662-2c29-90cd-9c74-6456939a0e6b@gmail.com>
 <20180730233547.1238-1-mr.nuke.me@gmail.com>
 <20180808011429.GB49411@bhelgaas-glaptop.roam.corp.google.com>
From:   "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <56a5722e-d102-554d-cbea-44af3383f7e3@gmail.com>
Date:   Tue, 7 Aug 2018 22:46:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180808011429.GB49411@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/07/2018 08:14 PM, Bjorn Helgaas wrote:
> On Mon, Jul 30, 2018 at 06:35:31PM -0500, Alexandru Gagniuc wrote:
>> When we don't own AER, we shouldn't touch the AER error bits. Clearing
>> error bits willy-nilly might cause firmware to miss some errors. In
>> theory, these bits get cleared by FFS, or via ACPI _HPX method. These
>> mechanisms are not subject to the problem.
> 
> What's FFS?

Firmware-first. Nobody likes spelling it out, and all other proposed 
acronyms are insanely tong-twisting. So, FFS.

> I guess you mean FFS and _HPX are not subject to the problem because
> they're supplied by firmware, so firmware would be responsible for
> looking at the bits before clearing them?

Exactly.

>> This race is mostly of theoretical significance, since I can't
>> reasonably demonstrate this race in the lab.
>>
>> On a side-note, pcie_aer_is_kernel_first() is created to alleviate the
>> need for two checks: aer_cap and get_firmware_first().
>>
>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>> ---
>>
>> Changes since v2:
>>    - Added missing negation in pci_cleanup_aer_error_status_regs()
>>
>>   drivers/pci/pcie/aer.c | 17 ++++++++++-------
>>   1 file changed, 10 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index a2e88386af28..40e5c86271d1 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -307,6 +307,12 @@ int pcie_aer_get_firmware_first(struct pci_dev *dev)
>>   		aer_set_firmware_first(dev);
>>   	return dev->__aer_firmware_first;
>>   }
>> +
>> +static bool pcie_aer_is_kernel_first(struct pci_dev *dev)
>> +{
>> +	return !!dev->aer_cap && !pcie_aer_get_firmware_first(dev);
>> +}
> 
> I think it complicates things to have both "firmware_first" and
> "kernel_first" interfaces, so I would prefer to stick with the
> existing "firmware_first" style.
> 
>>   #define	PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
>>   				 PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE)
>>   
>> @@ -337,10 +343,7 @@ bool aer_acpi_firmware_first(void)
>>   
>>   int pci_enable_pcie_error_reporting(struct pci_dev *dev)
>>   {
>> -	if (pcie_aer_get_firmware_first(dev))
>> -		return -EIO;
>> -
>> -	if (!dev->aer_cap)
>> +	if (!pcie_aer_is_kernel_first(dev))
>>   		return -EIO;
>>   
>>   	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS);
> 
> This change doesn't actually fix anything, does it?  It looks like a
> cleanup that doesn't change the behavior.

Initially (v1), this was a one-liner, but someone had a complaint about 
having pcie_aer_get_firmware_first() boilerplate all over the place. 
That's why I added the "kernel_first" function (previous comment), and 
then updated this here for completeness. I'm also fine with v1.

>> @@ -349,7 +352,7 @@ EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
>>   
>>   int pci_disable_pcie_error_reporting(struct pci_dev *dev)
>>   {
>> -	if (pcie_aer_get_firmware_first(dev))
>> +	if (!pcie_aer_is_kernel_first(dev))
>>   		return -EIO;
> 
> This change does effectively add a test for dev->aer_cap.  That makes
> sense in terms of symmetry with pci_enable_pcie_error_reporting(),
> but I think it should be a separate patch because it's conceptually
> separate from the change below.
> 
> We should keep the existing behavior (but add the symmetry) here for
> now, but it's not clear to me that these paths should care about AER
> or firmware-first at all.  PCI_EXP_DEVCTL is not an AER register and
> we have the _HPX mechanism for firmware to influence it (which these
> paths currently ignore).  I suspect we should program these reporting
> enable bits in the core enumeration path instead of having drivers
> call these interfaces.

The headache is that FFS needs the reporting bit to stay enabled in 
order to get AER notifications. Disabling things here could really break 
firmware. Of course, that's a cyclical argument, since FW is broken by 
definition.

> If/when we make changes along these lines, the history will be easier
> to follow if *this* change is not connected with the change below to
> pci_cleanup_aer_error_status_regs().

I agree. I think it might be preferred then to go with v1, and leave the 
refactoring to a later time, since the extra changes are cosmetical and 
social.

>>   	return pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
>> @@ -383,10 +386,10 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
>>   	if (!pci_is_pcie(dev))
>>   		return -ENODEV;
>>   
>> -	pos = dev->aer_cap;
>> -	if (!pos)
>> +	if (!pcie_aer_is_kernel_first(dev))
>>   		return -EIO;
> 
> This part makes sense to me, but I think I would rather have it match
> the existing style in pci_enable_pcie_error_reporting(), i.e., keep
> the test for dev->aer_cap and add a test for
> pcie_aer_get_firmware_first().

Had it that way in v1.

Alex

>> +	pos = dev->aer_cap;
>>   	port_type = pci_pcie_type(dev);
>>   	if (port_type == PCI_EXP_TYPE_ROOT_PORT) {
>>   		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &status);
>> -- 
>> 2.17.1
>>
