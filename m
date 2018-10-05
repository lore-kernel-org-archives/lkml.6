Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07590C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD1D2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="i90xZV4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD1D2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbeJEPvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:51:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728433AbeJEPvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:51:46 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45A7A2084D;
        Fri,  5 Oct 2018 08:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538729640;
        bh=Iu4+To0W3Zy6RJEVMrnKbEFfgJnCFaLVvtcngwc6Nts=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i90xZV4fmG1Kskn49amQXBNgcwM9LbWoT0pETN6IcEPhbNyKM4ij6zLeYiVpsIBIN
         Fy9+SWXfFiUrO1asScJexk9pC6mUv8sfck5AwO26WJ0TQ30EoE4/2XT/4OIvbsYT5c
         nwsh9XofpVJI6y+xX7tHk+LXJNwnmiHa840Np2xE=
Date:   Fri, 5 Oct 2018 17:53:56 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [ftrace/kprobes PATCH 3/3] tracing/kprobes: Allow kprobe-events
 to record module symbol
Message-Id: <20181005175356.cae90780f7c2fec361e406b7@kernel.org>
In-Reply-To: <20181003211128.58c7a15e@vmware.local.home>
References: <153547303754.26502.5265242979168613920.stgit@devbox>
        <153547312336.26502.11432902826345374463.stgit@devbox>
        <20181003151227.4a730dcb@gandalf.local.home>
        <20181003211128.58c7a15e@vmware.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Oct 2018 21:11:28 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 3 Oct 2018 15:12:27 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Wed, 29 Aug 2018 01:18:43 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> > > Allow kprobe-events to record module symbols.
> > > 
> > > Since data symbols in a non-loaded module doesn't exist, it fails to
> > > define such symbol as an argument of kprobe-event. But if the kprobe
> > > event is defined on that module, we can defer to resolve the symbol
> > > address.
> > > 
> > > Note that if given symbol is not found, the event is kept unavailable.
> > > User can enable it but the event is not recorded.
> > > 
> > >  
> > 
> > Hi Masami,
> > 
> > The first two patches look like they should be applied now and marked
> > for stable, as they are fixes. This patch looks like an added feature,
> > and will go into the next merge window.
> > 
> > Is that what you think too?
> >
> 
> Heh, I just realized that this is on my kprobes branch. I was looking
> at it as if they were in mainline. Nevermind about the "stable"
> comment ;-) 

Yes, ;) so I added [ftrace/kprobes] on the subject.

Anyway, these patches must be on top of that branch.

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
