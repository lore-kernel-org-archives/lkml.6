Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id oj6qJmxdGlvecgAAmS7hNA
	; Fri, 08 Jun 2018 10:41:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E0502607A4; Fri,  8 Jun 2018 10:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528454513;
	bh=v3t0PhZ74ybrF1oORUL7RujkrpRduZq5deadDr70qUc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=nPi/OxcsbCW0iTgh+mLzYZKe7DaC5H3WlgsCec6KYIPLFWq7gABEB0g1b2AEjOuV7
	 fiCj/Dmis2g29Tz0oCXgSjD+f9kru0FO0u8H1jwL5ugLO9Z6ct9AZtPBP403Q+I9mr
	 beOHPAi+drhMY28lnEiA2rYfdGYWIE18kDx68sHs=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 52046607E4;
	Fri,  8 Jun 2018 10:41:53 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VkWWUw8g";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VfzqzRBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 52046607E4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751486AbeFHKlv (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 06:41:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39914 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751056AbeFHKlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 06:41:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 45749608BF; Fri,  8 Jun 2018 10:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528454509;
        bh=v3t0PhZ74ybrF1oORUL7RujkrpRduZq5deadDr70qUc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VkWWUw8gplJ87bOa8HTxo1V7PssycyLzajwe1VrU2vClGGfsuTQmi9nc29hYpT7V4
         CTtDmMdqXUU+SWieEMaRFzONlx0AJQtsLBQtasF0B1t7U76YpMTKPKKlzzk6obe9xA
         p65pr4/3Jy9jzp2eJN1RTHaTkl2GSvkD06lUsHpo=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 23DB6607A4;
        Fri,  8 Jun 2018 10:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528454508;
        bh=v3t0PhZ74ybrF1oORUL7RujkrpRduZq5deadDr70qUc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VfzqzRBA5SakpynClGbZN8ldaRNwVk5L6kn/U3iD029tCZa4tHyZQgyWPlxQJ0NRz
         h+iGoF8HYWcimpyHbRHBBBR7B318Oql5pc2QxdgPCWYShYLqKw16KMTOyf41KccJgp
         /9bPWsDGa4TfPCQgX4JKK6ytU9QM9cUC3RmLOyYg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 08 Jun 2018 06:41:48 -0400
From: okaya@codeaurora.org
To: poza@codeaurora.org
Cc: Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Timur Tabi <timur@codeaurora.org>,
        linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH NEXT 6/6] PCI/PORTDRV: Remove ERR_FATAL handling from
 pcie_portdrv_slot_reset()
In-Reply-To: <bbce31a6e59fdfa00e565e09dcae9eea@codeaurora.org>
References: <1528351234-26914-1-git-send-email-poza@codeaurora.org>
 <1528351234-26914-6-git-send-email-poza@codeaurora.org>
 <94661add3e71e3694aa22c2a9cabf503@codeaurora.org>
 <20180607213448.GB37077@bhelgaas-glaptop.roam.corp.google.com>
 <bbce31a6e59fdfa00e565e09dcae9eea@codeaurora.org>
Message-ID: <eaa6c04259f0b41d5281d24c7422f914@codeaurora.org>
X-Sender: okaya@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-08 00:57, poza@codeaurora.org wrote:
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
> 
> Yes Bjorn thats right.
> I am trying to understand it but no clue.
> since it is restoring the stuffs in ERR_FATAL case, why would PCIe
> bridge loose all the settings ?  [config space, aer bits, master,
> device enable etc..)
> Max we do is link_reset in ERR_FATAL case, and Secondary bus reset
> should affect downstream components (not upstream)

Our first generation controller had this problem. There could be others 
too.
