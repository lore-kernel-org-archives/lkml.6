Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB590C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 04:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84FCE20850
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 04:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9lNZrwj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84FCE20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbeKYPmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 10:42:32 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39901 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbeKYPmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 10:42:32 -0500
Received: by mail-it1-f195.google.com with SMTP id m15so22833733itl.4;
        Sat, 24 Nov 2018 20:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h8TDJAeY4s5QrmXO/T6BUEmza430F8/8GrmGmRZ73hM=;
        b=T9lNZrwji1Uhj1dRrLk568BgCeYDWg87O+mPb14QIGVKEZCkN3GPc1b9tpkmq6MWkj
         uhfscgCWN2wPJBjFzVgTn3b+dN4egyMbhuxuGvPD/xteN79Ln0pflZbvoJB9H0DCuU+e
         /5EYVtOhzXgUgv9U6YAn0CmJdVVdRJ6BrrhwJMp8eYhu3lHmuDjV7nbzNpVJxielR9nD
         H9v7IFAitVWJyRDrFgVcOEPDpygODAQdIz/CdKAWnkrdnV6sBUR0l2Ksa+8dfn1QUN1M
         HA43lEuowBddqaaftI/RM+a7b98+3tIYC0XM96AiI9+7eoVgVhdddF+rdGIWNUKfPC8c
         zWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h8TDJAeY4s5QrmXO/T6BUEmza430F8/8GrmGmRZ73hM=;
        b=APwrHDb+PZZ0zeZrLLQkCiMJkklcVKYEXU2JRyR6lQBMgjZdbRUtexl2c6Bq1SLj+i
         1khmjxi2UY7enn8PjIi9PeZlqP5rBb/Knvnoab39QFEuk27JWta4W2i+jYQjl4xs/tyT
         biYQN1sb06Fy2p+EjhYJxWbmH2PVZNVXT3/6YUIWl99jemuU3Rh+vksB19TewnTJJ/3x
         L8PhKZ6lEqJDIJewyAhmfFAf7zQiyhENKDHkosyDWcXmvuEc7GyDb+6/SGVf9H2ketzH
         QAuSRwdYnirKX5JClk0Ak5aQxTH/5jJgh0yMm0H9lw73XMKA6MgUFr6hJ9wGqqoSJamC
         InOQ==
X-Gm-Message-State: AA+aEWZ696A7nB0sXjjoc4oF2j+zuo4u/fsOveovG70iW0h+HFpuqQxV
        cwcK+GNwHK5AwQUaJ0jeRzKelMXXZFUlEF3sTG8=
X-Google-Smtp-Source: AFSGD/UgFJMXZiuV3CaIec/4PE42KqCLPJ8Z9aouhJDiq2pRm+Zwib5jtLxxuIyTF5ePL9sLu5L97W/Gjfm7k7iHBQA=
X-Received: by 2002:a24:1c86:: with SMTP id c128mr6938575itc.58.1543121539467;
 Sat, 24 Nov 2018 20:52:19 -0800 (PST)
MIME-Version: 1.0
References: <20181124022035.17519-1-deepa.kernel@gmail.com>
 <20181124022035.17519-7-deepa.kernel@gmail.com> <CAF=yD-+1BJHuajcW=2bpeAp5XOAX2fObyvhOdH-YsiGY3-_J4Q@mail.gmail.com>
In-Reply-To: <CAF=yD-+1BJHuajcW=2bpeAp5XOAX2fObyvhOdH-YsiGY3-_J4Q@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Sat, 24 Nov 2018 20:52:08 -0800
Message-ID: <CABeXuvrV+xN3O8BSmJ7bGR+8uYmtrCk2YL37HQZrBSO8YSvzJQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] socket: Add struct sock_timeval
To:     willemdebruijn.kernel@gmail.com
Cc:     "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Network Devel Mailing List <netdev@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 11:38 AM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Sat, Nov 24, 2018 at 4:00 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> >
> > The new type is meant to be used as a y2038 safe structure
> > to be used as part of cmsg data.
> > Presently the SO_TIMESTAMP socket option uses struct timeval
> > for timestamps. This is not y2038 safe.
> > Subsequent patches in the series add new y2038 safe socket
> > option to be used in the place of SO_TIMESTAMP_OLD.
> > struct sock_timeval will be used as the timestamp format
> > at that time.
> >
> > struct sock_timeval also maintains the same layout across
> > 32 bit and 64 bit ABIs.
> >
> > Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> > ---
> >  include/uapi/linux/time.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/include/uapi/linux/time.h b/include/uapi/linux/time.h
> > index 04d5587f30d3..106f9398c285 100644
> > --- a/include/uapi/linux/time.h
> > +++ b/include/uapi/linux/time.h
> > @@ -70,6 +70,11 @@ struct __kernel_old_timeval {
> >  };
> >  #endif
> >
> > +struct sock_timeval {
> > +       long long tv_sec;
> > +       long long tv_usec;
>
> should these use fixed-width type __u64?

We have avoided using __u64/__s64 types for time types in uapi.
I think we did this for portability reasons.
Although this new type might not be required to be interpreted in
libc, I would prefer for this to be long long.
If there is a strong preference then I can change it.

-Deepa
