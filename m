Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D990DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 06:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A362086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 06:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1pyr4O4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfBUGZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 01:25:56 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44563 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbfBUGZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 01:25:55 -0500
Received: by mail-qk1-f195.google.com with SMTP id r21so3612230qkl.11;
        Wed, 20 Feb 2019 22:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=7xMYSM2aOe6bSPqc/45ReqpRuLE1CcWNfUMtbsqiRfY=;
        b=K1pyr4O4Lurjy/nxlGbpfORCbQCH2xI+AEVdpUDlGKerJ9NatgLXamL5mrdXXOCmEe
         K1fWwyLYrAKuKNzA6BZWDttGBhRcCt93Mnn+4JRBVtsnYNFjflfEvQQM3J3fgoZnfTYZ
         VQbI8MuzTiE+R2su8ZBrcpMaVt3xGOymw6y1unrQGqrRMboOZMyUB5rg2VqpLUGyehVR
         ZOEZNilC2vWe0d7mBWLu7jfxYFt/PbGHWEWi7FnOwVs4IevYt9R/297Wo/99nRA4FbTq
         U0FlwhHTNabtaXTM6q2Nhqk7uno+7i3w6Vtz+ta5twvm3iUj4apw3qbx1TKQgdGeJvSx
         aXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=7xMYSM2aOe6bSPqc/45ReqpRuLE1CcWNfUMtbsqiRfY=;
        b=f7H41J6xtYm6xilsBMvZ5t+W4CK7kypYeNx+SGcaQkhpPegPAQ7zuwKTMD4QImCM1b
         4aAyOMSUCxOOIQm0jltad/Xg27T1/y61BdfFZEFTFHz4X26RVVrAgjGa8RuooqOvCRJe
         iSVu1ZJdM/QFTIYqClOSVB7M86vTuHqB8PBfT8eRhaFOTfChHFy+1GsuW8eOyAPm8z3+
         cL7h0x4pq5ABDnyJfWrM4kS6x0UJa5jzxYVWTVePxkLYnPuO6n2o6zFBOUpeVJ1t0GI5
         Wud5q5h2qMWmUwQfIiwk6f/HJ4VuA3b/ayscV3TV7waaH9CyCObeHc2poCkb8QP6broT
         7u3g==
X-Gm-Message-State: AHQUAuaGhKmZq+mxAB3XN+aHhJOsTONv4C6OXxfy6chL8d+oL+r3qTyQ
        XDY6Q6EELh7VwAX3lmHyogvfK9YTehkIlnMxDKw=
X-Google-Smtp-Source: AHgI3IY11kIeB14F6g5Zkj2WULhJ5vYGwicmpr+RKgnJBe8c4QR8dXQy9byUNNZQL5W+TOE7tVew5TeNFSIlvPUyE7E=
X-Received: by 2002:a37:4707:: with SMTP id u7mr27283384qka.296.1550730354152;
 Wed, 20 Feb 2019 22:25:54 -0800 (PST)
MIME-Version: 1.0
References: <e7b709a2b040af7faa81b0aa2c3a125aed628a82.1525964383.git.joe@perches.com>
 <tip-1de392f5d5e803663abbd8ed084233f154152bcd@git.kernel.org>
 <20180517182659.GB27807@pd.tnic> <a341a36ed75712b6c624a14aa694843ee1ef948e.camel@perches.com>
In-Reply-To: <a341a36ed75712b6c624a14aa694843ee1ef948e.camel@perches.com>
Reply-To: bjorn@helgaas.com
From:   Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date:   Wed, 20 Feb 2019 22:25:42 -0800
Message-ID: <CABhMZUWmJpux98nN65UBkY4LvjUO5P4Y60ytAe+ze70gQUVf1A@mail.gmail.com>
Subject: Re: [tip:x86/cleanups] x86: Remove pr_fmt duplicate logging prefixes
To:     Joe Perches <joe@perches.com>
Cc:     Borislav Petkov <bp@alien8.de>, mingo@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 11:45 AM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2018-05-17 at 20:27 +0200, Borislav Petkov wrote:
> > On Sun, May 13, 2018 at 12:27:45PM -0700, tip-bot for Joe Perches wrote:
> > > Commit-ID:  1de392f5d5e803663abbd8ed084233f154152bcd
> > > Gitweb:     https://git.kernel.org/tip/1de392f5d5e803663abbd8ed084233f154152bcd
> > > Author:     Joe Perches <joe@perches.com>
> > > AuthorDate: Thu, 10 May 2018 08:45:30 -0700
> > > Committer:  Thomas Gleixner <tglx@linutronix.de>
> > > CommitDate: Sun, 13 May 2018 21:25:18 +0200
> > >
> > > x86: Remove pr_fmt duplicate logging prefixes
> > >
> > > Converting pr_fmt from a default simple #define to use KBUILD_MODNAME
> > > added some duplicate prefixes.
> > >
> > > Remove the duplicate prefixes.
> []
> > Maybe I'm missing something but this dropped the prefixes now
> > completely:
> >
> > -e820: BIOS-provided physical RAM map:
> > +BIOS-provided physical RAM map:
> >
> > -e820: last_pfn = 0x43f000 max_arch_pfn = 0x400000000
> > +last_pfn = 0x43f000 max_arch_pfn = 0x400000000
> >
> > -e820: last_pfn = 0x9d000 max_arch_pfn = 0x400000000
> > +last_pfn = 0x9d000 max_arch_pfn = 0x400000000
> >
> > ...
> >
> > I don't think that was the intention.
>
> Hi Borislav
>
> It wasn't and isn't the intention.
>
> This is a patch _series_, and all of the patches
> from 4-18 depend on patch 3 which converts the
> generic define in include/linux/printk.h
>
> from
>         #define pr_fmt(fmt) fmt
> to
>         #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> Perhaps a better option, which could be done in
> a v2 of the series, is to add a temporary
> #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> to each file modified in patches 4-18 and then
> allow the follow-on script described in the 0/18
> cover letter to remove those #defines

Was there ever a v2?  What I see from 1de392f5d5e8 ("x86: Remove
pr_fmt duplicate logging prefixes") is exactly what Borislav noted.

For example, https://bugzilla.kernel.org/attachment.cgi?id=281007 is a
v4.20 dmesg log from
https://bugzilla.kernel.org/show_bug.cgi?id=202511 .  That bug also
has a v4.17 dmesg log
(https://bugzilla.kernel.org/attachment.cgi?id=281011).  Comparing
them shows:

-Linux version 4.17.19-gentoo (root@survivor) (gcc version 7.3.0
(Gentoo 7.3.0-r3 p1.4)) #2 SMP Sat Sep 22 09:53:01 EDT 2018
+Linux version 4.20.6-gentoo (root@survivor) (gcc version 7.3.0
(Gentoo 7.3.0-r3 p1.4)) #1 SMP Tue Feb 5 09:46:51 EST 2019
...
-e820: BIOS-provided physical RAM map:
+BIOS-provided physical RAM map:

Not a big deal as far as I'm concerned, but it is a minor annoyance.

Bjorn
