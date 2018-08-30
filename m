Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AB2C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 23:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940B02082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 23:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 940B02082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbeHaDpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 23:45:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbeHaDpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 23:45:32 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F8C22082A;
        Thu, 30 Aug 2018 23:40:55 +0000 (UTC)
Date:   Thu, 30 Aug 2018 19:40:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 22/32] selftests/ftrace: Add ringbuffer size changing
 testcase
Message-ID: <20180830194053.4f1351b1@gandalf.local.home>
In-Reply-To: <20180831083528.ae339a660d28a71e02f03ed4@kernel.org>
References: <153443695002.23257.13628220023468200991.stgit@devbox>
        <153443757416.23257.9284862385646039929.stgit@devbox>
        <20180824191836.305ad740@gandalf.local.home>
        <20180830161218.e46affa5a84abd47c9cf2a39@kernel.org>
        <20180830115055.6a28054c@gandalf.local.home>
        <20180831083528.ae339a660d28a71e02f03ed4@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Aug 2018 08:35:28 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Thu, 30 Aug 2018 11:50:55 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Thu, 30 Aug 2018 16:12:18 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >   
> > > > I'm fine with this, but one day I need to port over some of my other
> > > > tests. I have a test that stresses the ring buffer size (basically
> > > > checks to see if it can cause an oom). I need to port that to
> > > > selftests. But for now...    
> > > 
> > > Hmm, such stress test is not good for kselftest, since it can cause
> > > oom and kill some test process. Maybe we should have such stresstest
> > > framework (which allows test to crash kernel)  
> > 
> > The point of the test is to make sure that it doesn't kill
> > everything :-)  The ring buffer code is suppose to detect that it will
> > cause an OOM, and if it does that's considered a failure.  
> 
> Ah, OK, so the test itself must not cause OOM. That's reasonable. :)
> 
> > 
> > Just like any other test, if it fails, it can crash the kernel. But the
> > ring buffer code is suppose to be able to keep the kernel from crashing
> > (including triggering OOM) if the buffer size is stressed.
> > 
> > Maybe I'll port that over today :-/  
> 
> Looking forward it!
> 

Unfortunately, I didn't get to it, and will be on PTO for the next 4
days. Perhaps next week.

-- Steve
