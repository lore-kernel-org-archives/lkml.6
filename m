Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752377AbeDFUIF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 16:08:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45986 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752334AbeDFUID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 16:08:03 -0400
Date: Fri, 6 Apr 2018 13:08:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>, Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH v2 0/3] mm/get_user_pages_fast fixes, cleanups
Message-Id: <20180406130802.d80742aeda85a595150b28cf@linux-foundation.org>
In-Reply-To: <1522962072-182137-1-git-send-email-mst@redhat.com>
References: <1522962072-182137-1-git-send-email-mst@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Apr 2018 00:03:48 +0300 "Michael S. Tsirkin" <mst@redhat.com> wrote:

> Turns out get_user_pages_fast and __get_user_pages_fast return different
> values on error when given a single page: __get_user_pages_fast returns
> 0.  get_user_pages_fast returns either 0 or an error.
> 
> Callers of get_user_pages_fast expect an error so fix it up to return an
> error consistently.
> 
> Stress the difference between get_user_pages_fast and __get_user_pages_fast
> to make sure callers aren't confused.
> 

A term which is missing from all these changelogs is "vhost" :(

This patchset fixes a user-affecting bug, does it not?  If so, please
fully describe that bug so that we can decide which kernel version(s)
need the patchset.

And yes, this return value asymmetry is sad.  Did you scope out what
would be needed to fix up the callers so we can avoid this?
