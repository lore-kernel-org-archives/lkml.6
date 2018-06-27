Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BED5C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF84260C1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Y8yVI4kC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEF84260C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964963AbeF0NM2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 09:12:28 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:42318 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753493AbeF0NM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 09:12:27 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w5RDCI9m010088;
        Wed, 27 Jun 2018 08:12:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530105138;
        bh=ey5u7I648xzHTMX33iXNnhy7yEOj1JJHOaNvQrhS9H0=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=Y8yVI4kCbP9BUGIAHRC+MFQtLwa3BOevnWaFe6XQ745BFAYgNRbpmWKmhlFKUrR4L
         /TqKLqD/R1pevegBl/jPWQgPUKNsNSTFoxj9jRRpX61FcgK8J60U0n9aWLRvad7ObE
         ONFk9mbwTaX1bel8XRLQcJ/4Ha4FXR5zdXfTNzFY=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5RDCI0X024278;
        Wed, 27 Jun 2018 08:12:18 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 27
 Jun 2018 08:12:18 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 27 Jun 2018 08:12:18 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5RDCGhZ031989;
        Wed, 27 Jun 2018 08:12:16 -0500
Subject: Re: [lkp-robot] [bisect done] ef1433f717 [ 7.049860] BUG: unable to
 handle kernel NULL pointer dereference at 0000004c
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <20180626011007.GI11011@yexl-desktop>
 <20180626211501.GC181504@bhelgaas-glaptop.roam.corp.google.com>
 <20180627102620.GA7893@red-moon>
CC:     kernel test robot <lkp@intel.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, LKP <lkp@01.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <582e6414-1a06-7521-c602-1eb77f6c67ba@ti.com>
Date:   Wed, 27 Jun 2018 18:42:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180627102620.GA7893@red-moon>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday 27 June 2018 03:56 PM, Lorenzo Pieralisi wrote:
> On Tue, Jun 26, 2018 at 04:15:01PM -0500, Bjorn Helgaas wrote:
>> On Tue, Jun 26, 2018 at 09:10:07AM +0800, kernel test robot wrote:
>>>
>>> Greetings,
>>>
>>> 0day kernel testing robot got the below dmesg and the first bad commit is
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>>
>>> commit ef1433f717a2c63747a519d86965d73ff9bd08b3
>>> Author:     Kishon Vijay Abraham I <kishon@ti.com>
>>> AuthorDate: Mon Apr 2 18:59:35 2018 +0530
>>> Commit:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>> CommitDate: Fri May 18 16:40:50 2018 +0100
>>>
>>>     PCI: endpoint: Create configfs entry for each pci_epf_device_id table entry
>>>     
>>>     In order to be able to provide correct driver_data for pci_epf device,
>>>     a separate configfs entry for each pci_epf_device_id table entry in
>>>     pci_epf_driver is required.
>>>     
>>>     Add support to create configfs entry for each pci_epf_device_id
>>>     table entry here.
>>>     
>>>     Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>     Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>>     Tested-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>>
>> From the .config below:
>>
>>   # CONFIG_PCI_ENDPOINT_CONFIGFS is not set
>>
>> From include/linux/pci-ep-cfs.h:
>>
>>   #ifdef CONFIG_PCI_ENDPOINT_CONFIGFS
>>   ...
>>   #else
>>   static inline struct config_group *pci_ep_cfs_add_epf_group(const char *name)
>>   {
>>         return 0;
>>   }
>>
>> From ef1433f717a2:
>>
>>   +       id = driver->id_table;
>>   +       while (id->name[0]) {
>>   +               group = pci_ep_cfs_add_epf_group(id->name);
>>   +               mutex_lock(&pci_epf_mutex);
>>   +               list_add_tail(&group->group_entry, &driver->epf_group);
>>
>> Obviously group == 0 and the list_add_tail() is a NULL pointer
>> dereference.
>>
>> Looks like we need either some sort of #ifdef CONFIG_PCI_ENDPOINT_CONFIGFS
>> in __pci_epf_register_driver() and pci_epf_unregister_driver(), or
>> higher-level interfaces and corresponding stubs that add/remove all
>> the IDs.
> 
> Yes, probably augment pci_ep_cfs_add_epf_group() to take a driver
> pointer so that adding a group is a NOP on !CONFIG_PCI_ENDPOINT_CONFIGFS.
> 
> Kishon can you please post a fix as soon as you can, thanks.

sure, I'll try to post before this week.

Thanks
Kishon
