Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C625C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C07C20820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C07C20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502589AbeKWUNB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:13:01 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42219 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387687AbeKWUNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:13:01 -0500
Received: from mail-pf1-f197.google.com ([209.85.210.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gQ7mG-0003eG-73
        for linux-kernel@vger.kernel.org; Fri, 23 Nov 2018 09:29:32 +0000
Received: by mail-pf1-f197.google.com with SMTP id 75so2447741pfq.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 01:29:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HAKqelIII1A3utvBwHDhh0xSlR4lBrUzhRywpmpFPj4=;
        b=KoXTueWDV6nhYghAeSyRI0jFeCuoJjD6vEvTTOKWpRSefA0l7Eytqcly70gi7j3RtK
         FHCVvvlGA2bay5S52kpQNQjllqYLywnqKp7A2MwrbUjCAjryqCRTwT94EoRb0pLeEYaY
         Zkc/NF3IgWjuDqdChis5lyTT8451GxWJ09MDO56sOX75sqYEH/binZTuyWbIiXI/alS6
         6stNrUswh+uIaenZpLGHIkWRbK5WBXFkM+R/En3CUVNyEQLeNL1zEJQ+jNuHLFKEYT2o
         KMI1VJqLmcwOQXDucfolZ1dXsPPECGD+Helg18OArH9msx/aDfiEjE8ytWsZ0JLdTlry
         miCA==
X-Gm-Message-State: AA+aEWbiUqxHFYCMoBHsSLuVwbqmu+WwhkVtQ6ib7JD+2oSGz0MncR9m
        uofVLyFxx3m6F59h0ZinX/Zvqyr4lKNT9r9NbQ95eG8sEh6yOXUqV04oZPdSGepF8/N1ny/2RLc
        /2K64+ORDx9HVsJwgFX4mkJCRd/gU0//Sbqwh9a1DUA==
X-Received: by 2002:a17:902:d697:: with SMTP id v23mr14572823ply.261.1542965370531;
        Fri, 23 Nov 2018 01:29:30 -0800 (PST)
X-Google-Smtp-Source: AFSGD/WNDkvy4tDjOTE9BZcUjyp6uBV86UrPybcwcBUnCi9smtWdotgGvA64/MWm7mpUJ7ufVb4FYQ==
X-Received: by 2002:a17:902:d697:: with SMTP id v23mr14572797ply.261.1542965370110;
        Fri, 23 Nov 2018 01:29:30 -0800 (PST)
Received: from [10.101.46.245] (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id 73-v6sm69856343pfl.142.2018.11.23.01.29.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 01:29:29 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH v2] xhci: workaround CSS timeout on AMD SNPS 3.0 xHC
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <1542860548-3109-1-git-send-email-Sandeep.Singh@amd.com>
Date:   Fri, 23 Nov 2018 17:29:26 +0800
Cc:     "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <31DD822A-AB20-4CE2-A5C9-878299011F62@canonical.com>
References: <1542860548-3109-1-git-send-email-Sandeep.Singh@amd.com>
To:     "Singh, Sandeep" <Sandeep.Singh@amd.com>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sandeep,

> On Nov 22, 2018, at 12:23 PM, Singh, Sandeep <Sandeep.Singh@amd.com> wrote:
> 
> From: Sandeep Singh <sandeep.singh@amd.com>
> 
> Occasionally AMD SNPS 3.0 xHC does not respond to
> CSS when set, also it does not flag anything on SRE and HCE
> to point the internal xHC errors on USBSTS register. This stalls
> the entire system wide suspend and there is no point in stalling
> just because of xHC CSS is not responding.
> 
> To work around this problem, if the xHC does not flag
> anything on SRE and HCE, we can skip the CSS
> timeout and allow the system to continue the suspend. Once the
> system resume happens we can internally reset the controller
> using XHCI_RESET_ON_RESUME quirk
> 
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> Signed-off-by: Sandeep Singh <Sandeep.Singh@amd.com>
> cc: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
> ---
> Changes since v1:
> 
> -> New Variable based decision making when SNPS issue happens hence 
>   quirk interdependency removed.
> -> Removed STS conditional check in suspend function.
> 
> drivers/usb/host/xhci-pci.c |  4 ++++
> drivers/usb/host/xhci.c     | 26 ++++++++++++++++++++++----
> drivers/usb/host/xhci.h     |  3 +++
> 3 files changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index 01c5705..72493c4 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -139,6 +139,10 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
> 		 pdev->device == 0x43bb))
> 		xhci->quirks |= XHCI_SUSPEND_DELAY;
> 
> +	if (pdev->vendor == PCI_VENDOR_ID_AMD &&
> +	    (pdev->device == 0x15e0 || pdev->device == 0x15e1))
> +		xhci->quirks |= XHCI_SNPS_BROKEN_SUSPEND;
> +
> 	if (pdev->vendor == PCI_VENDOR_ID_AMD)
> 		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 0420eef..808677d 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -970,6 +970,7 @@ int xhci_suspend(struct xhci_hcd *xhci, bool do_wakeup)
> 	unsigned int		delay = XHCI_MAX_HALT_USEC;
> 	struct usb_hcd		*hcd = xhci_to_hcd(xhci);
> 	u32			command;
> +	u32			res;
> 
> 	if (!hcd->state)
> 		return 0;
> @@ -1023,11 +1024,28 @@ int xhci_suspend(struct xhci_hcd *xhci, bool do_wakeup)
> 	command = readl(&xhci->op_regs->command);
> 	command |= CMD_CSS;
> 	writel(command, &xhci->op_regs->command);
> +	xhci->broken_suspend = 0;
> 	if (xhci_handshake(&xhci->op_regs->status,
> 				STS_SAVE, 0, 10 * 1000)) {
> -		xhci_warn(xhci, "WARN: xHC save state timeout\n");
> -		spin_unlock_irq(&xhci->lock);
> -		return -ETIMEDOUT;
> +	/*
> +	 * AMD SNPS xHC 3.0 occasionally does not clear the
> +	 * SSS bit of USBSTS and when driver tries to poll
> +	 * to see if the xHC clears BIT(8) which never happens
> +	 * and driver assumes that controller is not responding
> +	 * and times out. To workaround this, its good to check
> +	 * if SRE and HCE bits are not set (as per xhci
> +	 * Section 5.4.2) and bypass the timeout.
> +	 */
> +		res = readl(&xhci->op_regs->status);
> +		if ((xhci->quirks & XHCI_SNPS_BROKEN_SUSPEND) &&
> +		    (((res & STS_SRE) == 0) &&
> +				((res & STS_HCE) == 0))) {
> +			xhci->broken_suspend = 1;
> +		} else {
> +			xhci_warn(xhci, "WARN: xHC save state timeout\n");
> +			spin_unlock_irq(&xhci->lock);
> +			return -ETIMEDOUT;
> +		}
> 	}
> 	spin_unlock_irq(&xhci->lock);
> 
> @@ -1080,7 +1098,7 @@ int xhci_resume(struct xhci_hcd *xhci, bool hibernated)
> 	set_bit(HCD_FLAG_HW_ACCESSIBLE, &xhci->shared_hcd->flags);
> 
> 	spin_lock_irq(&xhci->lock);
> -	if (xhci->quirks & XHCI_RESET_ON_RESUME)
> +	if ((xhci->quirks & XHCI_RESET_ON_RESUME) || xhci->broken_suspend)
> 		hibernated = true;
> 
> 	if (!hibernated) {
> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> index bf0b369..d5d19b2 100644
> --- a/drivers/usb/host/xhci.h
> +++ b/drivers/usb/host/xhci.h
> @@ -1849,6 +1849,7 @@ struct xhci_hcd {
> #define XHCI_INTEL_USB_ROLE_SW	BIT_ULL(31)
> #define XHCI_ZERO_64B_REGS	BIT_ULL(32)
> #define XHCI_DEFAULT_PM_RUNTIME_ALLOW	BIT_ULL(33)
> +#define XHCI_SNPS_BROKEN_SUSPEND    BIT_ULL(34)

This bit is already in use by a another patch, so please update its value.

Kai-Heng

> 
> 	unsigned int		num_active_eps;
> 	unsigned int		limit_active_eps;
> @@ -1878,6 +1879,8 @@ struct xhci_hcd {
> 	void			*dbc;
> 	/* platform-specific data -- must come last */
> 	unsigned long		priv[0] __aligned(sizeof(s64));
> +	/* Broken Suspend flag for SNPS Suspend resume issue */
> +	u8			broken_suspend;
> };
> 
> /* Platform specific overrides to generic XHCI hc_driver ops */
> -- 
> 2.7.4
> 

