Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752291AbeDTTZw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 15:25:52 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42628 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbeDTTZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 15:25:50 -0400
X-Google-Smtp-Source: AIpwx48xS8UU/p0h0XUZgdTX0eY0/D0K+rhPykR6vQzGM4UpNF7NZBtRqRXZV6DbSJMSddEyuqdo9g==
Date: Fri, 20 Apr 2018 22:25:46 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] proc: make /proc/*/cmdline go through LSM
Message-ID: <20180420192546.GA3003@avx2>
References: <20180221192339.GA28548@avx2>
 <20180419170217.0418b519a269003fd950a291@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180419170217.0418b519a269003fd950a291@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 05:02:17PM -0700, Andrew Morton wrote:
> On Wed, 21 Feb 2018 22:23:39 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > /proc/*/cmdline is not different from /proc/*/environ as it accesses
> > target task's memory (and can access the very same region of memory)
> > but it doesn't go through ptrace_may_access() and thus doesn't go through LSM.
> 
> This change can cause existing code to break, no?
> 
> I'd like to see, in the changelog, a full explanation of why this won't
> break any existing setup?

It can. In fact, I'm not sure about this patch anymore.
Original /proc/*/cmdline hook did get_cmdline() which is basically GUP.
It is just nobody said anything when /proc/*/cmdline got rewritten and
security folks aren't bitching about it:

	$ cat /proc/1/cmdline
	init [3]

I'll resend the rest of cmdline changes if they gets broken.
