Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752222AbeBZNiI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 08:38:08 -0500
Received: from mga12.intel.com ([192.55.52.136]:45599 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751605AbeBZNiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 08:38:06 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,396,1515484800";
   d="scan'208";a="207110677"
Date: Mon, 26 Feb 2018 15:38:02 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Jeremy McNicoll <jmcnicol@redhat.com>
Cc: linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Mario.Limonciello@dell.com,
        Radion Mirchevsky <radion.mirchevsky@intel.com>
Subject: Re: [07/18] thunderbolt: Handle rejected Thunderbolt devices
Message-ID: <20180226133802.GR27191@lahna.fi.intel.com>
References: <20180213170018.9780-8-mika.westerberg@linux.intel.com>
 <20180222231736.GA628@mini-rhel.redhat.com>
 <20180226102029.GG27191@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226102029.GG27191@lahna.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 12:20:29PM +0200, Mika Westerberg wrote:
> On Thu, Feb 22, 2018 at 03:17:38PM -0800, Jeremy McNicoll wrote:
> > > +	if (pkg->link_info & ICM_LINK_INFO_REJECTED) {
> > > +		tb_info(tb, "switch at %u.%u was rejected by ICM firmware\n",
> > > +			link, depth);
> > 
> > This kind of condition sounds more like an error instead of info.
> > Please bump this up to tb_WARN/tb_warn ideally tb_err().
> 
> No, this is not an error.

To be more clear, it is totally fine to have the firmware to reject some
devices. For example in case of the new usbonly security level the
firmware rejects other devices but the first.
