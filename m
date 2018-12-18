Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D67C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B57ED21852
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ebwd6V8q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbeLRN0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:26:15 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39956 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbeLRN0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:26:13 -0500
Received: by mail-it1-f195.google.com with SMTP id h193so4173758ita.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 05:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bGSQyvaWMFrJndjksBzYgjE8objY3pFhGxBX/Cl9+r0=;
        b=ebwd6V8qb9C/L6fPK97eP0VN87T7mF0ck/6X1NU02alZreHXGLgxmspUmx5DgfrmnT
         GQQuAJtI9cpTPpJGsY+zXvfr0H8ue9AWxoUnKqN4nayevhOEXOwGFjTPUSuc0H9wlGDv
         joL1W8Ge26ECp+YoKJkTJnGjZ/BcFmhtTOphl58cESx32iW8g4m157jehPINYadb/q19
         fkbgn0LWHGQX1tURiphAbBpd/One8fysdQkyIEUVZ4e+0xYm/5OPrdLSlS7zgdcMT137
         lOy+ij1UVggKlbDxzplH8MpSAEdqSdqomW+tjxFKonu4OI8GGqTDdjOP66RN5TUefMbC
         92dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bGSQyvaWMFrJndjksBzYgjE8objY3pFhGxBX/Cl9+r0=;
        b=mTDGlGmDYuzawGzrb4MxTdvM4dLhUWsX7WmHJUvR4bFlp32kzI9YJX571/r5J9asK0
         US3aF0XL/2Txf/gmkS5lbdvt++M43MaDOPZr/T9d8Aeu8G3CATH/jykdoYgRfAc1YwSv
         XtNZueGS+hGJNRiXYt6jPcomGRn8+p4HwM3gI1wtcG+VqBVlLwvSMJPwcoKX0aSHg64p
         /6H4PgPIVrHB+S1884DISYzJ++B4/DaLA75K0QSSEmZTjC3jMNlfAKY7RP5j6D/Wq3iY
         J0/w+bvbU4pqcQMeBt9nLcNWNNrNyuo+4IIwhNDEUB9ZwYV/eACfoDyiEbfpPKasMXqy
         MqMw==
X-Gm-Message-State: AA+aEWZ9HtHkTUbzVxNksBVbqiIe4fEBMe0mHYmxhR2fh2NA3ko1Vj4Z
        qRB6HbQCeLm7GWqL9LRLJXzvpezMAxAl1KcLc92j9A==
X-Google-Smtp-Source: AFSGD/WsDFBam0PmfHsVQ5WOYaw2U0XMtLMH9qmjOYEcYpt60zSqhIG9OU6XS4EsypJ5dsnSiy6rAIHKMi40d8ugvus=
X-Received: by 2002:a24:f14d:: with SMTP id q13mr2640083iti.166.1545139571621;
 Tue, 18 Dec 2018 05:26:11 -0800 (PST)
MIME-Version: 1.0
References: <0000000000005e47a2057d0edc49@google.com> <20181216190412.GE4170@linux.ibm.com>
 <CACT4Y+b+mSs2FV3BY+MsHDTPPgvPaCdMmJONd9c4zEU67CdmOA@mail.gmail.com>
 <20181217112916.GG4170@linux.ibm.com> <1583d5fc-34bf-3a81-363d-01a1085a7363@linux.intel.com>
 <CACT4Y+aKn4XsGVgt3ELGnnJcg6H-m+dSdV018dLvJhrpshycWA@mail.gmail.com>
 <20641819-e4fb-f3bd-34c8-c68106cccd0e@gmail.com> <20181217162421.6d636ee5@redhat.com>
 <CACT4Y+YXFrnQh9h1KQf8=NcHugmxTj+d7AQdGCvRX_xsHwr1qA@mail.gmail.com>
 <20181218001828.49cea463@redhat.com> <CACT4Y+ZFpO26Tgqpi+Jies9XOiiCgAdp2DV0z_54hCNTqkJsiw@mail.gmail.com>
 <20181218134024.45d2d5e3@redhat.com>
In-Reply-To: <20181218134024.45d2d5e3@redhat.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 18 Dec 2018 14:26:00 +0100
Message-ID: <CACT4Y+az3--Y2f0OKSbF0kxwckdkKSASVog=XkX=+cXCt5r3ew@mail.gmail.com>
Subject: Re: WARNING in __rcu_read_unlock
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        syzbot <syzbot+43f6755d1c2e62743468@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        netdev <netdev@vger.kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Xin Long <lucien.xin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 1:40 PM Stefano Brivio <sbrivio@redhat.com> wrote:
>
> On Tue, 18 Dec 2018 09:49:17 +0100
> Dmitry Vyukov <dvyukov@google.com> wrote:
>
> > On Tue, Dec 18, 2018 at 12:18 AM Stefano Brivio <sbrivio@redhat.com> wrote:
> > >
> > > On Mon, 17 Dec 2018 16:53:36 +0100
> > > Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > > On Mon, Dec 17, 2018 at 4:24 PM Stefano Brivio <sbrivio@redhat.com> wrote:
> > > > >
> > > > > On Mon, 17 Dec 2018 06:57:35 -0800
> > > > > Eric Dumazet <eric.dumazet@gmail.com> wrote:
> > > > >
> > > > > > Might be cause by commit b8a51b38e4d4dec3e379d52c0fe1a66827f7cf1e
> > > > > > fou, fou6: ICMP error handlers for FoU and GUE
> > > > >
> > > > > This:
> > > > >
> > > > > diff --git a/net/ipv4/fou.c b/net/ipv4/fou.c
> > > > > index 0d0ad19ecb87..20a6de26d146 100644
> > > > > --- a/net/ipv4/fou.c
> > > > > +++ b/net/ipv4/fou.c
> > > > > @@ -1008,6 +1008,9 @@ static int gue_err_proto_handler(int proto, struct sk_buff *skb, u32 info)
> > > > >  {
> > > > >         const struct net_protocol *ipprot = rcu_dereference(inet_protos[proto]);
> > > > >
> > > > > +       if (ipprot == IPPROTO_UDP)
> > > > > +               return -EINVAL;
> > > > > +
> > > > >         if (ipprot && ipprot->err_handler) {
> > > > >                 if (!ipprot->err_handler(skb, info))
> > > > >                         return 0;
> > > > >
> > > > > should fix the issue, but I still have to run tests and make sure we
> > > > > don't hit similar cases.
> > > >
> > > > Please don't forget to add a regression test for it too ;)
> > >
> > > Where would you suggest to add this? The only selftest that goes
> >
> > I dunno. But there must be some place for such tests, right?
>
> Not as far as I know. The selftests checking this path, by design, only
> use supported configurations, they don't forge packets.
>
> Maybe it would be nice to have a semi-automated way to isolate and
> describe/name specific conditions found by syzbot via fuzzing and turn
> those into tests that are then repeated periodically. I'm not sure how
> that would look like, but I think it's still more maintainable than a
> pile of C reproducers with forged packets in selftests/net.

It would be nice to do something like this. Filed
https://github.com/google/syzkaller/issues/884
However, there are few open questions that I am not sure how to resolve yet...


> Eric, Cong, Xin, as you also recently fixed a nice deal of similar cases
> reported by syzbot, what do you think? Did you ever feel the need to
> turn a syzbot reproducer into a regression test case?
>
> > > through this path currently is net/pmtu.sh, but as configuration of an
> > > actual UDP-in-GUE tunnel is currently not supported, I would really
> > > need to forge that specific packet, so that doesn't seem to be a good
> > > fit.
> > >
> > > Won't syzbot add this to some list of reproducers that are checked in
> > > the future?
> >
> > It won't. Also fuzzing is complementary to testing, not a replacement:
>
> Indeed, but that doesn't mean we need to limit the potential of fuzzing
> because "it's not testing". It can be used to check for regressions,
> too, especially in these cases.
>
> > https://twitter.com/dvyukov/status/1074719682962358272
>
> Now, I'm extremely thankful for the work you're doing and especially
> for finding this subtle condition with syzbot, but this is quite
> inaccurate. To be exposed to this issue, the user would need to
> have the fou module loaded (it won't autoload), which is used quite
> rarely, and, on top of that, have a UDP tunnel configured. It wouldn't
> have been the kind of "evil packet crashes the internet" scenario you
> were dreaming of ;)

Okay, I see. Full bug assessment is hard. I mess it both ways for
different bugs.
But I did not claim that it does not require some setup :)
And maybe there is somebody important on the internet that uses such
setup. Who knows.
