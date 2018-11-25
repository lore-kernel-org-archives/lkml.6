Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C56DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 14:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD30B2084E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 14:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVpQL0cj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD30B2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbeKZBKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 20:10:44 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45409 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbeKZBKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 20:10:44 -0500
Received: by mail-ed1-f68.google.com with SMTP id d39so13636283edb.12;
        Sun, 25 Nov 2018 06:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z1CHFj7OL4Qufr45zlPa/6hi2tsIgOhmP+pDCYzTk2Q=;
        b=jVpQL0cjblZ9R50DNTqw1eTx7RBngU2jx5GT1djg2dcqA6jFjR2alSbdZPqdna7iaT
         kVJmyr+q5t9L8rRPPUE5lJlkALcKxeHdFNfzjrgMbZxAz1tfbHUiEOUuDByhFGnOHjyg
         DkZRqAfPEQMNhVVc1LIyYm9ibdQJvDQ1FS0GEn+lGc10riAIDDDR+Ygs3FQz1UQvJFmD
         FRdk9ReBd6q9pBYvsd+YoEhvhdsTdR8dDHBoKpEg1ubggFbto3pMxQ/kij0jEMn0+Qx+
         h+TRLiTkJSac4uyOUi3ziMj7ZmATSFzJeGpijvlKfiWWzgzZoE60KzSlZPSyQv3qaxdE
         q5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z1CHFj7OL4Qufr45zlPa/6hi2tsIgOhmP+pDCYzTk2Q=;
        b=LE5bAkNAtSuB7KXq3ACJnEJah9Fbuuy86DGnVdF4IBEnjOD5uUKmHGpWd23BX7IaIL
         gVOwmPdo0EIV4PxMphJVwH6Sa7IudtjbpcPCXPD/yFZ2faNLdTBhZZbSz7Ld6mDWxzbJ
         SoFeGllVhBSHPPSuSWxWusQzg1hhocIRV5k7R3W4FE5fWqg8IreC4Fc2L01IcKWC1Uj4
         Xrk8rodXWBibYXmuX/ildF07gNv9wUr21VHakZEsmEhXy0qgT2hqFkjrHtczuOTM0q4i
         7VGWCjQxR7UyUFrB80TBCJxJntKPJMwAf+QwUL7w4yKuJXQX2hU8mB7YUQY19NDstZXR
         2vpQ==
X-Gm-Message-State: AGRZ1gIoJjG/kxJxac0Tk2rxoMC1+IpK8OyZcUJ2VXitkYvtmGR/DsAU
        k8/CXYynuyykdzCKvA6yg8kRQnfouE/PRLKmd08=
X-Google-Smtp-Source: AJdET5dJbPLWhKFoNxSVrAEX+O+7tYoZhonKTCICSrgj/O2bJxUhKeU7wnKb5zDpRKI8/0gQLwnhsbrZWwxDtv8c8Vc=
X-Received: by 2002:a17:906:a455:: with SMTP id cb21-v6mr17348680ejb.185.1543155572047;
 Sun, 25 Nov 2018 06:19:32 -0800 (PST)
MIME-Version: 1.0
References: <20181124022035.17519-1-deepa.kernel@gmail.com>
 <20181124022035.17519-4-deepa.kernel@gmail.com> <CAF=yD-JGh23sA_6eUtBq8=wSZ5g=nipmhdr1WwjP5th51qEtiQ@mail.gmail.com>
 <CABeXuvqgPE_Cft+T0fSw8zT09uCKWQGUB+bVNqQDk6fOinn8rA@mail.gmail.com>
In-Reply-To: <CABeXuvqgPE_Cft+T0fSw8zT09uCKWQGUB+bVNqQDk6fOinn8rA@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sun, 25 Nov 2018 09:18:55 -0500
Message-ID: <CAF=yD-LjfVKSr=KhknZHhN-M2-ZdLE9g0XR8Ta4rokx24arkBg@mail.gmail.com>
Subject: Re: [PATCH 3/8] socket: Disentangle SOCK_RCVTSTAMPNS from SOCK_RCVTSTAMP
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 12:06 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> On Sat, Nov 24, 2018 at 7:59 PM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > On Sat, Nov 24, 2018 at 3:59 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> > >
> > > SOCK_RCVTSTAMPNS is never set alone. SOCK_RCVTSTAMP
> > > is always set along with SOCK_RCVTSTAMPNS. This leads to
> > > checking for two flag states whenever we need to check for
> > > SOCK_RCVTSTAMPS.
> > >
> > > Also SOCK_RCVTSTAMPS was the only flag that needed to be
> > > checked in order to verify if either of the two flags are
> > > set. But, the two features are not actually dependent on
> > > each other. This artificial dependency creates more
> > > confusion.
> >
> > This is done so that the hot path only has to check one flag
> > in the common case where no timestamp is requested.
>
> In that case we could just check it this way:
>
> if (newsk->sk_flags & SK_FLAGS_TIMESTAMP)
>
> We are already doing this in many places.
>
> I do not see any other reason for the two timestamps to be intertwined.
>
> Do you have any objections to using this patch and replacing the
> checks as above?

The existing logic is as is for a reason. There is no need to change
it to satisfy the main purpose of your patchset?

It is structured as one bit to test whether a timestamp is requested
and another to select among two variants usec/nsec. Just add another
layer of branching between new/old in cases where this distinction is
needed.

Please avoid code churn unless needed.
