Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753864AbeEWDTM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 23:19:12 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:37559 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753745AbeEWDTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 23:19:11 -0400
X-Google-Smtp-Source: AB8JxZrdzvcC7+ooCodL0CXrGzcEX/auJtXHOOZ5j03USdgorIpAGg/ydywKv+3uCkFg5VigEeci8Q==
Subject: Re: Difference between IOVA and bus address when SMMU is enabled
To: Russell King - ARM Linux <linux@armlinux.org.uk>
References: <c4fe00a3-33b1-7cd4-f613-768dee06ef6b@gmail.com>
 <20180514105303.GE16141@n2100.armlinux.org.uk>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
From: valmiki <valmikibow@gmail.com>
Message-ID: <e8377eb2-3d68-1809-0abd-2a4f4b9acaa1@gmail.com>
Date: Wed, 23 May 2018 08:48:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180514105303.GE16141@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, May 12, 2018 at 06:25:13PM +0530, valmiki wrote:
>> Hi All,
>>
>> What is the difference between IOVA address and bus address
>> when SMMU is enabled ?
>>
>> Is IOVA address term used only when hypervisor is present ?
>
> IOVA = IO virtual address.  IOVA is the term normally used to describe
> the address used on the _device_ side of an IOMMU.
>
> For any general setup:
>
> RAM ----- MMU ----- DEVICE
>       ^         ^
>   physical   virtual
>   address    address
>
> where "device" can be an IO device or a CPU, the terms still apply.
>
> If you have something like this:
>
> RAM ----- PCI bridge ----- MMU ----- DEVICE
>       ^                ^         ^
>    physical           bus     virtual
>    address          address   address
>
> You could also have (eg, in the case of a system MMU):
>
> RAM ----- MMU ----- PCI bridge ----- DEVICE
>       ^         ^                ^
>    physical  virtual            bus
>    address   address          address
>            (this can also be
>             considered a bus
>             address!)
>
> In both of the above two cases, the PCI bridge may perform some address
> translation, meaning that the bus address is different from the address
> seen on the other side of the bridge.
>
> So, the terms used depend exactly on the overall bus topology.
>
> In the case of a system MMU, where the system MMU sits between peripheral
> devices and RAM, then the bus addresses are the same as the
> _IOVA of the system MMU_.
>
Thanks Russell.

---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus
