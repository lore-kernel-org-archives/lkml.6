Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F52C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 07:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7064720684
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 07:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aDUlVdh1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7064720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbeKSSHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 13:07:42 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40373 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbeKSSHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 13:07:41 -0500
Received: by mail-lf1-f66.google.com with SMTP id v5so20584877lfe.7
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 23:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jnQHXqBXMtlUBxg0JJ5JkdbWiuesYlmvAAAoW6HUAgo=;
        b=aDUlVdh1eeDTkLy5ibnyONFLZQeMgs0Cs4rNN7B1GVidwCRj3hgBO5+DaFetNsda6H
         NT2KDAiR9jXWj8/qPlbHOeSplD2zkRKpNDtPumci32+R1polnU9G8JEBFrQb0CI9AD+M
         DxxsjABjVitd4V9slPYslINrv6FXBhthJdqpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jnQHXqBXMtlUBxg0JJ5JkdbWiuesYlmvAAAoW6HUAgo=;
        b=nNBTPHDO2hymNOjf7jvDDaFmtoTUUF/7BsVnOnajJ+5IIS7l7kPbjdWzNuUvVUb4vn
         puo8Uq2gzhya6ivEo6OoKk/fqi8AfkQFerxTncWUEz5wieMI0EJFQOxd+45aImFd98zA
         E20S9RZc82kjvZV602Zo7EIpRw51Dr2MsqibNvh4myGmwz1pMBgLXC9Ns/oZXlCM/n/r
         Q2WWUAppIlVYif29auB2BTPGG+HR+LKpAHBLUUyZe0ZAHYrCmYNOdc8QHY0wFuQoqrQe
         hm1D0XtwI83m2mJR+rRE6FoyDlB2iGprlOmN9ioQLK+9vu8S/7dYo/ziGbhlsuH+vUy5
         ndKQ==
X-Gm-Message-State: AGRZ1gLb+VRNHUgrZZ44sDEM91F0azFBD6l13mzHGpzpgd85RKK27hVZ
        oiqOJ+ktNeaVoIyHoyhmKGIm0KYPKGPkFtEIT3mrvQ==
X-Google-Smtp-Source: AJdET5cekZrzDNzEa7OMpYcawh2TMGsRnCwpMBS3mmCJXnvd5kycIZ/5STr1x4vNqL3u3TssgUi72SVZzJNIfBlCpEM=
X-Received: by 2002:a19:f813:: with SMTP id a19mr9736264lff.67.1542613491218;
 Sun, 18 Nov 2018 23:44:51 -0800 (PST)
MIME-Version: 1.0
References: <20181012160854.hmgpokxgsrqdzobx@pengutronix.de>
 <e4289ee5-3fc1-2848-1cae-77d29b5ed93c@ysoft.com> <20181107093355.e4n3irrnkybqsjvc@pengutronix.de>
 <eb4e7a42-bd5c-3ae2-ccb7-d1a73d5ae99c@ysoft.com> <20181107150125.7cpd4v5t7yi2254c@pengutronix.de>
 <4fbb7307-df01-d7bd-f2e2-e05e6d17807d@ysoft.com> <20181108191855.zuon3ecv4yjfbs7g@pengutronix.de>
 <283cfef3-16d0-8bd4-e306-6e34d44c3a86@ysoft.com> <20181109165555.vqbiwh4hlcnozdna@pengutronix.de>
 <20181114113449.GB2620@ulmo> <20181114215120.vddykljqyavm64wj@pengutronix.de>
In-Reply-To: <20181114215120.vddykljqyavm64wj@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 19 Nov 2018 08:44:38 +0100
Message-ID: <CACRpkdZAew3bUea=iR4t-a7SVSMf=-CTeWfeU215uT_jQ-o81A@mail.gmail.com>
Subject: Re: [RCF PATCH,v2,2/2] pwm: imx: Configure output to GPIO in disabled state
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Michal.Vokac@ysoft.com, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-pwm@vger.kernel.org,
        l.majewski@majess.pl,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@karo-electronics.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 10:51 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Wed, Nov 14, 2018 at 12:34:49PM +0100, Thierry Reding wrote:
> > On Fri, Nov 09, 2018 at 05:55:55PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > On Fri, Nov 09, 2018 at 02:24:42PM +0000, Vok=C3=A1=C4=8D Michal wrot=
e:
> > > > On 8.11.2018 20:18, Uwe Kleine-K=C3=B6nig wrote:
> > > > > Taking your example with the backlight device you specify an "ini=
t" and
> > > > > a "default" pinctrl and only "default" contains the muxing for th=
e PWM
> > > > > pin everything should be as smooth as necessary: The pwm is only =
muxed
> > > > > when the backlight device is successfully bound.
> > > >
> > > > Have you tried that Uwe? The bad news is I tested that before and n=
ow
> > > > again and it does not work like that. We already discussed that ear=
lier.
> > >
> > > The key is that the pinmux setting for the PWM pin should be part of =
the
> > > bl pinctrl, not the pwm pinctrl. Then "default" is only setup when th=
e
> > > bl device is successfully bound which is after the bl's .probe callba=
ck
> > > called pwm_apply().
> >
> > No, that's not at all correct. Pinmux settings should reside with the
> > consumer of the pin. In this case, the PWM is the consumer of the pin,
> > whereas the backlight is the consumer of the *PWM*.
>
> This is news to me. Adding Linus W. to Cc, maybe he can comment?!
>
> Grepping through the arm device trees it really seems common to put the
> pinctrl for the pwm pin into the pwm device. I didn't search in depth,
> but I didn't find a counter example.
>
> For GPIOs it is common that the pinmuxing is included in the GPIO's
> consumer pinctrl. Ditto for mdio busses whose pinctrl is included in the
> ethernet pinctrl.

There is quite a discussion you folks have going on here. I tried to
grasp it but I can't. I can try to answer the above question specifically.

For pin control it is mainly paramount that the state is associated
with *a* consumer. The problem we were facing when fleshing out
the subsystem can be seen in horrific solutions such as in
Documentation/devicetree/bindings/gpio/gpio-twl4030.txt
where you see that pull-ups and pull-downs are set on the
PRODUCER side, which just make everything a complete
mess.

So compared to things like that (that we still have to support
forever) whatever you are doing here you're doing great as long
as it is consumer controlled.

Whether that consumer is the previous driver thingie in the
daisy-chain of consumers or the final end user consumer of
the pin doesn't really matter to pin control, as long as it is a
consumer. I would tend to say it is up to the subsystem,
and the old IETF motto "rough consensus and running code".

It seems in the current discussion the "rough consensus"
part is the problem, and I'm afraid I can't fix that.

Yours,
Linus Walleij
