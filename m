Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0E5C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE8A21567
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EBus8tRn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE8A21567
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbeHXQlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 12:41:50 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:40359 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbeHXQlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 12:41:50 -0400
Received: by mail-yb0-f196.google.com with SMTP id f4-v6so3444361ybp.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 06:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tAkxiQVhB/4oXk51I1meUDbL60OAuk736CDQik6Ywqo=;
        b=EBus8tRnG+EzJxSk8Yv/gm1oCSB2X0UJkzN/2/sAlODqHFxgP5D9B5ju97oipHc/1a
         dKFgbBXNgA5rnfvo1x7bZTaWtUj9HSuS/YLIe4Y7sijH051Mf5BX51DeXS2757EHHwnW
         tE4yFuU6Dt1QyYO2/rS1zJMfOGpmm3W2m/lLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tAkxiQVhB/4oXk51I1meUDbL60OAuk736CDQik6Ywqo=;
        b=BZCKze45Vw2DfcrhmgNlAWl/sodeTuCGiRkHK3OsBzvLNJTHFHXMtmxwyiJenW62US
         qwWT0vnX6JWKgZ2mwNPzS1zZ1QKl9gS4xOKYqMYVROZEX3vNH+yskrDwfJmrUnNT6NVF
         endiY4752aFX0zP9ZNmwQDfc0z5YEMJ0JuvFdUTK87Om6smWh223+LZeb2hOPXtUPwAP
         KVZfuETHbYKcHhlcIeA+3eZPeOqdpQpSN156TLcQQa7Tm7lT6PWbur6YmaB7ZK3O9j3d
         1+pz04xbLREruPxoUUP1db4lOmgAB6kqXmizdeLn/jW0hBHBG23zkTko10Jqjx4ojfpu
         HVag==
X-Gm-Message-State: APzg51AK19evMMi9eF1k7Xjnc4QOvldgTdKSBeid00wXLn++k3QEk91y
        bBdBSQpnQUmIT1ey5RhhyKqiBeUu6Vo2V96F0E0BPA==
X-Google-Smtp-Source: ANB0Vdb6niu9QO+OcHKN6lT5j0TU9xeKFbbjmqy9OjlGvFAAI3Qlm/a04JNoCmiWGAZfqzILy9MCHZ13U1uHZZojfxk=
X-Received: by 2002:a25:ad01:: with SMTP id y1-v6mr881436ybi.195.1535116034837;
 Fri, 24 Aug 2018 06:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180704095318.19218-1-anders.roxell@linaro.org> <CAMuHMdWCyH-E9VA7ihsoXEq4dvLrPjYd01TYot6qja-psVRcog@mail.gmail.com>
In-Reply-To: <CAMuHMdWCyH-E9VA7ihsoXEq4dvLrPjYd01TYot6qja-psVRcog@mail.gmail.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Fri, 24 Aug 2018 15:07:03 +0200
Message-ID: <CADYN=9KH134zWogYt=FMMTgsYm6GEqBUY6=C453yj_NY=oq1hg@mail.gmail.com>
Subject: Re: [PATCH] fs/ocfs2/dlmglue: lockdep_keys defined but not used
To:     geert@linux-m68k.org
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        ocfs2-devel@oss.oracle.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Aug 2018 at 23:07, Geert Uytterhoeven <geert@linux-m68k.org> wro=
te:
>
> Hi Anders,
>
> On Wed, Jul 4, 2018 at 11:54 AM Anders Roxell <anders.roxell@linaro.org> =
wrote:
> > When CONFIG_DEBUG_LOCK_ALLOC isn't enabled lockdep_keys isn't used and
> > we get a warning:
> > fs/ocfs2/dlmglue.c:99:30: warning: =E2=80=98lockdep_keys=E2=80=99 defin=
ed but not used
> >     [-Wunused-variable]
> >  static struct lock_class_key lockdep_keys[OCFS2_NUM_LOCK_TYPES];
> >                               ^~~~~~~~~~~~
> > Adding __maybe_unused to the declaration hids the warning.
>
> Thanks for your patcj!
>
> > Fixes: 1cd75cdb8fbb ("ocfs2: make several functions and variables stati=
c (and some const)")
>
> Fixes: 480bd56485b77c36 ("ocfs2: make several functions and variables
> static (and some const)")

Thanks, thats correct.

>
> Presumably the branch got rebased?

probably.

Mark, Joel, do you want me to send a new patch where I correct the sha
in the "Fixes" part of the changelog or can you fix that?

Cheers,
Anders

>
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
