Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362A8C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4A220863
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbfBLNAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:00:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:45408 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728145AbfBLNAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:00:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E3088ADF0;
        Tue, 12 Feb 2019 13:00:31 +0000 (UTC)
Date:   Tue, 12 Feb 2019 14:00:30 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/9] vsprintf: Factor out %pV handler as va_format()
Message-ID: <20190212130030.s22aamlnmj2lv7zg@pathway.suse.cz>
References: <20190208152310.29531-1-pmladek@suse.com>
 <20190208152310.29531-6-pmladek@suse.com>
 <f308ab312810d538a79c2f54f49edba32c60b561.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f308ab312810d538a79c2f54f49edba32c60b561.camel@perches.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-02-08 09:11:17, Joe Perches wrote:
> On Fri, 2019-02-08 at 16:23 +0100, Petr Mladek wrote:
> > Move the code from the long pointer() function. We are going to improve
> > error handling that will make it more complicated.
> > 
> > This patch does not change the existing behavior.
> 
> But doesn't this increase stack use?
> %pV is recursive and increasing the stack is undesired
> for this use.

%pV handler is stack sensitive because the entire vsnprintf()
machinery is called recursively. This one extra call does
not make it much worse.

Best Regards,
Petr
