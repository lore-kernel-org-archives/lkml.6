Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDD2C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E037E2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UgEJl5mq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387932AbeLQPxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:53:49 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33041 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbeLQPxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:53:48 -0500
Received: by mail-io1-f65.google.com with SMTP id t24so10357184ioi.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 07:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nluuOvY/ko01muiOUJYBwCAJroNVraGln4EX2zVjxsY=;
        b=UgEJl5mqU+pP+ipnV/CfjELaOrMB3YWmKbUZVfvAABppeRBbJAjRFCXt8sidvstTSR
         TRFhl4HAIcX5LVhGtznppXr/M8ynlHw8dv/lkGk0nukrDdgzmwEoIBVR+ha2ftDMpkgd
         a+4GqPIOTyvb3NL0qDOTWeELsP7yhZExnTQUot6w+0CWKNPuE+OKaqPE+flbOm2aUtsj
         jxErIOnQA3siyKtXe8GCiHocAaypeh2HhiH3yDesxLeivNOCKAM+tI+YuVgnnCcVjocd
         CVHo2FJ62g8YjzMonUbAAzdmjI924GKAKBS+rS38LGpE6C+Ejf4sM4+F5h+xrzRyEKca
         WXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nluuOvY/ko01muiOUJYBwCAJroNVraGln4EX2zVjxsY=;
        b=tA+TzJP81+2sKbIc+pFA+WsXhpCyWFnXXK1nD6j6XXjjoP9K4iXeJf8vadVZqsJlRO
         QdDutDDAyM4XAHqgfMai5YT9ske9Xp7kPyC1h8lqd2i0PjIHjQx+XDXP4PQPWLq6ccC4
         t70z4/Ycja3ByyltNqSDtBN/lmUPwcHH3HHXCJA/dp4ydNLVGCjM8/aNM06Tks9NNSZ8
         b+L/fDPKvXZGoDEK4gDvqntsUt3WPVgBUi8qJDgsizv/RkW+bVb6GGN/1hNJxO6FcFtv
         esyBZ1BzgbMcTG8iLAo8YOhAPswMkNRUSIkLJGCVsKMVge6oNKLP5ZNz2FhOmCjwPXCV
         T3sw==
X-Gm-Message-State: AA+aEWY7rcCyj9ek2X+6tTKUf76JeTbht3PwKTzmqOk7K0imHuY+2tif
        uIXGVJ5qwgGj0xKqtzS5yXuV6+j1jpj3qUfBUdTqLQ==
X-Google-Smtp-Source: AFSGD/Whnpa89Nw4MScQv5pAOuYMhaislkJ5MdKh4Ke97YoRa3kZv9cZy+TAItkDKCiy4CWU0vVtFCcer10ZTGyoK8U=
X-Received: by 2002:a6b:fa0e:: with SMTP id p14mr10579523ioh.271.1545062027498;
 Mon, 17 Dec 2018 07:53:47 -0800 (PST)
MIME-Version: 1.0
References: <0000000000005e47a2057d0edc49@google.com> <20181216190412.GE4170@linux.ibm.com>
 <CACT4Y+b+mSs2FV3BY+MsHDTPPgvPaCdMmJONd9c4zEU67CdmOA@mail.gmail.com>
 <20181217112916.GG4170@linux.ibm.com> <1583d5fc-34bf-3a81-363d-01a1085a7363@linux.intel.com>
 <CACT4Y+aKn4XsGVgt3ELGnnJcg6H-m+dSdV018dLvJhrpshycWA@mail.gmail.com>
 <20641819-e4fb-f3bd-34c8-c68106cccd0e@gmail.com> <20181217162421.6d636ee5@redhat.com>
In-Reply-To: <20181217162421.6d636ee5@redhat.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 17 Dec 2018 16:53:36 +0100
Message-ID: <CACT4Y+YXFrnQh9h1KQf8=NcHugmxTj+d7AQdGCvRX_xsHwr1qA@mail.gmail.com>
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

On Mon, Dec 17, 2018 at 4:24 PM Stefano Brivio <sbrivio@redhat.com> wrote:
>
> On Mon, 17 Dec 2018 06:57:35 -0800
> Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
> > Might be cause by commit b8a51b38e4d4dec3e379d52c0fe1a66827f7cf1e
> > fou, fou6: ICMP error handlers for FoU and GUE
>
> This:
>
> diff --git a/net/ipv4/fou.c b/net/ipv4/fou.c
> index 0d0ad19ecb87..20a6de26d146 100644
> --- a/net/ipv4/fou.c
> +++ b/net/ipv4/fou.c
> @@ -1008,6 +1008,9 @@ static int gue_err_proto_handler(int proto, struct sk_buff *skb, u32 info)
>  {
>         const struct net_protocol *ipprot = rcu_dereference(inet_protos[proto]);
>
> +       if (ipprot == IPPROTO_UDP)
> +               return -EINVAL;
> +
>         if (ipprot && ipprot->err_handler) {
>                 if (!ipprot->err_handler(skb, info))
>                         return 0;
>
> should fix the issue, but I still have to run tests and make sure we
> don't hit similar cases.

Please don't forget to add a regression test for it too ;)
