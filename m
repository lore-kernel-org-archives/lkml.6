Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3C7C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29CD2077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A29CD2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbeIFAC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:02:27 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:42735 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbeIFAC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:02:26 -0400
X-Originating-IP: 134.134.139.75
Received: from localhost (jfdmzpr06-ext.jf.intel.com [134.134.139.75])
        (Authenticated sender: josh@joshtriplett.org)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id DB97D1C000B;
        Wed,  5 Sep 2018 19:30:42 +0000 (UTC)
Date:   Wed, 5 Sep 2018 12:30:35 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-sparse@vger.kernel.org
Subject: Re: [PATCH 07/12] Compiler Attributes: remove unneeded sparse
 (__CHECKER__) tests
Message-ID: <20180905193035.GB3420@localhost>
References: <20180903203316.16183-1-miguel.ojeda.sandonis@gmail.com>
 <20180903203316.16183-8-miguel.ojeda.sandonis@gmail.com>
 <20180905182038.muv535vfugm72spk@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905182038.muv535vfugm72spk@ltop.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 08:20:39PM +0200, Luc Van Oostenryck wrote:
> On Mon, Sep 03, 2018 at 10:33:11PM +0200, Miguel Ojeda wrote:
> > Sparse knows about a few more attributes now, so we can remove
> > the __CHECKER__ conditions from them (which, in turn, allow us
> > to move some of them later on to compiler_attributes.h).
> > 
> >   * assume_aligned: since sparse's commit ffc860b ("sparse:
> >     ignore __assume_aligned__ attribute"), included in 0.5.1
> > 
> >   * error: since sparse's commit 0a04210 ("sparse: Add 'error'
> >     to ignored attributes"), included in 0.5.0
> > 
> >   * hotpatch: since sparse's commit 6043210 ("sparse/parse.c:
> >     ignore hotpatch attribute"), included in 0.5.1
> > 
> >   * warning: since sparse's commit 977365d ("Avoid "attribute
> >     'warning': unknown attribute" warning"), included in 0.4.2
> 
> Hi,
> 
> I hadn't noticed in the previous version but I see now that hotpatch
> & assume_aligned is only available since sparse 0.5.1 which is only
> 13 months old. It would be great if everyone use a recent version
> but I fear that a lot of people still use something less recent.
> v0.5.0 should be OK, though, it's more than 5 years old.
> 
> Sorry for not having noticed this earlier.

Unlike GCC, I don't think it's at all unreasonable to assume a
*relatively* recent version of Sparse.

(Once we start assuming a version with __has_attribute support, this
will get even easier to handle.)
