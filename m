Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D21CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 375592133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u4qUOw6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbeLRQFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:05:55 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:35582 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbeLRQFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:05:54 -0500
Received: by mail-io1-f68.google.com with SMTP id o13so13178857ioh.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 08:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JJMuV+zTvqeTiG5UA7asEisktBNEsYb7OVHXNP2wv4U=;
        b=u4qUOw6jVPqLveMmHc3iCkUD6KNx6BraEeaAVIFuhegRaNiiJ8CXdTm+GTBRbf+sVK
         DNfPXfD2SJr6X83hT8Oo5sT5n14oi38f/hk0+BnfY/sOdq+h2p4KHhAy/mcFhJb+pIhR
         pve6w7z9t4S4J5QWRifynuSBCqlpGH2TFk2HFrFqdnuBTW/Z5dEILJfLG08F4/rHcC2P
         pmJNhirclWgu7Hqqvy6yjY72WDJs7VTyJasFIFx9SOWTa4A6MA8jnJyUabf6M9v/3WBi
         kDg/1dc6kykV7seOsItR/6lAPmBiMiqbtPSytbmTrtA1cuGMN+UFy5sBBoi5/5UdNRwg
         4G4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JJMuV+zTvqeTiG5UA7asEisktBNEsYb7OVHXNP2wv4U=;
        b=WeZwQPlz97oOMvMstdnfPOChJFMXKRgHojueyrKPGwxOidXwG5moGrQd1MC8rga2PY
         l9b9bCAL8nmGzkLjnZQVtYh9bwvpiuXKkFhjKYbu8DCEaC7BHWqn+cT/Q/speQi1sqd8
         /UsaNvJ1Ku2zRikAFkXAe/yPfjhFe+f+AGYnrl/sGjzcggjjFuWaezLLjT/7iRfN8IvT
         dVEiruC7wfqciHVKy6ibI33S5+2/U6IcknOIQHAp0Rx1787eOaDlO9X4u4nxO8z6YKqJ
         hAP813+T2uDehwcmpAB2//3fMaOSDZT5q1y7np8l8KdxR2Z+0y6j/lXrgqU8RrE3+NIo
         jN6w==
X-Gm-Message-State: AA+aEWavAtExnrF9goGbOMQj0H5sa9WgrFZAjjpfl0XyC3q4FBbjsHof
        GzHqZXZDUZMheI0G2hkRsspgS5sCb81xG0Nyug7u3w==
X-Google-Smtp-Source: AFSGD/U+wMPmVJXU3xkmppulzXg4XiAm+QVCDTxAnjRIz71VblmRsY5Q7sSHcKL/yhfZGJwc0v3ufawZn2LBW0o/z/E=
X-Received: by 2002:a5d:8491:: with SMTP id t17mr14853510iom.11.1545149153235;
 Tue, 18 Dec 2018 08:05:53 -0800 (PST)
MIME-Version: 1.0
References: <0000000000005e47a2057d0edc49@google.com> <20181216190412.GE4170@linux.ibm.com>
 <CACT4Y+b+mSs2FV3BY+MsHDTPPgvPaCdMmJONd9c4zEU67CdmOA@mail.gmail.com>
 <20181217112916.GG4170@linux.ibm.com> <1583d5fc-34bf-3a81-363d-01a1085a7363@linux.intel.com>
 <CACT4Y+aKn4XsGVgt3ELGnnJcg6H-m+dSdV018dLvJhrpshycWA@mail.gmail.com>
 <20641819-e4fb-f3bd-34c8-c68106cccd0e@gmail.com> <20181217162421.6d636ee5@redhat.com>
 <CACT4Y+YXFrnQh9h1KQf8=NcHugmxTj+d7AQdGCvRX_xsHwr1qA@mail.gmail.com>
 <20181218001828.49cea463@redhat.com> <CACT4Y+ZFpO26Tgqpi+Jies9XOiiCgAdp2DV0z_54hCNTqkJsiw@mail.gmail.com>
 <20181218134024.45d2d5e3@redhat.com> <CACT4Y+az3--Y2f0OKSbF0kxwckdkKSASVog=XkX=+cXCt5r3ew@mail.gmail.com>
 <20181218151258.38796e76@redhat.com>
In-Reply-To: <20181218151258.38796e76@redhat.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 18 Dec 2018 17:05:41 +0100
Message-ID: <CACT4Y+ZQKfCgPoekJLfLLezHgs8CUAwHZgZX063fPJL=xqjEqA@mail.gmail.com>
Subject: Re: WARNING in __rcu_read_unlock
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
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

On Tue, Dec 18, 2018 at 3:13 PM Stefano Brivio <sbrivio@redhat.com> wrote:
>
> [Dropping syzbot from Cc:]
>
> On Tue, 18 Dec 2018 14:26:00 +0100
> Dmitry Vyukov <dvyukov@google.com> wrote:
>
> > On Tue, Dec 18, 2018 at 1:40 PM Stefano Brivio <sbrivio@redhat.com>
> > wrote:
> >
> > > Maybe it would be nice to have a semi-automated way to isolate and
> > > describe/name specific conditions found by syzbot via fuzzing and
> > > turn those into tests that are then repeated periodically. I'm not
> > > sure how that would look like, but I think it's still more
> > > maintainable than a pile of C reproducers with forged packets in
> > > selftests/net.
> >
> > It would be nice to do something like this. Filed
> > https://github.com/google/syzkaller/issues/884
> > However, there are few open questions that I am not sure how to
> > resolve yet...
>
> I don't have a github account, so let me comment on your questions here:
>
> > 1. How to effectively fetch so many repros from datastore without
> > hitting timeouts? We probably need to limit this to 1 repro per bug,
> > but still that's many repros.
>
> I guess this would be less of a problem if reproducers are selected
> based on input from developers, instead of just taking all the
> reproducers. E.g. one could answer a report with something like:
>
>         #syz regression-test: <name>
>         <description>
>
> in this case I would have answered:
>
>         #syz regression-test: icmp-udp-in-gue-recursion
>         ICMP exceptions on UDP direct encapsulation in GUE
>
> and something could be automatically appended to the test name,
> perhaps e-mail and date. It would also be nice to be able to undo
> this and delete a regression test.
>
> > 2. Do we need some sorting based on namespace? E.g. stable releases
> > may not include fixes for bugs fixed in upstream, then we will just
> > crash lots of kernels in vain.
>
> Same here, I guess developer input might help, but I'm not sure how to
> formalise this.


I hope we can solve these technical problems without imposing more
work onto humans. And just run all repros.
Besides the fact that it's just not good to ask people to do what
machines can do, _very_ few people will use these new tags.
Potentially we will have just this repro marked by you :)


> > 3. syzkaller repros depend on exact syzkaller revision, new syzkaller
> > won't be able to use old repros. Using C repros is much harder and
> > they are not present for all bugs. Not sure what to do here.
>
> Would it make a difference if you could use the "syz" reproducers and
> translate them to C reproducer only once needed?

That's the problem. Once we need them we will need to build and copy
to the target machine the exact syzkaller revision used to produce
that repro. So if we will test 10K repros, we will need 10K builds and
binaries copied.
