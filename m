Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F86C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684F020849
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 684F020849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751915AbeFWMia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 08:38:30 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43307 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751442AbeFWMi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 08:38:28 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fWhny-0005j9-Rw; Sat, 23 Jun 2018 14:38:15 +0200
Date:   Sat, 23 Jun 2018 14:38:14 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     fenghua.yu@intel.com, Tony Luck <tony.luck@intel.com>,
        vikas.shivappa@linux.intel.com, gavin.hindman@intel.com,
        jithu.joseph@intel.com, dave.hansen@intel.com, mingo@redhat.com,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH V7 00/41] Intel(R) Resource Director Technology Cache
 Pseudo-Locking enabling
In-Reply-To: <alpine.DEB.2.21.1806231402500.8650@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1806231434270.8650@nanos.tec.linutronix.de>
References: <cover.1529706536.git.reinette.chatre@intel.com> <alpine.DEB.2.21.1806231402500.8650@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jun 2018, Thomas Gleixner wrote:

> Reinette!
> 
> On Fri, 22 Jun 2018, Reinette Chatre wrote:
> > The Cache Pseudo-Locking enabling series that was recently merged to the
> > x86/cache branch of tip was found to conflict with the new kernfs support
> > for mounting with fs_context.
> > 
> > In preparation for a conflict-free merge between the two repos some no-op
> > hooks are created within the RDT mount function being changed by
> > the two features. The goal is for this commit to be placed on a minimal
> > no-rebase branch to be consumed by both features.
> 
> Thanks for doing this so quick! I've picked up the lot and slightly
> modified the first patch by moving the stubs to the header file to get them
> completely out of the conflicting area.
> 
> The immutable branch for David to pull is:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git for-vfs
> 
> I've also created a branch based on Davids mount-context branch, applied
> the cleanup patch below to it and merged the for-vfs branch on top.
> 
> David feel free to pull the result from
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git for-vfs-merged
> 
> or pick up the patch below and do the merge and conflict resolution yourself.

I've force updated it after pushing out the variant which did not compile
instead of folding the fix back first. New head is:

   tip/for-vfs-merged 63b411121807: Merge branch 'for-vfs' into for-vfs-merged

/me hates computers and goes to mow the lawn
