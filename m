Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932170AbeE3Sco (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 14:32:44 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:60513 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753659AbeE3Scn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 14:32:43 -0400
Date: Wed, 30 May 2018 20:32:41 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Oza Pawandeep <poza@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] PCI/AER: Decode Error Source Requester ID
Message-ID: <20180530183241.GA20222@wunner.de>
References: <152770259826.80701.7360032106128917833.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152770285586.80701.6545710900591672975.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152770285586.80701.6545710900591672975.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 12:54:15PM -0500, Bjorn Helgaas wrote:
>  void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
>  {
> -	pci_info(dev, "AER: %s%s error received: id=%04x\n",
> +	u8 bus = info->id >> 8;
> +	u8 devfn = info->id & 0xff;
> +
> +	pci_info(dev, "AER: %s%s error received: %04x:%02x:%02x.%d\n",
>  		info->multi_error_valid ? "Multiple " : "",
> -		aer_error_severity_string[info->severity], info->id);
> +		aer_error_severity_string[info->severity],
> +		pci_domain_nr(dev->bus), bus, devfn >> 3, devfn & 0x7);

I think PCI_SLOT(devfn), PCI_FUNC(devfn) is a bit more readable.
