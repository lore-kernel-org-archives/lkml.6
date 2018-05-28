Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165593AbeE1OUK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:20:10 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50502 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162041AbeE1OUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 10:20:07 -0400
Date: Mon, 28 May 2018 15:20:05 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christian Brauner <christian@brauner.io>
Cc: linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, akpm@linux-foundation.org,
        oleg@redhat.com
Subject: Re: [PATCH 7/8] signal: make do_sigpending() void
Message-ID: <20180528142005.GB30522@ZenIV.linux.org.uk>
References: <20180528134916.7568-1-christian@brauner.io>
 <20180528134916.7568-8-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528134916.7568-8-christian@brauner.io>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 03:49:15PM +0200, Christian Brauner wrote:
> do_sigpending() returned 0 unconditionally so it doesn't make sense to have
> it return at all. This allows us to simplify a bunch of syscall callers.

Yeah, that should've been done in "signal: lift sigset size check out of
do_sigpending()" last year; missed that on review back then.
Acked-by: Al Viro <viro@zeniv.linux.org.uk>
