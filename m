Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C821AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916E22186A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZtcxbkeS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbfBZWcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 17:32:36 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34722 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbfBZWcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 17:32:36 -0500
Received: by mail-pf1-f193.google.com with SMTP id u9so6937630pfn.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 14:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Syx8ZkNs6xbsqFqTcYYoT2xEMErvYw1Uy1r0qmWNWd4=;
        b=ZtcxbkeSYtP27F/OOI0Pu+kjr63YzODu9uoJl3hFPFbF3VvFzLY5zJabn4WrfiuacV
         uKW5KEZsPiaWKuFQRu0aF+2OtKFucTN/1Tbd0MjjZDpLojkebfGiZTCCUMg6iXf1GDVl
         vAcGsKFhSHofZdoUsPSHXmdFSddQU2i05OcCVV9NwNGUI2vLaibQra6ikQwh/VKazRNN
         qIEBEA16ltUQLNc9zl392e4M16j4o6fYNXoYjpj7PMQMsn04hvl4NhM1F4S6Jz1v3AEq
         sJ8C4VhdFuXroGu+fp5MDKMqGT7wHnIgOZX2Fa8cnUFMxqvYf8IK6HIhAHZ/RCGYTaVn
         M/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Syx8ZkNs6xbsqFqTcYYoT2xEMErvYw1Uy1r0qmWNWd4=;
        b=bL626OjmmPo8jbB84z+nEcuJZR4+1i27zox31RyQsNYXqJclYSHxbFR6cryQKI2ctr
         lxX9Jmyh06doGrS8WaSfAaO1KNu4XQ5sBxUXg/q0ofVtD0Ie/ayNbWvSP1VOAvrFI9Rm
         IQ+sV+2UOahMNax+U9jtdxdYuMkW2zga+rd0IRu4luXej6Px+X1smHLz3PMK7+0qtbak
         CFssnAW5aHullJUeiL3Uf9PEpmKHOvX7MPsnL/EtQNauO1HxU82rgMhi8mnS28TM+ImC
         pCzWrfqByB7fL/4Mx6JMMM8BYhRxNjfQ55KyHxyxXKkPi6zRwU0a85gOk5oYERUoaYT3
         1oWQ==
X-Gm-Message-State: AHQUAuYidqBCoUcSBAcXg8wa2bHJGsF9W8o0ecZhcOE6b15z1d7wDYic
        hak56CzMXa0H2yNyOBBF14LH8WCTuU/+WucL8On17Q==
X-Google-Smtp-Source: AHgI3IbKi9AkmGDsGP2NQpNGQ/bfU2eNowpnC4gnQGIRYLj+rGrVReHQEyzTuCo1LynV5tgaPg4gkjH/G6QVNNoF6ds=
X-Received: by 2002:a65:43cc:: with SMTP id n12mr25610546pgp.218.1551220355672;
 Tue, 26 Feb 2019 14:32:35 -0800 (PST)
MIME-Version: 1.0
References: <20190221222537.137331-1-venture@google.com> <692c6c5d-9090-4e1f-9324-a03da381b003@www.fastmail.com>
 <CAO=notx+p5PQ1UXW7XKD=5Lb23RvC5+1R+LcJLxXYEnT6vvgkQ@mail.gmail.com>
 <CAO=notx1OTWbxg5EhgqDUcrpfBpgez3LXXrNKHX5VpOark3GvA@mail.gmail.com> <578fe6cd-cc7c-4f6d-8f7e-39c9f183a8e4@www.fastmail.com>
In-Reply-To: <578fe6cd-cc7c-4f6d-8f7e-39c9f183a8e4@www.fastmail.com>
From:   Patrick Venture <venture@google.com>
Date:   Tue, 26 Feb 2019 14:32:24 -0800
Message-ID: <CAO=notzjZQYeNo8nFmDfj+cw=hAMEmQ7GX-5ccY5786rMC_NEA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers/misc: Add Aspeed P2A control driver
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 2:20 PM Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Wed, 27 Feb 2019, at 08:26, Patrick Venture wrote:
> > On Tue, Feb 26, 2019 at 1:42 PM Patrick Venture <venture@google.com> wrote:
> > >
> > > On Sun, Feb 24, 2019 at 5:26 PM Andrew Jeffery <andrew@aj.id.au> wrote:
> > > >
> > >
> > > >
> > > > > +
> > > > > +     /* Access to these needs to be locked, held via probe, mapping ioctl,
> > > > > +      * and release, remove.
> > > > > +      */
> > > > > +     struct mutex tracking;
> > > > > +     u32 readers;
> > > > > +     u32 readerwriters[P2A_REGION_COUNT];
> > > >
> > > > Might be better to use refcount_t here instead of u32?
> > >
> > > Ack
> >
> > refcount requires atomic, is that something we have with the ast2400, 2500?
>
> Ah, we do on the 2500 (armv6) but not the 2400 (armv5)

Ok, so to avoid that complexity I'm not going to swap in refcounts.
but good to know for future reference since it's basically what I was
doing manually.
