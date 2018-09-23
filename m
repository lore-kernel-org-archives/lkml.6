Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC48FC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 02:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FCC121522
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 02:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQlSYZto"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FCC121522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbeIWIao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 04:30:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41168 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbeIWIan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 04:30:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id z3-v6so2722337pgv.8;
        Sat, 22 Sep 2018 19:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O9ZoHijVwvW8ow4N0D/GiREiHUN2Cq+8/0cyeNspxo0=;
        b=LQlSYZtomXKzTe8LY3jAtqRpAsz8Pr4wWBuOwccJwwP6Pq+JCmAWvJif+JdNe/yjoR
         mqNjWtuRypgCRIMqcqiUZ/xgYzOZGyYPlD0F5bh1HNKQxU+kTvNwOQLqXe5cMnIYEZi+
         l0zvTbhyiQc594XKVCOp7AwmN/ILHIxsczxS1OxdLX0nDHkQII27b/VgXMhKdqJwW8O1
         +IudY+C2Hkgj2BY7QcHWys//vl6l/FHwimeQ3K1Q3U2rXb4vEhkj9n8XG/uFt+/r8d/L
         XEYR9f0HGgU/nwUPzB1rWgcrUKEzUYRFhGDWAd5d4pyP+y0CSpT662RliOWiJOIL4orr
         j1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O9ZoHijVwvW8ow4N0D/GiREiHUN2Cq+8/0cyeNspxo0=;
        b=NdiP4an1mhMvyyi/Iu35cyUr/KsnxORIeOwrFjHm4n3VtobCOt+GdujfxxyZQ28rCr
         +orP3Q77Cu6bvDAiHHDqnQl3YskfAZAGTmWsXQEmTVmIX+9upKPikKtxDXAXyMNTqKpl
         rnS5+B2wKTltNGxFPlXCTA1RWnsXdJREKVuy6j8tZDeBWdFNar9/SG0aPPWkQcwYaI38
         2N7Sj6ddgOF2BF/m51lRO+mBKDbnR0Fdb3Fj5mq4nhFKTB994runbjrqj7uYiMS5ary8
         ZwqWMqvMsMLxtCvXLoxTKHLfwMNhTC0jG9qh8JnO6tMrd/2e63DnH1CHNszD18HtOSW6
         Bv5w==
X-Gm-Message-State: ABuFfogU5oual2gyDvSGVe7dMRhi01s3VYp/6Kc4HuAXsKiJi0MW7QCi
        lL26caWBJqq9nClUiTMk+8o=
X-Google-Smtp-Source: ACcGV60xSFKVcC27aVUK0bB6UetHQa4me7lT7xVK5O7uuLy+NlVUXr5Lp3lwywL/iM3SbJAY8rVSdw==
X-Received: by 2002:a63:1f0a:: with SMTP id f10-v6mr3974742pgf.313.1537670096535;
        Sat, 22 Sep 2018 19:34:56 -0700 (PDT)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.gmail.com with ESMTPSA id n9-v6sm50030151pfg.21.2018.09.22.19.34.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Sep 2018 19:34:55 -0700 (PDT)
Date:   Sun, 23 Sep 2018 12:34:52 +1000
From:   Balbir Singh <bsingharora@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-acpi@vger.kernel.org, xen-devel@lists.xenproject.org,
        devel@linuxdriverproject.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Allen <jallen@linux.vnet.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Juergen Gross <jgross@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Len Brown <lenb@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Mathieu Malaterre <malat@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Michal Hocko <mhocko@suse.com>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Paul Mackerras <paulus@samba.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>
Subject: Re: [PATCH v1 0/6] mm: online/offline_pages called w.o.
 mem_hotplug_lock
Message-ID: <20180923023452.GG8537@350D>
References: <20180918114822.21926-1-david@redhat.com>
 <20180919012207.GD8537@350D>
 <f3a13f6a-b34c-8561-884a-23fd9aa60331@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3a13f6a-b34c-8561-884a-23fd9aa60331@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 09:35:07AM +0200, David Hildenbrand wrote:
> Am 19.09.18 um 03:22 schrieb Balbir Singh:
> > On Tue, Sep 18, 2018 at 01:48:16PM +0200, David Hildenbrand wrote:
> >> Reading through the code and studying how mem_hotplug_lock is to be used,
> >> I noticed that there are two places where we can end up calling
> >> device_online()/device_offline() - online_pages()/offline_pages() without
> >> the mem_hotplug_lock. And there are other places where we call
> >> device_online()/device_offline() without the device_hotplug_lock.
> >>
> >> While e.g.
> >> 	echo "online" > /sys/devices/system/memory/memory9/state
> >> is fine, e.g.
> >> 	echo 1 > /sys/devices/system/memory/memory9/online
> >> Will not take the mem_hotplug_lock. However the device_lock() and
> >> device_hotplug_lock.
> >>
> >> E.g. via memory_probe_store(), we can end up calling
> >> add_memory()->online_pages() without the device_hotplug_lock. So we can
> >> have concurrent callers in online_pages(). We e.g. touch in online_pages()
> >> basically unprotected zone->present_pages then.
> >>
> >> Looks like there is a longer history to that (see Patch #2 for details),
> >> and fixing it to work the way it was intended is not really possible. We
> >> would e.g. have to take the mem_hotplug_lock in device/base/core.c, which
> >> sounds wrong.
> >>
> >> Summary: We had a lock inversion on mem_hotplug_lock and device_lock().
> >> More details can be found in patch 3 and patch 6.
> >>
> >> I propose the general rules (documentation added in patch 6):
> >>
> >> 1. add_memory/add_memory_resource() must only be called with
> >>    device_hotplug_lock.
> >> 2. remove_memory() must only be called with device_hotplug_lock. This is
> >>    already documented and holds for all callers.
> >> 3. device_online()/device_offline() must only be called with
> >>    device_hotplug_lock. This is already documented and true for now in core
> >>    code. Other callers (related to memory hotplug) have to be fixed up.
> >> 4. mem_hotplug_lock is taken inside of add_memory/remove_memory/
> >>    online_pages/offline_pages.
> >>
> >> To me, this looks way cleaner than what we have right now (and easier to
> >> verify). And looking at the documentation of remove_memory, using
> >> lock_device_hotplug also for add_memory() feels natural.
> >>
> > 
> > That seems reasonable, but also implies that device_online() would hold
> > back add/remove memory, could you please also document what mode
> > read/write the locks need to be held? For example can the device_hotplug_lock
> > be held in read mode while add/remove memory via (mem_hotplug_lock) is held
> > in write mode?
> 
> device_hotplug_lock is an ordinary mutex. So no option there.
> 
> Only mem_hotplug_lock is a per CPU RW mutex. And as of now it only
> exists to not require get_online_mems()/put_online_mems() to take the
> device_hotplug_lock. Which is perfectly valid, because these users only
> care about memory (not any other devices) not suddenly vanish. And that
> RW lock makes things fast.
> 
> Any modifications (online/offline/add/remove) require the
> mem_hotplug_lock in write.
> 
> I can add some more details to documentation in patch #6.
> 
> "... we should always hold the mem_hotplug_lock (via
> mem_hotplug_begin/mem_hotplug_done) in write mode to serialize memory
> hotplug" ..."
> 
> "In addition, mem_hotplug_lock (in contrast to device_hotplug_lock) in
> read mode allows for a quite efficient get_online_mems/put_online_mems
> implementation, so code accessing memory can protect from that memory
> vanishing."
> 
> Would that work for you?

Yes, Thanks

Balbir Singh.
