Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059E5C282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3B821473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbfA3I4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 03:56:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:40022 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725850AbfA3I4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 03:56:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 75B43AC4B;
        Wed, 30 Jan 2019 08:56:23 +0000 (UTC)
Date:   Wed, 30 Jan 2019 09:56:22 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] livepatch: Handle failing allocation of shadow
 variables in the selftest
Message-ID: <20190130085622.y4de47nekrhy4pmq@pathway.suse.cz>
References: <20190116161720.796-1-pmladek@suse.com>
 <20190116161720.796-3-pmladek@suse.com>
 <20190121224012.GB8766@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121224012.GB8766@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-01-21 17:40:12, Joe Lawrence wrote:
> On Wed, Jan 16, 2019 at 05:17:18PM +0100, Petr Mladek wrote:
> > Do not dereference pointers to the shadow variables when either
> > klp_shadow_alloc() or klp_shadow_get() fail.
> > 
> > There is no need to check the other locations explicitly. The test
> > would fail if any allocation fails. And the existing messages, printed
> > during the test, provide enough information to debug eventual problems.
> > 
> 
> I didn't run the test under those failing conditions, but at looking at
> the code, I think it would simply skip the "expected <conditions> found"
> and the test script would complain about not seeing that msg.

Accessing an invalid pointer would crash the kernel.


> Would it be easier to just bite the bullet and verify sv[0-4] at their
> allocation sites?  Then later uses (ie, the sv3 dereference that
> Miroslav spotted at the bottom) or new code wouldn't fall through the
> cracks.

As I wrote in the replay to Miroslav. The best practice is to
handle errors everywhere. I am going to do so in v2. People
might use it as a sample...

Best Regards,
Petr
