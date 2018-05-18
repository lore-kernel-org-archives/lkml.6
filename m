Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753317AbeERJvW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 05:51:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55618 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752657AbeERJvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 05:51:19 -0400
Date: Fri, 18 May 2018 11:51:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>, darrick.wong@oracle.com,
        tytso@mit.edu, linux-btrfs@vger.kernel.org, clm@fb.com, jbacik@fb.com,
        viro@zeniv.linux.org.uk, willy@infradead.org
Subject: Re: [PATCH 03/10] locking: bring back lglocks
Message-ID: <20180518095102.GE12217@hirez.programming.kicks-ass.net>
References: <20180518074918.13816-1-kent.overstreet@gmail.com>
 <20180518074918.13816-7-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518074918.13816-7-kent.overstreet@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 03:49:04AM -0400, Kent Overstreet wrote:
> bcachefs makes use of them - also, add a proper lg_lock_init()

Why?! lglocks are horrid things, we got rid of them for a reason. They
have terrifying worst case preemption off latencies.

Why can't you use something like per-cpu rwsems?
