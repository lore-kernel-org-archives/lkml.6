Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF3AC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531272083C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLDfKh1+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 531272083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbeJPTD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 15:03:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56164 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeJPTDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 15:03:25 -0400
Received: by mail-wm1-f67.google.com with SMTP id 206-v6so22003794wmb.5;
        Tue, 16 Oct 2018 04:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4je4xhXUCeLf8WgsbR+Mno33Kmekkz3UdqSRFHJ3HPs=;
        b=kLDfKh1+m47caMGRW8CaYkQSRo8Oaky3+rOBBamCWNj4QStSP90ObSv6FYVHl5a5zA
         X0IsJPV5UPd79C4e1HGdqtupUkS5FBhjuKRDjzx0gtU8nEBROtsLwjkUEzzijB5oKnVZ
         BdKyOd7hUka9GrRL2gQZPVQY7rkI2ooLS+5yllGXPNCMEczrwuXdYqRicIAB2u7FUwEk
         2F4ge9OwPqaNrKfFmWFkEtRUBQAG5t/Sl1GnEiJe9mdvAvAqDD5a2Ik1g/ugX7nMLjTw
         0ikYfvtlMPWoQZbcMdG/5zREisQQZDOEhlG4SXt9hWLCuXBTGq+tCTft2Qn/+janivIc
         3wVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4je4xhXUCeLf8WgsbR+Mno33Kmekkz3UdqSRFHJ3HPs=;
        b=LQTBon7oZSqychd9vQv+aGNXwhhFFsc6Vy8BzNx3gmk1cRhv/JwfWAo7mJvhBAlsYt
         8NLjFiaU/meo4nFG1wr+peK5Zawq00PVGak8A/Fwe9fDeqwuz//J39WZIsQHESlnu2bu
         Bbp3vcSADZ5JypWYDhSF0fwitO8fSmIV979DZWARjDFvXR2PvL9N2Eq7HpPVMiaQyO69
         YUPhiFPPlveAxYg4r9ZG+c4M7xXkLMSYEkUNPDa2oAQSUL/4KKUD2JaARUJPY/+opBIT
         ETxyMnvzSGyXKdArJTsD/g+YhnU33Mms/T54s38+MyHXvrcU3RJyd/b8dX9L5yA5VRRk
         7oKw==
X-Gm-Message-State: ABuFfoiTdnAr00vJll/JzZ+6Xm75jba7+B2qEUHWIpa8WLUMJjGGSMIN
        Ee3Pc94pHnvQUMsV9bopeFI=
X-Google-Smtp-Source: ACcGV6145tiwAzlh1H+MH5aPV3aWH+hPaWsbcomVP0tlsCTyYuQhmmvNu+WC69PzMzpHmjb/5whPNQ==
X-Received: by 2002:a1c:ee15:: with SMTP id m21-v6mr16157442wmh.124.1539688407082;
        Tue, 16 Oct 2018 04:13:27 -0700 (PDT)
Received: from localhost (pD9E5106D.dip0.t-ipconnect.de. [217.229.16.109])
        by smtp.gmail.com with ESMTPSA id 143-v6sm12746627wmv.6.2018.10.16.04.13.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 04:13:26 -0700 (PDT)
Date:   Tue, 16 Oct 2018 13:13:24 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Wesley Terpstra <wesley@sifive.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC 1/4] pwm: sifive: Add DT documentation for SiFive PWM
 Controller.
Message-ID: <20181016111324.GD8852@ulmo>
References: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
 <1539111085-25502-2-git-send-email-atish.patra@wdc.com>
 <20181010134926.GD21134@ulmo>
 <25758ab9-eb36-741b-6264-42412b3ddd8e@wdc.com>
 <CAMgXwTieXNa13_xGp2mkw99+VJm-R1xrxMHSmRLZV-hG5oSdzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vni90+aGYgRvsTuO"
Content-Disposition: inline
In-Reply-To: <CAMgXwTieXNa13_xGp2mkw99+VJm-R1xrxMHSmRLZV-hG5oSdzA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vni90+aGYgRvsTuO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2018 at 04:19:20PM -0700, Wesley Terpstra wrote:
> On Mon, Oct 15, 2018 at 3:57 PM Atish Patra <atish.patra@wdc.com> wrote:
> > >> +SiFive PWM controller
> > >> +
> > >> +Unlike most other PWM controllers, the SiFive PWM controller curren=
tly only
> > >> +supports one period for all channels in the PWM. This is set global=
ly in DTS.
> > >> +The period also has significant restrictions on the values it can a=
chieve,
> > >> +which the driver rounds to the nearest achievable frequency.
> > >
> > > What restrictions are these? If "nearest achievable" is too far off t=
he
> > > target period it might be preferable to error out.
> > >
> >
> > @Wes: Any comments?
>=20
> When I last looked at this driver and hardware, I briefly considered
> throwing up my hands and pretending that this PWM device had no period
> control at all, only duty-cycle. There are several examples of PWM
> controllers in linux already that behave that way.

Can you point those out? So far we've always opted to refuse changing
the period of PWM channels that share a period if it didn't match the
current period.

> Most of the uses of this PWM are only going to care about the
> duty-cycle, not the period. So failing when the period is unachievable
> seems worse to me than just completely eliminating access to period
> control.

I'm not sure we've ever tried to completely take period out of the
picture. You could probably do it if you use only the atomic API because
then you just leave the period untouched. And if you have a post-clock
change you just need to make sure to record the new period and update
the duty cycle so that the ratio remains the same.

I think that could work, but I think it'd be best to be explicit about
it, rather than just handwaving it.

Thierry

--vni90+aGYgRvsTuO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvFx9IACgkQ3SOs138+
s6EG5Q//VozF9Lk+dGPqd7hls3pRBj6SyqljD13wEXsC+zLveuBBDKtOFvJ53yYj
A5PxNzKHGdfFcEm+WWNthJezglWFUBwoeiJVmOkuhHSTAwSXr+bhKjPRzPyRssNe
Av0PZyxQ9yB9XsmZSZrixTtGT6XpAW3MB/9ha3G/PkL6lEM7mI1rCoA1riiZsnpq
gX5v1d8+lizsAJMYIDduyAbyB3+zvpRwtrQSEuM+p5pwpQBZhZiEI18fXOazDGmF
p0FCHWwRTXXlVN2gOk84+Q8/mXRFA35NqbhTJ6yrqavZLd2k7nhwVr69N1bw2DQC
PzdzYM/JD4CowrfzpAnNG6ysqvkzh44zQB0uHhF8dDNQC+JqAYReUNH8/JjbHqd/
cuI21LU5l0mBgMyza9Eal+WwXXMe/tppz9CcHddMEke3RUXDo+MRHDNtphid/sOf
TznJLIAbOiOGsoUfyoHycbEh0xmMiNoqnayt7sUvdzoKSxi+HIwsvVbsPMvlqapM
qGq0t3q/gK19MiEG5yUEhNf3WzhJCGMdJKcnlAzX8chKA2nrmIGvBIr29TUnPo8X
cMmOUncqNkQ3oj9ypACk+9ACXNAAQoupww+fLQZ/0V6lm4BM7JjLRCpsxPqKjYhK
nbW9AskHYjXg5kVVMj7/GwwdXNXV9Q/iWCxax2JxY8bsuXuxnMk=
=DuQI
-----END PGP SIGNATURE-----

--vni90+aGYgRvsTuO--
