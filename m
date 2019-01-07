Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E440EC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFFB62085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpr5KQ80"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfAGSx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:53:26 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40114 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfAGSxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:53:25 -0500
Received: by mail-lj1-f196.google.com with SMTP id n18-v6so1251441lji.7;
        Mon, 07 Jan 2019 10:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D8MGakRy9ZNPNyMHEJmpxYjL2GAt9loTUCwueusu3k4=;
        b=bpr5KQ80xXITi7AZalBgaphh2RFC/8TaNmRoLQecYjbbp5B8BgoTTFTZ4+BXslxQl8
         jp4uRA0aKKsneG505KdzTM4onnoW7CFnFEeNsDTneXlL3xOfZg5QPbbdKjthrpuQgUVi
         CUUNFZ0pcrff0nkvuEsMXs9APKZ73JfTZTCC9ciOLDISenXoi4bF2WTlWehmm9MzQgwz
         w4o0N+LD97fCnX2vmhj5feADqWpqCU6jecdNB1d4BA3Nz8ciJb1x1qgqRe7yFsbRUzvl
         Y7q6wTFVJX/Xm5NSex23wqs9ZYq5ZWjtQAfk0fK9VGIjTBHB9mu6w07+lFHkAwCjsgoJ
         fcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D8MGakRy9ZNPNyMHEJmpxYjL2GAt9loTUCwueusu3k4=;
        b=N5jp7s+qCXUQ6/Q/q/e/wOQYH7yn7GVpj26OHS+ZfibDCnC0TmHs99TMSOWj3PjQ9Q
         O8koPWrv1hKuy3ms7lO3WO+GqNPLC2JE/poDfQpPklhd41RDguyCyhD3xvo3Es6iYlCm
         v2fTxKDV25XTV7BeC7kpW8xOelp6WVHijY6+3F0JeQKMU+Y1Z3sP7MdSzS+CIVSBVIMh
         /weEQgO3ItD5PnVqmvd5YBB99Xug1TEFV9E6+Qq2R3LTKXSYpBbpYgsr447KYdv7lW2L
         DRsFPwf37K1uqgzSTzcUphs0feodzifAu34hwiRXcFXDpBu6bT+uosnAZ1OQDPcd//9q
         m5vQ==
X-Gm-Message-State: AJcUukfEwHk/vLEQ5XddKftQFVLH4L0dLh2koGNkqom5BHyRUJ4EbinT
        YBFekbRPKbwFP1OOBUjDwpU=
X-Google-Smtp-Source: ALg8bN4sc7vUhdqxdGfVi1+YeNEvFWJ2xlNDfHgCqMb6AZIJkAIiD8Uett/Ix5VXF86l1HwA/C9kcA==
X-Received: by 2002:a2e:63cd:: with SMTP id s74-v6mr33339090lje.117.1546887203037;
        Mon, 07 Jan 2019 10:53:23 -0800 (PST)
Received: from acerlaptop.localnet ([2a02:a315:5445:5300:c050:d453:6c2:1d01])
        by smtp.gmail.com with ESMTPSA id g24sm2121220lfh.33.2019.01.07.10.53.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 10:53:22 -0800 (PST)
From:   =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, xc-racer2@live.ca,
        Simon Shields <simon@lineageos.org>
Subject: Re: [PATCH v2 5/7] Input: dt-bindings: tm2-touchkey: Document new keycodes property
Date:   Mon, 07 Jan 2019 19:53:20 +0100
Message-ID: <5195258.Y6g2Bltml4@acerlaptop>
In-Reply-To: <CAL_JsqLoyQDzyhFvXn=DEucdh-9uwvrcXBK38izeGPdQsuv=Zw@mail.gmail.com>
References: <20181228154609.14846-1-pawel.mikolaj.chmiel@gmail.com> <CAKdAkRQ6iO5bSUkSuPOUXMy46W1kENqg3ev=i+75459wfWAhfw@mail.gmail.com> <CAL_JsqLoyQDzyhFvXn=DEucdh-9uwvrcXBK38izeGPdQsuv=Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia czwartek, 3 stycznia 2019 19:27:39 CET Rob Herring pisze:
> On Fri, Dec 28, 2018 at 4:52 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > On Fri, Dec 28, 2018 at 2:47 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Fri, 28 Dec 2018 16:46:07 +0100, =3D?UTF-8?q?Pawe=3DC5=3D82=3D20Ch=
miel?=3D wrote:
> > > > From: Jonathan Bakker <xc-racer2@live.ca>
> > > >
> > > > Document new optional property for setting custom keycodes.
> > > >
> > > > Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> > > > Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > > > ---
> > > > Changes from v1:
> > > >   - Because key codes could be bigger than 255, use ints for keycod=
es
> > > > ---
> > > >  .../devicetree/bindings/input/cypress,tm2-touchkey.txt        | 4 =
++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > >
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> >
> > Shouldn't this be "linux,keycodes" though?
>=20
> Sigh, yes.
>=20
> Rob
I'll send v3 version with this property name fixed (both in documentation a=
nd in driver).

Thanks



