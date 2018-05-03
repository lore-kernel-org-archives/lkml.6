Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752038AbeECFHA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 01:07:00 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36674 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750871AbeECFG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 01:06:59 -0400
Date: Thu, 3 May 2018 06:06:50 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Yizhuo Zhai <yzhai003@ucr.edu>
Cc: mingo@kernel.org, keescook@chromium.org, akpm@linux-foundation.org,
        paulmck@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        Chengyu Song <csong@cs.ucr.edu>, Zhiyun Qian <zhiyunq@cs.ucr.edu>
Subject: Re: [PATCH] kernel/exit.c: pointer sighand could be uninitialized
Message-ID: <20180503050650.GX30522@ZenIV.linux.org.uk>
References: <CABvMjLTfuDqNEt4+1E6R47UFQOj7N1SAhb3KCwxjHsxm7itaog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABvMjLTfuDqNEt4+1E6R47UFQOj7N1SAhb3KCwxjHsxm7itaog@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 06:48:57PM -0700, Yizhuo Zhai wrote:
> Variable 'sighand' could be uninitialized if probe_kernel_address fails
> (-EFAULT). The later use in the if statement may lead to undefined behavior.

Excuse me, but that's nonsense.  The value *copied* into it (in case
probe_kernel_address() has not failed) may be just as uninitialized.
If mere "compare uninitialized pointer value to NULL" can cause nasal demons to fly,
	* we are screwed anyway
	* the piece of crap compiler should be printed on sandpaper and used to
polish its authors.

Read the comments in there, please.  Especially the one regarding the second case.
