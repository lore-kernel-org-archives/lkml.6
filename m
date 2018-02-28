Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932936AbeB1Smf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 13:42:35 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:49327 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932373AbeB1Sme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 13:42:34 -0500
Date: Wed, 28 Feb 2018 19:42:26 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, tony.luck@intel.com, gavin.hindman@intel.com,
        vikas.shivappa@linux.intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V2 13/22] x86/intel_rdt: Support schemata write -
 pseudo-locking core
In-Reply-To: <057523c7-5192-9a29-ca04-a8b299ef9685@intel.com>
Message-ID: <alpine.DEB.2.21.1802281939490.1392@nanos.tec.linutronix.de>
References: <cover.1518443616.git.reinette.chatre@intel.com> <dbf01ddf087e4597f86a85c1c91c1fc942e70269.1518443616.git.reinette.chatre@intel.com> <alpine.DEB.2.21.1802200059240.1853@nanos.tec.linutronix.de> <85c96e41-5a54-d3dd-bda4-d8ef9c28b1d8@intel.com>
 <alpine.DEB.2.21.1802281819390.1392@nanos.tec.linutronix.de> <alpine.DEB.2.21.1802281858420.1392@nanos.tec.linutronix.de> <057523c7-5192-9a29-ca04-a8b299ef9685@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Feb 2018, Reinette Chatre wrote:
> On 2/28/2018 9:59 AM, Thomas Gleixner wrote:
> I hesitated doing something like this because during the review of this
> series there was resistance to using sysfs files for multiple values. I
> will proceed with your suggestion noting that it is tied with schemata file.

It's not sysfs, it's resctrl fs. So we have already multiple lines and
values, e.g. in the schemata file.

> I do not think we need these special labels for CDP though. From what I
> understand when CDP is enabled there will be two new resources in the
> info directory. For example,
> 
> info/L3DATA/
> info/L3CODE/
> 
> Each would have its own file(s) noting which bits are in use.
> 
> At this time I am also not enabling pseudo-locking when CDP is enabled
> so the locked label is not needed.

The locked label is needed for the !CDP case so you can see where the
locked regions are in a bitmap

> There is already the file "shareable_bits" in the info directory
> associated with each resource. At the moment it only reflects the bits
> that could be used by other entities on the system. Considering its name
> and us now introducing the idea of "shareable" I was thinking of adding
> all "shareable" bits (hardware and software) of this resource to this
> file. This still leaves the new "inuse_bits" (or perhaps "unused_bits")
> info file that will communicate the "exclusive" and "locked" bits in
> addition so what is in "shareable_bits". Between these two files users
> should have information needed to choose regions for their tasks. These
> would all use bitmap displays.

Yeah, that needs some thought, but I happily let you sort out the details.

Thanks,

	tglx
