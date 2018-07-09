Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3E9C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A4020854
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83A4020854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932601AbeGIJpk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:45:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:49658 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752914AbeGIJpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:45:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D7EE4AE75;
        Mon,  9 Jul 2018 09:45:37 +0000 (UTC)
Date:   Mon, 9 Jul 2018 11:45:35 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Tobin C. Harding" <me@tobin.cc>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsprintf: fix build warning
Message-ID: <20180709094535.pmknb3pf7uq3xxua@pathway.suse.cz>
References: <20180706134724.563799-1-arnd@arndb.de>
 <20180706144213.GA411@tigerII.localdomain>
 <20180706114951.6e739180@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706114951.6e739180@gandalf.local.home>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-07-06 11:49:51, Steven Rostedt wrote:
> On Fri, 6 Jul 2018 23:42:13 +0900
> Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> 
> > On (07/06/18 15:47), Arnd Bergmann wrote:
> > [..]
> > > Fixes: bfe80ed3d7c7 ("vsprintf: add command line option debug_boot_weak_hash")  
> > 
> > Seems like this one is still in linux-next.
> > Can we squash this patch and bfe80ed3d7c7?
> > 
> 
> I prefer not to do squashes unless absolutely necessary. Yes, it is in
> next, but even branches pulled into next should try to resist rebasing
> (I never rebase my next branch unless there is a real bug that will
> break bisecting).
> 
> As this is just a warning fix, and not something that should break any
> bisect, I say keep it separate. Rebases tend to cause issues.

Ted, just to be sure, are you going to take it via the random tree,
please?

Best Regards,
Petr
