Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753541AbeDPT5p (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 15:57:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47172 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753269AbeDPT5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 15:57:43 -0400
Date: Mon, 16 Apr 2018 14:57:42 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Nicolai Stange <nstange@suse.de>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] livepatch: Allocate and free shadow variables
 more safely
Message-ID: <20180416195742.n2zsthypbx7c4yzn@treble>
References: <20180416113647.25288-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180416113647.25288-1-pmladek@suse.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 01:36:45PM +0200, Petr Mladek wrote:
> Nikolai started to use shadow variables and found that list_head
> is not initialized correctly using the existing API.
> 
> The problem is that LIST_HEAD_INIT() set pointers to itself.
> klp_shadow_alloc() then copies these pointers to another location.
> 
> It would be possible to solve this by a late initialization. But
> this does not work well with klp_shadow_get_or_alloc(). Also this
> behavior is error prone. Note that list_head might be hidden in
> another structure, for example mutex.
> 
> I suggest to change the API and allow to initialize the shadow
> variables using a custom callback. I think that we have already
> talked about this but we decided to go the easier way. It seems
> that it was a bad decision.
> 
> I send also patch that add a symmetric callback to the klp_shadow_free()
> functions. It might be handy especially for klp_shadow_free_all().
> 
> 
> Changes against v2:
> 
>   + Use pr_err() instead of WARN() when ctor() fails [Josh]
>   + Some typos [Mirek]
> 
> 
> Changes against v1:
> 
>   + Rename init/free callbacks to ctor/dtor
>   + Misc update of comments and commit messages
>   + Fix sizeof() in the sample code in shadow-vars.txt

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh
