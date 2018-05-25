Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030235AbeEYUu0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 16:50:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:45253 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968275AbeEYUuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 16:50:25 -0400
Subject: Re: [PATCH] mm, page_alloc: do not break __GFP_THISNODE by zonelist
 reset
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>, David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, stable@vger.kernel.org
References: <20180525130853.13915-1-vbabka@suse.cz>
 <20180525124300.964a1a15d953e8972625bb0f@linux-foundation.org>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <4cd73f77-e6ab-bdd1-69a2-bd0f8413d189@suse.cz>
Date: Fri, 25 May 2018 22:48:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180525124300.964a1a15d953e8972625bb0f@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/25/2018 09:43 PM, Andrew Morton wrote:
> On Fri, 25 May 2018 15:08:53 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:
> 
>> we might consider this for 4.17 although I don't know if there's anything
>> currently broken. Stable backports should be more important, but will have to
>> be reviewed carefully, as the code went through many changes.
>> BTW I think that also the ac->preferred_zoneref reset is currently useless if
>> we don't also reset ac->nodemask from a mempolicy to NULL first (which we
>> probably should for the OOM victims etc?), but I would leave that for a
>> separate patch.
> 
> Confused.  If nothing is currently broken then why is a backport
> needed?  Presumably because we expect breakage in the future?  Can you
> expand on this?

I mean that SLAB is currently not affected, but in older kernels than
4.7 that don't yet have 511e3a058812 ("mm/slab: make cache_grow() handle
the page allocated on arbitrary node") it is. That's at least 4.4 LTS.
Older ones I'll have to check.
