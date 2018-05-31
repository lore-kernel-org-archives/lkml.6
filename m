Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932728AbeEaPab (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 11:30:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37118 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932704AbeEaPa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 11:30:28 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4999660261
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH] PCI: Check for PCIe downtraining conditions
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>, bhelgaas@google.com
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com,
        keith.busch@intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180531150535.9684-1-mr.nuke.me@gmail.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <e137d5bf-b640-68ef-c07e-d872a9343548@codeaurora.org>
Date: Thu, 31 May 2018 11:30:24 -0400
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
> +	if (dev_cur_speed < max_link_speed)
> +		pci_warn(dev, "PCIe downtrain: link speed is %s (%s capable)",
> +			 pcie_bus_speed_name(dev_cur_speed),
> +			 pcie_bus_speed_name(max_link_speed));
> +

Also this isn't quite correct. Target link speed is what the device tries to
train. A device can try to train to much lower speed than the maximum on purpose.

It makes sense to print this if the speed that platform wants via target link
speed is different from what is actually established though.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
