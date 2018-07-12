Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E1EC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207C320BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uEoqkU2p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 207C320BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732289AbeGLIld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:41:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49378 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbeGLIld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=forZD/L6gjHPjjIFb7h7gNzQINC9XsFL9+6zdWCl/z4=; b=uEoqkU2pFNHTG+SsRuVhqj5k5
        owmPp0OyzAGMaJaGdk16gA1xiJBwb/jV94EZt8f9kjHBX//gsxTFTIAJiWEaxtY1Z1aOVXTfDVFnK
        GjMkDW8TVTzLOh1cqDbuJoBAE9ISD6DCXQ0kgd+8SLApSmkOj2f1FQacBDroh2IIcTAlgnKJgjhSv
        6K/ittmbDsUeXIvO/H+20QYT5yjl2JZ/56QFDT/exMHGFTBFnnAGmpRAR8HOqZJuaigVNbqdkC2wR
        jGEFV0u21TRZAMdFsKThDF4LfLK6F8v5RRLksI/JpN8rkFMnMci9LuzqRz8OK528nA7FZcpvlmYkG
        pG48dudTA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdX22-0000cq-5H; Thu, 12 Jul 2018 08:32:58 +0000
Date:   Thu, 12 Jul 2018 01:32:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [PATCH v2 3/7] riscv: Include asm-generic/compat.h
Message-ID: <20180712083258.GE8802@infradead.org>
References: <20180705213604.18883-1-deepa.kernel@gmail.com>
 <20180705213604.18883-4-deepa.kernel@gmail.com>
 <20180705222110.GA5698@infradead.org>
 <CABeXuvoj_WwvnaqY1wao+axx1JLpPte-iXP=Ti7jsT+r6VrVUg@mail.gmail.com>
 <CAK8P3a2L9z+Ok1Wd0=5F=Xt7nvqL6be+AS++F3rZzByN+a+9QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2L9z+Ok1Wd0=5F=Xt7nvqL6be+AS++F3rZzByN+a+9QA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 01:42:46PM +0200, Arnd Bergmann wrote:
> We can also rename all the compat syscalls that are now shared
> with 32-bit, e.g. using sys_waitid_time32() instead of
> compat_sys_waitid(), and that would be consistent with the
> new _time64() naming that we are introducing for some of them.

Yes, please.  You'll need to touch the syscall tables anyway to refer to
some new name, so it really isn't that much more work.

> Completely separating them from the compat code
> would add further complexity though, as some of the
> system calls take another argument that is different
> between 32-bit and 64-bit kernels, in particular
> pselect6, ppoll, io_pgetevents, recvmmsg, and waitid.

Why would that create further complexity?  IFF those calls need compat
work other than the time structures you will need additional variants of
them anyway.  If the only compat handling is the time structures they
will stay the same independent of the name.

> 
>        Arnd
---end quoted text---
