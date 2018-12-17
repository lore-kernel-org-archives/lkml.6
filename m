Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1899C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD98D206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732466AbeLQLtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:49:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:55806 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731759AbeLQLtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:49:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8B126AE4F;
        Mon, 17 Dec 2018 11:49:22 +0000 (UTC)
Date:   Mon, 17 Dec 2018 12:49:22 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jessica Yu <jeyu@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] livepatch: fix non-static warnings
Message-ID: <20181217114922.km7dhpcuevjog3d3@pathway.suse.cz>
References: <1544806570-21299-1-git-send-email-hofrat@osadl.org>
 <72b8f2a4-9070-23d3-4e75-66e10b2d94b5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72b8f2a4-9070-23d3-4e75-66e10b2d94b5@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-12-14 16:34:23, Joe Lawrence wrote:
> Almost.  We should only need to annotate with __noclone for those
> function definitions which the samples will be patching.  As the commit
> message says, these correlate to klp_func.old_name functions found in
> klp_object.name objects (.ko modules or NULL for vmlinux).
> 
> For the functions defined in samples/livepatch/*.c those would be:
> 
>   livepatch-callbacks-busymod.c :: busymod_work_func()

__noclone is not added to this function in v2. Well, I wonder
if it can be optimized when it is passed as a pointer.

>   livepatch-shadow-mod.c :: dummy_alloc()
>   livepatch-shadow-mod.c :: dummy_free()
>   livepatch-shadow-mod.c :: dummy_check()
> 
> So even though livepatch-shadow-fix2 further refines
> livepatch-shadow-fix1, the livepatch core is going to redirect the
> original dummy_*() calls defined by livepatch-shadow-mod.c in both fix1
> and fix2 cases.  Ie, the fixes modules aren't patched, only the original.

Best Regards,
Petr
