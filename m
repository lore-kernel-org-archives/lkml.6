Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968049AbeEYTnE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 15:43:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37278 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967784AbeEYTnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 15:43:02 -0400
Date: Fri, 25 May 2018 12:43:00 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>, David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm, page_alloc: do not break __GFP_THISNODE by zonelist
 reset
Message-Id: <20180525124300.964a1a15d953e8972625bb0f@linux-foundation.org>
In-Reply-To: <20180525130853.13915-1-vbabka@suse.cz>
References: <20180525130853.13915-1-vbabka@suse.cz>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2018 15:08:53 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:

> we might consider this for 4.17 although I don't know if there's anything
> currently broken. Stable backports should be more important, but will have to
> be reviewed carefully, as the code went through many changes.
> BTW I think that also the ac->preferred_zoneref reset is currently useless if
> we don't also reset ac->nodemask from a mempolicy to NULL first (which we
> probably should for the OOM victims etc?), but I would leave that for a
> separate patch.

Confused.  If nothing is currently broken then why is a backport
needed?  Presumably because we expect breakage in the future?  Can you
expand on this?
