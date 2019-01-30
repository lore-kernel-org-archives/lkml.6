Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C726BC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A3120844
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cd1avWKm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731221AbfA3OD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:03:26 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39556 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfA3ODZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:03:25 -0500
Received: by mail-it1-f195.google.com with SMTP id a6so10595081itl.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 06:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pWDEpcRFq41++ojWySm7GWlG5kX2xsA4Hpp7FSF3Cdg=;
        b=cd1avWKm0dnA1DGmrnFTIj0dJXhyCPTD6KYHLOjAj/XYTtg3z5dPx7pHg9akCWXIbY
         Ncxai2WndsgkM3izORBtxTOJsAQz1KjGFzWEC0yWintjaLFsE/yQNQ+pxSusFNA/VWiU
         /sWdyksBgLXLKYLL0cJ1MqU1X0gAfZecCREFgltpllpVkfhufcN2ULt6v/Z3x4JvC6Rh
         zka5kHBuZDaF/rfrVcrIYRRzOeKTmKk2CuguYk8vsuGZQ3f6z8mf2rrnk1bksw7oejtz
         IJnRz3H35/EYiX2RcLE+0T4YjkHxI6XwWXt+7VksUvXAufI02S7WvaKVrGmdaIJoJUbs
         LMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pWDEpcRFq41++ojWySm7GWlG5kX2xsA4Hpp7FSF3Cdg=;
        b=INtYXK4m4fYsZtRMVOao2p1N308ZxTuu2tPTsvYmor1tEmC+d0iDHhpZQ6k4Ijrsqr
         rFNReFoeVJUeyRKWnQAtokSFc7hEy0z8YT0fefH2Q+bkkda1FETOOAsZT6ox22axLwli
         RU8zTu9+s2cLx1CdjgIkfAgyq9m3cqMr7uH0WKSuz0DdwgNUhlVgW0lWZe5oGJORZySb
         T+fI4M/2sReaAsrZkD+nkbsmWDfoUt+UG62cPgp6qaqyZ1jT6hb51tOsIuhCM1GVfowE
         qTYa5+rgx5lFCgQclSKKjdLjvmpMUlYNJ54/o0WBsh4Hmw7+VeX1scaHl3Zw7A/i8rNA
         iAmg==
X-Gm-Message-State: AJcUukd++yaCm05ltLzqUHvtrmJfaFie4oyJohjX17icHUgSRggIPFja
        wbQinjUTjxxpnsYDAUSzcAEl3cjupWSRqEe/T1o+VA==
X-Google-Smtp-Source: ALg8bN7R2ALi8qGQkVdWOpd+HOXOaOBF9Z3tsLVNYfZHOe0kc+wYhSDg1Ei3UDbgt5PDqQ2Ppmlt+L0aTgSvrO5nc1Y=
X-Received: by 2002:a05:660c:f94:: with SMTP id x20mr13628901itl.144.1548857004912;
 Wed, 30 Jan 2019 06:03:24 -0800 (PST)
MIME-Version: 1.0
References: <0000000000007b129305809553da@google.com> <20190129094144.bln4dnirr5kz3dl4@breakpoint.cc>
In-Reply-To: <20190129094144.bln4dnirr5kz3dl4@breakpoint.cc>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 30 Jan 2019 15:03:13 +0100
Message-ID: <CACT4Y+YB_icD2B6Bj6=5KjAvfamyCUeLnYHm5i5PQKO35=RMFA@mail.gmail.com>
Subject: Re: general protection fault in __xfrm_policy_bysel_ctx
To:     Florian Westphal <fw@strlen.de>
Cc:     syzbot <syzbot+e6e1fe9148cffa18cf97@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 10:41 AM Florian Westphal <fw@strlen.de> wrote:
>
> syzbot <syzbot+e6e1fe9148cffa18cf97@syzkaller.appspotmail.com> wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    085c4c7dd2b6 net: lmc: remove -I. header search path
> > git tree:       net-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=12347128c00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=505743eba4e4f68
> > dashboard link: https://syzkaller.appspot.com/bug?extid=e6e1fe9148cffa18cf97
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
>
> net-next doesn't contain the fixes for the rbtree fallout yet, so
> this might already be fixed (fingers crossed).

Hi Florian,

What is that fix for the record?
We will need to close this later. Or perhaps we can already mark this
as fixed by that patch with "#syz fix:" command?
