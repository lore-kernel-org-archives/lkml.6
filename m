Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274C5C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 01:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA91721581
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 01:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA91721581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbeHYFTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 01:19:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbeHYFTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 01:19:13 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC39C21581;
        Sat, 25 Aug 2018 01:42:06 +0000 (UTC)
Date:   Fri, 24 Aug 2018 21:42:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/32] selftests/ftrace: Add --console hidden option
Message-ID: <20180824214204.38e2004d@vmware.local.home>
In-Reply-To: <20180825103513.5b86d42a7ee2d20435522fbb@kernel.org>
References: <153443695002.23257.13628220023468200991.stgit@devbox>
        <153443703653.23257.12015337438174061938.stgit@devbox>
        <20180824163737.0f47535a@gandalf.local.home>
        <20180825103513.5b86d42a7ee2d20435522fbb@kernel.org>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Aug 2018 10:35:13 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Fri, 24 Aug 2018 16:37:37 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Fri, 17 Aug 2018 01:30:36 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >   
> > > Add --console hidden option for debug test cases.
> > > This option allows to put "sh" or something else
> > > when the test case hits a bug.  
> > 
> > Can you add more information to why and how this would be used.  
> 
> For example, if you find a testcase which doesn't
> pass, you can insert sh for interactive debug as below
> 
>   #!/bin/sh
>   # description: sample test case
> 
>   good-command
>   suspicious-wrong-command
>   sh # <- add this for interactive debug
> 

Ah! OK. But this needs to be explained a little better in the change
log as well as in the comments for it.

Thanks!

-- Steve
