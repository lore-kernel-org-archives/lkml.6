Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9303ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B44C20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="jDXDmhNM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B44C20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388149AbeGWWEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:04:51 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:37958 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388077AbeGWWEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:04:50 -0400
Received: by mail-qk0-f193.google.com with SMTP id 126-v6so1341011qke.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 14:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=QFrbF5EwtUdkExr4pnq5M6EyiXf10nZDfTGNARNHvCs=;
        b=jDXDmhNMSML+f/QM5Kz/YX0bckEdHzwt3exuXFwt0LmDngWwzACLowUsK4YrmtFC0d
         3DRMS7T/FGcJN/hwhBDj7VQBERd7eTod7M6BzYH9wqwlObR6H5Hj1Me+Yd0asHSUabzM
         bXf0vnEYcQAKylf4hlCo5+ZRr8a+SDVqIVX2Hw1jc04slXtDIVMTcfYjEVUXL4aYGe2N
         0EAaC4Bc7j2z0k/R8ZaB3P2AGUhiJBfyTA1wMlv3b7Tq5+gpYIcqrljEFhXt3YJhvSU2
         WIOfp/UBinZOPbQwXpv2qZzNkapjSCAJELiYMaN1nNbvqSQrPk7s4RnI9AHUzjPj6YUn
         t4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=QFrbF5EwtUdkExr4pnq5M6EyiXf10nZDfTGNARNHvCs=;
        b=Yg83gDbRmzMqXVm/jTQgJOJG9AiI6RkNDgFtGWp09d5gyMPgClOTcBP/GAz9iBXPxG
         /N+EOGzYGeMf0dUUMzhbk8vwf1g20fCCOIaKNTqB9v4iMGgpP6suHVzHxMYc6Hlr1Dfo
         OVg1zGfryz3Qx47bnJRJkNB4hHGiVvZrLJaIQ9FUzNG156kVP2W02IAf6Wu1iigTU2Ci
         H9HQvN0ddEbY59LzRhF4cphzFKu7OLuOVdIChd7gl2GFFD71xuexoiRs8QI5r9TagsM9
         Iqupj7vVoVJDbYc4HC/fazNAYZKdalL4ahg20J670nZjMX4lRecJlQZXGu4WqE6xnQ49
         1eqw==
X-Gm-Message-State: AOUpUlEmKdJiYrgtl7H0Cn63hMUSXvgcLhXY5+u9LXm54BfWLaBH9U7l
        YB7A7oROwmo+XEOru5Jajm97jA==
X-Google-Smtp-Source: AAOMgpe8d4xW/DQVFL9TaiZtajuUL3xjq0OmHFFX3ltmhfjAMw24cMWVuOejJGcUkrBLnWjDjpR2hQ==
X-Received: by 2002:a37:7004:: with SMTP id l4-v6mr12336344qkc.83.1532379708938;
        Mon, 23 Jul 2018 14:01:48 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id y21-v6sm9060124qtc.41.2018.07.23.14.01.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 14:01:48 -0700 (PDT)
Date:   Mon, 23 Jul 2018 14:01:43 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        keith.busch@intel.com, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        jeffrey.t.kirsher@intel.com, ariel.elior@cavium.com,
        michael.chan@broadcom.com, ganeshgr@chelsio.com,
        tariqt@mellanox.com, airlied@gmail.com, alexander.deucher@amd.com,
        mike.marciniszyn@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] PCI: Check for PCIe downtraining conditions
Message-ID: <20180723140143.1a46902f@cakuba.netronome.com>
In-Reply-To: <20180723200339.23943-1-mr.nuke.me@gmail.com>
References: <20180718215359.GG128988@bhelgaas-glaptop.roam.corp.google.com>
        <20180723200339.23943-1-mr.nuke.me@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jul 2018 15:03:38 -0500, Alexandru Gagniuc wrote:
> PCIe downtraining happens when both the device and PCIe port are
> capable of a larger bus width or higher speed than negotiated.
> Downtraining might be indicative of other problems in the system, and
> identifying this from userspace is neither intuitive, nor
> straightforward.
> 
> The easiest way to detect this is with pcie_print_link_status(),
> since the bottleneck is usually the link that is downtrained. It's not
> a perfect solution, but it works extremely well in most cases.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
> 
> For the sake of review, I've created a __pcie_print_link_status() which
> takes a 'verbose' argument. If we agree want to go this route, and update
> the users of pcie_print_link_status(), I can split this up in two patches.
> I prefer just printing this information in the core functions, and letting
> drivers not have to worry about this. Though there seems to be strong for
> not going that route, so here it goes:

FWIW the networking drivers print PCIe BW because sometimes the network
bandwidth is simply over-provisioned on multi port cards, e.g. 80Gbps
card on a x8 link.

Sorry to bike shed, but currently the networking cards print the info
during probe.  Would it make sense to move your message closer to probe
time?  Rather than when device is added.  If driver structure is
available, we could also consider adding a boolean to struct pci_driver
to indicate if driver wants the verbose message?  This way we avoid
duplicated prints.

I have no objection to current patch, it LGTM.  Just a thought.

>  drivers/pci/pci.c   | 22 ++++++++++++++++++----
>  drivers/pci/probe.c | 21 +++++++++++++++++++++
>  include/linux/pci.h |  1 +
>  3 files changed, 40 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 316496e99da9..414ad7b3abdb 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5302,14 +5302,15 @@ u32 pcie_bandwidth_capable(struct pci_dev *dev, enum pci_bus_speed *speed,
>  }
>  
>  /**
> - * pcie_print_link_status - Report the PCI device's link speed and width
> + * __pcie_print_link_status - Report the PCI device's link speed and width
>   * @dev: PCI device to query
> + * @verbose: Be verbose -- print info even when enough bandwidth is available.
>   *
>   * Report the available bandwidth at the device.  If this is less than the
>   * device is capable of, report the device's maximum possible bandwidth and
>   * the upstream link that limits its performance to less than that.
>   */
> -void pcie_print_link_status(struct pci_dev *dev)
> +void __pcie_print_link_status(struct pci_dev *dev, bool verbose)
>  {
>  	enum pcie_link_width width, width_cap;
>  	enum pci_bus_speed speed, speed_cap;
> @@ -5319,11 +5320,11 @@ void pcie_print_link_status(struct pci_dev *dev)
>  	bw_cap = pcie_bandwidth_capable(dev, &speed_cap, &width_cap);
>  	bw_avail = pcie_bandwidth_available(dev, &limiting_dev, &speed, &width);
>  
> -	if (bw_avail >= bw_cap)
> +	if (bw_avail >= bw_cap && verbose)
>  		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth (%s x%d link)\n",
>  			 bw_cap / 1000, bw_cap % 1000,
>  			 PCIE_SPEED2STR(speed_cap), width_cap);
> -	else
> +	else if (bw_avail < bw_cap)
>  		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth, limited by %s x%d link at %s (capable of %u.%03u Gb/s with %s x%d link)\n",
>  			 bw_avail / 1000, bw_avail % 1000,
>  			 PCIE_SPEED2STR(speed), width,
> @@ -5331,6 +5332,19 @@ void pcie_print_link_status(struct pci_dev *dev)
>  			 bw_cap / 1000, bw_cap % 1000,
>  			 PCIE_SPEED2STR(speed_cap), width_cap);
>  }
> +
> +/**
> + * pcie_print_link_status - Report the PCI device's link speed and width
> + * @dev: PCI device to query
> + *
> + * Report the available bandwidth at the device.  If this is less than the
> + * device is capable of, report the device's maximum possible bandwidth and
> + * the upstream link that limits its performance to less than that.
> + */
> +void pcie_print_link_status(struct pci_dev *dev)
> +{
> +	__pcie_print_link_status(dev, true);
> +}
>  EXPORT_SYMBOL(pcie_print_link_status);
>  
>  /**
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index ac876e32de4b..1f7336377c3b 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2205,6 +2205,24 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
>  	return dev;
>  }
>  
> +static void pcie_check_upstream_link(struct pci_dev *dev)
> +{
> +	if (!pci_is_pcie(dev))
> +		return;
> +
> +	/* Look from the device up to avoid downstream ports with no devices. */
> +	if ((pci_pcie_type(dev) != PCI_EXP_TYPE_ENDPOINT) &&
> +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_LEG_END) &&
> +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM))
> +		return;
> +
> +	/* Multi-function PCIe share the same link/status. */
> +	if (PCI_FUNC(dev->devfn) != 0 || dev->is_virtfn)
> +		return;
> +
> +	__pcie_print_link_status(dev, false);
> +}
> +
>  static void pci_init_capabilities(struct pci_dev *dev)
>  {
>  	/* Enhanced Allocation */
> @@ -2240,6 +2258,9 @@ static void pci_init_capabilities(struct pci_dev *dev)
>  	/* Advanced Error Reporting */
>  	pci_aer_init(dev);
>  
> +	/* Check link and detect downtrain errors */
> +	pcie_check_upstream_link(dev);
> +
>  	if (pci_probe_reset_function(dev) == 0)
>  		dev->reset_fn = 1;
>  }
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index abd5d5e17aee..15bfab8f7a1b 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1088,6 +1088,7 @@ int pcie_set_mps(struct pci_dev *dev, int mps);
>  u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
>  			     enum pci_bus_speed *speed,
>  			     enum pcie_link_width *width);
> +void __pcie_print_link_status(struct pci_dev *dev, bool verbose);
>  void pcie_print_link_status(struct pci_dev *dev);
>  int pcie_flr(struct pci_dev *dev);
>  int __pci_reset_function_locked(struct pci_dev *dev);

