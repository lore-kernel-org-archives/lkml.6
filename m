Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752448AbeBIDV1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 22:21:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:48394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752201AbeBIDV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 22:21:26 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 835D12075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 8 Feb 2018 22:21:22 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Zhengyuan Liu" <liuzhengyuan@kylinos.cn>
Cc: "mingo" <mingo@redhat.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "liuzhengyuang521" <liuzhengyuang521@gmail.com>,
        "linx.z.chen" <linx.z.chen@intel.com>
Subject: Re: [PATCH] ftrace: fix the file mode of graph tracer and
 stacktracer
Message-ID: <20180208222122.5ba7c7fe@vmware.local.home>
In-Reply-To: <tencent_34C119E628948BE127843C25@qq.com>
References: <1518054113-28096-1-git-send-email-liuzhengyuan@kylinos.cn>
        <20180208102149.7e3bfe45@gandalf.local.home>
        <tencent_34C119E628948BE127843C25@qq.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Feb 2018 10:33:31 +0800
"Zhengyuan Liu" <liuzhengyuan@kylinos.cn> wrote:

> It doesn't affect root writing to those files as root is a super user and
> can access to any write-only files.  I just want to make those writable

Ah, I know when I vim a file that's read only, even for root vim will
complain. But there's no complaining with redirection.

I just tried vim on set_graph_function, and yeah, it does complain.

> file to look consistent with others, seeing bellow:
> 
> -rw-r--r--  1 root root  set_event_pid
> -rw-r--r--  1 root root  set_ftrace_filter
> -rw-r--r--  1 root root  set_ftrace_notrace
> -rw-r--r--  1 root root  set_ftrace_pid
> -r--r--r--  1 root root   set_graph_function
> -r--r--r--  1 root root  set_graph_notrace

Yeah, I understand.

> 
> If this patch makes no sense, just ignore it!

No no, it makes perfect sense. I plan on adding it. But it's not that
important to be included for stable. Expect to see this in 4.17.

Thanks!

-- Steve
