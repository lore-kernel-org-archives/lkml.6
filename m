Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751262AbeDEDOc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 23:14:32 -0400
Received: from imap.thunk.org ([74.207.234.97]:34782 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750853AbeDEDOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 23:14:31 -0400
Date: Wed, 4 Apr 2018 23:14:20 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] locking/rwsem: Add up_write_non_owner() for
 percpu_up_write()
Message-ID: <20180405031420.GB22358@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Oleg Nesterov <oleg@redhat.com>
References: <1522852646-2196-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522852646-2196-1-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 10:37:26AM -0400, Waiman Long wrote:
> The commit 8c5db92a705d ("locking/rwsem: Add DEBUG_RWSEMS to look for
> lock/unlock mismatches") causes a warning in ext4 fstests due to the
> fact that the freeze and thaw ioctls, by design, are run in different
> processes.

While true, it's not just ext4 fstests --- it's any file system which
supports freeze/thaw, since it's happening in the vfs layer.  I have
just as easily replicated the problem using "kvm-xfstests -c xfs
generic/068".  Or "kvm-xfstests -c btrfs generic/068".

Cheers,

						- Ted
