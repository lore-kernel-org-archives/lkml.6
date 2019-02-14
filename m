Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640BDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399162229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439301AbfBNOov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:44:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:33254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732362AbfBNOot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:44:49 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B44B42229F;
        Thu, 14 Feb 2019 14:44:48 +0000 (UTC)
Date:   Thu, 14 Feb 2019 09:44:47 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] kprobe: safely access memory specified by userspace
Message-ID: <20190214094447.0adeea8e@gandalf.local.home>
In-Reply-To: <20190214141043.3j6upjrfmse75sma@mail.google.com>
References: <20190125151051.7381-1-changbin.du@gmail.com>
        <20190213143638.y54hghilbyastlpo@mail.google.com>
        <20190213104143.5c390b28@gandalf.local.home>
        <20190214000522.n7ltwbnjl3kufdsn@mail.google.com>
        <20190214080418.0f12923f@vmware.local.home>
        <20190214141043.3j6upjrfmse75sma@mail.google.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2019 14:10:44 +0000
Changbin Du <changbin.du@gmail.com> wrote:

> > No I didn't have the fix. I was running an older kernel actually. One
> > before commit 9da3f2b74054406f87dff7101a569217ffceb29b was added.
> > There's nothing actually wrong with that code, since kprobes is allowed
> > to poke at anything. But that commit considers the kernel using copy
> > from user to poke kernel address space is a security bug.
> >   
> Glade to know that. And I wonder wether all such cases have been
> disclosed. I noticed the uprobe code also uses some usercopy functions.

Well, uprobe shouldn't be poking at kernel addresses ;-)

-- Steve
