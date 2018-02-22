Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932991AbeBVPZL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:25:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:35453 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932785AbeBVPZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:25:09 -0500
Date: Thu, 22 Feb 2018 16:25:07 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Petr Mladek <pmladek@suse.com>
cc: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/8] livepatch: Allow to unpatch only functions of
 the given type
In-Reply-To: <20180221132914.4809-5-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1802221624550.12659@pobox.suse.cz>
References: <20180221132914.4809-1-pmladek@suse.com> <20180221132914.4809-5-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Feb 2018, Petr Mladek wrote:

> From: Jason Baron <jbaron@akamai.com>
> 
> We are going to add a feature called atomic replace. It will allow to
> create a patch that would replace all already registered patches.
> For this, we will need to dynamically create funcs and objects
> for functions that are no longer patched.
> 
> The dynamically allocated objects will not longer be needed once
> the patch is applied.
> 
> This patch allows to unpatch functions of the given type. It might
> cause that the obj->patched flag is true even when some listed
> functions are not longer patched. This is fine as long as the
> unpatched funcs' structures are removed right after. It will
> be the case. Anyway, it is safe. In the worst case, it will
> not be possible to enable the disabled functions.
> 
> Signed-off-by: Jason Baron <jbaron@akamai.com>
> [pmladek@suse.com: Split and modified to use the generic ftype]
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Miroslav Benes <mbenes@suse.cz>

Acked-by: Miroslav Benes <mbenes@suse.cz>

Miroslav
