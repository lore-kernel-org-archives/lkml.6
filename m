Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C269CC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A981208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpHopHR5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A981208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730791AbeG0OJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 10:09:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:40004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728384AbeG0OJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 10:09:03 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 190522064D;
        Fri, 27 Jul 2018 12:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532695636;
        bh=Wr0v0xJtcbR6dhI9+wSTU2DIujhvLipgcYdAFc2my9w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rpHopHR5ESCLKZX6y1+QywLKBdh893M/2Z3fELSiKd6wkUsk1OidMIE/AGO0Gh2VU
         FMOdqUJciE3SOLXIeArGEkpXVKgLCoei2KfncGWxdLfKACyix2kpQxETnSuGUYyiTp
         PomvUfEfinws5RDThAuOYLdOtuABbCqiV79oZRrU=
Date:   Fri, 27 Jul 2018 21:47:13 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Francis Deslauriers <francis.deslauriers@efficios.com>,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] selftests/ftrace: Fix kprobe string testcase to
 not probe notrace function
Message-Id: <20180727214713.a6e5743c5aa5cb12413af72e@kernel.org>
In-Reply-To: <555469b9-a866-60f1-6856-e8bd80f99591@kernel.org>
References: <153258437722.11602.12405835083073480618.stgit@devbox>
        <153258446365.11602.5245508133014563916.stgit@devbox>
        <20180726164409.c4967698668b1816a8e9747c@kernel.org>
        <20180726155848.5d45aedb@gandalf.local.home>
        <555469b9-a866-60f1-6856-e8bd80f99591@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jul 2018 15:22:22 -0600
Shuah Khan <shuah@kernel.org> wrote:

> On 07/26/2018 01:58 PM, Steven Rostedt wrote:
> > On Thu, 26 Jul 2018 16:44:09 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> >> On Thu, 26 Jul 2018 14:54:23 +0900
> >> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >>
> >>> Fix kprobe string argument testcase to not probe notrace
> >>> function. Instead, it probes tracefs function which must
> >>> be available with ftrace.  
> >>
> >> Oops, this must be sent to Shuah too.
> >>
> >> Shuah, I think you can freely pick this patch to kselftest
> >> branch, since this removes a dependency of notrace functions,
> >> not depends on any new feature :)
> >>
> > 
> > Shuah,
> > 
> > Please take this patch in your tree. I'll take the other two.
> > 
> > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > 
> > -- Steve
> > 
> 
> Steve,
> 
> yes. I will pick this up.

Thanks Steve and Shuah!

> 
> thanks,
> -- Shuah
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
