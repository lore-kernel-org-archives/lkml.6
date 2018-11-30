Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC65EC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7131620660
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNL4YbJe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7131620660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbeLAJyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:54:13 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:40740 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbeLAJyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 04:54:12 -0500
Received: by mail-io1-f67.google.com with SMTP id n9so5841035ioh.7;
        Fri, 30 Nov 2018 14:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DZT01dsD8qpi2rsK/ob5mfzEL677Q+xDV5gPtHeYIoA=;
        b=tNL4YbJelzCvwk85qcpPySaAjE77/zjFGhNrq+iGQ4U2oplhjiSvglbnfpEtc2GGKL
         xyv29UAkCKTfmh+4dXhkGisqYa1h+1Dwni0weGLQdHN+YVMeLxSlwZ0Sh7vEbEiDb4uM
         KTWLoM12+fZSjITD3gBHq/RQY/fCzVW8y0sqLEkbRP4od/U4QKHGee/OWPrStuLlpBQG
         Y2iNUKWABuaySWhxyjXPWfexwpwVZLRNVIQ2YRHUJuog/vfgAqQ6ekyMzS3OoO/+qT3O
         pJcG/nTy4Vii+0an2llh9ibpF5xucqz+C1yLKKlcn9B0TU44ILaZQ06v9eLX0ocfGZgg
         dmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DZT01dsD8qpi2rsK/ob5mfzEL677Q+xDV5gPtHeYIoA=;
        b=lRNNOfSusY5VjB4Bj3TmU7BcdZRnyrzN8oi60FCUEXPUJHOWGlkoDz7sYH8KcreqRW
         S2j+7j1SYC7jgWdxHIPbsKNL3tFJKx4JNvyFXk83aCam5ijtkLos/s+vTFWNydAGUZ/6
         VcBGiqkCZP8eOOsf/0kM8vV/T1ZVXMY2tg+HwD8Bx1EGwlVc042VDvgKLKgIL74HelRc
         HrotZkJPGyutGejI5LNlDcnoo3Qg0N5WBSdAwb6MgEXkrEtT1l8kpIv83UnmUc6Yrnm9
         +AGWsWoSILM6tRiVdT0c2YDUvquYCQ9ol1gnaRVu5/czN/Bui3tEkFIm3uR5x75QsO4a
         v7HA==
X-Gm-Message-State: AA+aEWY5VSo3TZkVqie2XZy9IEIBvMtiUFMNBXKp9iX/jnU1khNLzdQW
        4fBqf3BJUbfcTYGDvHHRPxCnSNVUhJ6q5bKe5GU=
X-Google-Smtp-Source: AFSGD/WTNXkuYAMq/7Nrg4kTNJDcvfBWz3yl4p6LZ/G4vQZEFNdEy8nH5TEruGrEImsWgoSzrCdV1/VQ74UxrlWOKAU=
X-Received: by 2002:a6b:4001:: with SMTP id k1mr6796923ioa.34.1543617801922;
 Fri, 30 Nov 2018 14:43:21 -0800 (PST)
MIME-Version: 1.0
References: <20181124022035.17519-1-deepa.kernel@gmail.com>
 <20181124022035.17519-8-deepa.kernel@gmail.com> <CAF=yD-K=ZLZ_S=Y6YnhvvkfKQS=21ujwiGd7+JB9yDMtiX_9hg@mail.gmail.com>
 <CAF=yD-K3Ga8qojSh5Epa6m4EYn-Lvdo=e38MnFqOKch1128VHw@mail.gmail.com>
 <CABeXuvoDPvT45CCt2L0TReqtb1Q_-E8+toYu6qjiP0cxfdQNdA@mail.gmail.com> <CAF=yD-LngkYq23Q2TCJv_0PRiAryznYRWRbqYFaQkNO=U0w9gQ@mail.gmail.com>
In-Reply-To: <CAF=yD-LngkYq23Q2TCJv_0PRiAryznYRWRbqYFaQkNO=U0w9gQ@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Fri, 30 Nov 2018 14:43:10 -0800
Message-ID: <CABeXuvp5OaVetzJJf2L5ZE1BP_KOO2FvvG8EWn5t29eCe-=dtg@mail.gmail.com>
Subject: Re: [PATCH 7/8] socket: Add SO_TIMESTAMP[NS]_NEW
To:     willemdebruijn.kernel@gmail.com
Cc:     "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Network Devel Mailing List <netdev@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Ralf Baechle <ralf@linux-mips.org>, rth@twiddle.net,
        linux-alpha@vger.kernel.org,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-rdma@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 6:33 AM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Sun, Nov 25, 2018 at 12:28 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> >
> > > > > +       if (type == SO_TIMESTAMP_NEW || type == SO_TIMESTAMPNS_NEW)
> > > > > +               sock_set_flag(sk, SOCK_TSTAMP_NEW);
> > > > > +       else
> > > > > +               sock_reset_flag(sk, SOCK_TSTAMP_NEW);
> > > > > +
> > > >
> > > > if adding a boolean whether the socket uses new or old-style
> > > > timestamps, perhaps fail hard if a process tries to set a new-style
> > > > option while an old-style is already set and vice versa. Also include
> > > > SO_TIMESTAMPING_NEW as it toggles the same option.
> >
> > I do not think this is a problem.
> > Consider this example, if there is a user application with updated
> > socket timestamps is linking into a library that is yet to be updated.
>
> Also consider applications that do not use libraries.

Arnd and I talked about this.
We thought that the new options should behave like the already
existing options. The patch already does this.
Eg: Today if we set SO_TIMESTAMP and then try to switch to
SO_TIMESTAMPNS then there is no fail.

Do you still want a hard fail?

-Deepa
