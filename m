Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9423ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E86D2088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E86D2088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbeIRDF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 23:05:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728644AbeIRDF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 23:05:26 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D14F820867;
        Mon, 17 Sep 2018 21:36:16 +0000 (UTC)
Date:   Mon, 17 Sep 2018 17:36:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vaibhav Nagarnaik <vnagarnaik@google.com>
Cc:     linux-kernel@vger.kernel.org, Jason Behmer <jbehmer@google.com>
Subject: Re: [PATCH] ring-buffer: Allow for rescheduling when removing pages
Message-ID: <20180917173615.7001c80c@gandalf.local.home>
In-Reply-To: <CAL26m8L7f5iw_eNqbB2OVJX4vYebHcjiBJCQxyd_L4WjNFMb7A@mail.gmail.com>
References: <20180907182131.144514-1-vnagarnaik@google.com>
        <20180907223129.71994-1-vnagarnaik@google.com>
        <CAL26m8+C3tPJLy38i4LajM1_9B+x_AOOvUTot-VUkpHTZfFKmA@mail.gmail.com>
        <20180917170055.1f1d161f@gandalf.local.home>
        <CAL26m8L7f5iw_eNqbB2OVJX4vYebHcjiBJCQxyd_L4WjNFMb7A@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Sep 2018 14:02:59 -0700
Vaibhav Nagarnaik <vnagarnaik@google.com> wrote:

> On Mon, Sep 17, 2018 at 2:01 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Mon, 17 Sep 2018 13:53:05 -0700
> > Vaibhav Nagarnaik <vnagarnaik@google.com> wrote:
> >  
> > > Hi Steven,
> > >
> > > Does the patch look good? Can this be picked up in the next rc?
> > >  
> >
> > Yes it's fine. I can pick it up. Does it need to be marked for stable?  
> 
> Thanks.
> 
> It'd be great to be marked for stable, since older kernels are also
> affected. But I can't judge if it crosses the threshold as a bug fix.
> 

When backporting to stable I use two (admittedly subjective) metrics.
One is the severity of the bug (this is low), the other is the risk of
adding it (this is even lower). If the severity divided by the risk is
high enough, I tag it for stable. Because the risk is so low, I have no
problems with tagging it.

Note, it will run through lots of tests before it gets out the door.

-- Steve
