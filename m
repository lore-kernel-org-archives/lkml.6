Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932251AbeBSXTq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 18:19:46 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:60419 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932169AbeBSXTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 18:19:45 -0500
Date: Tue, 20 Feb 2018 00:19:49 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, tony.luck@intel.com, gavin.hindman@intel.com,
        vikas.shivappa@linux.intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V2 11/22] x86/intel_rdt: Associate pseudo-locked
 regions with its domain
In-Reply-To: <7bd1f8e8-116f-bdb2-23d2-a94f9a21e028@intel.com>
Message-ID: <alpine.DEB.2.21.1802200017130.1853@nanos.tec.linutronix.de>
References: <cover.1518443616.git.reinette.chatre@intel.com> <216ad1ef8314dc578a900ff8b06248464f5aa2ee.1518443616.git.reinette.chatre@intel.com> <alpine.DEB.2.21.1802192218370.1853@nanos.tec.linutronix.de> <7bd1f8e8-116f-bdb2-23d2-a94f9a21e028@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Feb 2018, Reinette Chatre wrote:

> Hi Thomas,
> 
> On 2/19/2018 1:19 PM, Thomas Gleixner wrote:
> > On Tue, 13 Feb 2018, Reinette Chatre wrote:
> > 
> >> After a pseudo-locked region is locked it needs to be associated with
> >> the RDT domain representing the pseudo-locked cache so that its life
> >> cycle can be managed correctly.
> >>
> >> Only a single pseudo-locked region can exist on any cache instance so we
> >> maintain a single pointer to a pseudo-locked region from each RDT
> >> domain.
> > 
> > Why is only a single pseudo locked region possible? 
> 
> The setup of a pseudo-locked region requires the usage of wbinvd. If a
> second pseudo-locked region is thus attempted it will evict the
> pseudo-locked data of the first.

Why does it neeed wbinvd? wbinvd is a big hammer. What's wrong with clflush?

Thanks,

	tglx
