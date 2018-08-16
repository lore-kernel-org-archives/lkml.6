Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB13C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588D5214C5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:48:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588D5214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389486AbeHPKoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 06:44:55 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40000 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730404AbeHPKoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 06:44:55 -0400
Received: by mail-wm0-f65.google.com with SMTP id y9-v6so3430413wma.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 00:48:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4mDVOC4nWJuLveIxPLy2FA/YyWRuUjtQSnCsQcteGbY=;
        b=UgjVmvU1xrIvRu/hJrvBFKNZbYG2K3gOUtNpQ/bMUzLpW6LJ2sB8uQuRwenbLjxrky
         h7XXUMByjOOpxhzMhwjvusP9kPZXI1q+PxrZgQzC756Xwnfsc+XcyAqXIdwNjtIJuvqo
         qvSMxgU51+0aJzAToKNXVBBYRS7nYWpFrZNs4m5ceZ38M1QiTBfmbGQwBmzNBE4yFBEU
         Otk9+2yn8ATv8lHEgCHtFR3ab1iAW1nJtYFconVqcFURE4u06RNYlSA2QsyWlHuPWGtD
         XUU5vsPr4OsyAZdtDfACcTKTkc/4ilQQeIHbS82JHgUwoUlwCLyMsF+CF8xHNnVDXEmi
         Gr7g==
X-Gm-Message-State: AOUpUlGHW6cGNPZqnI4R0UniKITSYU/oEfRyT/KSfD0EeSaaoBLfQH/S
        9ZHAZKdMjo0a+niNSEFXVw0=
X-Google-Smtp-Source: AA+uWPzLnWrBIJ8QV3BtSmNH1PzoEjHp8V7PNhtPoToyS6GnMl67dzNgMZBlwlAE9tSb1EdYVqRZ6A==
X-Received: by 2002:a1c:e409:: with SMTP id b9-v6mr14577124wmh.34.1534405695447;
        Thu, 16 Aug 2018 00:48:15 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id 200-v6sm988292wmv.6.2018.08.16.00.48.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 00:48:14 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id ED6721248CD; Thu, 16 Aug 2018 09:48:13 +0200 (CEST)
Date:   Thu, 16 Aug 2018 09:48:13 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     mhocko@suse.com, vbabka@suse.cz, dan.j.williams@intel.com,
        yasu.isimatu@gmail.com, jonathan.cameron@huawei.com,
        david@redhat.com, Pavel.Tatashin@microsoft.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v3 3/4] mm/memory_hotplug: Refactor
 unregister_mem_sect_under_nodes
Message-ID: <20180816074813.GA16221@techadventures.net>
References: <20180815144219.6014-1-osalvador@techadventures.net>
 <20180815144219.6014-4-osalvador@techadventures.net>
 <20180815150121.7ec35ddabf18aea88d84437f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180815150121.7ec35ddabf18aea88d84437f@linux-foundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 03:01:21PM -0700, Andrew Morton wrote:
> Oh boy, lots of things.
> 
> That small GFP_KERNEL allocation will basically never fail.  In the
> exceedingly-rare-basically-never-happens case, simply bailing out of
> unregister_mem_sect_under_nodes() seems acceptable.  But I guess that
> addressing it is a reasonable thing to do, if it can be done sanely.

Yes, I think this can be fixed as the patch showed.
Currently, if we bail out, we will have dangled symlinks, but we do not
really need to bail out, as we can proceed anyway.

> But given that your new unregister_mem_sect_under_nodes() can proceed
> happily even if the allocation failed, what's the point in allocating
> the nodemask at all?  Why not just go ahead and run sysfs_remove_link()
> against possibly-absent sysfs objects every time?  That produces
> simpler code and avoids having this basically-never-executed-or-tested
> code path in there.

Unless I am mistaken, the whole point to allocate a nodemask_t there is to
try to perform as less operations as possible.
If we already unlinked a link, let us not call syfs_remove_link again,
although doing it more than once on the same node is not harmful.
I will have a small impact in performance though, as we will repeat
operations.

Of course we can get rid of the nodemask_t and just call syfs_remove_link,
but I wonder if that is a bit suboptimal.

> Incidentally, do we have locking in place to prevent
> unregister_mem_sect_under_nodes() from accidentally removing sysfs
> nodes which were added 2 nanoseconds ago by a concurrent thread?

Well, remove_memory() and  add_memory_resource() is being serialized with
mem_hotplug_begin()/mem_hotplug_done().

Since registering node's on mem_blk's is done in add_memory_resource(),
and unregistering them it is done in remove_memory() patch, I think they
cannot step on each other's feet.

Although, I saw that remove_memory_section() takes mem_sysfs_mutex.
I wonder if we should do the same in link_mem_sections(), just to be on the
safe side.

> Also, this stuff in nodemask.h:
> 
> : /*
> :  * For nodemask scrach area.
> :  * NODEMASK_ALLOC(type, name) allocates an object with a specified type and
> :  * name.
> :  */
> : #if NODES_SHIFT > 8 /* nodemask_t > 256 bytes */
> : #define NODEMASK_ALLOC(type, name, gfp_flags)	\
> :			type *name = kmalloc(sizeof(*name), gfp_flags)
> : #define NODEMASK_FREE(m)			kfree(m)
> : #else
> : #define NODEMASK_ALLOC(type, name, gfp_flags)	type _##name, *name = &_##name
> : #define NODEMASK_FREE(m)			do {} while (0)
> : #endif
> 
> a) s/scrach/scratch/
> 
> b) The comment is wrong, isn't it?  "NODES_SHIFT > 8" means
>    "nodemask_t > 32 bytes"?

It is wrong yes.
For example, if NODES_SHIFT = 9, that makes 64 bytes.

> c) If "yes" then we can surely bump that up a bit - "NODES_SHIFT >
>    11", say.

I checked all architectures that define NODES_SHIFT in Kconfig.
The maximum we can get is NODES_SHIFT = 10, and this makes 128 bytes.

> d) What's the maximum number of nodes, ever?  Perhaps we can always
>    fit a nodemask_t onto the stack, dunno.

Right now, we define the maximum as NODES_SHIFT = 10, so:

1 << 10 = 1024 Maximum nodes.

Since this makes only 128 bytes, I wonder if we can just go ahead and define a nodemask_t
whithin the stack.
128 bytes is not that much, is it?

Thanks
-- 
Oscar Salvador
SUSE L3
