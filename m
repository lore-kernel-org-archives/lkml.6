Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id +5K4H3AKGluBKwAAmS7hNA
	; Fri, 08 Jun 2018 04:47:48 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C36FD607E4; Fri,  8 Jun 2018 04:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528433268;
	bh=JTFDRi9JpV/X6zb0gov7ly3y105i8yN7RQWXhJ2ZtZY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=fTATh+Rwfz3gd2Hpw+bW+MxDJ7low9TD5afeS3nkW9JYidVcoyDlIritl3auZb9kc
	 8PTYESd95GWvsjDnV2YBHT/XKoa26W2w63G2QgOTGquqVLr8NMAaBgIiiI4RK6VM8J
	 RdatOTnP7zYB5oCRObcquozHAgQ1JIAAwbVlMjqk=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EB864601C3;
	Fri,  8 Jun 2018 04:47:47 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gJ42JMY4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="O4PcSWwe"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EB864601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751220AbeFHErp (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 00:47:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55744 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbeFHEro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 00:47:44 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8BEDF608C9; Fri,  8 Jun 2018 04:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528433263;
        bh=JTFDRi9JpV/X6zb0gov7ly3y105i8yN7RQWXhJ2ZtZY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gJ42JMY4D3ExorL2U6YTgk5LQdCjj2CkuI6UyWUhdOiHtDXhgdkHJOF6OHL9OX2LY
         FH89/WRzEp3CTUQb5yqaFdPhS3oc/FiiSwgIedL5VOl77QhTUX/ML6uFDylc854G5N
         D6oNhxKuX0XAlbkbiDMYH9qb3v5JFZNRIE//vI8Q=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 6A3FF6063F;
        Fri,  8 Jun 2018 04:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528433262;
        bh=JTFDRi9JpV/X6zb0gov7ly3y105i8yN7RQWXhJ2ZtZY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O4PcSWweZY1o+wx9M32BkIcDLpI3f5rQCumCgN79Y5AVX0T2UUN6WN2py5hJJnUmk
         CpHrAkjIbo+rppS+2ZvGULFfD+cquH7IGXV8jfRuReDF1Le/N6z0Sg5rshngzqCiq2
         YDwupiOo01fY/RFSEmzLd65ya7xweyJadaa0E+cM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 08 Jun 2018 10:17:42 +0530
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
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH NEXT 6/6] PCI/PORTDRV: Remove ERR_FATAL handling from
 pcie_portdrv_slot_reset()
In-Reply-To: <20180607213448.GB37077@bhelgaas-glaptop.roam.corp.google.com>
References: <1528351234-26914-1-git-send-email-poza@codeaurora.org>
 <1528351234-26914-6-git-send-email-poza@codeaurora.org>
 <94661add3e71e3694aa22c2a9cabf503@codeaurora.org>
 <20180607213448.GB37077@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <f9a6f1ae2e7c17f87e465e643c8e6dcc@codeaurora.org>
X-Sender: poza@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-08 03:04, Bjorn Helgaas wrote:
> On Thu, Jun 07, 2018 at 07:18:03PM +0530, poza@codeaurora.org wrote:
>> On 2018-06-07 11:30, Oza Pawandeep wrote:
>> > We are handling ERR_FATAL by resetting the Link in software,skipping the
>> > driver pci_error_handlers callbacks, removing the devices from the PCI
>> > subsystem, and re-enumerating, as a result of that, no more calling
>> > pcie_portdrv_slot_reset in ERR_FATAL case.
>> >
>> > Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
>> >
>> > diff --git a/drivers/pci/pcie/portdrv_pci.c
>> > b/drivers/pci/pcie/portdrv_pci.c
>> > index 973f1b8..92f5d330 100644
>> > --- a/drivers/pci/pcie/portdrv_pci.c
>> > +++ b/drivers/pci/pcie/portdrv_pci.c
>> > @@ -42,17 +42,6 @@ __setup("pcie_ports=", pcie_port_setup);
>> >
>> >  /* global data */
>> >
>> > -static int pcie_portdrv_restore_config(struct pci_dev *dev)
>> > -{
>> > -	int retval;
>> > -
>> > -	retval = pci_enable_device(dev);
>> > -	if (retval)
>> > -		return retval;
>> > -	pci_set_master(dev);
>> > -	return 0;
>> > -}
>> > -
>> >  #ifdef CONFIG_PM
>> >  static int pcie_port_runtime_suspend(struct device *dev)
>> >  {
>> > @@ -162,14 +151,6 @@ static pci_ers_result_t
>> > pcie_portdrv_mmio_enabled(struct pci_dev *dev)
>> >
>> >  static pci_ers_result_t pcie_portdrv_slot_reset(struct pci_dev *dev)
>> >  {
>> > -	/* If fatal, restore cfg space for possible link reset at upstream */
>> > -	if (dev->error_state == pci_channel_io_frozen) {
>> > -		dev->state_saved = true;
>> > -		pci_restore_state(dev);
>> > -		pcie_portdrv_restore_config(dev);
>> > -		pci_enable_pcie_error_reporting(dev);
>> > -	}
>> > -
>> >  	return PCI_ERS_RESULT_RECOVERED;
>> >  }
>> 
>> 
>> Hi Bjorn,
>> 
>> the above patch removes ERR_FATAL handling from 
>> pcie_portdrv_slot_reset()
>> because now we are handling ERR_FATAL differently than before.
>> 
>> I tried to dig into pcie_portdrv_slot_reset() handling for ERR_FATAL 
>> case
>> where it
>> restores the config space, enable device, set master and enable error
>> reporting....
>> and as far as I understand this is being done for upstream link 
>> (bridges
>> etc..)
>> 
>> why was it done at the first point (I checked the commit description, 
>> but
>> could not really get it)
>> and do we need to handle the same thing in ERR_FATAL now ?
> 
> You mean 4bf3392e0bf5 ("PCI-Express AER implemetation: pcie_portdrv
> error handler"), which added pcie_portdrv_slot_reset()?  I agree, that
> commit log has no useful information.  I don't know any of the history
> behind it.

Keith,

do you know why in ERR_FATAL case following was done ?
have a look at pcie_portdrv_slot_reset() handling (for bridges, switches 
etc..)

Regards,
Oza.
