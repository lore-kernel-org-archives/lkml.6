Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42ECEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 10:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E8B21741
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 10:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kYDm/8KR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730790AbeL0KRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 05:17:24 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:46752 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730769AbeL0KRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 05:17:22 -0500
Received: by mail-io1-f68.google.com with SMTP id v10so14165968ios.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 02:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4cSwDNdK1wJERrul5mAWeVHUwwLTjU5tyC5C4ok4ZeY=;
        b=kYDm/8KRwibcbdZut5zsyDKE2I0fnXYzo9rooOASJRG9UXzfAb16GL4b0eoerssbqT
         OEJm+5HepegilFx3FcQJZlfqU6KEIa8jSMRAtycRbmboG1YhFtmM9VnuLKj0EKFBAGnL
         Iy9e8iROoejdK0dzk6taOgTtGIDnoExD6mv/2GmbV6NJAn8R8x+Cwu1SVyTBMhO14eVK
         0fvMgvGayIMjwN38q27izG61h/AxESAFzmizekvxTwGEM638QGcbkZlPHSUZniCAw4XK
         pOmpc0jqfXq8Po2z+xvyyeX3nahOdNi9xZUJOvsZmRBA2UURSCilX/qZrw5P7ABEHOkz
         hF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4cSwDNdK1wJERrul5mAWeVHUwwLTjU5tyC5C4ok4ZeY=;
        b=MvYPJrhBVw7ne2VOK3xYyjpbeYdJXwicSMsLGu4AdtuckrxmMDB0lNxrJhdwqiIdRO
         E9Dk3qUW6LlJjhfxB5I+dFUWaWa5g+js5Zn404QZmxJdcXehCJvDlJz07/u4monaR08p
         1Lb4CgfIgWHl2KFQT+ugO5QxJ/75yr89fKwq4cE0byM3TjzftVgxjsgtuawOtShyXpVg
         0BGsIMuJZOwMq+kK7sAVYqfEuHtTLhEHzJwImFezzivOAxxErGCybRiDaucIcPQp4Ovs
         KFSFlIOFyRiz3hzmCAICcjay1e3qov0oAywVjGYnfbe45F4Ow1c0lOfUFZkLjYOIE6rp
         Dmhg==
X-Gm-Message-State: AJcUukeWRtF8Tg/aNL5edsnSMobZ39uJMDnC22rpFU56oIU21Rk01WyA
        kx8CF5JpcK5ab/V4oQ9ejkzWYnwaZ5LjFgrsnmD3hg==
X-Google-Smtp-Source: ALg8bN47elfGJm2gF/Ypya8uTnKKkCwRMkwFd4NXZgYC3CsPg+wWLqeLtz45/PrFXLrdpTqavP/RQDn53OMPZzQmtTI=
X-Received: by 2002:a5d:8491:: with SMTP id t17mr15766544iom.11.1545905841192;
 Thu, 27 Dec 2018 02:17:21 -0800 (PST)
MIME-Version: 1.0
References: <000000000000f16b5e05714225b8@google.com> <0000000000003878ad057d97d241@google.com>
 <20181226104221.pojiahsinsspkkxf@breakpoint.cc>
In-Reply-To: <20181226104221.pojiahsinsspkkxf@breakpoint.cc>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 27 Dec 2018 11:17:10 +0100
Message-ID: <CACT4Y+ZyOxkQgHm-8sgv+ORpFYTZ4gH9gqnYCZBL0-v4SJ1Asw@mail.gmail.com>
Subject: Re: KASAN: use-after-free Write in __xfrm_policy_unlink
To:     Florian Westphal <fw@strlen.de>
Cc:     syzbot <syzbot+9d971dd21eb26567036b@syzkaller.appspotmail.com>,
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

On Wed, Dec 26, 2018 at 11:42 AM Florian Westphal <fw@strlen.de> wrote:
>
> syzbot <syzbot+9d971dd21eb26567036b@syzkaller.appspotmail.com> wrote:
> > syzbot has found a reproducer for the following crash on:
> >
> > HEAD commit:    ce28bb445388 Merge git://git.kernel.org/pub/scm/linux/kern..
> > git tree:       net-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1673fb1b400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=67a2081147a23142
> > dashboard link: https://syzkaller.appspot.com/bug?extid=9d971dd21eb26567036b
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1134dcc7400000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=126986ed400000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+9d971dd21eb26567036b@syzkaller.appspotmail.com
>
> I've fixed this one.  Chances are that at least some of the other
> reports are duplicates of this one.
>
> I will continue to look at other reports over the next few days and plan
> to send out fixes and test cases next week.

Thanks for the update, Florian. Sounds great, let's kill them all!
