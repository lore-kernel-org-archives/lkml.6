Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754250AbeBMK1a (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 05:27:30 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:50201 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751685AbeBMK10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 05:27:26 -0500
Date: Tue, 13 Feb 2018 11:27:16 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Reinette Chatre <reinette.chatre@intel.com>
cc: "Hindman, Gavin" <gavin.hindman@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "vikas.shivappa@linux.intel.com" <vikas.shivappa@linux.intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 00/20] Intel(R) Resource Director Technology Cache
 Pseudo-Locking enabling
In-Reply-To: <0a93c952-070f-eb79-74d5-25c1df8a9791@intel.com>
Message-ID: <alpine.DEB.2.21.1802131114540.1130@nanos.tec.linutronix.de>
References: <cover.1510568528.git.reinette.chatre@intel.com> <alpine.DEB.2.20.1711180133540.2186@nanos> <93415e33-6adf-047f-9a46-0862c3cd33b6@intel.com> <alpine.DEB.2.20.1801142346200.2371@nanos> <D5D6254030DBC644B6EE58B333BFBB1E9D9F2F1C@FMSMSX151.amr.corp.intel.com>
 <alpine.DEB.2.20.1801161227180.1823@nanos> <0a93c952-070f-eb79-74d5-25c1df8a9791@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Feb 2018, Reinette Chatre wrote:
> On 1/16/2018 3:38 AM, Thomas Gleixner wrote:
> All tests involve a user space application that allocates (malloc() with
> mlockall()) or in the case of Cache Pseudo-Locking maps using mmap()) a
> 256KB region of memory. The application then randomly accesses this
> region, 32 bytes at a time, measuring the latency in cycles of each
> access using the rdtsc instruction. Each time a test is run it is
> repeated ten times.
> In both the PALLOC and CAT tests there was improvement (CAT most
> significant) in latency accessing a 256KB memory region but in both
> (PALLOC and CAT) 512KB of cache was set aside for application to obtain
> these results. Using Cache Pseudo-Locking to access the 256KB memory
> region only 256KB of cache was set aside while also reducing the access
> latency when compared to both PALLOC and CAT.
> 
> I do hope these results establishes the value of Cache Pseudo-Locking to
> you. 

Very nice. Thank you so much for doing this. That kind of data is really
valuable.

My take away from this: All of the mechanisms are only delivering best
effort and the real benefit is the reduction of average latency. The worst
case outliers are in the same ballpark at seems.

> The rebased patch series used in this testing will be sent out
> this week.

I'll make sure to have cycles available for review.

Thanks,

	tglx
