Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA16CECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1D120874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOcI+rnV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C1D120874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388551AbeGXRGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:06:43 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34260 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388324AbeGXRGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:06:43 -0400
Received: by mail-oi0-f66.google.com with SMTP id 13-v6so8430200ois.1;
        Tue, 24 Jul 2018 08:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Bq5wHhmbmGGbbZStcNtL2N8nEdzVdUrzgal6/FwqlK0=;
        b=OOcI+rnV0+cqG6t0HnpJKLPmeJ+V3tGUVOsrOImaMNI2klA/b+YLIaP8KlypaEBpPo
         JiiArL/L5TLA4r76v2Ve5tKDo8Y/a+W/nHwvgg8ubaslPLzhsDRueOg1MmmuCThTyFdn
         0hLi5pSj/QWWUq9oXE3YnxFUE/+UOTYk+uKm8LEebW1tYQraOxcFnnOQ4l7xnBznL46X
         bQA2Oep3thPvDcX8asSFgqtRr2objeczdFP0d5pcnsNMj8+4WYtNvVH1tucuQdCOIFVy
         3VNMp1BIwaYzbD7aj/kXPBEvBGlQofB4r3WPKxCw86CsEi83T1+PZALo+c8nI5V0iUxN
         2Scw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bq5wHhmbmGGbbZStcNtL2N8nEdzVdUrzgal6/FwqlK0=;
        b=QdaBq+dol/rPr2TslbNZEZt69d2qDJ2DqXBcG7ZFvEikZ8s1DSCmUas2j95Y6e8xvl
         BnbXkhYXCx6+gmTy26j4AS+iJraapqwhSsFmqcXqLZenNxTM41kSM7kx5cbHxZziZwnZ
         DJdHEW8OZn8DMpZbUfktl5aD/rIjwXE30IO/RZVyMaa1Kt4KtbhoRExLpjpJAqwNxU6e
         LHcxq+VS3AWKHSqUxlTfIVWSdy5QFStdCTP1Vcn7VrqONtXtRvN1QefMOHZG+I8hHdAZ
         IqJIQ0lMtFJHmYH0S6VUMG+RkrIP/7cq+apPcJKLdUfRTzpkomxByRxI0ShjKPTc/1JN
         WyEQ==
X-Gm-Message-State: AOUpUlFGTJ8A+xI3KN0qx9h1aE7ME08eVU1I4pEBZ7DEu9IMiBIfFeJ/
        vsc+0JR3mIAvUKM9z7koTW9IcHBlNjw=
X-Google-Smtp-Source: AAOMgpcYRiDy/4G0b/LNTfqDrF1soZmARartE+68KDqQ2KTPhtcz7ZLeGg3u3WLyzudm/VjVa01zDw==
X-Received: by 2002:aca:5004:: with SMTP id e4-v6mr4020910oib.111.1532447974214;
        Tue, 24 Jul 2018 08:59:34 -0700 (PDT)
Received: from nuclearis2-1.gtech (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id w204-v6sm14707285oif.2.2018.07.24.08.59.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 08:59:33 -0700 (PDT)
Subject: Re: [PATCH v2] PCI/AER: Do not clear AER bits if we don't own AER
To:     linux-pci@vger.kernel.org, bhelgaas@google.com
Cc:     keith.busch@intel.com, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        Frederick Lawler <fred@fredlawl.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oza Pawandeep <poza@codeaurora.org>,
        linux-kernel@vger.kernel.org
References: <20180717153135.25925-1-mr.nuke.me@gmail.com>
 <20180723165251.11424-1-mr.nuke.me@gmail.com>
From:   "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <3d05f662-2c29-90cd-9c74-6456939a0e6b@gmail.com>
Date:   Tue, 24 Jul 2018 10:59:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180723165251.11424-1-mr.nuke.me@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/23/2018 11:52 AM, Alexandru Gagniuc wrote:
> When we don't own AER, we shouldn't touch the AER error bits. Clearing
> error bits willy-nilly might cause firmware to miss some errors. In
> theory, these bits get cleared by FFS, or via ACPI _HPX method. These
> mechanisms are not subject to the problem.
> 
> This race is mostly of theoretical significance, since I can't
> reasonably demonstrate this race in the lab.
> 
> On a side-note, pcie_aer_is_kernel_first() is created to alleviate the
> need for two checks: aer_cap and get_firmware_first().
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>   drivers/pci/pcie/aer.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index a2e88386af28..85c3e173c025 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -307,6 +307,12 @@ int pcie_aer_get_firmware_first(struct pci_dev *dev)
>   		aer_set_firmware_first(dev);
>   	return dev->__aer_firmware_first;
>   }
> +
> +static bool pcie_aer_is_kernel_first(struct pci_dev *dev)
> +{
> +	return !!dev->aer_cap && !pcie_aer_get_firmware_first(dev);
> +}
> +
>   #define	PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
>   				 PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE)
>   
> @@ -337,10 +343,7 @@ bool aer_acpi_firmware_first(void)
>   
>   int pci_enable_pcie_error_reporting(struct pci_dev *dev)
>   {
> -	if (pcie_aer_get_firmware_first(dev))
> -		return -EIO;
> -
> -	if (!dev->aer_cap)
> +	if (!pcie_aer_is_kernel_first(dev))
>   		return -EIO;
>   
>   	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS);
> @@ -349,7 +352,7 @@ EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
>   
>   int pci_disable_pcie_error_reporting(struct pci_dev *dev)
>   {
> -	if (pcie_aer_get_firmware_first(dev))
> +	if (!pcie_aer_is_kernel_first(dev))
>   		return -EIO;
>   
>   	return pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
> @@ -383,10 +386,10 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
>   	if (!pci_is_pcie(dev))
>   		return -ENODEV;
>   
> -	pos = dev->aer_cap;
> -	if (!pos)
> +	if (pcie_aer_is_kernel_first(dev))

This here is missing a '!'. It's in my local branch, so I must have 
exported the patch before I fixed that. I'll get that fixed next rev.

>   		return -EIO;
>   
> +	pos = dev->aer_cap;
>   	port_type = pci_pcie_type(dev);
>   	if (port_type == PCI_EXP_TYPE_ROOT_PORT) {
>   		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &status);
> 
