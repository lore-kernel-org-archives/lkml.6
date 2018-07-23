Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF98ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA71E20875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GsXEfo39";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GsXEfo39"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA71E20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388005AbeGWJLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 05:11:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54702 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387918AbeGWJLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 05:11:04 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B86046085F; Mon, 23 Jul 2018 08:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532333464;
        bh=PEeUxE0wirdDxOKn+FJPDf4ciT0eyxcwaL6k+wfOoxE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GsXEfo39xNjOoyuUrsnuNFE0oArvaMCnkjoedBDvfScLEosSgGpOArkzdVUYBWy6R
         Aa7pWDqBrPNRGoqjCq0OfNq76kfCIeUuE/evuLD97usDND7+RaeUfTNNcsil+qw7tp
         dON4h/wzbGdfwNJsXdNlkpkHBeoi17HGKE3KFsy4=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 4CED6606CF;
        Mon, 23 Jul 2018 08:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532333464;
        bh=PEeUxE0wirdDxOKn+FJPDf4ciT0eyxcwaL6k+wfOoxE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GsXEfo39xNjOoyuUrsnuNFE0oArvaMCnkjoedBDvfScLEosSgGpOArkzdVUYBWy6R
         Aa7pWDqBrPNRGoqjCq0OfNq76kfCIeUuE/evuLD97usDND7+RaeUfTNNcsil+qw7tp
         dON4h/wzbGdfwNJsXdNlkpkHBeoi17HGKE3KFsy4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 23 Jul 2018 13:41:04 +0530
From:   poza@codeaurora.org
To:     Bharat Kumar Gogada <bharatku@xilinx.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH] PCI/AER: Enable SERR# forwarding in non ACPI flow
In-Reply-To: <BL0PR02MB4849C990B8C0822ECA45746AA5530@BL0PR02MB4849.namprd02.prod.outlook.com>
References: <1531406719-18606-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <b5ba83a0fd8694905528f740a186b891@codeaurora.org>
 <BL0PR02MB4849D9F256912CC9B869A20EA5580@BL0PR02MB4849.namprd02.prod.outlook.com>
 <3bd31b729f9f335fcd906a8164c0a4cb@codeaurora.org>
 <BL0PR02MB4849C990B8C0822ECA45746AA5530@BL0PR02MB4849.namprd02.prod.outlook.com>
Message-ID: <cba588cfb69aaa933adf2e8a31be6041@codeaurora.org>
X-Sender: poza@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-18 19:04, Bharat Kumar Gogada wrote:
>> On 2018-07-13 19:25, Bharat Kumar Gogada wrote:
>> >> > Currently PCI_BRIDGE_CTL_SERR is being enabled only in ACPI flow.
>> >> > This bit is required for forwarding errors reported by EP devices
>> >> > to upstream device.
>> >> > This patch enables SERR# for Type-1 PCI device.
>> >> >
>> >> > Signed-off-by: Bharat Kumar Gogada
>> <bharat.kumar.gogada@xilinx.com>
>> >> > ---
>> >> >  drivers/pci/pcie/aer.c |   23 +++++++++++++++++++++++
>> >> >  1 files changed, 23 insertions(+), 0 deletions(-)
>> >> >
>> >> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c index
>> >> > a2e8838..943e084 100644
>> >> > --- a/drivers/pci/pcie/aer.c
>> >> > +++ b/drivers/pci/pcie/aer.c
>> >> > @@ -343,6 +343,19 @@ int pci_enable_pcie_error_reporting(struct
>> >> > pci_dev
>> >> > *dev)
>> >> >  	if (!dev->aer_cap)
>> >> >  		return -EIO;
>> >> >
>> >> > +	if (!IS_ENABLED(CONFIG_ACPI) &&
>> >> > +	    dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
>> >> > +		u16 control;
>> >> > +
>> >> > +		/*
>> >> > +		 * A Type-1 PCI bridge will not forward ERR_ messages
>> >> coming
>> >> > +		 * from an endpoint if SERR# forwarding is not enabled.
>> >> > +		 */
>> >> > +		pci_read_config_word(dev, PCI_BRIDGE_CONTROL,
>> >> &control);
>> >> > +		control |= PCI_BRIDGE_CTL_SERR;
>> >> > +		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
>> >> > +	}
>> >> > +
>> >> >  	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL,
>> >> > PCI_EXP_AER_FLAGS);  }
>> >> > EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
>> >> > @@ -352,6 +365,16 @@ int pci_disable_pcie_error_reporting(struct
>> >> > pci_dev *dev)
>> >> >  	if (pcie_aer_get_firmware_first(dev))
>> >> >  		return -EIO;
>> >> >
>> >> > +	if (!IS_ENABLED(CONFIG_ACPI) &&
>> >> > +	    dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
>> >> > +		u16 control;
>> >> > +
>> >> > +		/* Clear SERR Forwarding */
>> >> > +		pci_read_config_word(dev, PCI_BRIDGE_CONTROL,
>> >> &control);
>> >> > +		control &= ~PCI_BRIDGE_CTL_SERR;
>> >> > +		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
>> >> > +	}
>> >> > +
>> >> >  	return pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
>> >> >  					  PCI_EXP_AER_FLAGS);
>> >> >  }
>> >>
>> >>
>> >> Should this configuration no be set by Firmware ? why should Linux
>> >> dictate it ?
>> > Hi Oza, Can you please let us know why this should be set by firmware ?
>> > Spec clearly states ERR_CORR,ERR_FATAL/NON FATAL will be forwarded
>> > only if this bit is set.
>> > If linux AER service is being enabled without checking/setting this
>> > bit, then AER service will not do anything even ERR_* is seen on link.
>> >
>> > Regards,
>> > Bharat
>> 
>> 
>> The ERR_* to be forwarded or not to be forwarded could be decision of 
>> the
>> platform.
>> hence I think it is best left to firmware to decide if it want to 
>> enable this for
>> particular platform.
>> 
> I'm not aware of other platforms, can you please give an example of a 
> platform
> how it decides to set this in firmware ?
> 
>> although,
>> There are 2 cases
>> Hotplug capable bridge and otherwise.
> 
> Yes, what about an RP which supports only AER but doesn't support 
> Hotplug ?
> If we have this patch we can set this bit without firmware also.
>> 
>> 1) If Firmware sets them, I do not think during enumeraion linux will 
>> loose
>> those settings.
> 
>> 2) I do not see any integration of hotplug with AER currently, so if 
>> the PCIe
>> switch is plugged into Hotplug capable RP, I am not very sure if this 
>> functions
>> get called.
>> 
>> Keith, Lukas and Bjorn any comments ?
> Hi all, do you have any inputs on this ?
> 

I have thought more on this..but needs separate discussion hence will be 
forking the separate thread.
If I choose to make some more patches based on this patch, this patch 
can remain as is and will be included with your authorship.

Regards,
Oza.

> Regards,
> Bharat
