Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF34AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752462084D
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQHixH3s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 752462084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbeIADHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:07:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41966 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbeIADHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:07:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id h79-v6so6136807pfk.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 15:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fCkYw97l/S6o/BAIxbPEAvCYN8auUeO0UdbRXRbSSNE=;
        b=fQHixH3sWpWaG8UkQPQN+cMqFpMolNLeNujuKUMZvApJGA/avf7I7ZEVAXh2/n4eJG
         FqlUhYFjN9OcFh9xR/PnoPOFdNp8KUukkoxfmbG4d38Q/prQDt6t0cXChaSZrtoHS9t5
         4XXt060nZXZXrDMkkIT6+Hpb3VKm4Kb01n6PxyEf2xY1At9yylIY6wTNT1qBuNkTXGn3
         jCOgVNCGywERu2BRVPrKk+rDUW/199HX20+s8ZrQygyMntHhxY3N/xGhOoBH2rUdJKhr
         ztzfMq2mBauyiiyDK/RXCWpi6P29ahCPUKN07F6iSlX96TuR5FqYkyr6keiyGy91wLs6
         Y0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fCkYw97l/S6o/BAIxbPEAvCYN8auUeO0UdbRXRbSSNE=;
        b=XWhRO8KNPqAUjNWSF5R7nrup9IMrzCeQpbEmln9VtWu+nEQMYB+8Nift7Ie6Pf+SLZ
         FAjZHn9Xsa22r2u6s0to6vb2bpw1f1k/ma/SpISB1FKXEaCiQ9aLHaGa/0KsJk0k6PfZ
         elFJ+Rg1KOvz8K7Aw2gbMUAGXaBwHFznNEoR/GbRnlHazKJ5QFqZxiUfSD7g+hf6Lo8o
         btcwhyg52iDPja28hSk5tWD+rsnL/vE8tSCNdgzU0CF7YdCVl1SYizQhkOHk5RMnQdkG
         p+x6dxgHc+2s67YbNUVu6/zwgce6Uj8V0CpLreFA0ODUuG1+VRzbBy25ysYqnRTF2948
         3gyw==
X-Gm-Message-State: APzg51C/qGiGS1VarE5K691Gu/uLVVCyBbgJvbF9gOl1b3P9Ibzc2v/+
        qwjiKVKJMFfie2dhjSgBazY=
X-Google-Smtp-Source: ANB0VdbDoTgi6tQbyaJv6iY6bqRfDjkHqHTw9dT3GdSkbr/x5AhN0yk+JZJI6P+K7YUsB1PDgZyZeA==
X-Received: by 2002:a63:5c10:: with SMTP id q16-v6mr16133221pgb.452.1535756252457;
        Fri, 31 Aug 2018 15:57:32 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-81-67.tpgi.com.au. [59.102.81.67])
        by smtp.gmail.com with ESMTPSA id e14-v6sm15154288pff.128.2018.08.31.15.57.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 15:57:31 -0700 (PDT)
Date:   Sat, 1 Sep 2018 08:57:25 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Subject: Re: VirtIO console hangs
Message-ID: <20180901085725.4dcd9cac@roar.ozlabs.ibm.com>
In-Reply-To: <CAGnkfhy9okKAfZVkbO3YWPVmWgVm2LFzR-8=S73OfJ3bK_1FxQ@mail.gmail.com>
References: <CAGnkfhzjeYU_jmhNkLEayL1FSq5rWkT7T+Nm1ky9QS-vWHUhyw@mail.gmail.com>
        <20180829003539.668e514c@roar.ozlabs.ibm.com>
        <CAGnkfhxhV_4JNhCm2s=XP15sp3bKax9O1R+nFwA+oRJXQ53xsg@mail.gmail.com>
        <20180831134943.7f516fed@roar.ozlabs.ibm.com>
        <CAGnkfhy9okKAfZVkbO3YWPVmWgVm2LFzR-8=S73OfJ3bK_1FxQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Aug 2018 15:17:44 +0000
Matteo Croce <mcroce@redhat.com> wrote:

> On Fri, Aug 31, 2018 at 3:49 AM Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > On Tue, 28 Aug 2018 15:00:14 +0000
> > Matteo Croce <mcroce@redhat.com> wrote:
> >  
> > > On Tue, Aug 28, 2018 at 2:35 PM Nicholas Piggin <npiggin@gmail.com> wrote:  
> > > >
> > > > On Tue, 28 Aug 2018 12:54:08 +0000
> > > > Matteo Croce <mcroce@redhat.com> wrote:
> > > >  
> > > > > With kernel 4.19.0-rc1 virtio_console hangs very often.
> > > > > I can always trigger the bug by pasting some characters in the
> > > > > terminal window, the console will stop receiving keypresses, but I can
> > > > > still see output from the console.
> > > > > Stangely, logging in the VM via SSH and sending lot of data to hvc0,
> > > > > like 'dmesg >/dev/hvc0' will fix the issue until the next paste.
> > > > >
> > > > > I did a git bisect and I've found that this is the offending commit,
> > > > > reverting it fixes it.
> > > > >
> > > > > Cheers,
> > > > >
> > > > > commit ec97eaad1383ab2500fcf9a07ade6044fbcc67f5
> > > > > Author: Nicholas Piggin <npiggin@gmail.com>
> > > > > Date:   Tue May 1 00:55:54 2018 +1000
> > > > >
> > > > >     tty: hvc: hvc_poll() break hv read loop  
> > > >
> > > > Thanks for the report. I can't immediately see what the problem
> > > > is. Can you try get a stack trace of where it is stuck?
> > > >  
> > >
> > > I tried but didn't get one.
> > >  
> > > > Perhaps try this patch if you have time (it's a bit of a shot
> > > > in the dark).
> > > >  
> > >
> > > Yes it seems to fix. Thanks!  
> >
> > Okay sorry for the delay, I can reproduce it here and found a better
> > fix, if I could trouble you to test again.
> >
> > [PATCH] tty: hvc: hvc_poll() fix read loop hang
> >  
> 
> Hi Nicholas,
> 
> the patch works, but now pasting text inside the terminal is extremely
> slow, it feels worse than a 9600 baud serial line.
> 
> Btw, I had to apply the patch by hand as it was corrupted, some lines
> were collapsed into one.

Oh, when you revert the above commit, does it fix the speed problem as
well? I realise I'm testing with a remote machine that probably is not
connected with much better than 9600 baud... I will set up a local test.

Thanks,
Nick
