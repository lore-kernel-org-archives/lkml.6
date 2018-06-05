Return-Path: <linux-pci-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-2490124-1528201644-2-7292595881721407581
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-pci-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528201643; b=dG3/MkyqLrEIPEfEZCXanS9rI8cLKBa5JCc1BljQuXM4CI7mnb
    Pg5HemLajmr4k5ZTJkrBp+CBDhPbk2byVEmaGGcZT1EBkTJPzuPvmNS89q2nbkUf
    24/s2rwXd3/nwz4tKzXomAztlysnsmJS5ZSCGjSudz+bySJskxTCzKWdTT1cAc5d
    gojTkDLADpxsGSBA9j1jIndKPfgcRdVrNgIxdPYW4RWyGXityoeTspB3i4lU9IVA
    TsOKVcoq3SiCr982+BEgZLhOQK33kC0Ju0USulwFCExevAXdbpRUwlwUyMGSxeb1
    iownP8UzBlw20AzD3XUtfPDoQoWuzPmHHllQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1528201643; bh=r8qzHqCNMPZwqQt0PujG3UIfvRafwr76ioBevjqOZY
    U=; b=m1vf7qLDl6komCcOpOXJGFBW9NV6x9u9Dgnjfv7pmHPlnc89/chc0Nnogk
    UTPvhyhsyuQSA+rAx9eFnvkJLdCsNGxfA58B+Fg4bK7L5ifSnjrkJOV2mAisr6oT
    zJJ68P8Q8MTBYZlyOFm0qeepeMXxvWiAemGPmkPSWCddl+JOsj5xk+9UVnlmaDHN
    41WZ9ensiK1ReonPKvM/KRl6RqPs5Gh44Wcz5rKPY41fTQYT+87DI+Gdwc7TtPm5
    4jFtAEtZx1KW+1y7M+GcUIch57t3AF28Kxt+t++RUrBEJHIQuY0ghIdJG4xn9gsJ
    I9j7Dkie68gZtOsmHrIzrq6cnw5w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=N5ZxS0wo header.a=rsa-sha256
    header.s=20161025 x-bits=2048;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=kASeqoM2;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=N5ZxS0wo header.a=rsa-sha256
      header.s=20161025 x-bits=2048;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=kASeqoM2;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEnS58MCXQ6pwY3TlBFlM8BFtllFYz6DfK1lS4qBRUHnqHGEAJTBguTTeE7S7TTr0LocypBxMbdXPkIG9nTYCfS3yJecDVgzq9aDynL8Me8QQSCNeZIR
    snlFjaczlx9bg2BMhS0vJ/ih2Op3C9ex8l6rytQke6mZon4g49vwruoiL4Gp6O9o+TxBoj9eU36ftUN7f2VkDxLYNqpr2lxnwP8N/wbFBzLyFov1yCe2Sm5a
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=fbV3Th2LUxsA:10 a=7mUfYlMuFuIA:10 a=pGLkceISAAAA:8 a=YP1ce2hCKkYCl1JQY8QA:9
    a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751722AbeFEM1Q (ORCPT <rfc822;linux@kroah.com>);
        Tue, 5 Jun 2018 08:27:16 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:43407 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751718AbeFEM1P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jun 2018 08:27:15 -0400
X-Google-Smtp-Source: ADUXVKKbXjHZrRPuTWoTGagygxYUx391qwix0oVvlo6ecePdPqqQljHNjxv7qKzZO5EHlOzVcW+9sLeVd7WKmwvgdEA=
MIME-Version: 1.0
In-Reply-To: <20180604155523.14906-1-mr.nuke.me@gmail.com>
References: <20180604155523.14906-1-mr.nuke.me@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 5 Jun 2018 15:27:14 +0300
Message-ID: <CAHp75VciAimPhuMDOzYdMP=S1OWGyOUh4dN4BqfsLVOpTnRBRQ@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: Check for PCIe downtraining conditions
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
X-Mailing-List: linux-pci@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Jun 4, 2018 at 6:55 PM, Alexandru Gagniuc <mr.nuke.me@gmail.com> wrote:
> PCIe downtraining happens when both the device and PCIe port are
> capable of a larger bus width or higher speed than negotiated.
> Downtraining might be indicative of other problems in the system, and
> identifying this from userspace is neither intuitive, nor straigh
> forward.
>
> The easiest way to detect this is with pcie_print_link_status(),
> since the bottleneck is usually the link that is downtrained. It's not
> a perfect solution, but it works extremely well in most cases.

Have you seen any of my comments?
For your convenience repeating below.

>
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>
> Changes since v2:
>  - Check dev->is_virtfn flag
>
> Changes since v1:
>  - Use pcie_print_link_status() instead of reimplementing logic
>
>  drivers/pci/probe.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index ac91b6fd0bcd..a88ec8c25dd5 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2146,6 +2146,25 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
>         return dev;
>  }
>
> +static void pcie_check_upstream_link(struct pci_dev *dev)
> +{

> +

This is redundant blank line.

> +       if (!pci_is_pcie(dev))
> +               return;
> +
> +       /* Look from the device up to avoid downstream ports with no devices. */
> +       if ((pci_pcie_type(dev) != PCI_EXP_TYPE_ENDPOINT) &&
> +           (pci_pcie_type(dev) != PCI_EXP_TYPE_LEG_END) &&
> +           (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM))
> +               return;

I looked briefly at the use of these calls and perhaps it might make
sense to introduce
pci_is_pcie_type(dev, type) which unifies pci_is_pcie() + pci_pcie_type().

> +
> +       /* Multi-function PCIe share the same link/status. */

> +       if ((PCI_FUNC(dev->devfn) != 0) || dev->is_virtfn)

The one pair of parens is not needed.

> +               return;
> +
> +       pcie_print_link_status(dev);
> +}
> +
>  static void pci_init_capabilities(struct pci_dev *dev)
>  {
>         /* Enhanced Allocation */
> @@ -2181,6 +2200,9 @@ static void pci_init_capabilities(struct pci_dev *dev)
>         /* Advanced Error Reporting */
>         pci_aer_init(dev);
>
> +       /* Check link and detect downtrain errors */
> +       pcie_check_upstream_link(dev);
> +
>         if (pci_probe_reset_function(dev) == 0)
>                 dev->reset_fn = 1;
>  }
> --
> 2.14.4
>



-- 
With Best Regards,
Andy Shevchenko
