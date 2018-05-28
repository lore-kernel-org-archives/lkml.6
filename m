Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939665AbeE1PHc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:07:32 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:49176 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S939653AbeE1PH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 11:07:27 -0400
Date: Mon, 28 May 2018 17:07:20 +0200
From: Christian Brauner <christian@brauner.io>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, akpm@linux-foundation.org,
        oleg@redhat.com
Subject: Re: [PATCH 5/8] signal: flatten do_send_sig_info()
Message-ID: <20180528150719.GA29882@mailbox.org>
References: <20180528134916.7568-1-christian@brauner.io>
 <20180528134916.7568-6-christian@brauner.io>
 <20180528141537.GA30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180528141537.GA30522@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 03:15:37PM +0100, Al Viro wrote:
> On Mon, May 28, 2018 at 03:49:13PM +0200, Christian Brauner wrote:
> > Let's return early when lock_task_sighand() fails and move send_signal()
> > and unlock_task_sighand() out of the if block.
> 
> Why is it an improvement?

I prefer to return early if I know I can and have the bigger portion of
the code move out of the if-branch. But that's - let's say - an
opinionated improvement.

Christian
