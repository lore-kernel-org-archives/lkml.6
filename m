Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933781AbeB1TlR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 14:41:17 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:49440 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933385AbeB1TlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 14:41:16 -0500
Date: Wed, 28 Feb 2018 20:40:43 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, tony.luck@intel.com, gavin.hindman@intel.com,
        vikas.shivappa@linux.intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V2 13/22] x86/intel_rdt: Support schemata write -
 pseudo-locking core
In-Reply-To: <7695220e-2503-d598-d9bd-cd0256028fce@intel.com>
Message-ID: <alpine.DEB.2.21.1802282039020.1392@nanos.tec.linutronix.de>
References: <cover.1518443616.git.reinette.chatre@intel.com> <dbf01ddf087e4597f86a85c1c91c1fc942e70269.1518443616.git.reinette.chatre@intel.com> <alpine.DEB.2.21.1802200059240.1853@nanos.tec.linutronix.de> <73fb98d2-ce93-0443-b909-fde75908cc1e@intel.com>
 <alpine.DEB.2.21.1802271109300.1886@nanos.tec.linutronix.de> <69ed85f2-b9c5-30d1-8437-45f20be3e95e@intel.com> <alpine.DEB.2.21.1802281924390.1392@nanos.tec.linutronix.de> <7695220e-2503-d598-d9bd-cd0256028fce@intel.com>
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
> On 2/28/2018 10:39 AM, Thomas Gleixner wrote:
> > I came up with this under the assumptions:
> > 
> >   1) One locked region per resource group
> >   2) Drop closid after locking
> 
> I am also now working under these assumptions ...
> 
> > Then the restrict file makes a lot of sense because it would give a clear
> > selection of the possible resource to lock.
> 
> ... but I am still stuck on why this restrict file is needed at this
> time. Surely it would be needed if later we add the more flexible
> exclusive mode, but I do not understand how it helps the locked mode.

You're right. Brainfart on my side. With that scheme it's really only
useful for a flexible exclusive mode, which would be nice to have but is
not a prerequisite for now.

Thanks,

	tglx
