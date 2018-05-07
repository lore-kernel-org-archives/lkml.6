Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1651933-1525729305-2-16799369787117027751
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525729305; b=BWyXB7pjKgah5cGw/F0WrLIweFNICWRqkb8pnwz3ms2Tjpf+PQ
    dVZXP5nYDKeAgLAKhY5MtuzHwFGwJ0oZUAEAfu5UMelNfUqnKsaOHXwL3oE4vuwN
    oFBPA3mvhavBLEK1Nx/6fGWhMYl2m54DrgUxCCG7O2YtvMEsTYsqgSit8vvNPibs
    5HXR2MLvqksfDMk2FSqv1S0x+UOeixeFV1Y5bt6JdUu/GZ/hbzNTiaxWsUHi8YIu
    jay0GZD4yuBLdHwkgYsfYSZE6kVhFfPQGVoq2Xhsdelll9Ar5on2vALljmssjsLS
    6agjA8bwDT17JB2xOtXhQ0FtbjsmnP48RBBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:content-type
    :content-transfer-encoding:date:from:to:cc:subject:in-reply-to
    :references:message-id:sender:list-id; s=fm2; t=1525729305; bh=3
    BPhNmH1C6HlSxl7kpBKzNBTx/FtfWwIdxuPYi+9tSY=; b=FzhgsREI5CIyCyp0O
    jYiqDFNtW8q+X6J7L6RPNZeiRcyJYWojn9i358ei+uFef5gOJNMPbqdHHjF+C18Z
    USgNS99m/AS9PgZpGCnHftqyZobHqHN/OI+clihFio9oXUEJENIOfCVTY86InpBd
    MO4JihTpTWo/thxY2csAYfZBCkHd2k5Brq0MWJhrVbNdg0NC9DH6wtjLQBnoU376
    Ouaw1yT1XYIqqLUO/8dQLUx5EBxAsmZU/+AXoJt4NrOl2fIK0tSVKRPmvcZgI9pI
    hDvhM3jtDOqoMj+q5RU5BBWhQ08pxLfBXelHQat2n19t/S/dgO/bzxyL5kf1dOTy
    dzhjQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org
    header.i=@codeaurora.org header.b=K45uJy8N x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org
    header.i=@codeaurora.org header.b=Sw+UXIrC x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org
      header.i=@codeaurora.org header.b=K45uJy8N x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org
      header.i=@codeaurora.org header.b=Sw+UXIrC x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfOWcSBpsHb+Anzow4iKaDZT79PURvcvn1TVfCKReo6AC7oAaaC6M/u4HtX2XCnEbZ54nE9cnMGUWNnpaEC/8BpQa8WzXlx15xbVncbmVIoGy2qQJnjHA
    /q2mYkHM5R+B9H1G5W6NDnrEE7vGGEwMk6IlS6dF+h932LkGId0ERsurhP+ymQeV2Q64h1Vn9gKQVa/RuNus+V2rKr3X+BCDetvmJ7CKwdhn50G56ePrX4DZ
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=LpQP-O61AAAA:8 a=1XWaLZrsAAAA:8 a=JfrnYn6hAAAA:8
    a=OmkBDKYMarP2BAkldYQA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=pioyyrs4ZptJ924tMmac:22 a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752766AbeEGVln (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 17:41:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49544 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753102AbeEGVlm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 7 May 2018 17:41:42 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 07 May 2018 22:41:40 +0100
From: okaya@codeaurora.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
        sulrich@codeaurora.org, Keith Busch <keith.busch@intel.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Markus Elfring <elfring@users.sourceforge.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: pciehp: Add quirk for QDF2400 Command Completed
 erratum
In-Reply-To: <20180507213531.GB133147@bhelgaas-glaptop.roam.corp.google.com>
References: <1525602662-1873-1-git-send-email-okaya@codeaurora.org>
 <20180507213531.GB133147@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <15288037a0316d181d6fd12813f468ad@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-05-07 22:35, Bjorn Helgaas wrote:
> On Sun, May 06, 2018 at 06:30:53AM -0400, Sinan Kaya wrote:
>> The QDF2400 controller does not set the Command Completed bit unless
>> writes to the Slot Command register change "Control" bits.  Command
>> Completed is never set for writes that only change software 
>> notification
>> "Enable" bits.  This results in timeouts like this:
>> 
>> pciehp 0000:00:00.0:pcie004: Timeout on hotplug command 0x1038
>> 
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> 
> Since there's no bisection benefit for keeping these separate, I folded
> this into the original quirk and added Mika's reviewed-by.
> 
> I also added the following ID patch and used PCI_VENDOR_ID_QCOM:

Thanks for the clean up.

> 
> commit 333c8c1216c1e7ead6af7b3d667b43eb425b5034
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Mon May 7 15:52:55 2018 -0500
> 
>     PCI: Add Qualcomm vendor ID
> 
>     Add the Qualcomm vendor ID to pci_ids.h and use it in quirks.
> 
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 2990ad1e7c99..e7bf44515fd6 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4361,8 +4361,8 @@ static const struct pci_dev_acs_enabled {
>  	{ PCI_VENDOR_ID_INTEL, 0x15b7, pci_quirk_mf_endpoint_acs },
>  	{ PCI_VENDOR_ID_INTEL, 0x15b8, pci_quirk_mf_endpoint_acs },
>  	/* QCOM QDF2xxx root ports */
> -	{ 0x17cb, 0x400, pci_quirk_qcom_rp_acs },
> -	{ 0x17cb, 0x401, pci_quirk_qcom_rp_acs },
> +	{ PCI_VENDOR_ID_QCOM, 0x0400, pci_quirk_qcom_rp_acs },
> +	{ PCI_VENDOR_ID_QCOM, 0x0401, pci_quirk_qcom_rp_acs },
>  	/* Intel PCH root ports */
>  	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_intel_pch_acs },
>  	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_intel_spt_pch_acs },
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index cc608fc55334..883cb7bf78aa 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2387,6 +2387,8 @@
> 
>  #define PCI_VENDOR_ID_LENOVO		0x17aa
> 
> +#define PCI_VENDOR_ID_QCOM		0x17cb
> +
>  #define PCI_VENDOR_ID_CDNS		0x17cd
> 
>  #define PCI_VENDOR_ID_ARECA		0x17d3
> 
>> ---
>>  drivers/pci/hotplug/pciehp_hpc.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>> 
>> diff --git a/drivers/pci/hotplug/pciehp_hpc.c 
>> b/drivers/pci/hotplug/pciehp_hpc.c
>> index e70eba5..974a8f1 100644
>> --- a/drivers/pci/hotplug/pciehp_hpc.c
>> +++ b/drivers/pci/hotplug/pciehp_hpc.c
>> @@ -914,3 +914,9 @@ static void quirk_cmd_compl(struct pci_dev *pdev)
>>  }
>>  DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
>>  			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
>> +
>> +DECLARE_PCI_FIXUP_CLASS_EARLY(0x17cb, 0x400,
>> +			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
>> +
>> +DECLARE_PCI_FIXUP_CLASS_EARLY(0x17cb, 0x401,
>> +			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
>> --
>> 2.7.4
>> 
>> 
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
