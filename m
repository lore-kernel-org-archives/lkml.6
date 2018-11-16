Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32D5C43610
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 08:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B5742087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 08:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B5742087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389178AbeKPSrP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:47:15 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59310 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbeKPSrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 13:47:14 -0500
Received: from mail-pf1-f197.google.com ([209.85.210.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gNZbU-00071z-Mv
        for linux-kernel@vger.kernel.org; Fri, 16 Nov 2018 08:35:52 +0000
Received: by mail-pf1-f197.google.com with SMTP id s71so6691100pfi.22
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 00:35:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=I2/AGPglVtwaUvoM+H68TUdOKuy5DMIrFWvUDJvvq2s=;
        b=VonERlyEOJToXhIFgUMfe17YDGAKjjB6PGRU44WhnAXiHXU6AKNZgy+tVC1G7/X5km
         BcLdFC4ugziExf1CiuNPi5O4uikAOloCsWAdiDBO4qfwGrXOE27YfzW+rSKBq8LTbyH1
         GiIXYkMx5vr8CLokboIskOprNCU1zpOrFlmx0/RXsfWC8bb8Pb7u6KCujuE+C2vxDESh
         ZAnAORS7j6ohoMnk/MT4W4djt+P/hux5ig9iY0B9E9bbtaheFxsS6ghnX9EFVuPWAR+u
         MuI8jNurpqsiLsjqH07F57Nv1y8IaWcj9K0tAFscj+/dE+PGaXd+vcaDRvS+qy1hxhjk
         DnHQ==
X-Gm-Message-State: AGRZ1gLYOnMxJii1yArtAFrlS6oYgkUjpUFjAh1GuY7eqmLpBxx5PInC
        QFZ3MyRA6I6x4IQ+2lFNvIh8GcRw+L5atelXFlGXkuOCwtRahOaYc2V2UfCUOtEdwKPwagAk4Eq
        KA2iRSJrZPEOz7TLaChrbfnlTFx1OnkRm2trhXaIL9w==
X-Received: by 2002:a62:da54:: with SMTP id w20-v6mr10133145pfl.106.1542357351335;
        Fri, 16 Nov 2018 00:35:51 -0800 (PST)
X-Google-Smtp-Source: AJdET5e9m+bD6jxzdjYoN12zfQe9n3iZQSZGTzeVVe6XH0vXK59TRh6EAWLj9jGKx3bfzY5zF1yuEg==
X-Received: by 2002:a62:da54:: with SMTP id w20-v6mr10133131pfl.106.1542357351036;
        Fri, 16 Nov 2018 00:35:51 -0800 (PST)
Received: from 2001-b011-380f-15ec-2dac-90da-1cd3-7462.dynamic-ip6.hinet.net (2001-b011-380f-15ec-2dac-90da-1cd3-7462.dynamic-ip6.hinet.net. [2001:b011:380f:15ec:2dac:90da:1cd3:7462])
        by smtp.gmail.com with ESMTPSA id w2-v6sm34713558pfn.89.2018.11.16.00.35.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 00:35:50 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH] xhci: workaround CSS timeout on AMD SNPS 3.0 xHC.
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <1542356426-10299-1-git-send-email-Sandeep.Singh@amd.com>
Date:   Fri, 16 Nov 2018 16:35:47 +0800
Cc:     "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <0B58593B-1CE2-49EB-9F13-A2BC449AB8E8@canonical.com>
References: <1542356426-10299-1-git-send-email-Sandeep.Singh@amd.com>
To:     "Singh, Sandeep" <Sandeep.Singh@amd.com>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sandeep,

> On Nov 16, 2018, at 16:21, Singh, Sandeep <Sandeep.Singh@amd.com> wrote:
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
> using XHCI_RESET_ON_RESUME quirk.

What happens to the connected and suspended USB devices?
Do USB devices lose remote wakeup functionality when this happens?

> 
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> Signed-off-by: Sandeep Singh <Sandeep.Singh@amd.com>
> cc: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
> ---
> drivers/usb/host/xhci-pci.c |  4 ++++
> drivers/usb/host/xhci.c     | 25 +++++++++++++++++++++++++
> drivers/usb/host/xhci.h     |  1 +
> 3 files changed, 30 insertions(+)
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
> index 0420eef..965b503 100644
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
> @@ -1025,10 +1026,32 @@ int xhci_suspend(struct xhci_hcd *xhci, bool do_wakeup)
> 	writel(command, &xhci->op_regs->command);
> 	if (xhci_handshake(&xhci->op_regs->status,
> 				STS_SAVE, 0, 10 * 1000)) {
> +		if (xhci->quirks & XHCI_SNPS_BROKEN_SUSPEND) {
> +		       /*
> +			* AMD SNPS xHC 3.0 occasionally does not clear the
> +			* SSS bit of USBSTS and when driver tries to poll
> +			* to see if the xHC clears BIT(8) which never happens
> +			* and driver assumes that controller is not responding
> +			* and times out. To workaround this, its good to check
> +			* if SRE and HCE bits are not set (as per xhci
> +			* Section 5.4.2) and bypass the timeout.
> +			*/
> +
> +			res = readl(&xhci->op_regs->status);
> +			if (res & STS_SAVE) {
> +				if (((res & STS_SRE) == 0) &&
> +				    ((res & STS_HCE) == 0)) {
> +					xhci->quirks |= XHCI_RESET_ON_RESUME;
> +					goto complete_suspend;
> +				}
> +			}

Maybe merge the two “ifs”? There are no other conditions to handle.

Kai-Heng

> +		}
> +
> 		xhci_warn(xhci, "WARN: xHC save state timeout\n");
> 		spin_unlock_irq(&xhci->lock);
> 		return -ETIMEDOUT;
> 	}
> + complete_suspend:
> 	spin_unlock_irq(&xhci->lock);
> 
> 	/*
> @@ -1213,6 +1236,8 @@ int xhci_resume(struct xhci_hcd *xhci, bool hibernated)
> 	usb_hcd_poll_rh_status(xhci->shared_hcd);
> 	set_bit(HCD_FLAG_POLL_RH, &hcd->flags);
> 	usb_hcd_poll_rh_status(hcd);
> +	if (xhci->quirks & XHCI_SNPS_BROKEN_SUSPEND)
> +		xhci->quirks &= ~XHCI_RESET_ON_RESUME;
> 
> 	return retval;
> }
> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> index bf0b369..eb99782 100644
> --- a/drivers/usb/host/xhci.h
> +++ b/drivers/usb/host/xhci.h
> @@ -1849,6 +1849,7 @@ struct xhci_hcd {
> #define XHCI_INTEL_USB_ROLE_SW	BIT_ULL(31)
> #define XHCI_ZERO_64B_REGS	BIT_ULL(32)
> #define XHCI_DEFAULT_PM_RUNTIME_ALLOW	BIT_ULL(33)
> +#define XHCI_SNPS_BROKEN_SUSPEND	BIT_ULL(34)
> 
> 	unsigned int		num_active_eps;
> 	unsigned int		limit_active_eps;
> -- 
> 2.7.4
> 

