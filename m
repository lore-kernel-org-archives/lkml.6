Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932198AbeBSUnf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:43:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:49042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932096AbeBSUnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:43:33 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 182A620C51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Mon, 19 Feb 2018 14:43:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Jayachandran Nair <Jayachandran.Nair@cavium.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Robert Richter <Robert.Richter@cavium.com>,
        Tom Vaden <tom.vaden@hpe.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        George Cherian <george.cherian@cavium.com>
Subject: Re: [PATCH v1 0/2] PCI: Probe for reset support earlier
Message-ID: <20180219204331.GB48133@bhelgaas-glaptop.roam.corp.google.com>
References: <20180216224213.67295.2251.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216224213.67295.2251.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 04:50:03PM -0600, Bjorn Helgaas wrote:
> The PCI core currently uses a late_initcall to probe each device for
> whether it supports reset.  This is dangerous because a driver may have
> already claimed the device by this point, and the PCI core should not
> interfere with the driver by touching the device on its own.
> 
> These patches move the probe to be earlier, during enumeration, before a
> driver has a chance to claim the device.
> 
> ---
> 
> Bjorn Helgaas (2):
>       PCI: Probe for device reset support before driver claim
>       PCI: Remove redundant probes for device reset support
> 
> 
>  drivers/pci/pci-sysfs.c |    3 +--
>  drivers/pci/pci.c       |   15 ++++++---------
>  drivers/pci/probe.c     |    3 +++
>  3 files changed, 10 insertions(+), 11 deletions(-)

Applied both to pci/virtualization with Rafael's reviewed-by (and
update to comment to s/D3hot/D3/) for v4.17.
