Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FB4C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A93120834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxNT4eYk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A93120834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbeLAKtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 05:49:11 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33437 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeLAKtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 05:49:10 -0500
Received: by mail-ed1-f65.google.com with SMTP id r27so6201151eda.0;
        Fri, 30 Nov 2018 15:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GuFX6rglq4ceWhwuWwI+isGe1TSvsKi3G75Rbi60msc=;
        b=YxNT4eYkITtVsxh4F0OWbbHq5KEcCLIhMUgmw1ngdpZQxqJSrM+GI3ueWv4XXQcSKZ
         m+6BCHhU3saepBlEUajsn17QAvwbN9XgrIkpPiB44mPw/1sltL3nPYsroc5gOCy9JIE1
         +YU+PzVl/7SOCUZ4TfU5cXGKZs0jo/GZVk23Z8Grj0rAB5daq2hx2rd1omuh2AmrNDUS
         JQtBmNNV/0mMEsQxFOZ3PMl7PQ9MVzVJMq7pCYi9npuOVwGQVB1WUeAUwcE85m/r5zzj
         WM1IYbSZ5Z9Ar6y1PdKgv3mTL/nsVgvzE9Kh80xZMAzEFvtk6ADySFWe/Lmwlvji71Co
         j0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GuFX6rglq4ceWhwuWwI+isGe1TSvsKi3G75Rbi60msc=;
        b=WYK0QKzXWzZl8cdcvTEk3pQfnOuOdIsNDEwCcS8iIr0kqlwzHJ1zOQhuCcrZFwInEl
         QeVgNCWIZW1Vux5kKiu0h0LkaK4ZREIm7JKmX9NAe2sQE7YK3W/hRcCkqVOPWfUrFSY1
         1mK7jv3u6kIdhMnW9uSArAFRk4HQgY6E4DwfuMFRlrdCPXyzPQh9ANbl8iKVnDM41k3L
         70DwiseAn57KTZ3gfoO35eP4fXuRWXj2zK0sT/0b+q//9dzetf1/2XCTPNFCv9nrQreF
         PDv0RkWHKrIbBNixVpK2+Aw7DbXbRRm/f1x00Dq+q7KxcZwbNW2AkaOtSlPRS0EVDopo
         wnLQ==
X-Gm-Message-State: AA+aEWbQBYgv2aLZr7/fZi4mgigHdPjR3Lh66j0ISoLg1D+SeGlJ0LfX
        OEVw8oNnO5D6GRMEcYzxXd86MkbjAb/x0MWPRHQ=
X-Google-Smtp-Source: AFSGD/XRqeRqY6ArZRU/0d+CNiwMLxKrL1xBkQkryo1D4X/k4rQnWt8o1h8CvEyZecqNO+jhqpmwhMap2aP8eYszq40=
X-Received: by 2002:a17:906:860a:: with SMTP id o10-v6mr5892177ejx.1.1543621090554;
 Fri, 30 Nov 2018 15:38:10 -0800 (PST)
MIME-Version: 1.0
References: <20181124022035.17519-1-deepa.kernel@gmail.com>
 <20181124022035.17519-8-deepa.kernel@gmail.com> <CAF=yD-K=ZLZ_S=Y6YnhvvkfKQS=21ujwiGd7+JB9yDMtiX_9hg@mail.gmail.com>
 <CAF=yD-K3Ga8qojSh5Epa6m4EYn-Lvdo=e38MnFqOKch1128VHw@mail.gmail.com>
 <CABeXuvoDPvT45CCt2L0TReqtb1Q_-E8+toYu6qjiP0cxfdQNdA@mail.gmail.com>
 <CAF=yD-LngkYq23Q2TCJv_0PRiAryznYRWRbqYFaQkNO=U0w9gQ@mail.gmail.com> <CABeXuvp5OaVetzJJf2L5ZE1BP_KOO2FvvG8EWn5t29eCe-=dtg@mail.gmail.com>
In-Reply-To: <CABeXuvp5OaVetzJJf2L5ZE1BP_KOO2FvvG8EWn5t29eCe-=dtg@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 30 Nov 2018 18:37:34 -0500
Message-ID: <CAF=yD-J=yTunQr279x8qb5B0xdAcdmcBj6utyM1gE8QfgorQPw@mail.gmail.com>
Subject: Re: [PATCH 7/8] socket: Add SO_TIMESTAMP[NS]_NEW
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        jejb@parisc-linux.org, ralf@linux-mips.org, rth@twiddle.net,
        linux-alpha@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-rdma@vger.kernel.org,
        sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 5:43 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> On Sun, Nov 25, 2018 at 6:33 AM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > On Sun, Nov 25, 2018 at 12:28 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> > >
> > > > > > +       if (type == SO_TIMESTAMP_NEW || type == SO_TIMESTAMPNS_NEW)
> > > > > > +               sock_set_flag(sk, SOCK_TSTAMP_NEW);
> > > > > > +       else
> > > > > > +               sock_reset_flag(sk, SOCK_TSTAMP_NEW);
> > > > > > +
> > > > >
> > > > > if adding a boolean whether the socket uses new or old-style
> > > > > timestamps, perhaps fail hard if a process tries to set a new-style
> > > > > option while an old-style is already set and vice versa. Also include
> > > > > SO_TIMESTAMPING_NEW as it toggles the same option.
> > >
> > > I do not think this is a problem.
> > > Consider this example, if there is a user application with updated
> > > socket timestamps is linking into a library that is yet to be updated.
> >
> > Also consider applications that do not use libraries.
>
> Arnd and I talked about this.
> We thought that the new options should behave like the already
> existing options. The patch already does this.
> Eg: Today if we set SO_TIMESTAMP and then try to switch to
> SO_TIMESTAMPNS then there is no fail.

> Do you still want a hard fail?

I do think that it is preferable. In general, and in this specific case.

We have had had many bug reports from syzkaller where the fuzzer
manages to trigger unexpected behavior by combining two APIs
that were never intended to be used together.

However inane the combination may be, once an API is published,
we cannot simply add an EINVAL and stop supporting it. So it is safer
to explicitly block unsafe combinations from the start. If there is a
legitimate use it is always possible to loosen that restriction later.

I don't see any sensible use for mixing both the old and the new
interface on the same socket.

That said, just a suggestion.
