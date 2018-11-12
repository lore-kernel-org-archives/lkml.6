Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47925C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 179EB223D0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 179EB223D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbeKMAWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 19:22:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59568 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbeKMAWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 19:22:54 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D863689AC4;
        Mon, 12 Nov 2018 14:29:23 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C3A15C207;
        Mon, 12 Nov 2018 14:29:23 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id wACETMWd006467;
        Mon, 12 Nov 2018 09:29:22 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id wACETKMH006462;
        Mon, 12 Nov 2018 09:29:20 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 12 Nov 2018 09:29:20 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     kernel test robot <rong.a.chen@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, LKP <lkp@01.org>,
        Tejun Heo <tj@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>
Subject: Re: [LKP] d50d82faa0 [ 33.671845] WARNING: possible circular locking
 dependency detected
In-Reply-To: <20181107190558.812375161de4b5df413ea31b@linux-foundation.org>
Message-ID: <alpine.LRH.2.02.1811120926240.3272@file01.intranet.prod.int.rdu2.redhat.com>
References: <20181023003004.GH24195@shao2-debian> <20181107154336.21e1f815226facdffd4a6c54@linux-foundation.org> <20181107190558.812375161de4b5df413ea31b@linux-foundation.org>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 12 Nov 2018 14:29:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Nov 2018, Andrew Morton wrote:

> On Wed, 7 Nov 2018 15:43:36 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > On Tue, 23 Oct 2018 08:30:04 +0800 kernel test robot <rong.a.chen@intel.com> wrote:
> > 
> > > Greetings,
> > > 
> > > 0day kernel testing robot got the below dmesg and the first bad commit is
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > 
> > > commit d50d82faa0c964e31f7a946ba8aba7c715ca7ab0
> > > Author:     Mikulas Patocka <mpatocka@redhat.com>
> > > AuthorDate: Wed Jun 27 23:26:09 2018 -0700
> > > Commit:     Linus Torvalds <torvalds@linux-foundation.org>
> > > CommitDate: Thu Jun 28 11:16:44 2018 -0700
> > > 
> > >     slub: fix failure when we delete and create a slab cache
> > 
> > This is ugly.  Is there an alternative way of fixing the race which
> > Mikulas attempted to address?  Possibly cancel the work and reuse the
> > existing sysfs file, or is that too stupid to live?
> > 
> > 3b7b314053d021 ("slub: make sysfs file removal asynchronous") was
> > pretty lame, really.  As mentioned,
> > 
> > : It'd be the cleanest to deal with the issue by removing sysfs files
> > : without holding slab_mutex before the rest of shutdown; however, given
> > : the current code structure, it is pretty difficult to do so.
> > 
> > Would be a preferable approach.
> > 
> > >     
> > >     This uncovered a bug in the slub subsystem - if we delete a cache and
> > >     immediatelly create another cache with the same attributes, it fails
> > >     because of duplicate filename in /sys/kernel/slab/.  The slub subsystem
> > >     offloads freeing the cache to a workqueue - and if we create the new
> > >     cache before the workqueue runs, it complains because of duplicate
> > >     filename in sysfs.
> 
> Alternatively, could we flush the workqueue before attempting to
> (re)create the sysfs file?

What if someone creates the slab cache from the workqueue?

> Extra points for only doing this if the
> first (re)creation attempt returned -EEXIST?

If it returns -EEXIST, it has already written the warning to the log.

Mikulas
