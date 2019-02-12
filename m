Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEA2C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D4AC21773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730691AbfBLPpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:45:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:55982 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726238AbfBLPpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:45:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5035CAF50;
        Tue, 12 Feb 2019 15:45:31 +0000 (UTC)
Date:   Tue, 12 Feb 2019 16:45:30 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 9/9] vsprintf: Avoid confusion between invalid address
 and value
Message-ID: <20190212154530.wjikbevy5beg2uzc@pathway.suse.cz>
References: <20190208152310.29531-1-pmladek@suse.com>
 <20190208152310.29531-10-pmladek@suse.com>
 <20190208172717.GW9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208172717.GW9224@smile.fi.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-02-08 19:27:17, Andy Shevchenko wrote:
> On Fri, Feb 08, 2019 at 04:23:10PM +0100, Petr Mladek wrote:
> > We are able to detect invalid values handled by %p[iI] printk specifier.
> > The current error message is "invalid address". It might cause confusion
> > against "(efault)" reported by the generic valid_pointer_address() check.
> > 
> > Let's unify the style and use the more appropriate error code description
> > "(einval)".
> 
> The proper one should be "invalid address family". The proposed change
> increases confusion.

I am confused. Is there any error code for "invalid address family"?

EINVAL is standard error code used when a wrong value is passed
as a parameter. In this case, the code is not able to handle
the given address family.

IMHO, the original message "invalid address" has been even more
confusing. Oops would happen if it was invalid. In fact, the value
was invalid.

Best Regards,
Petr
