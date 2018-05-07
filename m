Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1651933-1525728951-2-2893058964123099941
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES enfr,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525728951; b=ML7EuHPSiWDFzDT7R+dzcimFqR9OnAOfxG8BhNBzJKFoyl7tSs
    Tp1z/vR/9sh8MwBVdnkh/Ws4QdkPl9WIiMVT6gtPAO3N99w5ztTbgE1e18gtPKVt
    5axWpi4LkmiWvfCQ2x9L36k7I/TWxtoncDoHPM03Klod1lW5JPoopRG0bVuvHFcB
    bNUg0+RgW0Kmv4SYdUddU+AzS4Fupwh1mM+gaWt8yG7FGIAKVy5A749y8TJ3YpnZ
    Hsew3XdeguIPsXLvNEOO7/grLHsK+eMZ8Ibr+R7iyKohnQ1Wn/7oc5qTNlKy+E+3
    e5YPHuaU9KpNBZ4OgtE1SQP1Ks7ZIi7eZN/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525728951; bh=zO4ouGf/7xaDXF+0YErkcChnZ/Cnjf
    X68F3nMR8Dp7M=; b=RvOGkX16Ufb/blnuKkmg5CHbYo8m8PI2RUM6t7P62tYqUT
    ULOdkSKh64JmVxGlBZ/J8akmXUrHqLE6PCOZ5dv2GpB6AXp6DFymD+OOCxLdUeUh
    PnIMOzpimIT4bPmofcta9jI6NidWlUUoXmkPwdRPHraCBm5s30R9isw6cJYAIe9u
    kT5DdCOWmx+wqnULBqxtAf6r8eCTGgBkJ4YcHIDxlUPrfRmoQgbGj8GBUbVhRMcz
    ctveErT8bU6JyjVeB1EYbfztWKE0pSB+BKSHDxQAfufqd65CtKT4JiF7dA1n468h
    fMNYfk4cVv97+W/cYzhlLR/+RaLwo+oTXfoMkQLQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=s/CuRqFG x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=s/CuRqFG x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEDu8hx3pvnBp3xE6dFH4qmhWqDlysgmCrqyJTJIqwPoZG4lI4FrLMRZs2yJOVBKo1ZJu/33si0tKPmlI0qt9Vkx0c6KIaDJ0zOg3lo0kdnMVG41qfmD
    3VjOaVHqFXcygn7nOxspnVlN8UgMIJB+ejYOazgxMRf76BWY4P1d88YLEQXeD4KvzwOYot3/j4HOZ0pC3IF++eb6xU0U2bCChSovK48aucblFMobqLUSdb1e
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=LpQP-O61AAAA:8 a=1XWaLZrsAAAA:8 a=JfrnYn6hAAAA:8
    a=ScDZoTYWJJiAgSwt6RUA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=pioyyrs4ZptJ924tMmac:22 a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752904AbeEGVfe (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 17:35:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:34372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752389AbeEGVfd (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 7 May 2018 17:35:33 -0400
Date: Mon, 7 May 2018 16:35:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
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
Message-ID: <20180507213531.GB133147@bhelgaas-glaptop.roam.corp.google.com>
References: <1525602662-1873-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525602662-1873-1-git-send-email-okaya@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, May 06, 2018 at 06:30:53AM -0400, Sinan Kaya wrote:
> The QDF2400 controller does not set the Command Completed bit unless
> writes to the Slot Command register change "Control" bits.  Command
> Completed is never set for writes that only change software notification
> "Enable" bits.  This results in timeouts like this:
> 
> pciehp 0000:00:00.0:pcie004: Timeout on hotplug command 0x1038
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Since there's no bisection benefit for keeping these separate, I folded
this into the original quirk and added Mika's reviewed-by.

I also added the following ID patch and used PCI_VENDOR_ID_QCOM:

commit 333c8c1216c1e7ead6af7b3d667b43eb425b5034
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon May 7 15:52:55 2018 -0500

    PCI: Add Qualcomm vendor ID
    
    Add the Qualcomm vendor ID to pci_ids.h and use it in quirks.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 2990ad1e7c99..e7bf44515fd6 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4361,8 +4361,8 @@ static const struct pci_dev_acs_enabled {
 	{ PCI_VENDOR_ID_INTEL, 0x15b7, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_INTEL, 0x15b8, pci_quirk_mf_endpoint_acs },
 	/* QCOM QDF2xxx root ports */
-	{ 0x17cb, 0x400, pci_quirk_qcom_rp_acs },
-	{ 0x17cb, 0x401, pci_quirk_qcom_rp_acs },
+	{ PCI_VENDOR_ID_QCOM, 0x0400, pci_quirk_qcom_rp_acs },
+	{ PCI_VENDOR_ID_QCOM, 0x0401, pci_quirk_qcom_rp_acs },
 	/* Intel PCH root ports */
 	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_intel_pch_acs },
 	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_intel_spt_pch_acs },
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index cc608fc55334..883cb7bf78aa 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2387,6 +2387,8 @@
 
 #define PCI_VENDOR_ID_LENOVO		0x17aa
 
+#define PCI_VENDOR_ID_QCOM		0x17cb
+
 #define PCI_VENDOR_ID_CDNS		0x17cd
 
 #define PCI_VENDOR_ID_ARECA		0x17d3

> ---
>  drivers/pci/hotplug/pciehp_hpc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index e70eba5..974a8f1 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -914,3 +914,9 @@ static void quirk_cmd_compl(struct pci_dev *pdev)
>  }
>  DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
>  			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
> +
> +DECLARE_PCI_FIXUP_CLASS_EARLY(0x17cb, 0x400,
> +			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
> +
> +DECLARE_PCI_FIXUP_CLASS_EARLY(0x17cb, 0x401,
> +			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
