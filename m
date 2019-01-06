Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0187C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 03:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 743B521908
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 03:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r6MiI5pD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfAFDlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 22:41:49 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36304 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfAFDlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 22:41:49 -0500
Received: by mail-qk1-f194.google.com with SMTP id o125so23686191qkf.3;
        Sat, 05 Jan 2019 19:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7Rp6xI0oKFg6daamgdbuDkAiEfxiZjd/hpGcAjCvFK8=;
        b=r6MiI5pDjDsf9a9CjNnmuJaym1+KzR58h3ruivCk5K2NhT25x7qfWlyYWKTZ8hsg2s
         Nh87yOE+59bw5bW9a8MpkMXF7xrqc2erOBWRdgGST1896VnZLgvAz4c2i/d4wF48evuJ
         NLa55DbtgTF2vVRC69EhVi8MgzI8DIyTUvXqL16+GcLqck4Rnjq9lXUvC6uf+NRJRJ26
         eXbEwlqrnZ6/5c8o6BB1Y8/RHWp+xHd03degCC2ho/fgd62T2B3I/Bs6M281Z+baEe6i
         kiVwvLOkWfN1lYKnc8pjc/6wAouWYVyUrHQLGta6KNrUJ7noBUSyxc5dKzAeQFpQrkzb
         mXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7Rp6xI0oKFg6daamgdbuDkAiEfxiZjd/hpGcAjCvFK8=;
        b=pw5FFKntGLWcQKdoSWGPsuQ4VApilkK5BgMBb9lAwXtSyh5zXyLQYp1/9nTw+fkT3q
         fbRN5mS2zBocuNlUe2XMEGpLnXCx8MMwNs4xXhw1zVu1C+oHvtjtqfiRvrRP73tmNW1b
         fYxVjPd45mNE6WPIkJW9bcNviXRmR1nQY7k6UOyOQ19cvjVxwtS1eUoK6JyGH3MP9ULw
         GgSyBqL6dg4ghFfT5BDUNHtPdnlFgAofQ4kqhqkXrgPSHHIsc3QXkjFGp4yuTRs72VQQ
         D1r00zSzy20waH00CVJiqKrh1vu3xWSBIyb1MiKYHKb4d0nBTj6nM4Ksp/p0LGf2jBat
         xgeQ==
X-Gm-Message-State: AJcUukcc/R0ydSqr1CJ5p6X0EbE4AniKUK9vYP2Wf3c8+18uYUBWP9U4
        xYrmE23iZHs3WUulKMTLGBabHI5pjksFnT5S2V0=
X-Google-Smtp-Source: ALg8bN7L7wOb0soTenPnS89tbYu4zHaybYCtNzfBZz7bSLmB2gsBoFRw9q4mJAzsBWPe4+UV98gC+37xPLqgGoqll94=
X-Received: by 2002:a37:660f:: with SMTP id a15mr52225531qkc.328.1546746107716;
 Sat, 05 Jan 2019 19:41:47 -0800 (PST)
MIME-Version: 1.0
References: <20190105202659.20198-1-nazgul33@gmail.com> <20190105202659.20198-3-nazgul33@gmail.com>
 <CAKdAkRR80M4R4bWPu4smPD5=KPWanL+EFPvDUYLNrHaFQfApPw@mail.gmail.com>
In-Reply-To: <CAKdAkRR80M4R4bWPu4smPD5=KPWanL+EFPvDUYLNrHaFQfApPw@mail.gmail.com>
From:   nazgul33 <nazgul33@gmail.com>
Date:   Sun, 6 Jan 2019 12:41:36 +0900
Message-ID: <CAEo1RiwW4_j8t4G9amF7NsAmri5WYaYckz5VoZsKM1=saiLEfA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Input: rotaty-encoder - Add DT binding document
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Daniel Mack <daniel@caiaq.de>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, it's needed.
Even with the same encoder, adjusting steps affects rate of event generatio=
n.
(the steps defines 1 cycle of encoder rotation, and 1 cycle =3D 1 key event=
.)

On Sun, Jan 6, 2019 at 8:11 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Sat, Jan 5, 2019 at 2:27 PM Donghoon Han <nazgul33@gmail.com> wrote:
> >
> > Add DT binding document for rotary-encoder, keycode options.
> >
> > Signed-off-by: Donghoon Han <nazgul33@gmail.com>
> > ---
> >  .../devicetree/bindings/input/rotary-encoder.txt     | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/input/rotary-encoder.txt=
 b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> > index f99fe5cdeaec..113640079de3 100644
> > --- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
> > +++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> > @@ -12,6 +12,10 @@ Optional properties:
> >  - rotary-encoder,relative-axis: register a relative axis rather than a=
n
> >    absolute one. Relative axis will only generate +1/-1 events on the i=
nput
> >    device, hence no steps need to be passed.
> > +- rotary-encoder,relative-keys : generate pair of key events. This set=
ting
> > +  behaves just like relative-axis, generating key events. keycode[2]
> > +  corresponds -1/1 events.
> > +- rotary-encoder,relative-keycodes : keycodes for relative-keys
> >  - rotary-encoder,rollover: Automatic rollover when the rotary value be=
comes
> >    greater than the specified steps or smaller than 0. For absolute axi=
s only.
> >  - rotary-encoder,steps-per-period: Number of steps (stable states) per=
 period.
> > @@ -48,3 +52,11 @@ Example:
> >                         rotary-encoder,encoding =3D "binary";
> >                         rotary-encoder,rollover;
> >                 };
> > +
> > +               rotary@2 {
> > +                       compatible =3D "rotary-encoder";
> > +                       gpios =3D <&gpio 21 0>, <&gpio 22 0>;
> > +                       rotary-encoder,relative-keys;
> > +                       rotary-encoder,relative-keycode =3D <103>, <108=
>;
> > +                       rotary-encoder,steps-per-period =3D <2>;
>
> Do you need steps for keys? They weren't required for the relative axis m=
ode.
>
> Thanks.
>
> --
> Dmitry



--=20
=ED=95=9C=EB=8F=99=ED=9B=88 =EB=93=9C=EB=A6=BC.
