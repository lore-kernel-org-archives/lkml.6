Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D861BC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91AC021735
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91AC021735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbeHTXJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 19:09:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42506 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbeHTXJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 19:09:48 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A7FDEBD4;
        Mon, 20 Aug 2018 19:52:51 +0000 (UTC)
Date:   Mon, 20 Aug 2018 12:52:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        James Morse <james.morse@arm.com>,
        Omar Sandoval <osandov@fb.com>
Subject: Re: linux-next: manual merge of the akpm-current tree with the tip
 tree
Message-Id: <20180820125250.85db3bcb0052e1007a86358f@linux-foundation.org>
In-Reply-To: <20180820143222.5aaa69d9@canb.auug.org.au>
References: <20180820143222.5aaa69d9@canb.auug.org.au>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Aug 2018 14:32:22 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Today's linux-next merge of the akpm-current tree got conflicts in:
> 
>   fs/proc/kcore.c
>   include/linux/kcore.h
> 
> between commit:
> 
>   6855dc41b246 ("x86: Add entry trampolines to kcore")
> 
> from the tip tree and commits:
> 
>   4eb27c275abf ("fs/proc/kcore.c: use __pa_symbol() for KCORE_TEXT list entries")
>   ea551910d3f4 ("proc/kcore: clean up ELF header generation")
>   537412a2958f ("proc/kcore: don't grab lock for kclist_add()")
> 
> from the akpm-current tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Yup.

What's happening here?  A two month old patch turns up in linux-next in the
middle of the merge window, in the "perf/urgent" branch.  That's a strange
branch for a June 6 patch!

Is it intended that this material be merged into 4.19-rc1?
