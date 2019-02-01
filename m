Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4C4C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0571218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549027920;
	bh=Oy2B0cBtVEZtHEjGOPzWYBJxsdKdJSk9CNOaaDAMNvY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=mKHJZ5fMqNKnp+TS2IS0k5+ttpWdZlWD9pqAsqnba8mt4xFzaKyok549XZgrsW58T
	 iQmYiDLcyocF0ih6zfxQE7PARJ/rHXMT2DXAX6/1zp4FmjAm81VLSPkfic9GhasQ57
	 CcGzc9ZkEFw8s9fkSND9fQZTR4bFj1x14IZbb7XQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbfBANb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 08:31:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:36646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbfBANb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 08:31:58 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 927CE21872;
        Fri,  1 Feb 2019 13:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549027917;
        bh=Oy2B0cBtVEZtHEjGOPzWYBJxsdKdJSk9CNOaaDAMNvY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aybI9/M1TP2mjadu3sLWgnHz9u+7jZgjxJtRbn/7fN7gtysTS7p5WooFlcI7dWpTx
         bFF8QNp9SirqhN106e4dRZr8lmMA5JsUG332EgoBAW5v264TK3OF1FT2a3jy9NFSCn
         iyawE9wL+yd0x6T6E3QGAnUuvBEplMPlQulSWC9k=
Date:   Fri, 1 Feb 2019 22:31:53 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>
Subject: Re: [PATCH v2 0/9] kprobes: Fix and improve blacklist symbols
Message-Id: <20190201223153.0ccdf06378ac953eb2651ea9@kernel.org>
In-Reply-To: <20190114111810.79016d7d@gandalf.local.home>
References: <154725993986.18060.2759150647140353514.stgit@devbox>
        <20190114111810.79016d7d@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

Can I ask you to pick this series and Andrea's patch?
Or would I better update this series on the latest tip/master?

Thank you,

On Mon, 14 Jan 2019 11:18:10 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 12 Jan 2019 11:25:40 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Hi,
> > 
> > Here is the v2 series of kprobes blacklist bugfix and improvements mainly
> > on x86 (since I started testing on qemu-x86).
> > 
> > >From v1, I just removed stable-ml from Cc (but tagged [1/9]) and added  
> > Steve's Ack.
> 
> Ingo, I acted the ftrace change and also gave a review by to the added
> function in kprobes.c.
> 
> Since this changes x86, could you take it in your tree?
> 
> Thanks!
> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
