Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35A7C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844D720827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYPY1tVI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 844D720827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731435AbeKHChn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:37:43 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34524 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbeKHChn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:37:43 -0500
Received: by mail-wm1-f66.google.com with SMTP id f1-v6so11769917wmg.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 09:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2manXyxiixH+CojxXLCyUIi+u/Q8AUKb/fNRJUhH6wI=;
        b=ZYPY1tVI7hA4gs7B8bVP/hqGmJ1BurrVzjr9z+jSHNH7wMzVQV5FirrzyaYAogbqNW
         BqFreWysJkHS2gfQHrWnZX4Z3RTNJ8cXkQj83CYGNet7vBQSvgO7WTOdRQzoWVxTGa6n
         RbVNg5zNRgb+8JA5quYB6Re8c8s+OJ936ZmYYy9oox2jW8ia4rOF6fLaV15ki7oev5/f
         UxqdPpNOXHS1GtSsphS2zG2bcH45KU45M7kkI1Y1XdxTfZnUsmRcaDVz4NOd6doO/Lne
         HIIa843IdTDoCjYVjHCZSnh0Z6ASm5UpgvvwcOD/P6R0c52cHhmu+bCI8o5hKJYNNjYB
         Fv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2manXyxiixH+CojxXLCyUIi+u/Q8AUKb/fNRJUhH6wI=;
        b=QiJvR4w0dXvCsBLBnY7wW2dGX29n1WtP7fukE2SCs2eC3njIaR7hNgHV5Li9Mn8SS2
         +zxPanbS+go0UOn5h4d/R7SXLTUV9H9f9mozdlhVWPLBg0hDg1lvkd6Npysp9VoK8Wz2
         /ugAMDDCapGiPSVH9SkRPmifNqnJnQmqwFm/0Bqu2ijmyiPXo1h+/gIyGSnvgasVLgps
         tQadfzMMhgRNr65yHxDJSCRm8hUI4JNmtSNEGdStpXXS3HpQXnrnjktpxOzuHG2FHFK1
         JScpa58OSiN5l4IG1ctvH9hNo+jHVfTbeFhVLruY51Bb0fzV7cDc7jtnS33qITmiDVAc
         rwlQ==
X-Gm-Message-State: AGRZ1gLjYbtCPyUCRqlOfNsM6N51Q4UIeSznScIB1D0EoEI+UJiNx4a3
        O7iPG7gE3tayAAzDDPCOmJQZVTrtc+btDKusZXusGQ==
X-Google-Smtp-Source: AJdET5fhQ+JrunmvwShhJjU+tuKmADEeQTQxSfiAndOSr+3WUMkBfZ+CxK4edpqWhZdcIOQzdinocRT3uN3PB0f2bCc=
X-Received: by 2002:a1c:f417:: with SMTP id z23-v6mr923386wma.80.1541610387037;
 Wed, 07 Nov 2018 09:06:27 -0800 (PST)
MIME-Version: 1.0
References: <CAL8zT=imudTXvbsxx42mPSQj7Qt1b=44wnPHpb09-sOqLewu-w@mail.gmail.com>
 <3857132.MlRd14rs7I@ada>
In-Reply-To: <3857132.MlRd14rs7I@ada>
From:   Jean-Michel Hautbois <jhautbois@gmail.com>
Date:   Wed, 7 Nov 2018 18:07:42 +0100
Message-ID: <CAL8zT=hWY2FbFbmDm8wAoWO7pCqBiwboULE4-VVJ2m=5n2AaVw@mail.gmail.com>
Subject: Re: sama5d: using the ebi interface from another driver
To:     ada@thorsis.com
Cc:     linux-arm-kernel@lists.infradead.org, boris.brezillon@bootlin.com,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there !

Le mar. 6 nov. 2018 =C3=A0 10:57, Alexander Dahl <ada@thorsis.com> a =C3=A9=
crit :
>
> Hei hei,
>
> Am Freitag, 2. November 2018, 14:35:26 CET schrieb Jean-Michel Hautbois:
> > Then, after looking into deeper details in the datasheet I understand
> > it is connected through EBI and it sounds not so easy :D.
>
> Did you read docs on that? You'll find the binding docs here:
>
> Documentation/devicetree/bindings/memory-controllers/atmel,ebi.txt
>
> > I would appreciate some help/pointers on this, as there is (at least,
> > I could find) few documentation on how to use it except for NAND
> > cases.
>
> I use EBI with at91sam9g20 and custom FPGA on CS5 (0x6000000) and CS7
> (0x8000000).
>
> > I have something like that in my DTS, but not sure this is the correct
> > way to do it :
> >
> >         ebi: ebi@10000000 {
> >             pinctrl-0 =3D <&pinctrl_ebi_nand_addr>;
> >             pinctrl-names =3D "default";
> >             status =3D "okay";
> >
> >             dsp0: pef24628@1 {
> >                 status =3D "okay";
> >                 compatible =3D "intel,pef24628";
> >                 #address-cells =3D <1>;
> >                 #size-cells =3D <1>;
> >                 reg =3D <0x1 0x0 0x8000>;
> >                 pinctrl-0 =3D <&pinctrl_dsp_cs1>;
> >             };
> >
> >             dsp1: pef24628@2 {
> >                 status =3D "okay";
> >                 compatible =3D "intel,pef24628";
> >                 #address-cells =3D <1>;
> >                 #size-cells =3D <1>;
> >                 reg =3D <0x2 0x0 0x8000>;
> >                 pinctrl-0 =3D <&pinctrl_dsp_cs2>;
> >             };
>
> I'm not sure about those 'reg' settings. IIRC the first should correspond=
 to
> the CS line, on at91sam9g20 the 0x40000000 would be CS3 (which is used by
> NAND, like in the dts snippet you posted) and 0x50000000 would be CS4. Ar=
e CS1
> (which is used by SD-RAM) and CS2 free to use on sama5d3?
>
> Maybe that's different on sama5d3? I would check it again.

Well, yes, I am using CS1 and 2, and right now, I can confirm the reg
settings are ok as the platform_get_resource returns the correct
values :) !

> > The pinctrl for ebi should probably be changed however, I am wondering
> > how the (platform ?) driver can access the adress ? Should it parse
> > itself the parent, and find range, etc. Or is there an accessor for it
> > ?
>
> Probably. This is what I have for the at91sam9g20:
>
>             pinctrl@fffff400 {
>                 ebi {
>                     pinctrl_ebi_cs5: ebi-cs5-0 {
>                         atmel,pins =3D
>                             <AT91_PIOC 9 AT91_PERIPH_A AT91_PINCTRL_PULL_=
UP>;
>                     };
>
>                     pinctrl_ebi_cs7: ebi-cs7-0 {
>                         atmel,pins =3D
>                             <AT91_PIOC 12 AT91_PERIPH_B AT91_PINCTRL_PULL=
_UP>;
>                     };
>
>                     pinctrl_ebi_nwait: ebi-nwait-0 {
>                         atmel,pins =3D
>                             <AT91_PIOC 15 AT91_PERIPH_A AT91_PINCTRL_PULL=
_UP>;
>                     };
>                 };
>             };
>
> > Maybe can I just manually toggle the CS GPIO, and don't try to make
> > anything more complex than what it should be ? The driver should not
> > be atmel dependant...
>
> As Ludovic said, you should check the settings and timings for the extern=
al
> memory interface. This could look more or less similar to that:
>
>             foo_bar: foo-bar@5,0 {
>                 status =3D "okay";
>                 pinctrl-0 =3D <&pinctrl_ebi_cs5>;
>                 pinctrl-names =3D "default";
>                 reg =3D <0x5 0x0 0x80000>;
>
>                 atmel,smc-bus-width =3D <8>;
>                 atmel,smc-read-mode =3D "nrd";
>                 atmel,smc-write-mode =3D "nwe";
>                 atmel,smc-exnw-mode =3D "ready";
>
>                 atmel,smc-ncs-rd-setup-ns =3D <7>;
>                 atmel,smc-nrd-setup-ns =3D <7>;
>                 atmel,smc-ncs-wr-setup-ns =3D <7>;
>                 atmel,smc-nwe-setup-ns =3D <7>;
>
>                 atmel,smc-ncs-rd-pulse-ns =3D <56>;
>                 atmel,smc-nrd-pulse-ns =3D <56>;
>                 atmel,smc-ncs-wr-pulse-ns =3D <56>;
>                 atmel,smc-nwe-pulse-ns =3D <56>;
>
>                 atmel,smc-nwe-cycle-ns =3D <77>;
>                 atmel,smc-nrd-cycle-ns =3D <77>;
>
>                 atmel,smc-tdf-ns =3D <0>;
>             };
>
> As you can see, quite a lot of settings are made, all depending on how th=
e
> memory access is supposed to be configured. You should look out for detai=
ls in
> the hardware manuals of the SoC and the devices you want to connect.

Yes, this is the last part I need to get information about, but this
is datasheet reading basically, so not a big deal :).
Thanks to both of you, Alexander and Ludovic, I have now something
really better ;).

JM
