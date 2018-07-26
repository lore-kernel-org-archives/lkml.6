Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E542C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5139B2088E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5139B2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731659AbeGZVRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 17:17:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:38498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730533AbeGZVRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 17:17:13 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5532E20673;
        Thu, 26 Jul 2018 19:58:50 +0000 (UTC)
Date:   Thu, 26 Jul 2018 15:58:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Francis Deslauriers <francis.deslauriers@efficios.com>,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] selftests/ftrace: Fix kprobe string testcase to
 not probe notrace function
Message-ID: <20180726155848.5d45aedb@gandalf.local.home>
In-Reply-To: <20180726164409.c4967698668b1816a8e9747c@kernel.org>
References: <153258437722.11602.12405835083073480618.stgit@devbox>
        <153258446365.11602.5245508133014563916.stgit@devbox>
        <20180726164409.c4967698668b1816a8e9747c@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jul 2018 16:44:09 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Thu, 26 Jul 2018 14:54:23 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Fix kprobe string argument testcase to not probe notrace
> > function. Instead, it probes tracefs function which must
> > be available with ftrace.  
> 
> Oops, this must be sent to Shuah too.
> 
> Shuah, I think you can freely pick this patch to kselftest
> branch, since this removes a dependency of notrace functions,
> not depends on any new feature :)
> 

Shuah,

Please take this patch in your tree. I'll take the other two.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
