Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936293AbeCBL6S (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 06:58:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:44310 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934881AbeCBL6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 06:58:15 -0500
Date: Fri, 2 Mar 2018 12:58:13 +0100
From: Petr Mladek <pmladek@suse.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>
Subject: Re: [PATCH v0 3/3] livepatch: update documentation for shadow
 variables
Message-ID: <20180302115813.gjn7k67dkfe4szzj@pathway.suse.cz>
References: <1519421630-12025-1-git-send-email-joe.lawrence@redhat.com>
 <1519421630-12025-4-git-send-email-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519421630-12025-4-git-send-email-joe.lawrence@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-02-23 16:33:50, Joe Lawrence wrote:
> Update livepatch shadow variable documentation with respect to new
> atomic replace / cumulative patch functionality.
> 
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> ---
>  Documentation/livepatch/shadow-vars.txt | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/livepatch/shadow-vars.txt b/Documentation/livepatch/shadow-vars.txt
> index 89c66634d600..9a2754cf551c 100644
> --- a/Documentation/livepatch/shadow-vars.txt
> +++ b/Documentation/livepatch/shadow-vars.txt
> @@ -179,6 +179,30 @@ doesn't matter what data value the shadow variable holds, its existence
>  suggests how to handle the parent object.
>  
>  
> +Use in cumulative patches
> +-------------------------
> +
> +Cumulative livepatches provide a "one-stop" module containing all active
> +livepatch code.

I would remove the above sentence. I had troubles to parse and
understand it. I think that the sentence below is better descriptive
and enough :-)

+ A cumulative patch disables and replaces any previously
> +loaded livepatch.  Shadow variable lifetimes should be carefully
> +considered when loading cumulative livepatches:
> +
> +- If shadow variables lifetimes are specific to livepatch module
> +  versions, it may make sense to free them when the corresponding
> +  livepatch module is unloaded.
> +
> +- If shadow variable instances may be safely handled across cumulative
> +  livepatch module versions, then it may make sense to free them from
> +  unpatch callbacks.  When a cumulative patch replaces an existing
> +  livepatch, only the cumulative patch's callbacks will be executed.
> +  This means that new cumulative livepatches may be loaded while
> +  deprecated / disabled livepatches may be unloaded without clearing
> +  existing shadow variables.
> +
> +See Documentation/livepatch/callbacks.txt and cumulative.txt for more

s/cumulative.txt/cumulative-patches.txt/

Best Regards,
Petr
