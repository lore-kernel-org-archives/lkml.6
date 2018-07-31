Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2CBC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 23:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D6B20857
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 23:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfpOMOIF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D6B20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732754AbeHAAqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 20:46:02 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40782 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732635AbeHAAqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 20:46:02 -0400
Received: by mail-pg1-f195.google.com with SMTP id x5-v6so9801258pgp.7;
        Tue, 31 Jul 2018 16:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VdDueqK6PylNDDUcXZW53jNcTL6y61lbYsweGP8iE50=;
        b=TfpOMOIFpHFvfgcKyT1oSnoc12CZ2kzFzRlxUX3a6nd+3lL47Hj9o+I/B80QpGgVPH
         c8VRxYFgXs7QJOl/d6uObrg1KKWgDPGm2hErCTil6uKc71rT8zOJB4pM5rjAI4qTZgwC
         y1Cwi3TypK9UHxYFe6HlWCveOybCzw441cNvRKSVbCN2Lar+Rx3XBISbD0Nm1XLo9Pzd
         sgj+GpiAV+miGr0CUheig96bnjkWOakSO2vgl85a5W2lJ1i3oT7lmz4Tg+YuOJD7bJE1
         l7qiRF1V+/i3g0VG5GqfqJCXeuODjZ56wu1Vgq3eZqTuS/HzVPx9pBAU6CM13fpgTjZL
         j0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VdDueqK6PylNDDUcXZW53jNcTL6y61lbYsweGP8iE50=;
        b=iZUp+OcmJdG9sNXZCvdNI4XOJn3rX8DZQzG48DrkjMKZMDneT6DD/bbwP4S6AamPKc
         h706XB8jEi20vLmhr+PMu5pceyjTfeSRpEQOc/QePhPlyuatpcgX82XofoZSN77aHMBT
         m2RPXNPcT33NVu1UUUwNvYjp8iOnhLAwE4+pg/26IWOu0OGg7LJmegpRlE5agCy9phmT
         9/zgHhOEYwFvc2qyl/W3q2MTnYB+rKBa8qs+jBtySmG0KOXzKGOX0PRpaMdIzawO9rQx
         2v6mmPbIx6BOBM73V6kzVHXpgt6Umr+Rk0N6/2j2jcMtPvkRSw0q1BwUCcsLLrVm0Q34
         Q+jw==
X-Gm-Message-State: AOUpUlG1mnaNuRwzIoGyDxoM+gfgmHqqutydLibtFtuoHbqpkutyBS/7
        hFYJfuyOopeI7fRGinNFgk+7RFo47CPXdcUQQtE=
X-Google-Smtp-Source: AAOMgpd8ZHBjRNiSRK3mYYhEyW7wSW+VrTWO8qSSO3f2mbm8omn8RFT5tx/QDc8nYLNe2N2nQ6xIlHXqsFIui4zWduw=
X-Received: by 2002:a63:b445:: with SMTP id n5-v6mr22545841pgu.104.1533078205813;
 Tue, 31 Jul 2018 16:03:25 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004fe2be05724ac084@google.com> <c8ffd001-8c67-19b9-7223-34ca8d436db2@gmail.com>
 <20180731134014.GA32114@bistromath.localdomain>
In-Reply-To: <20180731134014.GA32114@bistromath.localdomain>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 31 Jul 2018 16:03:13 -0700
Message-ID: <CAM_iQpURKOMAaPfs9v7FzhqqQPzj71sQD2LS0eU8cuqTML-YoA@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in rtnetlink_put_metrics
To:     Sabrina Dubroca <sd@queasysnail.net>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot+41f9c04b50ef70c66947@syzkaller.appspotmail.com,
        christian.brauner@ubuntu.com, David Miller <davem@davemloft.net>,
        David Ahern <dsahern@gmail.com>,
        Florian Westphal <fw@strlen.de>, Jiri Benc <jbenc@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>,
        lucien xin <lucien.xin@gmail.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 6:41 AM Sabrina Dubroca <sd@queasysnail.net> wrote:
>
> 2018-07-31, 05:41:56 -0700, Eric Dumazet wrote:
> >
> >
> > On 07/31/2018 05:31 AM, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    61f4b23769f0 netlink: Don't shift with UB on nlk->ngroups
> > > git tree:       net
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=14a9de58400000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=ffb4428fdc82f93b
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=41f9c04b50ef70c66947
> > > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > >
> > > Unfortunately, I don't have any reproducer for this crash yet.
> [...]
>
> > Probably also caused by :
> >
> >
> > commit df18b50448fab1dff093731dfd0e25e77e1afcd1
> > Author: Sabrina Dubroca <sd@queasysnail.net>
> > Date:   Mon Jul 30 16:23:10 2018 +0200
> >
> >     net/ipv6: fix metrics leak
>
> Yeah, I'm looking into both those reports :/

Looks like this commit is completely unnecessary,
fib6_drop_pcpu_from() calls fib6_info_release()
which calls fib6_info_destroy_rcu(), so this metrics
will be released twice...
