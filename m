Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28F6C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E302083F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QVdM3grO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E302083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbeJECXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 22:23:50 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55786 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbeJECXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 22:23:49 -0400
Received: by mail-it1-f195.google.com with SMTP id c23-v6so14739250itd.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 12:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CCcZYfDvlKJH0iwp/L16NO1pvu6B+S++sEI+/tdUtGI=;
        b=QVdM3grOHmbX55aIkE6n952P5dWvOL4Ym9frOarLs6FkQNJmNMpkYDPM5phrde6zRy
         PT0bxoKs64F/oPd2jhhL8hEbxh75JblgY2ftfhD65SUrDWvh3uT30NxRHIvuIaElX4Rk
         azYIEh1t5Znl87TEeoIFB0aDLPsGO8aOeFc0z1SBdY0eoTwvgVsoQZ0qxYRo9zp0IIFu
         xC1LxyKxbmvXJJ1aM5hEGKXlUKg1HaTZo3nnGLFZCnXqZKPiSXRQIzxlJuu6kUEebhKL
         6bS5E+ltIwWbGnmZ48HwuiEs3igj5vscAVDC7ft2kCvRQQ5K7g71pPDlu9AhX7rAxCX9
         ckug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CCcZYfDvlKJH0iwp/L16NO1pvu6B+S++sEI+/tdUtGI=;
        b=cwAXdOm695uSaad4J2lRjCx/ruUbYj97f4UeJ29qEcZaAoxffYAWyeNR+1RirubFtX
         bLQuYmUIiy8eBWCWCS8+q9Hqq33j+coG5o8kQFBv5+OPnM4qxeANDdfQiPHUOB8/7Ckw
         gjs2rqY82TDscoUBm70G2duGqj+MulP8v4DDjWD//AnmW6I/BI6jgx9YTW5JQVHZXOfr
         WS8EqoYerBNgk2jPq/Gu2WD7FIJYP+1CM36waYJ389LMp5iVb626stP1TTNq9mwuKkaQ
         32s6Z6Bpt7WRCTuphaMb2CU7MQ1LQOYpWEp8psPlbc6pf5JQnTPc9vm/MqRznZK++7eb
         2QQQ==
X-Gm-Message-State: ABuFfoiI7Zz6ZuC7AAXAHs4S30BY+YXExMxXyoQdhfIiV/pQomQxgkLU
        m3pEs/TM1itpVP1KnWFnpZDlE1SyZJKHVYTSThtwDlXsqrQ=
X-Google-Smtp-Source: ACcGV60JOQNlG+7d2aziGgScOw/cPudgy5vhvgRcDvCZCnEVrfBneEGEAyHvR+H54ckMU9ml3Sw4cYLoNX01hRmdDgs=
X-Received: by 2002:a24:85c6:: with SMTP id r189-v6mr6943185itd.83.1538681348272;
 Thu, 04 Oct 2018 12:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <20181004154749.111595-1-edumazet@google.com> <20181004185949.GA233675@dtor-ws>
In-Reply-To: <20181004185949.GA233675@dtor-ws>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 4 Oct 2018 12:28:56 -0700
Message-ID: <CANn89iJMhGEkw13KrGbqrvGbznb45QZwdr7eLy_rUV6zitvs=Q@mail.gmail.com>
Subject: Re: [PATCH] Input: mousedev - add a schedule point in mousedev_write()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        linux-input@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 11:59 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Eric,
>
> On Thu, Oct 04, 2018 at 08:47:49AM -0700, Eric Dumazet wrote:
> > syzbot was able to trigger rcu stalls by calling write()
> > with large number of bytes.
> >
> > Add a cond_resched() in the loop to avoid this.
>
> I think this simply masks a deeper issue. The code fetches characters
> from userspace in a loop, takes a lock, quickly places response in an
> output buffer, and releases interrupt. I do not see why this should
> cause stalls as we do not hold spinlock/interrupts off for extended
> period of time.
>
> Adding Paul so he can straighten me out...
>

Well...

write(fd, buffer, 0x7FFF0000);

Takes between 20 seconds and 2 minutes depending on CONFIG options ....

So either apply my patch, or add a limit on the max count, and
possibly break legitimate user space ?

I dunno...

> >
> > Link: https://lkml.org/lkml/2018/8/23/1106
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Reported-by: syzbot+9436b02171ac0894d33e@syzkaller.appspotmail.com
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: linux-input@vger.kernel.org
> > ---
> >  drivers/input/mousedev.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
> > index e08228061bcdd2f97aaadece31d6c83eb7539ae5..412fa71245afe26a7a8ad75705566f83633ba347 100644
> > --- a/drivers/input/mousedev.c
> > +++ b/drivers/input/mousedev.c
> > @@ -707,6 +707,7 @@ static ssize_t mousedev_write(struct file *file, const char __user *buffer,
> >               mousedev_generate_response(client, c);
> >
> >               spin_unlock_irq(&client->packet_lock);
> > +             cond_resched();
> >       }
> >
> >       kill_fasync(&client->fasync, SIGIO, POLL_IN);
> > --
> > 2.19.0.605.g01d371f741-goog
> >
>
> Thanks.
>
> --
> Dmitry
