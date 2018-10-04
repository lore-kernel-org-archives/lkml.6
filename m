Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD127C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B4B320877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B4B320877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbeJDU2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:28:09 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44066 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbeJDU2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:28:09 -0400
Received: by mail-qt1-f193.google.com with SMTP id c56-v6so9814768qtd.11;
        Thu, 04 Oct 2018 06:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LxtndgWwJ3jOqz+8lR7DIcBExQhEd0Gsz7AWaJkxc3E=;
        b=pGbIMyvqMbzPKrdzBeF+GnofDHWKq+YOs2DPD6SKX0Frkg91kUAhYd3469ucklUeuX
         VHfglLf1rYDwuu0mQE67bVoxs+whEqC7/Af2B8V8mP9+QBfOZzV4C7P9pqr0FfUtsFT2
         ONoCPMAvXjsvonvHEG5i9LFbkOzLtG1pn3mJhB3qf786CVv02FDw6lu98xDM0xsH5fDx
         aI/U3iCbzNa1+Wlq2ctRaqYqZH+3/oS9X4C/YdyFMt5mPWToWyn2OA+ozd2Zj8yPjAS8
         o75fPz+I1fWVMnjAyQZBVAlivgcm8+gbVg3VgL0oG6SiA4VegsqpuWmW++gNOib89PU9
         vqmA==
X-Gm-Message-State: ABuFfoh7cGQEBtL7qoJwyGlIefujdNHCI7D4QxZg72OSLaEh9Wel/sOm
        5ZoL0skeKdZdv4E224QsqzdKWjWzlBOOJeT5PXA=
X-Google-Smtp-Source: ACcGV62HJAp3QYWeloa6ANx0Oto4qDQDxrnREANovY2Wo+LfY9bnbX9fddI7IpCUnp8f7cPHxyCNTDDhjQ388QwPuVE=
X-Received: by 2002:a0c:ad8e:: with SMTP id w14-v6mr5249015qvc.149.1538660088085;
 Thu, 04 Oct 2018 06:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <20181002210213.GA17826@ls3530.fritz.box> <20181002211645.GA6454@kroah.com>
 <ad45f249-e064-d5a4-c658-eaa03bb3a04a@gmx.de> <20181002222452.GB11788@kroah.com>
 <dbfa0162-8ed1-b16e-a418-da3b92c76230@gmx.de> <20181003181612.GB28575@kroah.com>
 <CAK8P3a2ntPX4+LbYWJbDG1k-8NwkhyY0nYk-mfZU2FBF_h23Yw@mail.gmail.com>
 <20181003230226.GB27729@kroah.com> <ed8a12d5-604f-c938-f65d-051e05561dc6@gmx.de>
In-Reply-To: <ed8a12d5-604f-c938-f65d-051e05561dc6@gmx.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 4 Oct 2018 15:34:31 +0200
Message-ID: <CAK8P3a3HCBY8+xK_o50aswFsrb1EVCFATV4zwqfNqHUDqtDa_w@mail.gmail.com>
Subject: Re: [GIT PULL] parisc fixes for kernel v4.19
To:     Helge Deller <deller@gmx.de>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        James.Bottomley@hansenpartnership.com,
        John David Anglin <dave.anglin@bell.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 10:42 AM Helge Deller <deller@gmx.de> wrote:
> On 04.10.2018 01:02, gregkh wrote:
> > On Wed, Oct 03, 2018 at 09:49:08PM +0200, Arnd Bergmann wrote:
> >> On Wed, Oct 3, 2018 at 8:16 PM Greg Kroah-Hartman
> >> <gregkh@linuxfoundation.org> wrote:
> >>> On Wed, Oct 03, 2018 at 04:47:30PM +0200, Helge Deller wrote:
> >>>> On 03.10.2018 00:24, Greg Kroah-Hartman wrote:
> >>>>> On Tue, Oct 02, 2018 at 11:46:11PM +0200, Helge Deller wrote:
> >> Or to put it another way: If the argument is
> >> that there won't ever be a 64-bit user space for parisc
>
> FYI, I was planning to try a 64-bit user space at some point.
> Just see my recent patches and mails, e.g.
> b6fc0cccb6b35815a7d1cfc9279cdbfc2c61d00d
> 5b00ca0b8035e49ef7c466e959c5cb457a654351
> and
> https://www.spinics.net/lists/linux-parisc/msg09070.html
>
> >> and we don't care about it,
>
> I (and a few others) do care about it.
>
> >> then we'd be better of removing all native 64-bit
> >> syscalls from arch/parisc/kernel/syscall_table.S.
> >
> > Ok, then let's treat this like any other arch/driver/subsystem that we
> > remove.  Drop the file(s) in a -rc1 merge window and then if anyone
> > object to it later on because they really were using it, you can easily
> > revert that change.
>
> As a maintainer of this port, I object to this.
> You suggest to remove a working, functional and maintained interface for no good use.
> Removing it won't save lots of bytes in the executable (or source code)
> but will make my life as maintainer harder.

Makes sense. I was basing my thoughts on the observation that
nobody did this in the last 18 years that he port has been around,
but if you still plan to do this, then we should not regress.

What is your current estimate for how many more patches
are required to get it working reasonably well? Did you plan
to have commit 5b00ca0b8035 ("parisc: Restore possibility
to execute 64-bit applications") backported to stable kernels,
or just get it working in future versions?
I suppose we either want to backport that patch and mine,
or neither of them.

         Arnd
