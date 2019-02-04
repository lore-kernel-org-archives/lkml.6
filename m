Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A238C282D8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 338C121848
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbfBDJk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 04:40:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:41646 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726537AbfBDJk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 04:40:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E765AAC6C;
        Mon,  4 Feb 2019 09:40:26 +0000 (UTC)
Date:   Mon, 4 Feb 2019 10:40:26 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] livepatch: Followup changes for the atomic replace
 patchset
Message-ID: <20190204094026.izlifqzkwjegpsca@pathway.suse.cz>
References: <20190116161720.796-1-pmladek@suse.com>
 <20190201160303.GA4241@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201160303.GA4241@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-02-01 11:03:03, Joe Lawrence wrote:
> On Wed, Jan 16, 2019 at 05:17:16PM +0100, Petr Mladek wrote:
> > This patchset implements ideas that were mentioned and postponed during
> > the review of the atomic replace patchset. I hope that I did not miss
> > anything.
> > 
> > Well, I did not add __used attribute to avoid non-static warnings
> > in modules for the selftest. The work on the sample modules somehow
> > stalled.
> > 
> > BTW: Does it make sense to maintain the sample modules any longer?
> > We could point people to the modules used by the selftest instead.
> > 
> > 
> > The patches apply on top of livepatching.git, branch
> > origin/for-5.1/atomic-replace.
> > 
> > 
> > Petr Mladek (4):
> >   livepatch: Introduce klp_for_each_patch macro
> >   livepatch: Handle failing allocation of shadow variables in the
> >     selftest
> >   livepatch: Module coming and going callbacks can proceed all listed
> >     patches
> >   livepatch: Remove the redundant enabled flag in struct klp_patch
> > 
> >  include/linux/livepatch.h            |  2 --
> >  kernel/livepatch/core.c              | 57 ++++++++++++++++--------------------
> >  kernel/livepatch/core.h              |  6 ++++
> >  kernel/livepatch/transition.c        |  9 +++---
> >  kernel/livepatch/transition.h        |  1 +
> >  lib/livepatch/test_klp_shadow_vars.c |  8 ++---
> >  6 files changed, 40 insertions(+), 43 deletions(-)
> > 
> > -- 
> > 2.13.7
> > 
> 
> Hi Petr,
> 
> This change is trivial, but since folks are letting loose various static
> code analysers on the livepatch samples and selftests, could you add
> this to your patchset.  The shadow variable selftest is happy with this
> change since it expects to see specific (non-negative) ptr_id values.

Sure. I am going to queue the patch into v2.

Best Regards,
Petr
