Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0EDC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307A22183F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGqAF4yv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfAGVtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 16:49:24 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41085 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfAGVtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 16:49:24 -0500
Received: by mail-pl1-f195.google.com with SMTP id u6so771537plm.8;
        Mon, 07 Jan 2019 13:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p8QDgmF5hWQbM1FPsPHmky74xeeRc06CUZN469xsWiA=;
        b=SGqAF4yvF01kc3E6aC/4n3E5TW+fFkStsEjxi/K5DrKGzgXrQLY0N/DkGPwRfoV4W+
         gN5PHqNlLPIoQ68HmqMajXsXwJuR0H0O6DcHt4sZtTc/WT7VUlixyWzzU/Hq9WullsR9
         OLo4J7A9uWhGUyHL1NxQNmz7VZou9m1mcP0aTvzDnK8vClCqtmUoO52yQ7jOo/arpShP
         MV5axduRx/PFxpJ/Lc4WUTfYWyH0IHDSYPVF8D9fNZajjE0sEdYX94s/sBeOvNt8lhfi
         RZVkfnrq5rb1LGFSkRVkjPqmEkgyn2ClStXrheoa7O4FeYNcy0EieJ6gBP6E+EvQd6Zz
         a1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p8QDgmF5hWQbM1FPsPHmky74xeeRc06CUZN469xsWiA=;
        b=nvJ1R5G4xaUhX4pyHG/sih4t0nJlpfaCvbN0u8Mt/Nem4MhBS25VmXwDagAOyN6JFD
         x8T2Jm+X/CrOUF9i58Fn05vsmHZ+gx7Cajhr1CSnEUx7ENIED9Az45CjbhrHKDU7DkQo
         grjLX8PQdo4L5Skfyz2II/siLOfmi1MvYr3sSkSOUiBzWy6mKOle0NQ2Ni4+ZYuL1mAl
         11oksR7H8BYykks+ep3xtcUEe7R73aL9Y6jswKRooMUpiCI0QK7oe+Zg9SmxQqk14YTy
         GPWKyxyDk2lARTO4iTyYlVmBvckBCuHHtjLOcuUawir6AUTaeyXLh+oNBMNFWQUYv864
         WC+g==
X-Gm-Message-State: AJcUuke0eM4WYJLUr6TxmYdXmxhVUHadPJNNaPvcV1Dz2KzaC6Bk+BZK
        BPuAvrVUf44mBWxEHtlun8Y=
X-Google-Smtp-Source: ALg8bN5a/ZKpxXYIoZ7ha3dW54bhk5Vgcugr71nSi29cbzO0m9vmL9TyI8mBccomZH9+mmcMb/LhQg==
X-Received: by 2002:a17:902:7896:: with SMTP id q22mr63887096pll.280.1546897763148;
        Mon, 07 Jan 2019 13:49:23 -0800 (PST)
Received: from localhost (g206.124-44-15.ppp.wakwak.ne.jp. [124.44.15.206])
        by smtp.gmail.com with ESMTPSA id x12sm88232620pgr.55.2019.01.07.13.49.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 13:49:22 -0800 (PST)
Date:   Tue, 8 Jan 2019 06:49:19 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Matt Turner <mattst88@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Paul Burton <paul.burton@mips.com>,
        Greentime Hu <green.hu@gmail.com>,
        Ley Foon Tan <lftan@altera.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make 'user_access_begin()' do 'access_ok()'
Message-ID: <20190107214919.GO3235@lianli.shorne-pla.net>
References: <20190106180927.GA11993@roeck-us.net>
 <CAHk-=whyNbpBtPyoS=wh4nVgBtUBpihcOT+LFdEw369kYjATaQ@mail.gmail.com>
 <CAHk-=wiSVm6j1Ga8gra6hSQQSK8WF5bW4DtRi4V7mCtCUkTaQw@mail.gmail.com>
 <78e3717b-0604-3d5f-38b8-c523e392fc76@roeck-us.net>
 <CAHk-=wg45nXe50ORC7reBJqsFGUPELtbk5p7ijkE9=fs1wGLAQ@mail.gmail.com>
 <CAHk-=wgnLcrL8PbS0Dz3nprCXvR5iFCKjVvJmN_EbZW88i4L7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgnLcrL8PbS0Dz3nprCXvR5iFCKjVvJmN_EbZW88i4L7w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 10:05:12AM -0800, Linus Torvalds wrote:
> Gaah. Re-sending this for the kernel mailing list just for posterity.
> I keep replying to emails that had the mailing list address wrong, and
> then my reply will have it wrong too.
> 
> I will learn to fix up the address just in time for this thread to die
> out, I suspect.
> 
>                 Linus
> 
> On Mon, Jan 7, 2019 at 10:02 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Sun, Jan 6, 2019 at 8:05 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > Of the above, my test system boots images for the following architectures
> > > in qemu.
> > >
> > > - mips (32/64 bit, big/little endian)
> > > - nios2
> > > - openrisc
> > > - xtensa (mmu and nommu)
> >
> > So most of those are "only" the "macro arguments used twice" problem
> > (although openrisc also does the "arguments not quoted right"). That
> > doesn't cause problems with the new commit, it's an independent issue
> > that could cause random problems elsewhere

Linus,  Thanks for pointing this out and Guenter thanks for testing.

I ack the issue on OpenRISC and will send a patch for review in a day or so.
I'll also do an audit of openrisc to see if we have similar issues.

Next to access_ok() is __addr_ok() which seems to have the similar quoting
issue, but I don't see it being used anywhere, it's also defined and not
used on: arm, x86 and csky.   It is used on SH.

OK to remove __addr_ok()?

-Stafford
