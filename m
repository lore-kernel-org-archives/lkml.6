Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEF7C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70800217FA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmWwVFmg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388673AbfBKURv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:17:51 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:40539 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729457AbfBKURt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 15:17:49 -0500
Received: by mail-yw1-f65.google.com with SMTP id c67so79398ywa.7;
        Mon, 11 Feb 2019 12:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YPf184+zrdt4QtTJ4m/wSSLQM/wvd6gNxP/hOiuCrD4=;
        b=XmWwVFmgbUuKt0NERdkZ1wN/pHx6POzXHHLU2OmharbpiUTBMPWfBfOPG+4uXj7bNE
         NI4EtUAtINrXHOr54IcZ4G+0IIlUpfly8YnkmZVG1uhpDFIrWbSH/OZz7Hif49n4X6al
         bRepu0GiGYZJUyErzy+mcSPoVMmot5jbjt9uqkTOqeIpUGPlLJ1He36Fb/cpPSpS6wFP
         kiyfB15hcdi8LVJmKeuve/QLathLLi5B9J1lSJ3NSn6rwpQH8bhqIoJoXySa8IyL/coQ
         r2/L4Q0wSPedhpg5RwtqMryFxcIvvTAIrDGxmgZ4IrzHKukDUYcuyw+tOEgIQr3AnYGP
         KAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YPf184+zrdt4QtTJ4m/wSSLQM/wvd6gNxP/hOiuCrD4=;
        b=f5ZnzqBZjSuCFVsNBmd2iSaoj0cozkS9giQFgVxVSKBMPT6hGSj4l9/MY09opfnKxg
         85fDNJhnljW4a1pb2Kh1DDaVQZwoJDDmRz7kWUTUBju8ecxryMRQ9/Fzdwn8C0kvRY41
         sHt8IIUEvg23S6fsPFEFnxGlzOE/SHjVnXlRnpSTt+LUzTstv9dPNjWAMSKawKlQcAju
         sNY2u9mtHJTI43Ejz5sCzgjk78+lC0UzN45OQEfUa2CMztAWiD/tEzbp0hz2E2lx7IBd
         T8xaV9UsO/3EvOgtrRHMXIuoR+df+YKwJqs1Q1tpv0EtroaWs7hcUZpPre9ES/Sl+hJE
         yLxQ==
X-Gm-Message-State: AHQUAub6z+Y1HeFyTu6xM5yN5B1JxMg03yRj8yD53ic/oud18NJHalWt
        E3fAmSxXccURIFAsXDQo1vDUZAjEbP2+zklrUPQ=
X-Google-Smtp-Source: AHgI3Ia7b/QxGc6lItic+npPZsO3Er9mdYQunM5nkPX8WrmcnRRyWch4c/zuPwylfgWxKwsm36gIiD4CKwRiVhjs5+Q=
X-Received: by 2002:a81:4f14:: with SMTP id d20mr39516ywb.16.1549916268570;
 Mon, 11 Feb 2019 12:17:48 -0800 (PST)
MIME-Version: 1.0
References: <1549653856-47409-1-git-send-email-justinpopo6@gmail.com>
 <20190209170042.69a78684@archlinux> <2e692086-4be5-10ea-34b0-4444995c4275@lechnology.com>
 <20190211200557.7648d447@archlinux>
In-Reply-To: <20190211200557.7648d447@archlinux>
From:   Justin Chen <justinpopo6@gmail.com>
Date:   Mon, 11 Feb 2019 12:17:37 -0800
Message-ID: <CAJx26kXdap3oSBREDfakwaWMz4oKxy=oaagP1jo4grD=kqJ2hA@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ti-ads7950: add GPIO support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     David Lechner <david@lechnology.com>, linux-iio@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bgolaszewski@baylibre.com,
        Linus Walleij <linus.walleij@linaro.org>, knaack.h@gmx.de,
        lars@metafoo.de, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 12:06 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sat, 9 Feb 2019 12:56:11 -0600
> David Lechner <david@lechnology.com> wrote:
>
> > On 2/9/19 11:00 AM, Jonathan Cameron wrote:
> > > Nope.  This is a state lock used to protect against transitions between
> > > different modes of the IIO device (buffered vs polled), it
> > > isn't suitable for general use.
> > >
> > > The driver should be modified to handle that correctly.
> > > We have iio_claim_direct_mode etc that deal with the case
> > > where a device can't do certain operations whilst in buffered
> > > mode.  Note it can fail and should.
> > >
> > > Seems there are more drivers still doing this than I thought.
> > > If anyone is bored and wants to clean them out, that would be
> > > most appreciated!
> > >
> > > If you need locking to protect a local buffer or the device
> > > state, define a new lock to do it with clearly documented
> > > scope.
> >
> > Just as a reminder, there is a use case for this particular
> > chip that requires buffered mode and direct mode at the same
> > time.
> >
> > https://patchwork.kernel.org/patch/10539021/
> > https://patchwork.kernel.org/patch/10527757/
>
> Thanks, I had indeed forgotten that entirely.
> So it should have a local lock and not take mlock explicitly at all.
>
Thanks for all the feedback.
So If I am understanding this correctly. I should create a local lock
to synchronize three different type of transactions (buffered, direct,
gpio).
I do not want to use iio_claim_direct_mode because that doesn't allow
simultaneous use of buffered mode and direct mode, which is necessary
for this driver because of the above mentioned patch.

Justin
> Jonathan
