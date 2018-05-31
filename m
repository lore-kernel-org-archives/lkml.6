Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750830AbeEaVoV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 17:44:21 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:42777 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbeEaVoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 17:44:19 -0400
X-Google-Smtp-Source: ADUXVKJJ7kRQGmiXbnEddgsqF2lQZaurWFVmka9LLygE2ve91npkx4xxTi2RDNHS7k+h+1J/D5WufQ==
Subject: Re: [PATCH] PCI: Check for PCIe downtraining conditions
To: Sinan Kaya <okaya@codeaurora.org>, bhelgaas@google.com
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com,
        keith.busch@intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180531150535.9684-1-mr.nuke.me@gmail.com>
 <e137d5bf-b640-68ef-c07e-d872a9343548@codeaurora.org>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <3e0ddec1-649b-3e97-65e5-073dd9d45a1c@gmail.com>
Date: Thu, 31 May 2018 16:44:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <e137d5bf-b640-68ef-c07e-d872a9343548@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/31/2018 10:30 AM, Sinan Kaya wrote:
> On 5/31/2018 11:05 AM, Alexandru Gagniuc wrote:
>> +	if (dev_cur_speed < max_link_speed)
>> +		pci_warn(dev, "PCIe downtrain: link speed is %s (%s capable)",
>> +			 pcie_bus_speed_name(dev_cur_speed),
>> +			 pcie_bus_speed_name(max_link_speed));
>> +
> 
> Also this isn't quite correct. Target link speed is what the device tries to
> train. A device can try to train to much lower speed than the maximum on purpose.
> 
> It makes sense to print this if the speed that platform wants via target link
> speed is different from what is actually established though.

After seeing Gen 3 devices that train above the speed in the target link
speed field, I talked to one the spec writers today. There is some
ambiguity with the target link speed field. In PCIe 4.0 they are
clarifying that to state that this field is "permitted to have no effect".

Alex
