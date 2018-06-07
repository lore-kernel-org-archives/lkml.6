Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id nmVfENhiGVs1YgAAmS7hNA
	; Thu, 07 Jun 2018 16:53:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B64D26089E; Thu,  7 Jun 2018 16:53:00 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvNzCZ5d"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,FROM_EXCESS_BASE64,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3A1AF60115;
	Thu,  7 Jun 2018 16:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3A1AF60115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933695AbeFGQw6 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:52:58 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34247 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932630AbeFGQwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:52:54 -0400
Received: by mail-yw0-f196.google.com with SMTP id b125-v6so3228008ywe.1;
        Thu, 07 Jun 2018 09:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5Y2vzhyZp42Ba8LdVKKQla/fC1IJp4EV39lhWJu4oF4=;
        b=NvNzCZ5dS3bJ7s9JuZq5ICjlnKM6r3PKnHToCRAk8UCfOd7f7nmJ7YAwYzNNAwhDzE
         ymvsIPHjANdmw4J+oaGXgpIN4MBGLnaQYLtnRyokfvNWyPZOFPVCWxjEt76BqwYh9fBa
         4lR0g8OGQEWoIEFr0uJfdiuBSL3aWkAtpYvTWjlyc2NKz473x8YEQOdWxn6bTwC5CG0R
         OpviUtyAnODpaO6mIA4WLkLTTS8RgGDC8ArVnpF8I+xP8NC40VU8p4E28gfxhgURZfrv
         rxulIFWgktuHqsKo4wcV9cr+BgDJUSADAO03ct+KjgwRKG7qBMY4z3y06ByvSIIi5Dok
         Jd5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5Y2vzhyZp42Ba8LdVKKQla/fC1IJp4EV39lhWJu4oF4=;
        b=EfuBakqgfQGgvnrCWGv3cgXnbWyetFXu7I93B2/CZ4Z5MnGYeETeligeJcNd8GTe2l
         bCqYBi5iJMHDBWsJ1vYRILVPSdf2nTU5qcn3+IgXaGxAoGDeemhRTWccy9y64otWFuWN
         f1CndN/yld8FDDIfsgC0T9z1ij2LF7OysyKMWp5JIe7zHrMNEstMyVtYtj9OVhKZ/QFm
         eU7RfLtIUoskc99/2tkBjfF40z+3UAVk2uQJ4l2xDeKckhlmpRd0vD32ewXs4jPb2lo6
         WRQvgW/2YMm1gWW9zhpNQ3bnoF2pIVH5sXAVZBHQcIkEB8zPSqcgp+iCyxa6QwMFVqIp
         reHw==
X-Gm-Message-State: APt69E1sztrIKNI2r+jceaz2v7YNCRdNup0M+1lox63hiJz5t/fri5/D
        NpkwN5qaSzWRKbux/rMmTqZTDDuFFXN6aQiNOj0=
X-Google-Smtp-Source: ADUXVKJuw09R8Ocn5IodrxzKAjU1F1UO/exjlUU/BhcvMdhbKdulmLZVmnekQxkFurDOfr1ZBhhsE/+lzdlPB7QRW60=
X-Received: by 2002:a0d:f7c2:: with SMTP id h185-v6mr1476830ywf.457.1528390373265;
 Thu, 07 Jun 2018 09:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <1528309291-25579-1-git-send-email-scott.branden@broadcom.com> <c0b4d69d-2826-320e-974e-c7cdbf341747@gmail.com>
In-Reply-To: <c0b4d69d-2826-320e-974e-c7cdbf341747@gmail.com>
From: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date: Thu, 7 Jun 2018 18:52:42 +0200
Message-ID: <CAJiuCcefDycphDfTM1a=Dz7vaHMQy4Bq=b4mKTiVZhRTKmWhoQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ARM: dts: cygnus: enable iproc-hwrng
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: scott.branden@broadcom.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mohamed-ismail.abdul@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Thu, 7 Jun 2018 at 18:35, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 06/06/2018 11:21 AM, Scott Branden wrote:
> > From: Mohamed Ismail Abdul Packir Mohamed <mohamed-ismail.abdul@broadco=
m.com>
> >
> > Enable the HW rng driver "iproc-rng200" for all cygnus platforms.
> >
> > Signed-off-by: Mohamed Ismail Abdul Packir Mohamed <mohamed-ismail.abdu=
l@broadcom.com>
> > Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> > Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>
> Clement, do you want to test this and reported back?

Tested v1 and works fine on bcm58305

Tested-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>

>
> > ---
> >  arch/arm/boot/dts/bcm-cygnus.dtsi | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-=
cygnus.dtsi
> > index 9fe4f5a..b0e38fa 100644
> > --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
> > +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
> > @@ -417,6 +417,11 @@
> >                       status =3D "disabled";
> >               };
> >
> > +             rng: rng@18032000 {
> > +                     compatible =3D "brcm,iproc-rng200";
> > +                     reg =3D <0x18032000 0x28>;
> > +             };
> > +
> >               sdhci0: sdhci@18041000 {
> >                       compatible =3D "brcm,sdhci-iproc-cygnus";
> >                       reg =3D <0x18041000 0x100>;
> >
>
>
> --
> Florian
