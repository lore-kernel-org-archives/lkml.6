Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC86AC4161D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2252085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B2252085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbeJKVIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 17:08:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727056AbeJKVIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 17:08:16 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2347E20652;
        Thu, 11 Oct 2018 13:41:00 +0000 (UTC)
Date:   Thu, 11 Oct 2018 09:40:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Dhaval Giani <dhaval.giani@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alice Ferrazzi <alice.ferrazzi@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Tim Bird <tbird20d@gmail.com>,
        Laura Abbott <labbott@redhat.com>,
        gustavo.padovan@collabora.co.uk,
        "Carpenter,Dan" <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, knut.omang@oracle.com,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [Announce] LPC 2018: Testing and Fuzzing Microconference
Message-ID: <20181011094057.1016cc1b@gandalf.local.home>
In-Reply-To: <CACT4Y+a6stTxMritOizwvcbkQAJoGF3MbBmBFu-8x3o13Vxc5g@mail.gmail.com>
References: <CAPhKKr_XFzGcBBuQ51w7HjZd_Kq3nTOB6uAFG2vP5JH+Vx_eng@mail.gmail.com>
        <CACT4Y+Y+6arxj4=72DZSj45u5kjKRksJZ7c6pBLeFDxUSBFwOg@mail.gmail.com>
        <20181008142300.3aacaabe@gandalf.local.home>
        <CAPhKKr8QvK3bkT6gQB9jc31Cx+gLmZwRnKuRUD_1xaidwL14Dg@mail.gmail.com>
        <CACT4Y+aiSXsyFqXueRGXeVeY6KAJ4M2Oy6RZWFnNS_d9Z9pAnw@mail.gmail.com>
        <CACT4Y+a6stTxMritOizwvcbkQAJoGF3MbBmBFu-8x3o13Vxc5g@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2018 11:41:47 +0200
Dmitry Vyukov <dvyukov@google.com> wrote:

> >
> > Hi Steven, Dhaval,
> >
> > Acknowledged.
> >
> > Then smaller topic that would benefit from discussion are:
> >
> > the main one being:
> >
> > 1. syzbot: developer process; unfixed bugs; bug triage; what's
> > working? what's not? why? how can we make more parts work? collecting
> > feedback  
> 
> +Paul as Plumbers committee representative
> And +Greg is already here as Kernel Summit representative
> 
> Re syzbot talk (around process and feedback).
> I've submitted this as proposal to Plumbers, it did not make it to
> main track but it's in backlog (I am a reserve speaker).
> Sergey suggested to submit this as proposal for Kernel Summit TECH
> TOPIC. It would probably benefit from more kernel maintainers in the
> room.
> 
> Now I am somewhat troubled, if I submit the talk for Kernel Summit and
> then suddenly I materialize as speaker on Plumbers too. It's not a
> good idea to do the same talk twice, right?

Why not, it's been done before :-)

> The questions are:
> 1. Is it a good fit for Kernel Summit TECH TOPIC?
> 2. What should I do if I suddenly accepted to both Summit and
> Plumbers? I probably could prepare a second, different talk for
> Plumbers then (it wasn't announced yet).
> 3. If the talk is accepted to Summit, what should we do with Testing
> MC part? Withdraw?

If this is a discussion topic, and you get accepted as a plumbers talk,
here's what I would do:

1. Have a talk (full presentation) ready to give at the plumbers track.
The Refereed Track is presentation style. Here you will be able to
explain in details what the issues are, and explain your own ideas.

2. For the plumbers MC, have something ready to give a quick overview
of what the issues are and what you think needs to get done. This is a
good way to get feed back from people, and use the time for discussions.

3. If you also get a Kernel Summit track accepted, I find that this is
somewhat in between a full presentation and a full discussion base of a
MC. Here, I would focus on details focusing on the kernel, and what you
would like to discuss with kernel developers specifically (note, I'm
sure the plumbers MC room will also be filled with kernel developers).

In other words, you can have three talks about the same topic, but all
addressing different aspects of that topic in different ways. That's
perfectly fine to do (I did this in Prague, I had 3 talks about printk!)

-- Steve


> 
> 
> > 2. how to increase test coverage/find more bugs, in particular:
> >  - adding manual spot KASAN/KMSAN checks into kernel codebase
> >  - stubbing hardware/external inputs to kernel for testing
> >  - description of kernel interfaces (again)
> >
> > 3. dealing with kernel console output mess
> >  - intermixed/split lines
> >  - understand when/how kernel crashed
> >  - and where is that message
> >  - crash identity  

