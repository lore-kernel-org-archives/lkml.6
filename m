Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EFAECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AFC52064D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AFC52064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388532AbeGTUUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 16:20:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42364 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388452AbeGTUUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 16:20:01 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CEEB8D33;
        Fri, 20 Jul 2018 19:30:19 +0000 (UTC)
Date:   Fri, 20 Jul 2018 12:30:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Tony Luck <tony.luck@gmail.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Daniel Vacek <neelx@redhat.com>,
        Stefan Agner <stefan@agner.ch>, Joe Perches <joe@perches.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] mm/memblock: add missing include <linux/bootmem.h>
Message-Id: <20180720123018.0a7b4ea3a5c848e1a63750aa@linux-foundation.org>
In-Reply-To: <CA+8MBbLB5JTdcgS3yJRR12doMgEiofD8NNXedyYyj4c7AcDnMg@mail.gmail.com>
References: <20180625171513.31845-1-malat@debian.org>
        <20180626184422.24974-1-malat@debian.org>
        <CA+8MBbLB5JTdcgS3yJRR12doMgEiofD8NNXedyYyj4c7AcDnMg@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018 12:16:05 -0700 Tony Luck <tony.luck@gmail.com> wrote:

> On Tue, Jun 26, 2018 at 11:44 AM, Mathieu Malaterre <malat@debian.org> wrote:
> > Because Makefile already does:
> >
> >   obj-$(CONFIG_HAVE_MEMBLOCK) += memblock.o
> >
> > The #ifdef has been simplified from:
> >
> >   #if defined(CONFIG_HAVE_MEMBLOCK) && defined(CONFIG_NO_BOOTMEM)
> >
> > to simply:
> >
> >   #if defined(CONFIG_NO_BOOTMEM)
> 
> Is this sitting in a queue somewhere ready to go to Linus?

linux-next ;)

> I don't see it upstream yet.

For some brainfarty reason I had it for 4.19-rc1.  Shall send it in
today.

