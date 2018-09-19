Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC960C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704162150E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYP6hEXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 704162150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbeISG5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 02:57:30 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36599 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbeISG5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 02:57:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id b11-v6so1865454pfo.3;
        Tue, 18 Sep 2018 18:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UrTrWbpH9AWgy9n7J6b6EqfVJPxAM+sBtDAXZwlWKz4=;
        b=aYP6hEXNkOEh3hOb6bXM7dYTYS5jj19RYKBIbmHKM43qPHmiWb5+by+5LQOhGdDeYL
         eDBtbcU3uNl6VBcJjQRfr1s25exYxP3rSjl+MvWp7uR5it41cDoHP0lcVdfLVvktR6nX
         UgPxSmmTlA+tyLG7sP4Y454XgfS9vsHMjSPaOI2SgrH+qQQJQDgHYfkNMepEHcZ95gme
         FY81U0wnspFgfEAcSTl7ZO4NMe5tyGlQ3yAHNPS65gpFiAogW61Ery5wS1I0e4YcK5wM
         0mUy2aU6Sqk16MZlSXyUEdKljA0YGKZtdIqyAqynZhhSQs6C7jBjHpomgc6rW9udGxwK
         J5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UrTrWbpH9AWgy9n7J6b6EqfVJPxAM+sBtDAXZwlWKz4=;
        b=qxfE2yvj4GRRnYGWjvmMbTXWE9d0D3pBFhi/Zvy1DQya70Wl7sz0XS60vbp6gp2wk+
         ZTW5LZFJJLbaFTC22ui78RmtDaJ7wyS5xgLHYtqaaydet670ML9OY70aQd9ftu16wQWY
         Dvv0NWSHDRICkmRTM4Z19PYWIeDJXkOGocZal0gDOUdmUF5e8frbXCSqVXbvV2TZgGR9
         Di++UcRrKoVRwHY3QyPq01Zc1t+L0rS6NSp2LmSJu7ynmOwsjlCjMfQuxkg9f0C+fUO5
         HcJrlCoOZWbVxlfQkPTlhxueRlSLJH89SGNkBZK9xcf3QAVEJ/Z8CwIDCesQjaDVXJ2X
         tNAA==
X-Gm-Message-State: APzg51CVxS54yEuDcRCx632tBU1ES5oep/gvFjBtfThC6VSRmPQViRqU
        EHktvKOrpIUD2g1a6Ku7gJY=
X-Google-Smtp-Source: ANB0VdYgCOyhGJa82W3YuA4km0qhZLmI3SB4xdJRTmqLba+IWkzYZyHf3dxyHmJmU6fCtSH5w0YXfg==
X-Received: by 2002:a63:5a13:: with SMTP id o19-v6mr29785435pgb.75.1537320131382;
        Tue, 18 Sep 2018 18:22:11 -0700 (PDT)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.gmail.com with ESMTPSA id n26-v6sm602291pgd.45.2018.09.18.18.22.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 18:22:10 -0700 (PDT)
Date:   Wed, 19 Sep 2018 11:22:07 +1000
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
Message-ID: <20180919012207.GD8537@350D>
References: <20180918114822.21926-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918114822.21926-1-david@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 01:48:16PM +0200, David Hildenbrand wrote:
> Reading through the code and studying how mem_hotplug_lock is to be used,
> I noticed that there are two places where we can end up calling
> device_online()/device_offline() - online_pages()/offline_pages() without
> the mem_hotplug_lock. And there are other places where we call
> device_online()/device_offline() without the device_hotplug_lock.
> 
> While e.g.
> 	echo "online" > /sys/devices/system/memory/memory9/state
> is fine, e.g.
> 	echo 1 > /sys/devices/system/memory/memory9/online
> Will not take the mem_hotplug_lock. However the device_lock() and
> device_hotplug_lock.
> 
> E.g. via memory_probe_store(), we can end up calling
> add_memory()->online_pages() without the device_hotplug_lock. So we can
> have concurrent callers in online_pages(). We e.g. touch in online_pages()
> basically unprotected zone->present_pages then.
> 
> Looks like there is a longer history to that (see Patch #2 for details),
> and fixing it to work the way it was intended is not really possible. We
> would e.g. have to take the mem_hotplug_lock in device/base/core.c, which
> sounds wrong.
> 
> Summary: We had a lock inversion on mem_hotplug_lock and device_lock().
> More details can be found in patch 3 and patch 6.
> 
> I propose the general rules (documentation added in patch 6):
> 
> 1. add_memory/add_memory_resource() must only be called with
>    device_hotplug_lock.
> 2. remove_memory() must only be called with device_hotplug_lock. This is
>    already documented and holds for all callers.
> 3. device_online()/device_offline() must only be called with
>    device_hotplug_lock. This is already documented and true for now in core
>    code. Other callers (related to memory hotplug) have to be fixed up.
> 4. mem_hotplug_lock is taken inside of add_memory/remove_memory/
>    online_pages/offline_pages.
> 
> To me, this looks way cleaner than what we have right now (and easier to
> verify). And looking at the documentation of remove_memory, using
> lock_device_hotplug also for add_memory() feels natural.
>

That seems reasonable, but also implies that device_online() would hold
back add/remove memory, could you please also document what mode
read/write the locks need to be held? For example can the device_hotplug_lock
be held in read mode while add/remove memory via (mem_hotplug_lock) is held
in write mode?

Balbir Singh.
 
