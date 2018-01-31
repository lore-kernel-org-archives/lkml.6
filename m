Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753883AbeAaQTS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 11:19:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:44004 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753865AbeAaQTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 11:19:14 -0500
Date: Wed, 31 Jan 2018 17:19:11 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Petr Mladek <pmladek@suse.com>
cc: jpoimboe@redhat.com, jikos@kernel.org, Jason Baron <jbaron@akamai.com>,
        jeyu@kernel.org, Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: PATCH v6 5/6] livepatch: Support separate list for replaced
 patches.
In-Reply-To: <20180125160203.28959-6-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1801311717230.7649@pobox.suse.cz>
References: <20180125160203.28959-1-pmladek@suse.com> <20180125160203.28959-6-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jan 2018, Petr Mladek wrote:

> From: Jason Baron <jbaron@akamai.com>
> 
> We are going to add a feature called atomic replace. It will allow to
> create a patch that would replace all already registered patches.
> 
> The replaced patches will stay registered because they are typically
> unregistered by some package uninstall scripts. But we will remove
> these patches from @klp_patches list to keep the enabled patch
> on the bottom of the stack. Otherwise, we would need to implement
> rather complex logic for moving the patches on the stack. Also
> it would complicate implementation of the atomic replace feature.
> It is not worth it.
> 
> As a result, we will have patches that are registered but that
> are not longer usable. Let's get prepared for this and use
> a better descriptive name for klp_is_patch_registered() function.
> 
> Also create separate list for the replaced patches and allow to
> unregister them. Alternative solution would be to add a flag
> into struct klp_patch. Note that patch->kobj.state_initialized
> is not safe because it can be cleared outside klp_mutex.
> 
> This patch does not change the existing behavior.

Ok, why not. We could also unregister the patches right away and amend the 
check in klp_unregister_patch() not to return error. Ever.

However, this seems better in the end.

Miroslav
