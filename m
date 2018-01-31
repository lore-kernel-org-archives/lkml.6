Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753496AbeAaOfW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 09:35:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:33211 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751899AbeAaOfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 09:35:20 -0500
Date: Wed, 31 Jan 2018 15:35:17 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Petr Mladek <pmladek@suse.com>
cc: Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        jpoimboe@redhat.com, jeyu@kernel.org, jikos@kernel.org,
        joe.lawrence@redhat.com
Subject: Re: [PATCH v5 0/3] livepatch: introduce atomic replace
In-Reply-To: <20180126102326.u5jscbbgburrzatp@pathway.suse.cz>
Message-ID: <alpine.LSU.2.21.1801311521220.7649@pobox.suse.cz>
References: <cover.1515786085.git.jbaron@akamai.com> <c9064c38-9f04-f6d3-c28b-593a0bb74488@virtuozzo.com> <86cac2eb-0de4-bae7-f633-5ad03297880d@akamai.com> <20180126102326.u5jscbbgburrzatp@pathway.suse.cz>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> IMHO, it might be easier to run just the callbacks from
> the new patch. In reality, the author should always know
> what it might be replacing and what needs to be done.

I agree. I don't see a good solution to the problem. Imagine a crazy 
situation in which someone would like to patch the entry code. Callbacks 
would be non-empty, because of the need to write to MSR and IDT. Then 
there might be an atomic replace cumulative patch. You don't want to run 
callbacks of the previous patches, because that would make the system 
vulnerable again. On the other hand, callbacks in the replace patch could 
do what is necessary.

It is not only entry patching of course. I think it is valid everytime you 
need to write a value to a global system variable of some sort.
 
> By other words, it might be much easier to handle all
> situations in a single script in the new patch. Alternative
> would be doing crazy hacks to prevent the older scripts from
> destroying what we would like to keep. We would need to
> keep in mind interactions between the scripts and
> the order in which they are called.

Crazy, yes.

> Or do you plan to use cumulative patches to simply
> get rid of any other "random" livepatches with something
> completely different? In this case, it might be much more
> safe to disable the older patches a normal way.
> 
> I would suggest to just document the current behavior.
> We should create Documentation/livepatch/cummulative-patches.txt
> anyway.

Agreed.

Regards,
Miroslav
