Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751910AbeBIKGX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 05:06:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:47468 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751034AbeBIKGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 05:06:21 -0500
Date: Fri, 9 Feb 2018 11:06:19 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Petr Mladek <pmladek@suse.com>
cc: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/7] livepatch: Use lists to manage patches, objects
 and functions
In-Reply-To: <20180206103424.10829-2-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1802070932320.1099@pobox.suse.cz>
References: <20180206103424.10829-1-pmladek@suse.com> <20180206103424.10829-2-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Feb 2018, Petr Mladek wrote:

> From: Jason Baron <jbaron@akamai.com>
> 
> Currently klp_patch contains a pointer to a statically allocated array of
> struct klp_object and struct klp_objects contains a pointer to a statically
> allocated array of klp_func. In order to allow for the dynamic allocation
> of objects and functions, link klp_patch, klp_object, and klp_func together
> via linked lists. This allows us to more easily allocate new objects and
> functions, while having the iterator be a simple linked list walk.
> 
> The static structures are added to the lists early. It allows to add
> the dynamically allocated objects before klp_init_object() and
> klp_init_func() calls. Therefore it reduces the further changes
> to the code.
> 
> Also klp_init_*_list() functions are split because they will
> be used when adding the dynamically allocated structures.
> 
> This patch does not change the existing behavior.
> 
> Signed-off-by: Jason Baron <jbaron@akamai.com>
> [pmladek@suse.com: Initialize lists before init calls]
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Miroslav Benes <mbenes@suse.cz>

Acked-by: Miroslav Benes <mbenes@suse.cz>

Miroslav
