Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44684C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007092086C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zsuv9nNB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007092086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387803AbeKFDUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 22:20:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35076 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387515AbeKFDUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 22:20:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DQqVhs29vby9aKj55IChDsTKXxyzXsDVam6CEhurpNo=; b=Zsuv9nNBXm+b0gYn0LONNiMu8
        LGMutUYnUCfg9KKxNMSL8aqB2U0PIxcAhtytZfL3OVHqi0lbpJtXTzQJQZLlPyQ03xRT0iiXkEfZd
        9HSvwOl/5uLgAtY0gy/5APzf1+QpUBS8NV6cr3VsvRBrxHt4xX8UUVr/dmTrNR6LINeVxCfWPm6QA
        0ITQL/L0JvuHx5NPeaWUFfARNmvjhYOMzHdf2miDMehj8th6LgTGZQ6IOpIxlAK/pIW4ap3jhe39F
        do0H8UvSsGFwn75c1ueE0132j50IDcTAMuzBvg68j08MVo3p2otWVeURtuMFV2T28mADDgfCBzWWT
        FUmZRmA1w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJjAT-0002FD-EE; Mon, 05 Nov 2018 18:00:05 +0000
Date:   Mon, 5 Nov 2018 10:00:04 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     rong.a.chen@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lkp@01.org
Subject: Re: [LKP] [xarray] 0e9446c35a:
 WARNING:at_include/linux/xarray.h:#xa_mk_value
Message-ID: <20181105180004.GA4923@bombadil.infradead.org>
References: <20181105070337.GX24195@shao2-debian>
 <CAHk-=wgHY5EdhvPoS458Wu8iUfC9C8UBG8GzEO72=0prT2nVcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgHY5EdhvPoS458Wu8iUfC9C8UBG8GzEO72=0prT2nVcw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 09:57:47AM -0800, Linus Torvalds wrote:
> Willy,
> 
> On Sun, Nov 4, 2018 at 11:03 PM kernel test robot <rong.a.chen@intel.com> wrote:
> >
> > commit: 0e9446c35a80931044b6d8d2d74a9cabd248539f ("xarray: Add range store functionality")
> ...
> > [   11.880031] WARNING: CPU: 0 PID: 1 at include/linux/xarray.h:54 xa_mk_value+0x7/0x10
> > [   11.881944] EIP: xa_mk_value+0x7/0x10
> > [   11.883565] Call Trace:
> > [   11.883565]  __check_store_range+0xe/0x171
> > [   11.883565]  check_store_range+0x5d/0x87
> 
> If I read this right, it's simply this case:
> 
>                 __check_store_range(xa, UINT_MAX + i, UINT_MAX + j);
> 
> which turns into negative values on a 32-bit machine, and then
> xa_mk_value() warns.
> 
> Should that part of the test be surrounded by #ifdef CONFIG_64BIT? Or
> did you _want_ the warnings?

I should have just made that (1 << 24) instead of UINT_MAX.  I had forgotten
about 32-bit machines while writing that test.

That prompted me to actually build the test suite on 32-bit and there's
a few other things in there that want fixing.  I'll have a pull request
for you later today.
