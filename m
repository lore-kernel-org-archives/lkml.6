Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE63C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2019B2086D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:56:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2019B2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbeJIVOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:14:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:54702 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726476AbeJIVN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:13:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A58D7ACBC;
        Tue,  9 Oct 2018 13:56:53 +0000 (UTC)
Date:   Tue, 9 Oct 2018 15:56:52 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Tobin C. Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 1/3] lib/vsprintf: Prepare for more general use of
 ptr_to_id()
Message-ID: <20181009135652.kdy2izt2pbehndmx@pathway.suse.cz>
References: <20181008110504.25449-1-geert+renesas@glider.be>
 <20181008110504.25449-2-geert+renesas@glider.be>
 <20181008142544.GB15943@smile.fi.intel.com>
 <CAMuHMdXFjDXWVxmkpc5AWebeOasDvj5RrhKOd3gkTqAeK5Y5pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXFjDXWVxmkpc5AWebeOasDvj5RrhKOd3gkTqAeK5Y5pg@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-10-08 16:37:29, Geert Uytterhoeven wrote:
> Hi Andy,
> 
> On Mon, Oct 8, 2018 at 4:25 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Oct 08, 2018 at 01:05:02PM +0200, Geert Uytterhoeven wrote:
> > >   - Make the ptr argument const, to avoid adding casts in future
> > >     callers,
> >
> > >   - Add a forward declaration, to avoid moving large blocks of code.
> >
> > How big it would be? ptr_to_id() itself plus...
> 
> ... all the randomization helpers.
> And ptr_to_id() needs pointer_string(), string(), widen_string(), number(),
> and move_right().
> 
> 118 insertions(+), 120 deletions(-)
> 
> Is that acceptable?

Yes, it is acceptable. And my feeling is that it is the preferred
solution is kernel because it helps to keep the code cleaner
in the long term.

I am for moving the code if there is no cyclic dependency.

Best Regards,
Petr
