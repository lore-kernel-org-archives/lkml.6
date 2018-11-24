Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4C3C04EBB
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 18:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56A52086B
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 18:46:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B56A52086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbeKYFfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 00:35:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:40786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbeKYFfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 00:35:38 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F7ED20868;
        Sat, 24 Nov 2018 18:46:36 +0000 (UTC)
Date:   Sat, 24 Nov 2018 13:46:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        linux-parisc@vger.kernel.org, stable@kernel.org,
        stable@vger.kernel.org
Subject: Re: [for-next][PATCH 08/18] parisc: function_graph: Simplify with
 function_graph_entry()
Message-ID: <20181124134634.306192c2@gandalf.local.home>
In-Reply-To: <20181123200011.GM1917@sasha-vm>
References: <20181122003332.500796758@goodmis.org>
        <20181123073033.2083020863@mail.kernel.org>
        <511cb47a-a1bd-bb5d-69ec-0836c6b5abfe@gmx.de>
        <20181123121253.278146b4@vmware.local.home>
        <20181123183415.GB1917@sasha-vm>
        <20181123142617.3d3972ca@vmware.local.home>
        <20181123200011.GM1917@sasha-vm>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2018 15:00:11 -0500
Sasha Levin <sashal@kernel.org> wrote:

> On Fri, Nov 23, 2018 at 02:26:17PM -0500, Steven Rostedt wrote:
> >On Fri, 23 Nov 2018 13:34:15 -0500
> >Sasha Levin <sashal@kernel.org> wrote:
> >  
> >> Does this mean that someone (Steve) will send a backport of this to all
> >> relevant stable trees? Right now it looks like the series will randomly
> >> apply on a mix of trees, which can't be good.  
> >
> >Nope. I stated that in my 0 patch.  
> 
> That's not good though, if you don't intend for them to be automagically
> backported to stable trees by Greg, then they shouldn't be tagged at all
> and if someone is interested then he can provide a backport.

For the most part they will be fine going back a few releases. But how
far back is questionable before they start getting into issues. I
talked a bit about this to Greg on IRC and he seemed fine with me
adding the stable tag.

If they don't port back properly, it wont be a silent failure. They
will either build or they wont. I'm suspect that you build all
supported archs for your stable trees, right? If the patch fails to
build, then either have someone that cares for that arch back port it,
or don't back port the series. Simple as that.

> 
> What will happen with these is that once Greg's scripts process Linus's
> tree he'll end up with this patch series inconsistently backported to
> stable trees, which is not what you want here.

It's not like it won't work and then start to work again. Once they
start failing in older versions, they will probably fail in all
versions before that.

> 
> Sure, we can wait for the "added to the xyz stable tree" mails and
> object then, but why risk breaking the trees?

Again, it's not much different than other stable patches that need to
be fixed for older trees. If they build, they are fine, if they don't
then they need to be fixed. You'll know right at build time.

-- Steve
