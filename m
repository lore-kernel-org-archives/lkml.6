Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751692AbeBZRPS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 12:15:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:43612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750767AbeBZRPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 12:15:17 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD3F21719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 26 Feb 2018 12:15:14 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Byungchul Park <byungchul.park@lge.com>
Cc: jiangshanlai@gmail.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH] rcu: Remove the unnecessary separate function,
 rcu_preempt_do_callback()
Message-ID: <20180226121514.122669b9@vmware.local.home>
In-Reply-To: <1519621896-8786-1-git-send-email-byungchul.park@lge.com>
References: <1519621896-8786-1-git-send-email-byungchul.park@lge.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Feb 2018 14:11:36 +0900
Byungchul Park <byungchul.park@lge.com> wrote:

> rcu_preemptp_do_callback() was introduced in commit 09223371dea(rcu:
> Use softirq to address performance regression), where it had to be
> distinguished between in the case CONFIG_TREE_PREEMPT_RCU is set and
> it's not.
> 
> Now that the code was cleaned up so that rcu_preemt_do_callback() is
> only called in rcu_kthread_do_work() in the same file, tree_plugin.h,
> we don't have to keep the separate function anymore. Remove it for a
> better readability.

Looks good to me (looks like commit f8b7fc6b51 "rcu: use softirq
instead of kthreads except when RCU_BOOST=y" cleaned up the ifdefs and
removed the requirement).

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
