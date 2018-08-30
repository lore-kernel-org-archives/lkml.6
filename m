Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541F0C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 23:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BDDE20835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 23:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQ5U43nW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BDDE20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbeHaDkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 23:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbeHaDkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 23:40:07 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A5602082A;
        Thu, 30 Aug 2018 23:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535672131;
        bh=upf4N5EmZ93V9CeM5LmTK9yiEoT/Nib4/P9YVT9HnjQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hQ5U43nWa0gx2jU790w/uTJqqNlWOdirkGqnzDcRDDyRXrcJf7GQf75k+mgw55oE/
         eTdIQxTnl8rxwy8XMG29oiBMDwv0sfdMBtgL/tvgBv9qmo2VazArJCe5UnlLi7IPzP
         842wYW//ZBWFtAhOqk0+cLFH6CnEUywxiAA35JZw=
Date:   Fri, 31 Aug 2018 08:35:28 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 22/32] selftests/ftrace: Add ringbuffer size changing
 testcase
Message-Id: <20180831083528.ae339a660d28a71e02f03ed4@kernel.org>
In-Reply-To: <20180830115055.6a28054c@gandalf.local.home>
References: <153443695002.23257.13628220023468200991.stgit@devbox>
        <153443757416.23257.9284862385646039929.stgit@devbox>
        <20180824191836.305ad740@gandalf.local.home>
        <20180830161218.e46affa5a84abd47c9cf2a39@kernel.org>
        <20180830115055.6a28054c@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018 11:50:55 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 30 Aug 2018 16:12:18 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > > I'm fine with this, but one day I need to port over some of my other
> > > tests. I have a test that stresses the ring buffer size (basically
> > > checks to see if it can cause an oom). I need to port that to
> > > selftests. But for now...  
> > 
> > Hmm, such stress test is not good for kselftest, since it can cause
> > oom and kill some test process. Maybe we should have such stresstest
> > framework (which allows test to crash kernel)
> 
> The point of the test is to make sure that it doesn't kill
> everything :-)  The ring buffer code is suppose to detect that it will
> cause an OOM, and if it does that's considered a failure.

Ah, OK, so the test itself must not cause OOM. That's reasonable. :)

> 
> Just like any other test, if it fails, it can crash the kernel. But the
> ring buffer code is suppose to be able to keep the kernel from crashing
> (including triggering OOM) if the buffer size is stressed.
> 
> Maybe I'll port that over today :-/

Looking forward it!

Thank you,

> 
> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
