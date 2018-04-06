Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752424AbeDFWH2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 18:07:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32882 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751488AbeDFWH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 18:07:27 -0400
Date: Fri, 6 Apr 2018 17:07:23 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] livepatch: Remove Nop structures when unused
Message-ID: <20180406220723.t3bsb6j7w4lf3wbb@treble>
References: <20180323120028.31451-1-pmladek@suse.com>
 <20180323120028.31451-7-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180323120028.31451-7-pmladek@suse.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 01:00:26PM +0100, Petr Mladek wrote:
> Replaced patches are removed from the stack when the transition is
> finished. It means that Nop structures will never be needed again
> and can be removed. Why should we care?

Warning, grammar pedantry ahead.

"Nop" isn't a proper noun, so it shouldn't be capitalized (here and in
the patch subject).

Also, "NOP", used elsewhere, might be confused with x86 NOP
instructions.  I would vote for "nop" everywhere.

> @@ -146,6 +155,21 @@ static void klp_complete_transition(void)
>  	if (!klp_forced && klp_target_state == KLP_UNPATCHED)
>  		module_put(klp_transition_patch->mod);
>  
> +	if (klp_transition_patch->replace && klp_target_state == KLP_PATCHED) {
> +		/*
> +		 * We do not need to wait until the objects are really freed.
> +		 * We will never need them again because the patch must be on
> +		 * the bottom of the stack now.
> +		 */
> +		klp_free_objects_dynamic(klp_transition_patch);
> +		/*
> +		 * Replace behavior will not longer be needed. Avoid the related
> +		 * code when disabling and enabling again.

"not longer" -> "no longer"

-- 
Josh
