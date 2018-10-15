Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C88C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB382064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB382064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbeJPGAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 02:00:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33244 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbeJPGAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 02:00:30 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C849122CC;
        Mon, 15 Oct 2018 22:13:20 +0000 (UTC)
Date:   Mon, 15 Oct 2018 15:13:19 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Rob Herring <robherring2@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: linux-next: Tree for Oct 15
Message-Id: <20181015151319.3a443f0421c20bd7ed055cb9@linux-foundation.org>
In-Reply-To: <20181016072439.42613abd@canb.auug.org.au>
References: <20181015192546.15faf3a1@canb.auug.org.au>
        <20181015182637.GA16445@roeck-us.net>
        <20181016071240.3f62816d@canb.auug.org.au>
        <20181016072439.42613abd@canb.auug.org.au>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018 07:24:39 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> On Tue, 16 Oct 2018 07:12:40 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > On Mon, 15 Oct 2018 11:26:37 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > ALl ppc qemu tests (including big endian pseries) also generate a warning.
> > > 
> > > WARNING: CPU: 0 PID: 0 at mm/memblock.c:1301 .memblock_alloc_range_nid+0x20/0x68
> 
> That is:
> 
> static phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
>                                         phys_addr_t align, phys_addr_t start,
>                                         phys_addr_t end, int nid,
>                                         enum memblock_flags flags)
> {
>        if (WARN_ON_ONCE(!align))
>                 align = SMP_CACHE_BYTES;
> 
> Looks like patch
> 
>   "memblock: stop using implicit alignment to SMP_CACHE_BYTES"
> 
> missed some places ...

To be expected, I guess.  I'm pretty relaxed about this ;) Let's do
another sweep in a week or so, after which we'll have a couple of
months to mop up any leftovers.

