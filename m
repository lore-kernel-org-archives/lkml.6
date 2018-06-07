Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ekWlCJo3GVvuZgAAmS7hNA
	; Thu, 07 Jun 2018 13:48:17 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4FA7F607E7; Thu,  7 Jun 2018 13:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528379297;
	bh=aMGTZV/Txs5XiGLVGoXCYibwqxR03GdV/Rl9O06xyxo=;
	h=Date:From:To:Subject:In-Reply-To:References:List-ID:From;
	b=amjlHcNlJMiaRMDocVDk5jcghcEvm8i141S/dq9oCHOwZbcZus6lEpVKuUQOl77sJ
	 TuxJUMai6Y4aRqqKnANj5wny6aktLzvsbgKikd2Dq0LjXmsVNZ4wMvMYXs3WeZrLKy
	 kEQ4qQcsTioiFZQtdj+s8U0wHNfZggG4/Qtk/UiM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BC282601B4;
	Thu,  7 Jun 2018 13:48:16 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cqE7COVh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oowlkLz/"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BC282601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932693AbeFGNsO (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 09:48:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56286 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932152AbeFGNsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:48:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 84078607E7; Thu,  7 Jun 2018 13:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528379290;
        bh=aMGTZV/Txs5XiGLVGoXCYibwqxR03GdV/Rl9O06xyxo=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=cqE7COVhSF9dxekCZr22uGxF3/Ie1APFykzWMXSFpW0aLoOolwnfye0rTL7ncRuFP
         qPnZrH1yeHhEvB17QIc70SdhOuBWBVAmLd8Rkx+z+MCXrPhbs7MgKgePXxCH7pSmM7
         LjWtGw6Wcc6PEvI58RCe8+B943Q8O3aTvuiWO8jg=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id B758F601B4;
        Thu,  7 Jun 2018 13:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528379283;
        bh=aMGTZV/Txs5XiGLVGoXCYibwqxR03GdV/Rl9O06xyxo=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=oowlkLz/a5YXibHHw/tLicNJCf3LRsMt04MeaEEYaaVccbUbDuEOyHRpzpS3Dl5Na
         JO/cay/nKkmeXAsfIaSH9cIrJ68LenyptEP1Z4R53NPV1oXs7Wd2Rpb/QsX3f1Y9d1
         NL1GRIc2HiYhRqDo7sksFZ+3x0eHZxqfKrcjLyNs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 07 Jun 2018 19:18:03 +0530
From: poza@codeaurora.org
To: Bjorn Helgaas <bhelgaas@google.com>,
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
In-Reply-To: <1528351234-26914-6-git-send-email-poza@codeaurora.org>
References: <1528351234-26914-1-git-send-email-poza@codeaurora.org>
 <1528351234-26914-6-git-send-email-poza@codeaurora.org>
Message-ID: <94661add3e71e3694aa22c2a9cabf503@codeaurora.org>
X-Sender: poza@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-07 11:30, Oza Pawandeep wrote:
> We are handling ERR_FATAL by resetting the Link in software,skipping 
> the
> driver pci_error_handlers callbacks, removing the devices from the PCI
> subsystem, and re-enumerating, as a result of that, no more calling
> pcie_portdrv_slot_reset in ERR_FATAL case.
> 
> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
> 
> diff --git a/drivers/pci/pcie/portdrv_pci.c 
> b/drivers/pci/pcie/portdrv_pci.c
> index 973f1b8..92f5d330 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -42,17 +42,6 @@ __setup("pcie_ports=", pcie_port_setup);
> 
>  /* global data */
> 
> -static int pcie_portdrv_restore_config(struct pci_dev *dev)
> -{
> -	int retval;
> -
> -	retval = pci_enable_device(dev);
> -	if (retval)
> -		return retval;
> -	pci_set_master(dev);
> -	return 0;
> -}
> -
>  #ifdef CONFIG_PM
>  static int pcie_port_runtime_suspend(struct device *dev)
>  {
> @@ -162,14 +151,6 @@ static pci_ers_result_t
> pcie_portdrv_mmio_enabled(struct pci_dev *dev)
> 
>  static pci_ers_result_t pcie_portdrv_slot_reset(struct pci_dev *dev)
>  {
> -	/* If fatal, restore cfg space for possible link reset at upstream */
> -	if (dev->error_state == pci_channel_io_frozen) {
> -		dev->state_saved = true;
> -		pci_restore_state(dev);
> -		pcie_portdrv_restore_config(dev);
> -		pci_enable_pcie_error_reporting(dev);
> -	}
> -
>  	return PCI_ERS_RESULT_RECOVERED;
>  }


Hi Bjorn,

the above patch removes ERR_FATAL handling from 
pcie_portdrv_slot_reset()
because now we are handling ERR_FATAL differently than before.

I tried to dig into pcie_portdrv_slot_reset() handling for ERR_FATAL 
case where it
restores the config space, enable device, set master and enable error 
reporting....
and as far as I understand this is being done for upstream link (bridges 
etc..)

why was it done at the first point (I checked the commit description, 
but could not really get it)
and do we need to handle the same thing in ERR_FATAL now ?

Regards,
Oza.
