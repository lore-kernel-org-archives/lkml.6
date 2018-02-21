Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752501AbeBUIfF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 03:35:05 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:36441 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752335AbeBUIfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 03:35:04 -0500
Date: Wed, 21 Feb 2018 09:34:57 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Mike Kravetz <mike.kravetz@oracle.com>
cc: Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com,
        tony.luck@intel.com, gavin.hindman@intel.com,
        vikas.shivappa@linux.intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V2 13/22] x86/intel_rdt: Support schemata write -
 pseudo-locking core
In-Reply-To: <2db87a79-e13f-ad6b-c399-1ad58585f38e@oracle.com>
Message-ID: <alpine.DEB.2.21.1802210934060.24268@nanos.tec.linutronix.de>
References: <cover.1518443616.git.reinette.chatre@intel.com> <dbf01ddf087e4597f86a85c1c91c1fc942e70269.1518443616.git.reinette.chatre@intel.com> <alpine.DEB.2.21.1802200059240.1853@nanos.tec.linutronix.de> <6c960fc0-820e-757c-2770-d770647e63d6@intel.com>
 <alpine.DEB.2.21.1802202355240.24268@nanos.tec.linutronix.de> <2db87a79-e13f-ad6b-c399-1ad58585f38e@oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Feb 2018, Mike Kravetz wrote:
> On 02/20/2018 03:21 PM, Thomas Gleixner wrote:
> > The other problem is that we'd need to have MAP_CONTIG first so you
> > actually can allocate physically contigous memory from user space. Mike is
> > working on that, but it's not available today. The only way to do so today
> > (with lots of waste) would be MAP_HUGETLB, which might be an acceptable
> > constraint up to the point where MAP_CONTIG is available.
> 
> Just to clarify, there is not any activity on exposing a general purpose
> MAP_CONTIG interface to user space.  When initially proposed, MAP_CONTIG
> was shot down and the suggestion was to create a new in kernel interface
> to make allocation of contiguous pages easier.  The initial use case was
> a driver which could use the new internal interface as part of it's
> mmap() routine to give contiguous regions to user space.

Thanks for the clarification.

> Reinette is using this new interface, but that must be for the ?immediate
> allocation? case you are trying to move away from.  Sorry, I have not been
> following development of this feature.
> 
> If you would have to create a device to accept a user buffer, could you
> perhaps use the same device to create/hand out a contiguous mapping?

Yes, that's straight forward.

Thanks,

	tglx
