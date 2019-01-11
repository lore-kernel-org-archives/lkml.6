Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0469BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C297220874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387896AbfAKRox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:44:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56866 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733206AbfAKRos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:44:48 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 713855A1F7;
        Fri, 11 Jan 2019 17:44:48 +0000 (UTC)
Received: from treble (ovpn-122-231.rdu2.redhat.com [10.10.122.231])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 646AA60C67;
        Fri, 11 Jan 2019 17:44:44 +0000 (UTC)
Date:   Fri, 11 Jan 2019 11:44:42 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 00/11] livepatch: Atomic replace feature
Message-ID: <20190111174442.6jtvrr7qov3lruxi@treble>
References: <20190109124329.21991-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190109124329.21991-1-pmladek@suse.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 11 Jan 2019 17:44:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 01:43:18PM +0100, Petr Mladek wrote:
> Changes against v14:
> 
>   + Rename klp_active -> klp_added [Josh]
> 
>   + Do not clear klp_added variable in klp_free*() [Josh]
> 
>   + Rename klp_init_patch_before_free() ->  klp_init_patch_early()
>     [Josh]
> 
>   + Do not call klp_free_patch() when
>     kobject_init_and_add(&patch->kobj) fails in 3rd patch.
>     The final code stays the same after the refactoring
>     in 5th patch. [Josh]
> 
>   + Better 4th patch subject [Josh]
> 
>   + Use safe iterators in klp_free() functions already in 7th
>     patch instead of in 8th [Josh]
> 
>   + Rename free_all -> nops_only and revert the logic in
>     klp_free*() and klp_unpatch_object*() functions [Josh]
> 
>   + Do not refuse loading conflicting patches. Just remove
>     the ordering (stacking) [Josh]
> 
>   + fixed typos, improved wording [all]

Petr,

This looks great to me.  Thanks for all your patience and hard work!

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh
