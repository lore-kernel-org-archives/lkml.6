Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755270AbeDTNwh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:52:37 -0400
Received: from mga12.intel.com ([192.55.52.136]:29448 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755008AbeDTNw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:52:27 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,301,1520924400";
   d="scan'208";a="39058058"
Date: Fri, 20 Apr 2018 16:52:22 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: John Garry <john.garry@huawei.com>
Cc: rjw@rjwysocki.net, andriy.shevchenko@linux.intel.com,
        linux-acpi@vger.kernel.org, lenb@kernel.org, lorenzo.pieralisi@arm.com,
        linux-kernel@vger.kernel.org, arnd@arndb.de, graeme.gregory@linaro.org,
        helgaas@kernel.org, linuxarm@huawei.com, z.liuxinliang@hisilicon.com
Subject: Re: [RFC PATCH 1/2] ACPI / PNP: Don't add "enumeration_by_parent"
 devices
Message-ID: <20180420135222.GY2173@lahna.fi.intel.com>
References: <1524218846-169934-1-git-send-email-john.garry@huawei.com>
 <1524218846-169934-2-git-send-email-john.garry@huawei.com>
 <20180420130727.GV2173@lahna.fi.intel.com>
 <27c3f84e-4d53-4b6b-7382-04908082ed01@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27c3f84e-4d53-4b6b-7382-04908082ed01@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 02:24:18PM +0100, John Garry wrote:
> Hi Mika,
> 
> On 20/04/2018 14:07, Mika Westerberg wrote:
> > On Fri, Apr 20, 2018 at 06:07:25PM +0800, John Garry wrote:
> > > +	} else {
> > > +		device->driver_data = dev;
> > 
> > I think this deserves a comment explaining why we (ab)use driver_data
> > like this.
> 
> Sure, could add. I didn't see any other way for the acpi_device structure to
> reference the derived PNP device.
> 
> TBH, This overall approach is not good since we are creating the PNP device
> in the scan, and then leaving the device in limbo, waiting for the parent to
> add it, if at all. There's no rule for this.
> 
> So I'm looking for ideas on how to improve this.

One idea is to make pnpacpi_add_device() available outside of PNP and
call it directly (or some variation) in hisi_lpc.c when it walks over
its children.
