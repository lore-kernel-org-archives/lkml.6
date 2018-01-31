Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753441AbeAaWIR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 17:08:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51362 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751880AbeAaWIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 17:08:15 -0500
Date: Wed, 31 Jan 2018 16:08:11 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        jeyu@kernel.org, jikos@kernel.org, mbenes@suse.cz,
        joe.lawrence@redhat.com
Subject: Re: [PATCH v5 0/3] livepatch: introduce atomic replace
Message-ID: <20180131220811.isgqpf3gwrsnul5k@treble>
References: <cover.1515786085.git.jbaron@akamai.com>
 <c9064c38-9f04-f6d3-c28b-593a0bb74488@virtuozzo.com>
 <86cac2eb-0de4-bae7-f633-5ad03297880d@akamai.com>
 <20180126102326.u5jscbbgburrzatp@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180126102326.u5jscbbgburrzatp@pathway.suse.cz>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26, 2018 at 11:23:26AM +0100, Petr Mladek wrote:
> So, we are talking about a lot of rather non-trivial code.
> IMHO, it might be easier to run just the callbacks from
> the new patch. In reality, the author should always know
> what it might be replacing and what needs to be done.
> 
> By other words, it might be much easier to handle all
> situations in a single script in the new patch. Alternative
> would be doing crazy hacks to prevent the older scripts from
> destroying what we would like to keep. We would need to
> keep in mind interactions between the scripts and
> the order in which they are called.
> 
> Or do you plan to use cumulative patches to simply
> get rid of any other "random" livepatches with something
> completely different? In this case, it might be much more
> safe to disable the older patches a normal way.
> 
> I would suggest to just document the current behavior.
> We should create Documentation/livepatch/cummulative-patches.txt
> anyway.

+1.  Only the new patch (hopefully) knows the details about what is
being reverted.  So it makes sense to ignore the replaced patch's
callbacks, and to only call the new patch's callbacks.

-- 
Josh
