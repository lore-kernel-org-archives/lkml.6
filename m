Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09E2C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6170821738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbWTSZNM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfA1LKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 06:10:05 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41107 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfA1LKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 06:10:04 -0500
Received: by mail-pl1-f193.google.com with SMTP id u6so7592027plm.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 03:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tookZhE3Gg07eSYnAqmj5WiXGGx7H53YDBTeTnabsdc=;
        b=LbWTSZNMqzJhpBX4a+OTlNIIOKilIx9dE1BuT6ckIsnqg3AfxA+w8MFrzplrrl/cnQ
         6O/50N6JlAr1SO+UTOCxJ/dLdAfaS+O6VuDKlpcPqAFM51/n6uUtd9V6IQTzPOW7QWuq
         k6yNAAqGh7ffbyVYiNV9nQnDu0F+U9URLB8O4jsZg/nJaYgna4XlxUthn4VUtPK8aYi4
         1XsIk0ZccIpZ77dlSxm5jrxjhDj14WwgC0hlwodRN6s2XhNGcxF0Pz0ohzBSLk+9tHXT
         dpnP2jOJIitMKpacTB+Xes/h/4wi+COBI9NvrvmLOxKJuIJDkwLWpDwiEXldh1alEFWb
         iJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tookZhE3Gg07eSYnAqmj5WiXGGx7H53YDBTeTnabsdc=;
        b=CWHGdo03ZtX+ZXbs6o2fKPTTuevwtsu8aQSzNZ3TqpILzfl15Hd4B/uMU7p+2lJxpG
         eZ9Drc45xVpBWgpSmJf4DRjZisNn2L8Pg7QgUp5u9aOceQV/PhfBBQDAEzEi3LKcKUIB
         pnLq/kWNYVtDjPa4aAroCFxHQzx1dpy3sEJ4EbqAbHhgnnZ8HL0CoK4W8NyxX25bRYAI
         jEUPkqRdzkIddJLsmfVjDOCpWEVxEWKcgO6DMwKzdcJesP24AZTum8M74MT/rnxhZbnx
         ONTtIHN9+V9mu62DRGn1JziIaM+cfIYtVGCiE7mjfT05AaGr4b7s7UHHw8XhRrc4BkbM
         KX9g==
X-Gm-Message-State: AJcUukdCfmhTgZU+xIZkdIMfrZ38j0zM2PSs0LL/LSovX6mTHaI7Ptiz
        X6Yu/ZhEimq97/LBV7V7aZw=
X-Google-Smtp-Source: ALg8bN7MZ+beb4wnUlU4G36UZ5ySXa7Kg2Kp2eAAyDX3TdAkwES4oErHjhEmG2oH7U+qWMiNU2c1Mw==
X-Received: by 2002:a17:902:7107:: with SMTP id a7mr21318054pll.290.1548673803282;
        Mon, 28 Jan 2019 03:10:03 -0800 (PST)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.gmail.com with ESMTPSA id d6sm46571537pgc.89.2019.01.28.03.10.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 03:10:02 -0800 (PST)
Date:   Mon, 28 Jan 2019 22:09:58 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
        mhocko@suse.com, linux-nvdimm@lists.01.org, tiwai@suse.de,
        ying.huang@intel.com, linux-mm@kvack.org, jglisse@redhat.com,
        bp@suse.de, baiyaowei@cmss.chinamobile.com, zwisler@kernel.org,
        bhelgaas@google.com, fengguang.wu@intel.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH 0/5] [v4] Allow persistent memory to be used like normal
 RAM
Message-ID: <20190128110958.GH26056@350D>
References: <20190124231441.37A4A305@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124231441.37A4A305@viggo.jf.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 03:14:41PM -0800, Dave Hansen wrote:
> v3 spurred a bunch of really good discussion.  Thanks to everybody
> that made comments and suggestions!
> 
> I would still love some Acks on this from the folks on cc, even if it
> is on just the patch touching your area.
> 
> Note: these are based on commit d2f33c19644 in:
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git libnvdimm-pending
> 
> Changes since v3:
>  * Move HMM-related resource warning instead of removing it
>  * Use __request_resource() directly instead of devm.
>  * Create a separate DAX_PMEM Kconfig option, complete with help text
>  * Update patch descriptions and cover letter to give a better
>    overview of use-cases and hardware where this might be useful.
> 
> Changes since v2:
>  * Updates to dev_dax_kmem_probe() in patch 5:
>    * Reject probes for devices with bad NUMA nodes.  Keeps slow
>      memory from being added to node 0.
>    * Use raw request_mem_region()
>    * Add comments about permanent reservation
>    * use dev_*() instead of printk's
>  * Add references to nvdimm documentation in descriptions
>  * Remove unneeded GPL export
>  * Add Kconfig prompt and help text
> 
> Changes since v1:
>  * Now based on git://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git
>  * Use binding/unbinding from "dax bus" code
>  * Move over to a "dax bus" driver from being an nvdimm driver
> 
> --
> 
> Persistent memory is cool.  But, currently, you have to rewrite
> your applications to use it.  Wouldn't it be cool if you could
> just have it show up in your system like normal RAM and get to
> it like a slow blob of memory?  Well... have I got the patch
> series for you!
> 
> == Background / Use Cases ==
> 
> Persistent Memory (aka Non-Volatile DIMMs / NVDIMMS) themselves
> are described in detail in Documentation/nvdimm/nvdimm.txt.
> However, this documentation focuses on actually using them as
> storage.  This set is focused on using NVDIMMs as DRAM replacement.
> 
> This is intended for Intel-style NVDIMMs (aka. Intel Optane DC
> persistent memory) NVDIMMs.  These DIMMs are physically persistent,
> more akin to flash than traditional RAM.  They are also expected to
> be more cost-effective than using RAM, which is why folks want this
> set in the first place.

What variant of NVDIMM's F/P or both?

> 
> This set is not intended for RAM-based NVDIMMs.  Those are not
> cost-effective vs. plain RAM, and this using them here would simply
> be a waste.
> 

Sounds like NVDIMM (P)

> But, why would you bother with this approach?  Intel itself [1]
> has announced a hardware feature that does something very similar:
> "Memory Mode" which turns DRAM into a cache in front of persistent
> memory, which is then as a whole used as normal "RAM"?
> 
> Here are a few reasons:
> 1. The capacity of memory mode is the size of your persistent
>    memory that you dedicate.  DRAM capacity is "lost" because it
>    is used for cache.  With this, you get PMEM+DRAM capacity for
>    memory.
> 2. DRAM acts as a cache with memory mode, and caches can lead to
>    unpredictable latencies.  Since memory mode is all-or-nothing
>    (either all your DRAM is used as cache or none is), your entire
>    memory space is exposed to these unpredictable latencies.  This
>    solution lets you guarantee DRAM latencies if you need them.
> 3. The new "tier" of memory is exposed to software.  That means
>    that you can build tiered applications or infrastructure.  A
>    cloud provider could sell cheaper VMs that use more PMEM and
>    more expensive ones that use DRAM.  That's impossible with
>    memory mode.
> 
> Don't take this as criticism of memory mode.  Memory mode is
> awesome, and doesn't strictly require *any* software changes (we
> have software changes proposed for optimizing it though).  It has
> tons of other advantages over *this* approach.  Basically, we
> believe that the approach in these patches is complementary to
> memory mode and that both can live side-by-side in harmony.
> 
> == Patch Set Overview ==
> 
> This series adds a new "driver" to which pmem devices can be
> attached.  Once attached, the memory "owned" by the device is
> hot-added to the kernel and managed like any other memory.  On
> systems with an HMAT (a new ACPI table), each socket (roughly)
> will have a separate NUMA node for its persistent memory so
> this newly-added memory can be selected by its unique NUMA
> node.


NUMA is distance based topology, does HMAT solve these problems?
How do we prevent fallback nodes of normal nodes being pmem nodes?
On an unexpected crash/failure is there a scrubbing mechanism
or do we rely on the allocator to do the right thing prior to
reallocating any memory. Will frequent zero'ing hurt NVDIMM/pmem's
life times?

Balbir Singh.
