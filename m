Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752154AbeC2QFc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 12:05:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750820AbeC2QFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 12:05:31 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 451F120856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 29 Mar 2018 12:05:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-patch-test@lists.linaro.org
Subject: Re: [PATCH v1] kernel/trace:check the val against the available mem
Message-ID: <20180329120528.337bf6cb@gandalf.local.home>
In-Reply-To: <1522320104-6573-1-git-send-email-zhaoyang.huang@spreadtrum.com>
References: <1522320104-6573-1-git-send-email-zhaoyang.huang@spreadtrum.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Mar 2018 18:41:44 +0800
Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:

> It is reported that some user app would like to echo a huge
> number to "/sys/kernel/debug/tracing/buffer_size_kb" regardless
>  of the available memory, which will cause the coinstantaneous
> page allocation failed and introduce OOM. The commit checking the
> val against the available mem first to avoid the consequence allocation.
> 

One of my tests is to stress buffer_size_kb, and it fails nicely if you
try to get too much. Although, it may cause an OOM, but that's expected.

The application should do the test (try "free" on the command line).
This isn't something that the kernel should be responsible for. If
someone wants to allocate all memory for tracing, that's their
prerogative.

-- Steve
