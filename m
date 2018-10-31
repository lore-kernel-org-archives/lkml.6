Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47F2ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97548205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxOBmg1r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97548205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbeJaXYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 19:24:11 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40942 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729492AbeJaXYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 19:24:11 -0400
Received: by mail-qk1-f196.google.com with SMTP id f18-v6so9712247qkm.7;
        Wed, 31 Oct 2018 07:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nP7Djv6v9shpmQaYTxM+upkt37Jfp8TUxQtY6zVOVog=;
        b=VxOBmg1rqWXqKEBbu21qj/VubWUGGzSuSwgtCxnVnUA64xGtjGrqOmUmpfbLcwbaLI
         NrDB7LQLzXt4xsoq4Swf8XJBWRLkyNNKAX0xnk6xNrxaT+s19DNSnMVbDwNZni/T/d3C
         0FbY7Up8QKrs2qvYdum1L9/TwZhIyAH1DTjzNndGj2QfCB8BbUh3fvPQ1Uy4VvodFZQr
         Gv5Sl1C9VB34iMcvQXFHJt/92A6HK46DlaQCZD9t+hhrrKFr7JpJ4LhBBiXvRmEhdlNH
         VqtA+SYgcFUWNKVBVMRLrEjQF1OFDSW6mcDG75QOqPsJT8aeV79wJE4I7PxIbdTHzaL8
         Tt4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nP7Djv6v9shpmQaYTxM+upkt37Jfp8TUxQtY6zVOVog=;
        b=MJD14WUb2Y2lh9ECuLYAc2+MEd7fCnlg98/QvFLZ7DRQfHgwvvjvW6+5Vxn/GyrSEo
         Nuk8TxtfdNzWWpEneGAj6//v0Hx2jPDCeAi5xTmEUEuUakwtm1lAwOu4/dw/X2ud/vc5
         LtAr/X/0hYJDDj7ISignMWVw+Hxak2A7MCn9BWwJtaiP9m+/oTeNns2R6ljFQ8hrsTbD
         GVuP2DHW7F05CdLIGaG6d+8KmGGSeSywXc2ffC8cUkT/Zu5RN7Ilu1PFG9+LwhRjMJli
         AtrrqigNI7yPVoVXaL4ZhIvDA785NNOfE1Ovu55Red+HP+BlS94prZ1rgAlKP1eyGf7d
         0kRQ==
X-Gm-Message-State: AGRZ1gJVrkq2DFmgBDTNDIzh2ohpSW0i4D2gQzdQb84jPXMIwvZEfbCQ
        OpsUp1s5adcecWGB+4zJgOwDhImxSWzuz4Dy6o0=
X-Google-Smtp-Source: AJdET5fV0+HVwkP/qUQRmBR4ru+ARC/XQ0wFKMwQRwY3gWysR87Uw7zKnTxPP/Je6IBwf8HNHGo2t+R1OdBoNQwNdS8=
X-Received: by 2002:ac8:2c49:: with SMTP id e9-v6mr2879568qta.17.1540995955282;
 Wed, 31 Oct 2018 07:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <20181024134040.115413-1-smuchun@gmail.com> <CACRpkdbht0wn=Vy4-M-sgEbsiY-S8u3eP0s_DM+j+6vWvZG5cQ@mail.gmail.com>
In-Reply-To: <CACRpkdbht0wn=Vy4-M-sgEbsiY-S8u3eP0s_DM+j+6vWvZG5cQ@mail.gmail.com>
From:   Muchun Song <smuchun@gmail.com>
Date:   Wed, 31 Oct 2018 22:25:46 +0800
Message-ID: <CAPSr9jEW_+9BSFRLbqMVO=m4+AMih4cHm_AS241TjfvGcMFKAA@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: fix possible use after free on label
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Thanks for your review.

Linus Walleij <linus.walleij@linaro.org> =E4=BA=8E2018=E5=B9=B410=E6=9C=883=
1=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=886:32=E5=86=99=E9=81=93=EF=BC=
=9A
>
> Hi Muchun,
>
> thanks for your patch!
>
> On Wed, Oct 24, 2018 at 3:41 PM Muchun Song <smuchun@gmail.com> wrote:
>
> > gpiod_request_commit() copies the pointer to the label
> > passed as an argument only to be used later. But there's a
> > chance the caller could immediately free the passed string
> > (e.g., local variable). This could trigger a use after free
> > when we use gpio label(e.g., gpiochip_unlock_as_irq(),
> > gpiochip_is_requested()).
> >
> > To be on the safe side: duplicate the string with
> > kstrdup_const() so that if an unaware user passes an address
> > to a stack-allocated buffer, we won't get the arbitrary label.
> >
> > Signed-off-by: Muchun Song <smuchun@gmail.com>
>
> I am a bit worried about the memory consumption for this,
> but I guess typically this should not be much.

Yeah, I think so. In most cases, we pass the label, which is
in .rodata section.

>
> I am a little bit lost in const-correctness here, and I do
> understand that the label could point to something allocated on
> the stack, but it seems like an awkward way of shooting
> oneself in the foot really. Allocate something and then
> pass it as a const char *? That is something we could pretty
> much detect with a cocinelle script I think?

Some user may have more than one gpio to request
and may program the following code to request one gpio=EF=BC=9A

int gpio_request_one(int gpio)
{
        char name[8];

        snprintf(name, sizeof(name), "GPIO_%d", gpio);

        return gpio_request(gpio, name);
}

In this case, it could trigger a use after free when we use gpio label.
But the user may not realize it. With this patch applied, we can get
the right label.

>
> Anyways: if you want to proceed with this approach, also
> make sure to fix gpiod_set_consumer_name() to free previous
> label and make a new strdup when called.
>
> Yours,
> Linus Walleij

Sorry, I forgot to fix gpiod_set_consumer_name().
I will send you a patch of v2 later. Thanks.

Yours,
Muchun Song
