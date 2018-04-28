Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933447AbeD1H3N (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 03:29:13 -0400
Received: from david.siemens.de ([192.35.17.14]:54440 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753203AbeD1H3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 03:29:12 -0400
Subject: Re: [PATCH 3/6] PCI: Introduce devm_of_pci_get_host_bridge_resources
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1524582822.git.jan.kiszka@siemens.com>
 <e387d04ea235c9a4879a897bb730adc383a96635.1524582822.git.jan.kiszka@siemens.com>
 <20180427222427.GB73638@bhelgaas-glaptop.roam.corp.google.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <869a8ad9-dd2f-8462-c0c4-2d8a62d74185@siemens.com>
Date: Sat, 28 Apr 2018 09:28:47 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <20180427222427.GB73638@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-28 00:24, Bjorn Helgaas wrote:
> On Tue, Apr 24, 2018 at 05:13:39PM +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> of_pci_get_host_bridge_resources allocates the resource structures it
>> fills dynamically, but none of its callers care to release them so far.
>> Rather than requiring everyone to do this explicitly, introduce a
>> managed version of that service. This differs API-wise only in taking a
>> reference to the associated device, rather than to the device tree node.
>>
>> As of_pci_get_host_bridge_resources is an exported interface, we cannot
>> simply drop it at this point. After converting all in-tree users to the
>> new API, we could phase out the unmanaged one over some grace period.
> 
> It looks like it might be possible to split this into three or four
> patches:
> 
>   1) Factor __of_pci_get_host_bridge_resources() out of
>      of_pci_get_host_bridge_resources()
> 
>   2) Add struct device * argument
> 
>   3) Convert pr_info() to dev_info()
> 
>   4) Add devm_of_pci_get_host_bridge_resources()

Will do. I'm even considering

5) mark of_pci_get_host_bridge_resources() __deprecated, due to the leak
   and no remaining in-tree user - what do you think?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
