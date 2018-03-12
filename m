Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752202AbeCLIEF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 04:04:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42442 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751618AbeCLIEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 04:04:02 -0400
Date: Mon, 12 Mar 2018 01:04:02 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>, Sinan Kaya <okaya@codeaurora.org>,
        Lukas Wunner <lukas@wunner.de>, Frederick Lawler <fred@fredlawl.com>
Subject: Re: [PATCH v2 08/13] PCI/portdrv: Simplify PCIe feature permission
 checking
Message-ID: <20180312080402.GE10358@infradead.org>
References: <152062141493.77693.9630397416694091342.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152062203293.77693.8159909590216160503.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152062203293.77693.8159909590216160503.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	 * We assume we can manage these PCIe features.  Some systems may
> +	 * reserve these for use by the platform itself, e.g., an ACPI BIOS
> +	 * may implement its own AER handling and use _OSC to prevent the
> +	 * OS from interfering.
> +	 */
> +	bridge->use_aer = 1;
> +	bridge->use_hotplug = 1;
> +	bridge->use_pme = 1;

If we start out with enabled maybe these should be disable_foo flags
instead?

Also please use bool (or a bitfield bool) for true/false values.
