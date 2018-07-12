Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26421C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D011421479
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="plSa47F4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D011421479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732487AbeGLOIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:08:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727497AbeGLOIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:08:47 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CE59208E9;
        Thu, 12 Jul 2018 13:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531403946;
        bh=k8hPuUF9ADARwyLnHwkHHL/4Gu7GzZzLZua9ncDVCIw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=plSa47F4vcHP1NcCWFxr1vNYN8bP7uiHth0nDk0m0f4lFf0gpHeEdAz9LCvaBrI45
         BC1Sd6r6oQPci8OOJS1BQ0HZUnE6BYjbi3N+wMCG52hsvbQ3Gs7lGOaLRAk6lD97V5
         pQ0ImHPqK5cX4lsdDheJAOPOLIVZrdajyHbuNczM=
Date:   Thu, 12 Jul 2018 22:59:03 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Francis Deslauriers <francis.deslauriers@efficios.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        torvalds@linux-foundation.org
Subject: Re: [PATCH 2/2] kprobe: fix: Add ftrace_ops_assist_func to kprobe
 blacklist
Message-Id: <20180712225903.54fc8720cc188676655475bc@kernel.org>
In-Reply-To: <CADcCL0hz7GOW=+pzMcwktiMx+g7NTV3ua41zU0UHHSjHQdGKQg@mail.gmail.com>
References: <1500044315-9508-1-git-send-email-francis.deslauriers@efficios.com>
        <1500044315-9508-3-git-send-email-francis.deslauriers@efficios.com>
        <20170714142900.1c91949c@gandalf.local.home>
        <CADcCL0i_Rw9dRkrTUXiVK4dXOXD6QsRrBRc_pJ3XB_SyEqPR5w@mail.gmail.com>
        <20180316112517.66bdd85a@gandalf.local.home>
        <229385456.11580.1521217739037.JavaMail.zimbra@efficios.com>
        <20180316124134.30fa47d5@gandalf.local.home>
        <20180316124840.3e83bbec@gandalf.local.home>
        <1577244734.11604.1521222781948.JavaMail.zimbra@efficios.com>
        <20180317091334.55f1fc325c26deaa4d4a4d19@kernel.org>
        <20180317102211.a648f26ae0d5a53d95c63022@kernel.org>
        <20180703183048.1eeeef4a@gandalf.local.home>
        <CADcCL0gFTR2s7X_a8CiqHBeFyy3mR15jF48tOyZoJ3zbDA9KZA@mail.gmail.com>
        <20180711155628.78b0fd83@gandalf.local.home>
        <CADcCL0hz7GOW=+pzMcwktiMx+g7NTV3ua41zU0UHHSjHQdGKQg@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 20:40:45 -0400
Francis Deslauriers <francis.deslauriers@efficios.com> wrote:

> Le mer. 11 juill. 2018, à 15 h 56, Steven Rostedt
> <rostedt@goodmis.org> a écrit :
> >
> > On Wed, 11 Jul 2018 15:34:30 -0400
> > Francis Deslauriers <francis.deslauriers@efficios.com> wrote:
> >
> > > Hi Steven,
> > > I tested it and it prevents the kernel crash I am witnessing.
> > > As for the side-effect that Masami mentioned regarding not being able to probe
> > > function inside the trace_kprobe.c file, I suggest we move the target
> > > function in
> > > its own separate compile unit so it can be compiled with the ftrace cflags.
> > > See patch below.
> > >
> >
> > The patch below looks fine and so does Masami's. But there's too many
> > patches within emails (not separated out). I have no idea what to
> > apply. I'm not going to apply anything that is not sent as a proper
> > patch (ie. any patch within a separate thread, like the patch below).
> >
> I will put together a proper patch set with both commits.
> 
> Masami, you mentioned: "So anyway we still need to mark those functions
> NOKPROBE_SYMBOL." in a reply. What functions were you talking about?
> ftrace_ops_assist_func? Aren't those functions covered by your
> within_notrace_func check?

Ah, I thought that we'd better to consider a "pure" kprobe without ftrace
on notrace functions. From ftrace, we can prohibit probing on notrace funcs,
but if user makes an out-of-tree kprobe module and put it on notrace funcs,
that can cause a problem (if they enable some kprobe events at same time).

Thank you,



-- 
Masami Hiramatsu <mhiramat@kernel.org>
