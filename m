Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A90C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B502082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnMARkSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B502082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbeJBVd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:33:26 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:35675 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbeJBVdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:33:25 -0400
Received: by mail-yw1-f68.google.com with SMTP id y76-v6so853058ywd.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 07:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HWvAH8hkjtkAuohQgK1B9p5lEx209J/nEFP5Wps4HGo=;
        b=jnMARkSmW5Jq8DtqgwtNs5Vfz5jOzrmnd7gCSmlioGy1xv73VBO1N+7ytQqhFWviu3
         /0s5mpq7gehr2OasARhKNO8IMJr9Sk4GqXkQ6gahCJyWX/vKW1C8ixGInci3xC/WFDsJ
         ZY6th2soLsYl7ERTGxLHb/gJ2vWapAFywaIIuUSEn2C67kCyR2A8DGrPZgYk41By6CFQ
         9Ezr3ZL17tibVJB6EzQ/yDzVdOGtSAtgrUSZVdJEg/IhHuGpY/rGgIVA7bdy0dGTXJjx
         fkEuxv7MDWZeGy9aak/zfHkp4h7U3rJMeXn3Kz4GG9Ps6OpCqZe+tV76BW2kdQTIKure
         CqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HWvAH8hkjtkAuohQgK1B9p5lEx209J/nEFP5Wps4HGo=;
        b=ShHcghc8jd47XPe5c0s23t+GdvFkUMrucDE+BnBSe4K4PJxrr5nhI8pWLcdWfXt3z7
         a2Z2ikLIGoxaVZS/2xLHOkCQDNYFSyNlH6EtR3ONR6GnGzX8xK2tu3cbFfr4vt9fzhYc
         H6/pgZQ3bq9rDBgHXO9IFj0nMWjsx6EIKURcO1kHbhVZWUMTU9gseDieYzHTZsD1+AYW
         PMwPOZ6W8DJqyvK0yRoj+WQkIAGu7llA0DJ3lOdIyO4w2J1mkQI6FbDBdrQcgTbsQdrZ
         DU5JQjgHdeWkWaFZSQQ0pt3MDZPdMKciAK919PfcJxAX9pKNtWwkUlfjoL4UaYSOc36m
         9DFw==
X-Gm-Message-State: ABuFfojl8gHLaEavaaczVuK6DYapNIKJ9LaC7wPWFKBukfSxQ4TYz41v
        Dww5kuAo0hHEaB6kNhSHqyD3pUaOrJa6yaqpKPJj3w==
X-Google-Smtp-Source: ACcGV63Yw8UTvJLuEotPz+Qr2fa0qCapkWNDtzfoQGMU4BzcVWyS75kjC9AwwdtllP5WEctmho2LeexbGeRiMtlSLgc=
X-Received: by 2002:a81:ae4e:: with SMTP id g14-v6mr8566571ywk.248.1538491778910;
 Tue, 02 Oct 2018 07:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180930065100.GL15893@shao2-debian> <CAOQ4uxiHkufAtt87bMs9n-0sFxJSHsBxDX6jn8v28vkvy=a_qQ@mail.gmail.com>
 <20181001093249.GD3913@quack2.suse.cz> <CAOQ4uxiY=-=F6v4enQkcw4VjhP6gp4E31fdRxM=_ShutbT2QXw@mail.gmail.com>
In-Reply-To: <CAOQ4uxiY=-=F6v4enQkcw4VjhP6gp4E31fdRxM=_ShutbT2QXw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 2 Oct 2018 17:49:27 +0300
Message-ID: <CAOQ4uxij6LuL6t3Y2ezbb=6sk-Q1Rqu6py3beY84jTGOmWH=+Q@mail.gmail.com>
Subject: Re: [LKP] [fsnotify] 60f7ed8c7c: will-it-scale.per_thread_ops -5.9% regression
To:     Jan Kara <jack@suse.cz>
Cc:     rong.a.chen@intel.com, linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 12:52 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Mon, Oct 1, 2018 at 12:32 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Sun 30-09-18 12:00:46, Amir Goldstein wrote:
> [...]
> > > > commit:
> > > >   1e6cb72399 ("fsnotify: add super block object type")
> > > >   60f7ed8c7c ("fsnotify: send path type events to group with super block marks")
> > > >
> > >
> > > I have to admit this looks strange.
> > > All this commit does is dereference mnt->mnt.mnt_sb and then
> > > sb->s_fsnotify_mask/sb->s_fsnotify_marks to find that they are zero.
> > > AFAICT there should be no extra contention added by this commit and it's
> > > hard to believe that parallel unlink workload would suffer from this change.
> >
> > Well, it could be those additional fetches of
> > sb->s_fsnotify_mask/sb->s_fsnotify_marks if they happen to be cache cold.
> > Or it could be just code layout differences (i.e., compiler is not able to
> > optimize resulting code as good or the code layout just happens to align
> > with cache lines in a wrong way or something like that). Anyway, without
> > being able to reproduce this and do detailed comparison of perf profiles I
> > don't think we'll be able to tell.
> >
>

On my test machine, I couldn't measure a difference in results between the
two commits, but it may be because my test machine is not strong enough to
drive the test. It only has 4 cores and so I could only reach ~1/4 of
the workload
reported by 0day robot.

I tested both 16-thread and 4-thread jobs. In both cases the measured difference
between the two commits was less than 0.5% and within the stddev margins.

I will see if I can get my hands on a stronger test machine.

Thanks,
Amir.
