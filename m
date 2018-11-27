Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD8FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9A520873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9A520873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbeK0Slg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 13:41:36 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35217 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728920AbeK0Slf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 13:41:35 -0500
Received: from mail-pl1-f199.google.com ([209.85.214.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gRY2r-0005P5-RS
        for linux-kernel@vger.kernel.org; Tue, 27 Nov 2018 07:44:33 +0000
Received: by mail-pl1-f199.google.com with SMTP id m1-v6so23174129plb.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 23:44:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DX+wn/AKky27OOXrtotGQIIxJZybkzeoDLAK/8RhLjY=;
        b=rn6UzHCRA1rHAktIBF4L+6hNx1D7OZn8Z9gaeJuHvW8BqcQV6Tcabl7vwq06iFP8ZE
         OK+uKHSMu5tpu87M1XdONuL31joa08sJSV01OzoSdAN7EBGTGLIJKT/d78n99mfoXG5Z
         /XMIQHJnEcr/IXourdgWOaOQJ+34cxMV62iBDyplna7sQlaLc8UfBCF1RiQvaFozFfc3
         b2UQzjnaqM942jSiZKkG+xXIc3lXveZgHQ3ooE6vrK3cRO06gVj+nZd8hMPl/WNqHCHp
         i86n4HLMqYRKaXeLcDOd4JzEP27GFQTKfDm2/gTQYqtNASLNe6OXyU/uFoXZS+cZFSjN
         Z5Og==
X-Gm-Message-State: AA+aEWZrPhGYyLm4sNElYFAIMZxSMiW7JiXvcZO8mEetetLJYnz2aA0k
        AETVC/pCZjuzvtkboiHhYHgk5V0goWo/HtZAJuLg0ywQB94j/25vmJQoB4vYNERx+z7VdtS94ie
        dO/MnM5vfqKYwTqJzt/I9EYJmttgaWvCSE9m1US++0g==
X-Received: by 2002:a62:e90a:: with SMTP id j10-v6mr12589766pfh.228.1543304672273;
        Mon, 26 Nov 2018 23:44:32 -0800 (PST)
X-Google-Smtp-Source: AFSGD/XeJQDwGo75ZXRjdPj7p30Rs2zG4ICq5v4lCRpF2QTIkS5AJcHXVhU+mMC7fk3+HWUWNrP4Ww==
X-Received: by 2002:a62:e90a:: with SMTP id j10-v6mr12589752pfh.228.1543304671889;
        Mon, 26 Nov 2018 23:44:31 -0800 (PST)
Received: from 2001-b011-380f-1339-7cc8-c5c9-88cf-1fae.dynamic-ip6.hinet.net (2001-b011-380f-1339-7cc8-c5c9-88cf-1fae.dynamic-ip6.hinet.net. [2001:b011:380f:1339:7cc8:c5c9:88cf:1fae])
        by smtp.gmail.com with ESMTPSA id f6sm3486626pfg.188.2018.11.26.23.44.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 23:44:30 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH v3] xhci: workaround CSS timeout on AMD SNPS 3.0 xHC
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <1542990218-30495-1-git-send-email-Sandeep.Singh@amd.com>
Date:   Tue, 27 Nov 2018 15:44:28 +0800
Cc:     "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <4B40F321-BE33-4D36-BE1A-59139D9AA711@canonical.com>
References: <1542990218-30495-1-git-send-email-Sandeep.Singh@amd.com>
To:     "Singh, Sandeep" <sandeep.singh@amd.com>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 24, 2018, at 00:24, Singh, Sandeep <sandeep.singh@amd.com> wrote:
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

Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

> ---
> Changes since v1:
> 
> -> New Variable based decision making when SNPS issue happens hence 
> -> quirk interdependency removed.
> -> Removed STS conditional check in suspend function.
> 
> Changes since v2:
> -> Updated quirk bit as per Kai-heng comment.
> 
> drivers/usb/host/xhci-pci.c |  4 ++++
> drivers/usb/host/xhci.c     | 26 ++++++++++++++++++++++----
> drivers/usb/host/xhci.h     |  3 +++
> 3 files changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index a951526..a9ec705 100644
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
> index c928dbb..c20b85e 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -968,6 +968,7 @@ int xhci_suspend(struct xhci_hcd *xhci, bool do_wakeup)
> 	unsigned int		delay = XHCI_MAX_HALT_USEC;
> 	struct usb_hcd		*hcd = xhci_to_hcd(xhci);
> 	u32			command;
> +	u32			res;
> 
> 	if (!hcd->state)
> 		return 0;
> @@ -1021,11 +1022,28 @@ int xhci_suspend(struct xhci_hcd *xhci, bool do_wakeup)
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
> @@ -1078,7 +1096,7 @@ int xhci_resume(struct xhci_hcd *xhci, bool hibernated)
> 	set_bit(HCD_FLAG_HW_ACCESSIBLE, &xhci->shared_hcd->flags);
> 
> 	spin_lock_irq(&xhci->lock);
> -	if (xhci->quirks & XHCI_RESET_ON_RESUME)
> +	if ((xhci->quirks & XHCI_RESET_ON_RESUME) || xhci->broken_suspend)
> 		hibernated = true;
> 
> 	if (!hibernated) {
> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> index 260b259..c3515ba 100644
> --- a/drivers/usb/host/xhci.h
> +++ b/drivers/usb/host/xhci.h
> @@ -1850,6 +1850,7 @@ struct xhci_hcd {
> #define XHCI_ZERO_64B_REGS	BIT_ULL(32)
> #define XHCI_DEFAULT_PM_RUNTIME_ALLOW	BIT_ULL(33)
> #define XHCI_RESET_PLL_ON_DISCONNECT	BIT_ULL(34)
> +#define XHCI_SNPS_BROKEN_SUSPEND    BIT_ULL(35)
> 
> 	unsigned int		num_active_eps;
> 	unsigned int		limit_active_eps;
> @@ -1879,6 +1880,8 @@ struct xhci_hcd {
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

