Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751384AbeDEI4b (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 04:56:31 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36073 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbeDEI4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 04:56:30 -0400
X-Google-Smtp-Source: AIpwx49XM/p1VtPvj8gAMo5JnxKj8FAWOoj/lq866dkqmZERSBAokkUJ7mWxpHWsnFgzSKTn6xEn1Q==
Date: Thu, 5 Apr 2018 10:56:21 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: David Howells <dhowells@redhat.com>, paulmck@linux.vnet.ibm.com,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Andrea Parri <parri.andrea@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v2 1/3] locking: Document the semantics of
 spin_is_locked()
Message-ID: <20180405085620.GA6079@andrea>
References: <1522600912-6208-2-git-send-email-andrea.parri@amarulasolutions.com>
 <1522600912-6208-1-git-send-email-andrea.parri@amarulasolutions.com>
 <29562.1522759749@warthog.procyon.org.uk>
 <20180405074749.GA23889@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405074749.GA23889@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 12:47:49AM -0700, Christoph Hellwig wrote:
> Can't we just kill off spin_is_locked?  It seems pretty much all uses
> should simply be replaced with lockdep annotations, and there aren't
> many to start with.

Yeah, this is not the first time such a question has been raised ;) In fact,
some people (see, e.g., Peter's comment in this thread) have also suggested
extending it to {mutex,rwsem,bit_spin}_is_locked  (the number of uses would
then increase to a few hundreds, and lockdep would need some extensions...).
Of course, removing the docbook headers should not cause particular trouble,
once/if the removal of these primitives will be realized... ;)

  Andrea
> 
