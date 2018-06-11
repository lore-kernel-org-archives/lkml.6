Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id d2DkJ8pvHluZZwAAmS7hNA
	; Mon, 11 Jun 2018 12:50:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A75F760850; Mon, 11 Jun 2018 12:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528721434;
	bh=kUQlAqksyRS9MZRDyWvvPVJT9UNo8GREOZoL0LC6d/0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=JCA4yHVMBoLcS+EtKW3hPVhDWF5CKZpp0iRIlh1H8cRX2TRT1GZEAIfdYupOY99sT
	 Or6ifqXrbJ8tV8w9KnfTu+zvGVxRs5dtJifNuaLgBEjsCeyknnjfg9jO4Cnwu+pjv6
	 jQuYycN57J44JLaSTYFxfoaolnk9+RmJeD08kfGo=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0D9AA601C3;
	Mon, 11 Jun 2018 12:50:34 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="POBBPTDT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Mi3KHOu5"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0D9AA601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932993AbeFKMuc (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 08:50:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50014 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932607AbeFKMub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 08:50:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A0598601C3; Mon, 11 Jun 2018 12:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528721430;
        bh=kUQlAqksyRS9MZRDyWvvPVJT9UNo8GREOZoL0LC6d/0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=POBBPTDTjU4/3BqEWkRAfFIPWKJL0okDdvdzEbq63i5v9NoS67r/RINQCWLutIGjg
         UeNrjpA72UDsVCDWnvaTsByupnAHLT71cCktBx+vsR2B8BhrwkT8xYFOqbBsHeJb9n
         x1IiGD7V+KDOnhhiMpTs9cf42xT3ppXe7/hCVq6g=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 47D89601C3;
        Mon, 11 Jun 2018 12:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528721429;
        bh=kUQlAqksyRS9MZRDyWvvPVJT9UNo8GREOZoL0LC6d/0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Mi3KHOu5iYOU1XggVv5layjeH6nnJ/l8xG9qJI0ddjT5TzZgNMrPEXPezSVZtQRKl
         DFIy42utqmBILjmXZBZ3hYpzC9fkIW1syvnmszqmj/hnjNTNihFBTMuYq55g2QVBfO
         DIPGHnysyFIAJ4eRNOK2IN7Z9JnUbyvnxL839Zls=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 11 Jun 2018 18:20:29 +0530
From: poza@codeaurora.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>,
        linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH NEXT 6/6] PCI/PORTDRV: Remove ERR_FATAL handling from
 pcie_portdrv_slot_reset()
In-Reply-To: <50f38cb058b29f84ca60a19825efd28a@codeaurora.org>
References: <1528351234-26914-1-git-send-email-poza@codeaurora.org>
 <1528351234-26914-6-git-send-email-poza@codeaurora.org>
 <94661add3e71e3694aa22c2a9cabf503@codeaurora.org>
 <20180607213448.GB37077@bhelgaas-glaptop.roam.corp.google.com>
 <50f38cb058b29f84ca60a19825efd28a@codeaurora.org>
Message-ID: <c079ffe5ac8e0504eea3efb71a056b94@codeaurora.org>
X-Sender: poza@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-11 15:31, poza@codeaurora.org wrote:
> On 2018-06-08 03:04, Bjorn Helgaas wrote:
>> On Thu, Jun 07, 2018 at 07:18:03PM +0530, poza@codeaurora.org wrote:
>>> On 2018-06-07 11:30, Oza Pawandeep wrote:
>>> > We are handling ERR_FATAL by resetting the Link in software,skipping the
>>> > driver pci_error_handlers callbacks, removing the devices from the PCI
>>> > subsystem, and re-enumerating, as a result of that, no more calling
>>> > pcie_portdrv_slot_reset in ERR_FATAL case.
>>> >
>>> > Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
>>> >
>>> > diff --git a/drivers/pci/pcie/portdrv_pci.c
>>> > b/drivers/pci/pcie/portdrv_pci.c
>>> > index 973f1b8..92f5d330 100644
>>> > --- a/drivers/pci/pcie/portdrv_pci.c
>>> > +++ b/drivers/pci/pcie/portdrv_pci.c
>>> > @@ -42,17 +42,6 @@ __setup("pcie_ports=", pcie_port_setup);
>>> >
>>> >  /* global data */
>>> >
>>> > -static int pcie_portdrv_restore_config(struct pci_dev *dev)
>>> > -{
>>> > -	int retval;
>>> > -
>>> > -	retval = pci_enable_device(dev);
>>> > -	if (retval)
>>> > -		return retval;
>>> > -	pci_set_master(dev);
>>> > -	return 0;
>>> > -}
>>> > -
>>> >  #ifdef CONFIG_PM
>>> >  static int pcie_port_runtime_suspend(struct device *dev)
>>> >  {
>>> > @@ -162,14 +151,6 @@ static pci_ers_result_t
>>> > pcie_portdrv_mmio_enabled(struct pci_dev *dev)
>>> >
>>> >  static pci_ers_result_t pcie_portdrv_slot_reset(struct pci_dev *dev)
>>> >  {
>>> > -	/* If fatal, restore cfg space for possible link reset at upstream */
>>> > -	if (dev->error_state == pci_channel_io_frozen) {
>>> > -		dev->state_saved = true;
>>> > -		pci_restore_state(dev);
>>> > -		pcie_portdrv_restore_config(dev);
>>> > -		pci_enable_pcie_error_reporting(dev);
>>> > -	}
>>> > -
>>> >  	return PCI_ERS_RESULT_RECOVERED;
>>> >  }
>>> 
>>> 
>>> Hi Bjorn,
>>> 
>>> the above patch removes ERR_FATAL handling from 
>>> pcie_portdrv_slot_reset()
>>> because now we are handling ERR_FATAL differently than before.
>>> 
>>> I tried to dig into pcie_portdrv_slot_reset() handling for ERR_FATAL 
>>> case
>>> where it
>>> restores the config space, enable device, set master and enable error
>>> reporting....
>>> and as far as I understand this is being done for upstream link 
>>> (bridges
>>> etc..)
>>> 
>>> why was it done at the first point (I checked the commit description, 
>>> but
>>> could not really get it)
>>> and do we need to handle the same thing in ERR_FATAL now ?
>> 
>> You mean 4bf3392e0bf5 ("PCI-Express AER implemetation: pcie_portdrv
>> error handler"), which added pcie_portdrv_slot_reset()?  I agree, that
>> commit log has no useful information.  I don't know any of the history
>> behind it.
> 
> Hi Bjorn and Keith,
> 
> broadcast_error_message()
> if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
>         .....
>         pci_walk_bus(dev->subordinate, cb, &result_data);
> 
> 
> so in case of ERR_FATAL, the walk bus is happening on subordinates,
> and if I understand the walk right
> then, pcie_portdrv_slot_reset() is called only on BRIDGES/Switches
> 
> If is never called on Root-Ports
> 
> having said that, now since we are removing the devices (compare to
> previous error callback handling in ERR_FATAL)
> I dont see the need of the above code anymore.
> 

when I say above code, I meant this patch itself which removes ERR_FATAL 
handling out of pcie_portdrv_slot_reset

> because there is nothing to restore to any more. as we are initiating
> re-enumeration.
> 
> Regards,
> Oza.
