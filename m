Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752628AbeDBP4L (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 11:56:11 -0400
Received: from mga18.intel.com ([134.134.136.126]:50178 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751415AbeDBP4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 11:56:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,396,1517904000";
   d="scan'208";a="33545593"
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Tal Gilboa <talgi@mellanox.com>
CC: Tariq Toukan <tariqt@mellanox.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        "everest-linux-l2@cavium.com" <everest-linux-l2@cavium.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v5 12/14] fm10k: Report PCIe link properties with
 pcie_print_link_status()
Thread-Topic: [PATCH v5 12/14] fm10k: Report PCIe link properties with
 pcie_print_link_status()
Thread-Index: AQHTyGrxIzt7s2y8aE68Xz7ilEcaGaPtpMFg
Date: Mon, 2 Apr 2018 15:56:06 +0000
Message-ID: <02874ECE860811409154E81DA85FBB5882D497EE@ORSMSX115.amr.corp.intel.com>
References: <152244269202.135666.3064353823697623332.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152244397259.135666.12655029447932912161.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152244397259.135666.12655029447932912161.stgit@bhelgaas-glaptop.roam.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjVmY2VhOTktOWI0Ni00ZWY3LWFiZGUtZjM1NGY2MmJiY2Q3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE2LjUuOS4zIiwiVHJ1c3RlZExhYmVsSGFzaCI6IkhIeFRJYVhjUDk3QlJcL3dLVTdpQXhvOGgza0M2UW8rRW0waXNYSE16NGZBPSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w32FuLp2018061

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: Friday, March 30, 2018 2:06 PM
> To: Tal Gilboa <talgi@mellanox.com>
> Cc: Tariq Toukan <tariqt@mellanox.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Ariel Elior <ariel.elior@cavium.com>; Ganesh
> Goudar <ganeshgr@chelsio.com>; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; everest-linux-l2@cavium.com; intel-wired-
> lan@lists.osuosl.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-pci@vger.kernel.org
> Subject: [PATCH v5 12/14] fm10k: Report PCIe link properties with
> pcie_print_link_status()
> 
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Use pcie_print_link_status() to report PCIe link speed and possible
> limitations instead of implementing this in the driver itself.
> 
> Note that pcie_get_minimum_link() can return misleading information because
> it finds the slowest link and the narrowest link without considering the
> total bandwidth of the link.  If the path contains a 16 GT/s x1 link and a
> 2.5 GT/s x16 link, pcie_get_minimum_link() returns 2.5 GT/s x1, which
> corresponds to 250 MB/s of bandwidth, not the actual available bandwidth of
> about 2000 MB/s for a 16 GT/s x1 link.

This comment is about what's being fixed, so it would have been easier to parse if it were written to more clearly indicate that we're removing (and not adding) this behavior.

Aside from the commit message (which I don't feel strongly enough needs a re-send of the patch) this looks good to me.

Acked-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks Bjorn and Tal for fixing this!

> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c |   87 --------------------------
>  1 file changed, 1 insertion(+), 86 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
> b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
> index a434fecfdfeb..aa05fb534942 100644
> --- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
> @@ -2120,91 +2120,6 @@ static int fm10k_sw_init(struct fm10k_intfc *interface,
>  	return 0;
>  }
> 
> -static void fm10k_slot_warn(struct fm10k_intfc *interface)
> -{
> -	enum pcie_link_width width = PCIE_LNK_WIDTH_UNKNOWN;
> -	enum pci_bus_speed speed = PCI_SPEED_UNKNOWN;
> -	struct fm10k_hw *hw = &interface->hw;
> -	int max_gts = 0, expected_gts = 0;
> -
> -	if (pcie_get_minimum_link(interface->pdev, &speed, &width) ||
> -	    speed == PCI_SPEED_UNKNOWN || width ==
> PCIE_LNK_WIDTH_UNKNOWN) {
> -		dev_warn(&interface->pdev->dev,
> -			 "Unable to determine PCI Express bandwidth.\n");
> -		return;
> -	}
> -
> -	switch (speed) {
> -	case PCIE_SPEED_2_5GT:
> -		/* 8b/10b encoding reduces max throughput by 20% */
> -		max_gts = 2 * width;
> -		break;
> -	case PCIE_SPEED_5_0GT:
> -		/* 8b/10b encoding reduces max throughput by 20% */
> -		max_gts = 4 * width;
> -		break;
> -	case PCIE_SPEED_8_0GT:
> -		/* 128b/130b encoding has less than 2% impact on throughput */
> -		max_gts = 8 * width;
> -		break;
> -	default:
> -		dev_warn(&interface->pdev->dev,
> -			 "Unable to determine PCI Express bandwidth.\n");
> -		return;
> -	}
> -
> -	dev_info(&interface->pdev->dev,
> -		 "PCI Express bandwidth of %dGT/s available\n",
> -		 max_gts);
> -	dev_info(&interface->pdev->dev,
> -		 "(Speed:%s, Width: x%d, Encoding Loss:%s, Payload:%s)\n",
> -		 (speed == PCIE_SPEED_8_0GT ? "8.0GT/s" :
> -		  speed == PCIE_SPEED_5_0GT ? "5.0GT/s" :
> -		  speed == PCIE_SPEED_2_5GT ? "2.5GT/s" :
> -		  "Unknown"),
> -		 hw->bus.width,
> -		 (speed == PCIE_SPEED_2_5GT ? "20%" :
> -		  speed == PCIE_SPEED_5_0GT ? "20%" :
> -		  speed == PCIE_SPEED_8_0GT ? "<2%" :
> -		  "Unknown"),
> -		 (hw->bus.payload == fm10k_bus_payload_128 ? "128B" :
> -		  hw->bus.payload == fm10k_bus_payload_256 ? "256B" :
> -		  hw->bus.payload == fm10k_bus_payload_512 ? "512B" :
> -		  "Unknown"));
> -
> -	switch (hw->bus_caps.speed) {
> -	case fm10k_bus_speed_2500:
> -		/* 8b/10b encoding reduces max throughput by 20% */
> -		expected_gts = 2 * hw->bus_caps.width;
> -		break;
> -	case fm10k_bus_speed_5000:
> -		/* 8b/10b encoding reduces max throughput by 20% */
> -		expected_gts = 4 * hw->bus_caps.width;
> -		break;
> -	case fm10k_bus_speed_8000:
> -		/* 128b/130b encoding has less than 2% impact on throughput */
> -		expected_gts = 8 * hw->bus_caps.width;
> -		break;
> -	default:
> -		dev_warn(&interface->pdev->dev,
> -			 "Unable to determine expected PCI Express
> bandwidth.\n");
> -		return;
> -	}
> -
> -	if (max_gts >= expected_gts)
> -		return;
> -
> -	dev_warn(&interface->pdev->dev,
> -		 "This device requires %dGT/s of bandwidth for optimal
> performance.\n",
> -		 expected_gts);
> -	dev_warn(&interface->pdev->dev,
> -		 "A %sslot with x%d lanes is suggested.\n",
> -		 (hw->bus_caps.speed == fm10k_bus_speed_2500 ? "2.5GT/s " :
> -		  hw->bus_caps.speed == fm10k_bus_speed_5000 ? "5.0GT/s " :
> -		  hw->bus_caps.speed == fm10k_bus_speed_8000 ? "8.0GT/s " :
> ""),
> -		 hw->bus_caps.width);
> -}
> -
>  /**
>   * fm10k_probe - Device Initialization Routine
>   * @pdev: PCI device information struct
> @@ -2326,7 +2241,7 @@ static int fm10k_probe(struct pci_dev *pdev, const
> struct pci_device_id *ent)
>  	mod_timer(&interface->service_timer, (HZ * 2) + jiffies);
> 
>  	/* print warning for non-optimal configurations */
> -	fm10k_slot_warn(interface);
> +	pcie_print_link_status(interface->pdev);
> 
>  	/* report MAC address for logging */
>  	dev_info(&pdev->dev, "%pM\n", netdev->dev_addr);
