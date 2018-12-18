Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF70C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB112133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WXe/YzAP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbeLRItc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:49:32 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:38955 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeLRItb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:49:31 -0500
Received: by mail-io1-f67.google.com with SMTP id k7so12146792iob.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 00:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SZLy9GtLOSPmcm1TJ/4tu3KIUYhdGwri89QEAb8LxHc=;
        b=WXe/YzAPHLcvASI/w2eqvGMXzNzvNE5ELfJNOM5WLMY5n+q3NbLZyhRFIzeFtlnlFC
         lOjSbUy4Z4Ws2aqFCBe0Rz2ROZWW0EccYxtemcqgm2tw2+hqtMh/gVAk8R8q1OBk6kRc
         CYvQ7rtgWlswuNWC8cBqcnWzBSH9+GnzMTWam8VVR+PNOUdTsODR2oTe5sSY4BxwwfY8
         8poPnSTQmFhvfE6r9IPzvvgg1zRCObZYdx9cxmFm6CkUwITFkuySyIF1JZ+a5YuW6GWP
         aRtY4Ij/I17Dusn6Vjz9Ws38HXds86PKnvQkdKjuJgbPGQ+hD7IMsu8JS6nfjz/tX9xx
         crJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SZLy9GtLOSPmcm1TJ/4tu3KIUYhdGwri89QEAb8LxHc=;
        b=fENkSPdZcsYsvNwcXkHcoVEqfk/TcbO3x3xs1vGME8PFedPo1ycVnargp1tAbwlKS5
         fhubx/bo5g2xtxXHgptR9OVpOSqXeYwnLEJzxIOuhzOqDdfQ0fnqVoTBMZj+R7LyMVrR
         fbI9NaPjC/w37FNnhojKOgXy0dzyc7snA8yHYa+PGDxNwfg/KBvpNKJpl3a4U47JSlcO
         OV9Y7TY3MzCSEaCV55WdxZyHa9s7p7krLv24nE7xBxonkoJMdwKHUDjKG3fjInxuq1V7
         h2K8vgS0YgeJm5ovSr4Z+R2TkLi40k3Z8wujoBtN3ec5VknCJv2x5yY7jf3xSptAUhUi
         j9ug==
X-Gm-Message-State: AA+aEWYuUf17i3VyJFpmKgut+kiVMdpUTQTnMiWcimqbwBEzjPdcWDqn
        QvFIaATm0oTQU99ebeeBAZ9LZOaicgpolctK+jeySg==
X-Google-Smtp-Source: AFSGD/X4DGpmf2bUrpUvzmSBYZ9I1hlsB53MB6ETVAZew1z7m5U9ukFwrbx1EVNRwJPBkvzn3A5ccj+w0dV8ys8Hwvw=
X-Received: by 2002:a5d:8491:: with SMTP id t17mr13624225iom.11.1545122969450;
 Tue, 18 Dec 2018 00:49:29 -0800 (PST)
MIME-Version: 1.0
References: <0000000000005e47a2057d0edc49@google.com> <20181216190412.GE4170@linux.ibm.com>
 <CACT4Y+b+mSs2FV3BY+MsHDTPPgvPaCdMmJONd9c4zEU67CdmOA@mail.gmail.com>
 <20181217112916.GG4170@linux.ibm.com> <1583d5fc-34bf-3a81-363d-01a1085a7363@linux.intel.com>
 <CACT4Y+aKn4XsGVgt3ELGnnJcg6H-m+dSdV018dLvJhrpshycWA@mail.gmail.com>
 <20641819-e4fb-f3bd-34c8-c68106cccd0e@gmail.com> <20181217162421.6d636ee5@redhat.com>
 <CACT4Y+YXFrnQh9h1KQf8=NcHugmxTj+d7AQdGCvRX_xsHwr1qA@mail.gmail.com> <20181218001828.49cea463@redhat.com>
In-Reply-To: <20181218001828.49cea463@redhat.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 18 Dec 2018 09:49:17 +0100
Message-ID: <CACT4Y+ZFpO26Tgqpi+Jies9XOiiCgAdp2DV0z_54hCNTqkJsiw@mail.gmail.com>
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
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 12:18 AM Stefano Brivio <sbrivio@redhat.com> wrote:
>
> On Mon, 17 Dec 2018 16:53:36 +0100
> Dmitry Vyukov <dvyukov@google.com> wrote:
>
> > On Mon, Dec 17, 2018 at 4:24 PM Stefano Brivio <sbrivio@redhat.com> wrote:
> > >
> > > On Mon, 17 Dec 2018 06:57:35 -0800
> > > Eric Dumazet <eric.dumazet@gmail.com> wrote:
> > >
> > > > Might be cause by commit b8a51b38e4d4dec3e379d52c0fe1a66827f7cf1e
> > > > fou, fou6: ICMP error handlers for FoU and GUE
> > >
> > > This:
> > >
> > > diff --git a/net/ipv4/fou.c b/net/ipv4/fou.c
> > > index 0d0ad19ecb87..20a6de26d146 100644
> > > --- a/net/ipv4/fou.c
> > > +++ b/net/ipv4/fou.c
> > > @@ -1008,6 +1008,9 @@ static int gue_err_proto_handler(int proto, struct sk_buff *skb, u32 info)
> > >  {
> > >         const struct net_protocol *ipprot = rcu_dereference(inet_protos[proto]);
> > >
> > > +       if (ipprot == IPPROTO_UDP)
> > > +               return -EINVAL;
> > > +
> > >         if (ipprot && ipprot->err_handler) {
> > >                 if (!ipprot->err_handler(skb, info))
> > >                         return 0;
> > >
> > > should fix the issue, but I still have to run tests and make sure we
> > > don't hit similar cases.
> >
> > Please don't forget to add a regression test for it too ;)
>
> Where would you suggest to add this? The only selftest that goes

I dunno. But there must be some place for such tests, right?

> through this path currently is net/pmtu.sh, but as configuration of an
> actual UDP-in-GUE tunnel is currently not supported, I would really
> need to forge that specific packet, so that doesn't seem to be a good
> fit.
>
> Won't syzbot add this to some list of reproducers that are checked in
> the future?

It won't. Also fuzzing is complementary to testing, not a replacement:
https://twitter.com/dvyukov/status/1074719682962358272
