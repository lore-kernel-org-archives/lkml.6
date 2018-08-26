Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B4BC433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 07:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35752084E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 07:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oy66ZbMX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F35752084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbeHZLMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 07:12:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbeHZLMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 07:12:05 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 367EE2084E;
        Sun, 26 Aug 2018 07:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535268623;
        bh=+D073OtBuhT2tp9ty+gWmD/JczrGET1hFTxW4MZgUN4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oy66ZbMXDm/IhiB6d0QJy9ZlHyWteatCnfWGprbOiq5IxkzFt3wB78s8PZNDB60rY
         uCWSLa8WWst67BCKH8s3VH0s8VOk9/hKOtWqBQ6mon+YUPk8mq+XNBKk/jvnv0EpD1
         B0qQHgRVpyEuxS6qOgBgpZbNByGop43jcJyiYJ0c=
Date:   Sun, 26 Aug 2018 16:30:20 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 19/32] selftests/ftrace: Add a testcase for nop
 tracer
Message-Id: <20180826163020.acae9d2772fa6d7de005b83d@kernel.org>
In-Reply-To: <20180824185342.542d8a6a@gandalf.local.home>
References: <153443695002.23257.13628220023468200991.stgit@devbox>
        <153443748943.23257.13855745627496095446.stgit@devbox>
        <20180824185342.542d8a6a@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 18:53:42 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 17 Aug 2018 01:38:09 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Add a testcase for nop tracer. This tracer has 2 test
> > options, so check it too.
> > 
> 
> I'd rather not include this. In fact, I'd love to get rid of the nop
> options. They were added to make sure options worked when we first
> added them. They are actually pointless.

Got it. I was thinking it was an odd option when I was writing a test. :)

> The only point of this test is to know if options work or not. Hmm, I
> guess that is something that could possibly be valuable :-/

Actually setting "nop" is already done in basic testcase. So I think
we can just drop this test.


Thank you,
 
> -- Steve
> 
> 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  .../testing/selftests/ftrace/test.d/tracer/nop.tc  |   22 ++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >  create mode 100644 tools/testing/selftests/ftrace/test.d/tracer/nop.tc
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/tracer/nop.tc b/tools/testing/selftests/ftrace/test.d/tracer/nop.tc
> > new file mode 100644
> > index 000000000000..ca63e316e0f5
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/tracer/nop.tc
> > @@ -0,0 +1,22 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +# description: Test nop tracer
> > +
> > +# nop must be supported always
> > +grep -q "nop" available_tracers
> > +
> > +echo "nop" > current_tracer
> > +
> > +# nop provides 2 test options
> > +grep -q "test_nop_accept" trace_options
> > +grep -q "test_nop_refuse" trace_options
> > +
> > +# nop_accept always success
> > +echo "test_nop_accept" > trace_options
> > +echo "notest_nop_accept" > trace_options
> > +
> > +# nop_refuse always failed
> > +! echo "test_nop_refuse" > trace_options
> > +! echo "notest_nop_refuse" > trace_options
> > +
> > +exit 0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
