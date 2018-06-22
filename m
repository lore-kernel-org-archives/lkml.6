Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD59C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92CCD23DA3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0YhCqh/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92CCD23DA3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751015AbeFVGHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 02:07:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750779AbeFVGHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 02:07:45 -0400
Received: from devnote (s169.156.222.122.fls.vectant.ne.jp [122.222.156.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60C7B23DA1;
        Fri, 22 Jun 2018 06:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529647665;
        bh=GczzUJzf8qw/ygZyUq4GdyoKIquYQVfXdidfpr+URh8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0YhCqh/dZKeJj6/2H+WZ8Oz2FwOSVJ0EgNx/OIGZLiIl5L40E8/9YxkFSnEm4nmax
         8THQ7b1vfKVersqxdTmIN0/1M5OQV5se7phpq0ZS1RmQs4lh0xWl31MMXaAv5jnLka
         JLElyg28ZTqHS+VxQJUPFLJPIC8Va71aQgALqJoo=
Date:   Fri, 22 Jun 2018 15:07:40 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH -tip v6 26/27] Documentation: kprobes: Add how to change
 the execution path
Message-Id: <20180622150740.bd26241032c972d86e23bf73@kernel.org>
In-Reply-To: <20180621103546.GA9212@gmail.com>
References: <152942424698.15209.15245996287444292393.stgit@devbox>
        <152942500680.15209.12374262914863044775.stgit@devbox>
        <706832c5-dab4-f806-96d6-2cdc37203d9d@infradead.org>
        <20180620172637.35916da482442b6ab139c7dc@kernel.org>
        <20180621103546.GA9212@gmail.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2018 12:35:46 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Tue, 19 Jun 2018 09:31:49 -0700
> > Randy Dunlap <rdunlap@infradead.org> wrote:
> > 
> > > On 06/19/2018 09:16 AM, Masami Hiramatsu wrote:
> > > > Add a section that explaining how to change the execution
> > > > path with kprobes and warnings for some arch.
> > > > 
> > > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > > Cc: Jonathan Corbet <corbet@lwn.net>
> > > > Cc: linux-doc@vger.kernel.org
> > > > ---
> > > >  Documentation/kprobes.txt |   20 ++++++++++++++++++++
> > > >  1 file changed, 20 insertions(+)
> > > > 
> > > > diff --git a/Documentation/kprobes.txt b/Documentation/kprobes.txt
> > > > index 3e9e99ea751b..8a98eed1521b 100644
> > > > --- a/Documentation/kprobes.txt
> > > > +++ b/Documentation/kprobes.txt
> > > > @@ -80,6 +80,26 @@ After the instruction is single-stepped, Kprobes executes the
> > > >  "post_handler," if any, that is associated with the kprobe.
> > > >  Execution then continues with the instruction following the probepoint.
> > > >  
> > > 
> > > Hi,
> > > I have a few small suggestions...
> > 
> > Hi Randy,
> > 
> > Thank you for your suggestions!
> > All of those are good to me. I'll fix it:)
> 
> Could you please send a delta patch on top of your v6 series, with Randy credited, 
> etc?

Ok, Here's the delta patch.


> 
> I've applied your series and will push it out once it passes all testing.

Thanks!


From 103fc58ece99475b855e065bd48d780697b93bbc Mon Sep 17 00:00:00 2001
From: Masami Hiramatsu <mhiramat@kernel.org>
Date: Fri, 22 Jun 2018 15:05:49 +0900
Subject: [PATCH] Documentation/kprobes: Fix typo in Changing Execution Path
 section

Fix typo and clean it up according to the
comment from Randy.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Suggested-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/kprobes.txt | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/kprobes.txt b/Documentation/kprobes.txt
index 13d8efd..10f4499 100644
--- a/Documentation/kprobes.txt
+++ b/Documentation/kprobes.txt
@@ -83,22 +83,22 @@ Execution then continues with the instruction following the probepoint.
 Changing Execution Path
 -----------------------
 
-Since the kprobes can probe into a running kernel code, it can change
-the register set, including instruction pointer. This operation
-requires maximum attention, such as keeping the stack frame, recovering
-execution path etc. Since it is operated on running kernel and need deep
-knowladge of the archtecture and concurrent computing, you can easily
-shot your foot.
+Since kprobes can probe into a running kernel code, it can change the
+register set, including instruction pointer. This operation requires
+maximum care, such as keeping the stack frame, recovering the execution
+path etc. Since it operates on a running kernel and needs deep knowledge
+of computer architecture and concurrent computing, you can easily shoot
+your foot.
 
 If you change the instruction pointer (and set up other related
-registers) in pre_handler, you must return !0 so that the kprobes
-stops single stepping and just returns to given address.
+registers) in pre_handler, you must return !0 so that kprobes stops
+single stepping and just returns to the given address.
 This also means post_handler should not be called anymore.
 
-Note that this operation may be harder on some architectures which
-use TOC (Table of Contents) for function call, since you have to
-setup new TOC for your function in your module, and recover old
-one after back from it.
+Note that this operation may be harder on some architectures which use
+TOC (Table of Contents) for function call, since you have to setup a new
+TOC for your function in your module, and recover the old one after
+returning from it.
 
 Return Probes
 -------------
-- 
2.7.4
