Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964784AbeE3Clw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 22:41:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45014 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbeE3Cls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 22:41:48 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 075B960242
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH V2] PCI/portdrv: do not disable device on reboot/shutdown
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org, ryan@finnie.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        stable@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Frederick Lawler <fred@fredlawl.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Don Brace <don.brace@microsemi.com>, esc.storagedev@microsemi.com,
        linux-scsi@vger.kernel.org
References: <1527043490-17268-1-git-send-email-okaya@codeaurora.org>
 <20180523213249.GD150632@bhelgaas-glaptop.roam.corp.google.com>
 <61f70fd6-52fd-da07-ce73-303f95132131@codeaurora.org>
 <20180524183502.GB85822@bhelgaas-glaptop.roam.corp.google.com>
 <984b9734-244d-04e9-946f-7524f148ff7c@codeaurora.org>
 <20180525221024.GC92995@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <8eacc568-af8c-a990-ee96-d13e669e8643@codeaurora.org>
Date: Tue, 29 May 2018 19:41:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180525221024.GC92995@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn,

On 5/25/2018 3:10 PM, Bjorn Helgaas wrote:
> On Fri, May 25, 2018 at 09:30:59AM -0400, Sinan Kaya wrote:
>> On 5/24/2018 2:35 PM, Bjorn Helgaas wrote:
>>> That sounds like a reasonable idea, and it is definitely another can
>>> of worms.  I looked briefly at some of the .shutdown() cases:
>>
>> should we throw it into 4.18 and see what happens?
> 
> It wouldn't solve this particular problem because hpsa *does* have a
> .shutdown() method.  The problem is that it doesn't work -- it's
> supposed to stop DMA and interrupts but it apparently doesn't.
> 
> I think we need to fix hpsa first.
> 

I don't know if you followed my latest V3 patch but I found a way to put
these two together to reach to an, IMO, more acceptable solution.

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
