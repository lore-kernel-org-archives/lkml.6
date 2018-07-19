Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFBFC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF3E2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LdcsA+BK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="H50HdPZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBF3E2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732013AbeGSQkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:40:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57350 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730922AbeGSQkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:40:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B43F46063A; Thu, 19 Jul 2018 15:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532015806;
        bh=V0jeFeuWuVPhuNs4PoD90wkGpQep4iiXvhnf4C1iy8Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LdcsA+BKdrDlGAipoqrrAo0J1Q02IMRv1XdG2fNHriYdZ/nPP+72CtK6HwSCs2y/X
         drWKSulTESDaJvadTnwXizY8TPCtg1MxnUjNQmbJgLBEutDnLwwQr5EDuRA/daq1PI
         wW1Fvh4liiqbJSukUoXnGTUBl90xN8tSoGFNHdgQ=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 881E3606DB;
        Thu, 19 Jul 2018 15:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532015805;
        bh=V0jeFeuWuVPhuNs4PoD90wkGpQep4iiXvhnf4C1iy8Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H50HdPZNy7fs+8vpiDONsamBwf/x+0CCBg+Hu/tSRzGdy2FUyzYU7y7YK5J5Eu5R4
         9UaRADlcdCHK3H7Z+efglPNN80vmqAbDewUqf7zXz0UwK6zqQjVGwj/BLfhLKyfoo+
         8FCIQPRkmo6wgTMVC8iBKVMm3vFF62NgtVjkiBtQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 19 Jul 2018 21:26:45 +0530
From:   poza@codeaurora.org
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@kernel.org>,
        Timur Tabi <timur@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] Fix issues and cleanup for ERR_FATAL and
 ERR_NONFATAL
In-Reply-To: <153194245964.191586.14782253252654776509.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <153194245964.191586.14782253252654776509.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <272934d875d2f3a1546567f8c26e5946@codeaurora.org>
X-Sender: poza@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-19 01:14, Bjorn Helgaas wrote:
> This is a v3 of Oza's patches [1].  It's available at [2] if you prefer
> git.
> 
> v3 changes:
>   - Add pci_aer_clear_fatal_status() to clear ERR_FATAL bits, only 
> called
>     from pcie_do_fatal_recovery().  Moved to first in series to avoid a
>     window where ERR_FATAL recovery only clears ERR_NONFATAL bits.  
> Visible
>     only inside the PCI core.
>   - Instead of having pci_cleanup_aer_uncorrect_error_status() do 
> different
>     things based on dev->error_state, use this only for ERR_NONFATAL 
> bits.
>     I didn't change the name because it's used by many drivers.
>   - Rename pci_cleanup_aer_error_device_status() to
>     pci_aer_clear_device_status(), make it void, and make it visible 
> only
>     inside the PCI core.
>   - Remove pcie_portdrv_err_handler.slot_reset altogether instead of 
> making
>     it a stub function.  Possibly pcie_portdrv_err_handler could be 
> removed
>     completely?
> 
> [1]
> https://lkml.kernel.org/r/1529661494-20936-1-git-send-email-poza@codeaurora.org
> [2]
> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/?h=pci/06-22-oza-aer
> 
> ---
> 
> Bjorn Helgaas (1):
>       PCI/AER: Clear only ERR_FATAL status bits during fatal recovery
> 
> Oza Pawandeep (6):
>       PCI/AER: Clear only ERR_NONFATAL bits during non-fatal recovery
>       PCI/AER: Factor out ERR_NONFATAL status bit clearing
>       PCI/AER: Remove ERR_FATAL code from ERR_NONFATAL path
>       PCI/AER: Clear device status bits during ERR_FATAL and 
> ERR_NONFATAL
>       PCI/AER: Clear device status bits during ERR_COR handling
>       PCI/portdrv: Remove pcie_portdrv_err_handler.slot_reset
> 
> 
>  drivers/pci/pci.h              |    5 ++++
>  drivers/pci/pcie/aer.c         |   47 
> +++++++++++++++++++++++++++-------------
>  drivers/pci/pcie/err.c         |   15 +++++--------
>  drivers/pci/pcie/portdrv_pci.c |   25 ---------------------
>  4 files changed, 43 insertions(+), 49 deletions(-)


Hi Bjorn,

I am planning on some things to do after this series.


your text
"
1) I don't think the driver slot_reset callbacks should be responsible
for clearing these AER status bits.  Can we clear them somewhere in
the pcie_do_nonfatal_recovery() path and remove these calls from the
drivers?
"

Oza: We can do following
broadcast_error_message()
       if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
                 should do
           pci_walk_bus(dev->subordinate, 
pci_cleanup_aer_uncorrect_error_status, NULL);

and update all the drivers and remove the call 
pci_cleanup_aer_uncorrect_error_status()


2) In principle, we should only read PCI_ERR_UNCOR_STATUS *once* per
device when handling an error.  We currently read it three times:

   aer_isr
     aer_isr_one_error
       find_source_device
         find_device_iter
           is_error_source
             read PCI_ERR_UNCOR_STATUS              # 1
Oza: this is the first legitimate read
       aer_process_err_devices
         get_device_error_info(e_info->dev[i])
           read PCI_ERR_UNCOR_STATUS                # 2
Oza: I see this read used to check if link is healthy so the purpose of 
this read looks different to me.
         handle_error_source
           pcie_do_nonfatal_recovery
             ...
               report_slot_reset
                 driver->err_handler->slot_reset
                   pci_cleanup_aer_uncorrect_error_status
                     read PCI_ERR_UNCOR_STATUS      # 3
Oza: pci_cleanup_aer_uncorrect_error_status() is generic and able to 
clear status.
for e.g. in point 4 as I suggested if we have to do
pci_walk_bus(dev->subordinate, pci_cleanup_aer_uncorrect_error_status, 
NULL); then we have to read them.


3) we need to get rid of pci_channel_io_frozen permanently.

Regards,
Oza.
















