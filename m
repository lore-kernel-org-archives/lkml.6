Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751615AbeCNL2b (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 07:28:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:55746 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750855AbeCNL23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 07:28:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,470,1515484800";
   d="scan'208";a="38758397"
Date: Wed, 14 Mar 2018 13:28:24 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] thunderbolt: Prevent crash when ICM firmware is not
 running
Message-ID: <20180314112824.GZ2703@lahna.fi.intel.com>
References: <20180309104434.64412-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309104434.64412-1-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 01:44:34PM +0300, Mika Westerberg wrote:
> On Lenovo ThinkPad Yoga 370 (and possibly some other Lenovo models as
> well) the Thunderbolt host controller sometimes comes up in such way
> that the ICM firmware is not running properly. This is most likely an
> issue in BIOS/firmware but as side-effect driver crashes the kernel due
> to NULL pointer dereference:
> 
>   BUG: unable to handle kernel NULL pointer dereference at 0000000000000980
>   IP: pci_write_config_dword+0x5/0x20
>   Call Trace:
>    pcie2cio_write+0x3b/0x70 [thunderbolt]
>    icm_driver_ready+0x168/0x260 [thunderbolt]
>    ? tb_ctl_start+0x50/0x70 [thunderbolt]
>    tb_domain_add+0x73/0xf0 [thunderbolt]
>    nhi_probe+0x182/0x300 [thunderbolt]
>    local_pci_probe+0x42/0xa0
>    ? pci_match_device+0xd9/0x100
>    pci_device_probe+0x146/0x1b0
>    driver_probe_device+0x315/0x480
>    ...
> 
> Instead of crashing update the driver to bail out gracefully if we
> encounter such situation.
> 
> Fixes: f67cf491175a ("thunderbolt: Add support for Internal Connection Manager (ICM)")
> Reported-by: Jordan Glover <Golden_Miller83@protonmail.ch>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: stable@vger.kernel.org

Applied to thunderbolt.git/next.
