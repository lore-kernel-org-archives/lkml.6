Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753885AbeBSUf2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:35:28 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:60198 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753593AbeBSUfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:35:25 -0500
Date: Mon, 19 Feb 2018 21:35:16 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, tony.luck@intel.com, gavin.hindman@intel.com,
        vikas.shivappa@linux.intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V2 01/22] x86/intel_rdt: Documentation for Cache
 Pseudo-Locking
In-Reply-To: <9416db57e47e2040a7108ba269f5432d0c91f1f7.1518443616.git.reinette.chatre@intel.com>
Message-ID: <alpine.DEB.2.21.1802192104210.1853@nanos.tec.linutronix.de>
References: <cover.1518443616.git.reinette.chatre@intel.com> <9416db57e47e2040a7108ba269f5432d0c91f1f7.1518443616.git.reinette.chatre@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-219678201-1519070685=:1853"
Content-ID: <alpine.DEB.2.21.1802192106400.1853@nanos.tec.linutronix.de>
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-219678201-1519070685=:1853
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.21.1802192106401.1853@nanos.tec.linutronix.de>

On Tue, 13 Feb 2018, Reinette Chatre wrote:
> +Cache Pseudo-Locking
> +--------------------
> +CAT enables a user to specify the amount of cache space into which an
> +application can fill. Cache pseudo-locking builds on the fact that a
> +CPU can still read and write data pre-allocated outside its current
> +allocated area on a cache hit. With cache pseudo-locking, data can be
> +preloaded into a reserved portion of cache that no application can
> +fill, and from that point on will only serve cache hits.

This lacks explanation how that preloading works.

> The cache
> +pseudo-locked memory is made accessible to user space where an
> +application can map it into its virtual address space and thus have
> +a region of memory with reduced average read latency.
> +
> +Cache pseudo-locking increases the probability that data will remain
> +in the cache via carefully configuring the CAT feature and controlling
> +application behavior. There is no guarantee that data is placed in
> +cache. Instructions like INVD, WBINVD, CLFLUSH, etc. can still evict
> +“locked” data from cache. Power management C-states may shrink or
> +power off cache. It is thus recommended to limit the processor maximum
> +C-state, for example, by setting the processor.max_cstate kernel parameter.
> +
> +It is required that an application using a pseudo-locked region runs
> +with affinity to the cores (or a subset of the cores) associated
> +with the cache on which the pseudo-locked region resides. This is
> +enforced by the implementation.

Well, you only enforce in pseudo_lock_dev_mmap() that the caller is affine
to the right CPUs. But that's not a guarantee that the task stays there.

Thanks,

	tglx
--8323329-219678201-1519070685=:1853--
