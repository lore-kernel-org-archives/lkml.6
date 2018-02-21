Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751346AbeBUUG3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 15:06:29 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:60030 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbeBUUG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:06:28 -0500
Date: Wed, 21 Feb 2018 12:06:27 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] proc: make /proc/*/cmdline go through LSM
Message-Id: <20180221120627.9e134187df86df7c08ad78ca@linux-foundation.org>
In-Reply-To: <20180221192339.GA28548@avx2>
References: <20180221192339.GA28548@avx2>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Feb 2018 22:23:39 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> /proc/*/cmdline is not different from /proc/*/environ as it accesses
> target task's memory (and can access the very same region of memory)
> but it doesn't go through ptrace_may_access() and thus doesn't go through LSM.
> 

I'd really like to see more thoughtful changelogging, please.

Why are we doing this?  What is the advantage?

Doesn't this mean that code which could previously read
/proc/pid/cmdline may no longer be able to do so?  Can't this break
userspace?  Discuss.  Lots!
