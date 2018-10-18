Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BB7C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBC62087A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFBC62087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbeJRUKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 16:10:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:49736 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726132AbeJRUKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 16:10:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B74EDAD91;
        Thu, 18 Oct 2018 12:09:48 +0000 (UTC)
Date:   Thu, 18 Oct 2018 14:09:47 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 05/12] livepatch: Refuse to unload only livepatches
 available during a forced transition
Message-ID: <20181018120947.py36o462zdqjknsm@pathway.suse.cz>
References: <20181015123713.25868-1-pmladek@suse.com>
 <20181015123713.25868-6-pmladek@suse.com>
 <20181017183519.wfc2n54ga6cyjhfi@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017183519.wfc2n54ga6cyjhfi@treble>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-10-17 13:35:19, Josh Poimboeuf wrote:
> I'm having trouble parsing the subject.  How about:
> 
>   Allow unloading of patches added after using 'force'

ok

> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
> > @@ -45,7 +45,8 @@
> >   */
> >  DEFINE_MUTEX(klp_mutex);
> >  
> > -static LIST_HEAD(klp_patches);
> > +/* Registered patches */
> > +LIST_HEAD(klp_patches);
> 
> Instead of making this non-static, can we just move
> klp_force_transition() to core.c?  It's nice to have all the list
> management code encapsulated in the same file.

Come on! We need it just to iterate over a list of available
livepatches. The logic used to manage this list is trivial.
klp_force_transition() itself is more complicated and it
logically fits into transitions.c.

I do not want to fight over this. If you resist, I'll move it.
I just wanted to share my view.

Best Regards,
Petr
