Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F044CC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 11:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9110206C0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 11:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="im8xgItr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfADLFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 06:05:19 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:56111 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfADLFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 06:05:19 -0500
Received: by mail-it1-f194.google.com with SMTP id m62so1099027ith.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 03:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/uoWL0t0iMkvXvq5HcdVPIlDfpkDMSDIYS2Wnw4EHBM=;
        b=im8xgItrHCINn5sJaxU1Yv98xg5jzvEAlhpvXTahtyU42hFD+gTSBDOEyt33DSFCUU
         AMOX7EaSBnALuxrEY2xVs1dVl3qKD/MQLU2Pn7QtNnbXHM1n1qNYYzoFBRoxLHtGh9Gd
         l6t/3mgRkZx5mskZu+HcgPg62mj0neUO2Sfm3zjj2eVFSE/11cDTF4DT7deepABPKgEt
         DE28xbIYVzgaVw16E0Qb9Qn1ZpfOvxvFELirjWA6sGALcuj0nw4Jhtq/K1Avc06QvbON
         b6jh4f19B4vqAYy0IeypfUXvhOn8/gLNHfSTefTFhG30xuDaoFrtx/OlDV5N4pr0rDsb
         qD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/uoWL0t0iMkvXvq5HcdVPIlDfpkDMSDIYS2Wnw4EHBM=;
        b=sI+D28gIBRK4Sj14lArha97qtHlMO+5TbG2sAo1l1HnAd8cYaxylOBt+QywRAQKAS0
         GaaBGfb1osuQwYDRoxNy1r3RrH3PFUt8dPmIXeWIBwJK5koUojDrOYP+L8PYbKUY01uq
         Lmuia/OwoEcoMhQovIJXID0ekvIrQj200giY9N/Otzn+ismtFlOk8FdWGDV7YZvjpda/
         m6DB/a0/EwVgpIyNM+WkeqTAm8FR37sdiO8yZcpmT/2kjo7Y5J46ujY++4Jblcx31izE
         r7u0FJESTh0OBDPpnq3QMS3WLR/wrsZuX6XIVW9Ci1t7QpN3geUo9AbIzsPpdnC/GJhD
         nutw==
X-Gm-Message-State: AJcUuke33VAV4QkCTyVBYKPFC/qbTVZajAdJJO9iwluWOdZAqU5Kq4Ac
        wxwlEobYAMXBxTwPJUCs+01NEkVTvWOPEWkmDlZKxA==
X-Google-Smtp-Source: ALg8bN5u25mBKmaIRMindjeg7C2o3UAVmoIrf828AhcDIdYPDSHd/+ll2vtR5tGMfeTTv0y1hdThzjEEn3jO8Qk2pGU=
X-Received: by 2002:a24:6511:: with SMTP id u17mr650010itb.12.1546599916677;
 Fri, 04 Jan 2019 03:05:16 -0800 (PST)
MIME-Version: 1.0
References: <000000000000513fb7057e8d7013@google.com> <f2e566ac-5c4c-11ae-d436-ebb3522a2195@gmail.com>
 <20190103210743.6518841e@redhat.com> <CA+FuTScFwA3F44MvbaWrOYJ2EYgdKAmoMzEGjOLcz3ZPVQLLDA@mail.gmail.com>
 <20190103225404.66b0ec9f@redhat.com> <CACT4Y+aAofhchOpKTjLGGkQb5PAa74Uyp7kowdSoAwt130ZpAg@mail.gmail.com>
 <20190104115435.478b4b4a@redhat.com>
In-Reply-To: <20190104115435.478b4b4a@redhat.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 4 Jan 2019 12:05:04 +0100
Message-ID: <CACT4Y+bRLOVCx9Z=vCMspjzGrcnNFqNGWxDwiwYZbw2LTh__FA@mail.gmail.com>
Subject: Re: kernel panic: stack is corrupted in udp4_lib_lookup2
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+4ad25edc7a33e4ab91e0@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 4, 2019 at 11:54 AM Stefano Brivio <sbrivio@redhat.com> wrote:
>
> On Fri, 4 Jan 2019 11:32:12 +0100
> Dmitry Vyukov <dvyukov@google.com> wrote:
>
> > On Thu, Jan 3, 2019 at 10:54 PM Stefano Brivio <sbrivio@redhat.com> wrote:
> > >
> > > On Thu, 3 Jan 2019 15:15:06 -0600
> > > Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > > syzbot generated stack traces with
> > > >
> > > > [  183.517380]  udpv6_err+0x46/0x60
> > > > [  183.520739]  ? __udp6_lib_err+0x1890/0x1890
> > > > [  183.525054]  gue6_err_proto_handler+0x199/0x280
> > >
> > > Where? I can't find that in any logs linked from the dashboard at
> > > https://syzkaller.appspot.com/bug?extid=4ad25edc7a33e4ab91e0 :(
> >
> > Stefano, there are these 4 bugs reported that have similarly looking
> > reproducers involving udp sockets and that crash modes that looks like
> > stack corruption/overflow:
> >
> > https://syzkaller.appspot.com/bug?extid=14005fa30c9a07192934
> > https://syzkaller.appspot.com/bug?extid=d14090007dc9ba5fa9b7
> > https://syzkaller.appspot.com/bug?extid=137ed32ec9a6d5b0d5fe
> > https://syzkaller.appspot.com/bug?id=d5bc3e0c66d200d72216ab343a67c4327e4a3452
> >
> > Are these the same bug as this?
>
> Judging from the reproducers for the first three, they seem to be.

OK, then I will mark them as dups of this one.

> I
> guess I can trigger tests also for those by sending a (sharp)syz
> test ... e-mail with the patch to the Reported-by: addresses, right?

Correct.
These should be on LKML, but as you noted you can just add the syzbot
email with tag to TO/CC. That email is available in the Reported-by
tag (and also shown on the dashboard).

> And the three reports you pointed out from the pile of corrupted
> reports also seem to match, others look unrelated.

I've added these as tests:

https://github.com/google/syzkaller/blob/master/pkg/report/testdata/linux/report/341
https://github.com/google/syzkaller/blob/master/pkg/report/testdata/linux/report/342
https://github.com/google/syzkaller/blob/master/pkg/report/testdata/linux/report/343
https://github.com/google/syzkaller/blob/master/pkg/report/testdata/linux/report/344

Will try to figure out how to distinguish them from true corrupted
reports. Usually when Call Trace does not have any frames, it's a sign
of a corrupted report, and in other crashes we see the same report but
with a stack trace. But some stack-corruption-related reliably don't
have stack traces (not corrupted). But then some other
stack-corruption-related crashes do have stack traces, and for these
no stack trace again means a corrupted kernel output. Amusingly this
is one of the most complex parts of syzkaller.
