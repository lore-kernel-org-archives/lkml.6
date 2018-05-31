Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755545AbeEaP2O (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 11:28:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36320 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755421AbeEaP2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 11:28:10 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6664D60261
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH] PCI: Check for PCIe downtraining conditions
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>, bhelgaas@google.com
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com,
        keith.busch@intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180531150535.9684-1-mr.nuke.me@gmail.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <28004506-24f0-6d10-2d1e-074e0483d2f9@codeaurora.org>
Date: Thu, 31 May 2018 11:28:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180531150535.9684-1-mr.nuke.me@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/2018 11:05 AM, Alexandru Gagniuc wrote:
> +static void pcie_max_link_cap(struct pci_dev *dev, enum pci_bus_speed *speed,
> +				enum pcie_link_width *width)
> +{
> +	uint32_t lnkcap;
> +
> +	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
> +
> +	*speed = pcie_link_speed[lnkcap & PCI_EXP_LNKCAP_SLS];
> +	*width = (lnkcap & PCI_EXP_LNKCAP_MLW) >> PCI_EXP_LNKCAP_MLW_SHIFT;
> +}
> +
> +static void pcie_cur_link_sta(struct pci_dev *dev, enum pci_bus_speed *speed,
> +				enum pcie_link_width *width)
> +{
> +	uint16_t lnksta;
> +
> +	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
> +	*speed = pcie_link_speed[lnksta & PCI_EXP_LNKSTA_CLS];
> +	*width = (lnksta & PCI_EXP_LNKSTA_NLW) >> PCI_EXP_LNKSTA_NLW_SHIFT;
> +}
> +
> +static const char *pcie_bus_speed_name(enum pci_bus_speed speed)
> +{
> +	switch (speed) {
> +	case PCIE_SPEED_2_5GT:
> +		return "2.5 GT/s";
> +	case PCIE_SPEED_5_0GT:
> +		return "5.0 GT/s";
> +	case PCIE_SPEED_8_0GT:
> +		return "8.0 GT/s";
> +	default:
> +		return "unknown";
> +	}
> +}

I thought Bjorn added some functions to retrieve this now.


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
