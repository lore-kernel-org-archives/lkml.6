Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DDDC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27BF2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YcJGeMgy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391609AbfAPJWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 04:22:11 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41834 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391596AbfAPJWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 04:22:10 -0500
Received: by mail-lj1-f196.google.com with SMTP id k15-v6so4804010ljc.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 01:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dIWRftyT8CqF38UDX+izuWLKuJcEJZYvAAotx/d6iZA=;
        b=YcJGeMgypIJdNln8H3bZCv5lDf9Fjup2vcdrOoiHJly2JU+bp1bj5sXBnwXI1kdhh9
         FGWNeBJ0Df3eYc3hED8KV4cDPe/bGRRyFc5F/Pl8grFwPH+0eGUGpC+9MM7ooUgzGj1P
         dm7uAmjj62+AlS5xzbHnM26N0iPP0lrWoVh8yWZglzgtfiF6W7XYby+qjyaonWvBmmZU
         0hCjhg45DiDIBsYzLEsIGy4GJXE2jgC9hThmvNjEZX4n4Fi9oBM3SLPjZ+VxM9F+tKBm
         Zmw5KY4KREpLWZO9gHiZUytUg0xYTXOw0X6lbEluKCNPpr96m6Czqctv6YL1T6fsrZPi
         bC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dIWRftyT8CqF38UDX+izuWLKuJcEJZYvAAotx/d6iZA=;
        b=ssZLgX+JS8TnafLPAYl17dXcsHxBz50pNXYxurUQeLwA9xMX4K6C+1Jeq6JkyCS4yA
         LaaGQgA4SHFwcvK+gePI7/0c245z5Px39iT3IfTuReVQVgCh99feaP7YykCCD/8uyNSi
         dYWAOcNXlHxPN59oZulEe8+EzQiRy+I0cOjOsaytXOuZCf3uXIDVaE8TeaEGzFR8fliw
         R37rZESvMdjoUJw0rpqelw8exGhnLiOCvmmlmkjMyMfwxzUSTeTvdQpeJYVSxk3oAE8X
         tD5wfN1Ee7IjlCwJmfOpswqFWMRtOrdnOCs6NEPTfG2ObOSEtLmP+FMFXSW/dwyQtwpl
         ucOQ==
X-Gm-Message-State: AJcUukfo0VrGuUf6Z4epe5Jn2oczIfSZOuhXRgfKkuxU2f01sOHIKaRI
        g97MrRHWS30ngKo7QNcv2N+6yCVF4P4zMNEmFOQnyQ==
X-Google-Smtp-Source: ALg8bN4d8kFmxVEeFLFHrGaY96LCZJwIIesbaEKAMAme5TKExewN0aJpuLDEof97tH+dpKePqMoE8B6O3LxO2Ji7gSI=
X-Received: by 2002:a2e:1603:: with SMTP id w3-v6mr5882456ljd.33.1547630527947;
 Wed, 16 Jan 2019 01:22:07 -0800 (PST)
MIME-Version: 1.0
References: <1547194964-16718-1-git-send-email-yash.shah@sifive.com>
 <1547194964-16718-2-git-send-email-yash.shah@sifive.com> <20190115201149.ghddnf27s5kqephc@pengutronix.de>
In-Reply-To: <20190115201149.ghddnf27s5kqephc@pengutronix.de>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Wed, 16 Jan 2019 14:51:31 +0530
Message-ID: <CAJ2_jOGPpwsn=+OU3QcHtGYJ3MFYh9azdALSeWz3-WPXL9vHnw@mail.gmail.com>
Subject: Re: [PATCH 1/2] pwm: sifive: Add DT documentation for SiFive PWM Controller
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 1:41 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> this is v3, right? It is helpful to point this out to ease reviewing.

Yes, it is v3. Will take care of this in v4.

>
> On Fri, Jan 11, 2019 at 01:52:43PM +0530, Yash Shah wrote:
> > DT documentation for PWM controller added with updated compatible
> > string.
>
> Not sure what was updated here. But assuming this is compared to v2 this
> is not a helpful info in the commit log.

Ok, will remove the 'updated compatible string' part.

>
> > Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> > [Atish: Compatible string update]
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > ---
> >  .../devicetree/bindings/pwm/pwm-sifive.txt         | 37 ++++++++++++++=
++++++++
> >  1 file changed, 37 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.tx=
t
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/Doc=
umentation/devicetree/bindings/pwm/pwm-sifive.txt
> > new file mode 100644
> > index 0000000..e0fc22a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> > @@ -0,0 +1,37 @@
> > +SiFive PWM controller
> > +
> > +Unlike most other PWM controllers, the SiFive PWM controller currently=
 only
> > +supports one period for all channels in the PWM. This is set globally =
in DTS.
> > +The period also has significant restrictions on the values it can achi=
eve,
> > +which the driver rounds to the nearest achievable frequency.
> > +
> > +Required properties:
> > +- compatible: Please refer to sifive-blocks-ip-versioning.txt
>
> While the description was too verbose in v2, this is too short. You
> should at least mention something like "sifive,pwmX" and
> "sifive,$cpuname-pwm" (or how ever that scheme works).

Will mention the above.

>
> > +- reg: physical base address and length of the controller's registers
> > +- clocks: Should contain a clock identifier for the PWM's parent clock=
.
> > +- #pwm-cells: Should be 2.
> > +  The first cell is the PWM channel number
> > +  The second cell is the PWM polarity
>
> I'd drop these two lines and refer to bindings/pwm/pwm.txt instead.

Will be done.

>
> > +- sifive,approx-period-ns: the driver will get as close to this period=
 as it can
>
> As already said for v2: I'd drop "approx-".

Sure, will be done.

>
> > +- interrupts: one interrupt per PWM channel
> > +
> > +PWM RTL that corresponds to the IP block version numbers can be found
> > +here:
> > +
> > +https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/dev=
ices/pwm
> > +
> > +Further information on the format of the IP
> > +block-specific version numbers can be found in
> > +Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.t=
xt
> > +
> > +Examples:
> > +
> > +pwm:  pwm@10020000 {
> > +     compatible =3D "sifive,fu540-c000-pwm","sifive,pwm0";
> > +     reg =3D <0x0 0x10020000 0x0 0x1000>;
> > +     clocks =3D <&tlclk>;
> > +     interrupt-parent =3D <&plic>;
> > +     interrupts =3D <42 43 44 45>;
> > +     #pwm-cells =3D <2>;
> > +     sifive,approx-period-ns =3D <1000000>;
> > +};
> > --
> > 1.9.1
> >
> >
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|

Thanks for the comments.
