Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-865074-1527116249-2-8366053183093039544
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527116248; b=IzVX83wh8aUtT5tIjlmluvBXtiP+cHm0DPpSBmJMQUnH4GIXZg
    lY7OLav4svjEKgr6yqhUIrtCTvCZdjZZf6aEhCnwpH7OOIqQZ8xbW+P0loi//wQO
    sHViBkfqNJ4fjkCGwNXEgr7Wug9wh9jccnYK6b9wD43DkmuwMlgrKDKbJcCNd97t
    IW+sfAwW45zEyZk8HwmJZl3VprpzzfZDUkqhJOGFuLZSki/0lU3bOvoJmK3zZ4pl
    tvLShugj/bkxa46+CAuPo0hkNtho9cjFeyOOzrtpd3ejTue5wOsUv+CpFFXY+0fm
    AWCaaIHh22nHo1Bh6ELVr8ba7TaRSr8xHwWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527116248;
    bh=H6OQ1h51K420yHqAE9pPDhnrst9JZs25/VTTXsDxrqI=; b=CmfIO+LIIBeT
    y5qVoQ2gbm9phvdl+clsqywmvJRRSyzXOVQUZDdZiwPYxkjsUmLvC9/8xsapLzR4
    FSV9kY8PmJ9xBbw1FxF4LCoYT2nLkAYwieTwT5c1Fg2n+WAtanHf3896Qx9PE8mi
    1PcbkrcNoXWRweD/CDYAY71CWl7kLAFVkJY68Tc7/ZuzQZ1hhcUlTKhpdlzGcJ61
    rz40YqWq1LZA9hZ1WHTU6h/eitBYpxCAB3853jTzDQPnpQq7KfR2kFoNe4IAZGAM
    8bLAdHv73xuof8ziaU/3lwUpJ3b1pjcgMNf2BAfaWSTkMma7Z3NibZ/kMhrW6JqY
    ApsYO9NtIA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org
    header.i=@codeaurora.org header.b=A9CQ606S x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org
    header.i=@codeaurora.org header.b=kDu+x03+ x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=codeaurora.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org
      header.i=@codeaurora.org header.b=A9CQ606S x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org
      header.i=@codeaurora.org header.b=kDu+x03+ x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=codeaurora.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOP5VQBsKN9afhU23kmesFeCd/UtAZYe8Oo7ccxEuGE8rokRearCdy4yxR4gCwLXYMWks7e/rOZwKRjVNYnNjvs6JsUiBgOy35DuWHgcwqyXAj8rxwts
    ltk34Z1BWowpNPUKQyagsEaumIt8+NvKsOpAIiWflNRNHiyzXl+aG0Gm9yFGCcN2ZyZxBfQ9JbtS2y2M4j6aWk6Z/SaGGqQ8KoKak/rAWjlD2ZAdMXEo/kfg
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=V1tP6XUCybAbTSWtVokA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934909AbeEWW5Z (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 18:57:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55854 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934544AbeEWW5X (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 23 May 2018 18:57:23 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 87D966047C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH V2] PCI/portdrv: do not disable device on reboot/shutdown
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org, ryan@finnie.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Frederick Lawler <fred@fredlawl.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Don Brace <don.brace@microsemi.com>,
        esc.storagedev@microsemi.com, linux-scsi@vger.kernel.org
References: <1527043490-17268-1-git-send-email-okaya@codeaurora.org>
 <20180523213249.GD150632@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <61f70fd6-52fd-da07-ce73-303f95132131@codeaurora.org>
Date: Wed, 23 May 2018 18:57:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180523213249.GD150632@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 5/23/2018 5:32 PM, Bjorn Helgaas wrote:
> 
> The crash seems to indicate that the hpsa device attempted a DMA after
> we cleared the Root Port's PCI_COMMAND_MASTER, which means
> hpsa_shutdown() didn't stop DMA from the device (it looks like *most*
> shutdown methods don't disable device DMA, so it's in good company).

All drivers are expected to shutdown DMA and interrupts in their shutdown()
routines. They can skip removing threads, data structures etc. but DMA and
interrupt disabling are required. This is the difference between shutdown()
and remove() callbacks.

If you see that this is not being done in HPSA, then that is where the
bugfix should be.

Counter argument is that if shutdown() is not implemented, at least remove()
should be called. Expecting all drivers to implement shutdown() callbacks
is just bad by design in my opinion. 

Code should have fallen back to remove() if shutdown() doesn't exist.
I can propose a patch for this but this is yet another story to chase.

> 
>> This has been found to cause crashes on HP DL360 Gen9 machines during
>> reboot. Besides, kexec is already clearing the bus master bit in
>> pci_device_shutdown() after all PCI drivers are removed.
> 
> The original path was:
> 
>   pci_device_shutdown(hpsa)
>     drv->shutdown
>       hpsa_shutdown                     # hpsa_pci_driver.shutdown
>   ...
>   pci_device_shutdown(RP)               # root port
>     drv->shutdown
>       pcie_portdrv_remove               # pcie_portdriver.shutdown
>         pcie_port_device_remove
>           pci_disable_device
>             do_pci_disable_device
>               # clear RP PCI_COMMAND_MASTER
>     if (kexec)
>       pci_clear_master(RP)
>         # clear RP PCI_COMMAND_MASTER
> 
> If I understand correctly, the new path after this patch is:
> 
>   pci_device_shutdown(hpsa)
>     drv->shutdown
>       hpsa_shutdown                     # hpsa_pci_driver.shutdown
>   ...
>   pci_device_shutdown(RP)               # root port
>     drv->shutdown
>       pcie_portdrv_shutdown             # pcie_portdriver.shutdown
>         __pcie_portdrv_remove(RP, false)
>           pcie_port_device_remove(RP, false)
>             # do NOT clear RP PCI_COMMAND_MASTER

yup

>     if (kexec)
>       pci_clear_master(RP)
>         # clear RP PCI_COMMAND_MASTER
> 
> I guess this patch avoids the panic during reboot because we're not in
> the kexec path, so we never clear PCI_COMMAND_MASTER for the Root
> Port, so the hpsa device can DMA happily until the lights go out.
> 
> But DMA continuing for some random amount of time before the reboot or
> shutdown happens makes me a little queasy.  That doesn't sound safe.
> The more I think about this, the more confused I get.  What am I
> missing?  

see above.

> 
>> Just remove the extra clear in shutdown path by seperating the remove and
>> shutdown APIs in the PORTDRV.
>>
>>  static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
>> @@ -218,7 +228,7 @@ static struct pci_driver pcie_portdriver = {
>>  
>>  	.probe		= pcie_portdrv_probe,
>>  	.remove		= pcie_portdrv_remove,
>> -	.shutdown	= pcie_portdrv_remove,
>> +	.shutdown	= pcie_portdrv_shutdown,
> 
> What are the circumstances when we call .remove() vs .shutdown()?
> 
> I guess the main (maybe only) way to call .remove() is to hot-remove
> the port?  And .shutdown() is basically used in the reboot and kexec
> paths?

Correct. shutdown() is only called during reboot/shutdown calls. If you echo
1 into the remove file, remove() gets called. Handy for hotplug use cases.
It needs to be the exact opposite of the probe. It needs to clean up resources
etc. and have the HW in a state where it can be reinitialized via probe again.

> 
>>  	.err_handler	= &pcie_portdrv_err_handler,
>>  
>> -- 
>> 2.7.4
>>
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
