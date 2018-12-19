Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB52C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 04:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC08721871
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 04:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbhID/fv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbeLSEMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 23:12:17 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36197 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbeLSEMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 23:12:17 -0500
Received: by mail-pf1-f194.google.com with SMTP id b85so9197029pfc.3;
        Tue, 18 Dec 2018 20:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=99ol7qbLCgkmttbxGy8bJMeKzGX8ofEsvRhXZ26stH8=;
        b=TbhID/fv2AjiLgcCxrnVAJ6XUQWH7mP1752zzD6yYjgm0mhlD5xWJ0s36T9ahjYvAl
         TyirBr/wFYuVNosCKZll+qd7dtrYKn6jxYZ14ws9BajP4J7VDQ+Er07UL3icToD1yfbP
         FjIsfIgkurdqEuEL2T+MPbXIKjAOWW4rdQqC89IzOP0tlIj+bEqvkOPv3kuplXqsejd2
         cfqVLjjaVK3fEsYJwSHA5jm+bJjEAOMSzOJoBpahJXINcsF9fezRcdzT4L9mB499OB43
         qtwmMY993aeAZjY0+vVDZR9pC0s6LfZPF8HC17ZkNREx3SueoBU1l8LKYtjPtIJiZ7mO
         AEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=99ol7qbLCgkmttbxGy8bJMeKzGX8ofEsvRhXZ26stH8=;
        b=E/rTkNtLDQimY6+O46ttu04Pozlw2HkDoH9bP1A1agf6RRGkWUS71IAPHS8Zj0uy6X
         6pAlRXWgrPdflbgvXkuF8O3C7ohhgAsD99p6xdaLILDPm3qcw0WEn3TcuCVaa3abNrht
         sHboMIQdNVIONc6HIk76iYJkthoiN+tCzu+URvCUHWZZy6CEqZzUVRN+7yXo91mxz0i4
         y9l0bGeHYGb2GKOvmuo/eHjp8bvJlgc4SaKB8GcWCYHOCjcyefkIhbLdQxT9DUlGUHLT
         kGcZ14kR4xRAtWW7op5+Xf5NPrNTsZOn8YvYODMX9SM+Yo5nw0s1ZGL98fqtYjmPhqE1
         iv2g==
X-Gm-Message-State: AA+aEWaJxEdAJReSHb74PxJ7m80D2bmB7y4Mr9/HWfeQ7gNiUUQdc1v+
        ajzmX1nFK7yvKZ8q6UIljNUDfj1VeOwoLRQIOqk=
X-Google-Smtp-Source: AFSGD/UyHuK9cw3f2JzLnTb9wNkvWQBGXbupwvgo4NwYpaK9lVwNEcTMMJkzGf8I57LTAGbaHpQ7G+Bsg6d89hbD3O8=
X-Received: by 2002:a63:2586:: with SMTP id l128mr18503023pgl.104.1545192736238;
 Tue, 18 Dec 2018 20:12:16 -0800 (PST)
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
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 18 Dec 2018 20:12:04 -0800
Message-ID: <CAM_iQpUYeF1vLRX=TryfH6ruPi2qL-j8Y2shbs7s9cKiy4xvmA@mail.gmail.com>
Subject: Re: WARNING in __rcu_read_unlock
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        syzbot <syzbot+43f6755d1c2e62743468@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        netdev <netdev@vger.kernel.org>, Xin Long <lucien.xin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 4:40 AM Stefano Brivio <sbrivio@redhat.com> wrote:
> Not as far as I know. The selftests checking this path, by design, only
> use supported configurations, they don't forge packets.
>
> Maybe it would be nice to have a semi-automated way to isolate and
> describe/name specific conditions found by syzbot via fuzzing and turn
> those into tests that are then repeated periodically. I'm not sure how
> that would look like, but I think it's still more maintainable than a
> pile of C reproducers with forged packets in selftests/net.
>
> Eric, Cong, Xin, as you also recently fixed a nice deal of similar cases
> reported by syzbot, what do you think? Did you ever feel the need to
> turn a syzbot reproducer into a regression test case?

I think it is a very good idea to archive these C reproducers in
tools/testing/selftests/. After this is done, kbuild bot could do these
regression tests, no longer need to bother syzbot to run them again. :)

Thanks.
