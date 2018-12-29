Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238B0C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 17:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15F42146F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 17:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeL2Rz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 12:55:27 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:33016 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727580AbeL2Rz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 12:55:26 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id wBTHt2TM015389;
        Sat, 29 Dec 2018 18:55:02 +0100
Date:   Sat, 29 Dec 2018 18:55:02 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] rcutorture/nolibc: add a bit of documentation to
 explain how to use nolibc
Message-ID: <20181229175502.GA12726@1wt.eu>
References: <20181229155817.12647-1-w@1wt.eu>
 <20181229155817.12647-4-w@1wt.eu>
 <7e3f7a66-2e66-a795-ea00-0e27af18f0b1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e3f7a66-2e66-a795-ea00-0e27af18f0b1@infradead.org>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Sat, Dec 29, 2018 at 08:50:09AM -0800, Randy Dunlap wrote:
> This is a good summary IMO.  Thanks.
> And it's in good shape -- doesn't *require* any fixes.
> But if you do make any changes to it, here are a few suggestions.  :)

Thanks very much.

> > + * This file is designed to be used as a libc alternative for minimal programs
> > + * with very limited requirements. It consists of a small number of syscall and
> > + * types definitions, and the minimal startup code needed to call main().
> 
>       type

Funny, I hesitated on this one and "fixed" it :-)

> > + * All syscalls are declared as static functions so that they can be optimized
> > + * away by the compiler when not used.
> > + *
> > + * Syscalls are split between 3 levels :
> 
> Instead of "between", use either "among" or "into".  and then "levels:".

Will do, thanks.

> > + *   - the lower level is the arch-specific syscall() definition, consisting in
> > + *     assembly code in compound expressions. These ones are called
> 
> Apparently "these ones" is acceptable in UK English, not so in US English.

Oh I didn't know, I've used it quite a bit in the last decades, thinking
it was a valid plural for "this one". It seems like I should use "These"
instead, feel free to suggest otherwise.

> I don't like it, but we do accept UK English here.  :)

I prefer to be corrected and to avoid using bad English, whether it's
US or UK, as much as I hate to make mistakes in French.

> > + * Some stdint-like integer types are defined. These ones are valid on all
> 
>                                                   These are valid on all

OK, makes sense according to the point above.

> ciao.  thanks.

I'm applying the changes right now to my local tree and will respin a
version. Thank you!

Willy
