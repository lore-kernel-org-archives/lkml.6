Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B3CC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB2F20815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546540075;
	bh=fpxd2g8yGu7xI5noWEvFmUrifHbuytJ96obkqpH4sRs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aijpPSBthkPUWJRNQOtfC+PxrQEfzgD1btXgfhf8hO7R9hIKNj16SYeF/qJ2ozPD1
	 ud3njZcepgioydS3aE6o9aGc3+fmOZxUeggZEV9nrn4hyqCh3l49/YL93ejZgu/l0D
	 JZLL2KkHJExqC+F34lqixydwfYr+4K1A8AE+4358=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732075AbfACS1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 13:27:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:55614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730506AbfACS1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 13:27:52 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BCA92184B;
        Thu,  3 Jan 2019 18:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546540071;
        bh=fpxd2g8yGu7xI5noWEvFmUrifHbuytJ96obkqpH4sRs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0NmAWKu+mvKTEpEz3Zv1oE47L55P82bwn6qvGsUJeHZv2WR9CvUFFHTJSciBlq/JU
         jGlY0c8MHqw98wqbnsXeYK4Y0FyPv9cvUKEPmiWIZv3TZcD9wFIkQMNXRQ/BgaM16m
         7dxsS0l4QWSgOmZeG557Pc3gGhrYTD+w1DjVdxEw=
Received: by mail-qt1-f172.google.com with SMTP id i7so37865247qtj.10;
        Thu, 03 Jan 2019 10:27:51 -0800 (PST)
X-Gm-Message-State: AJcUukceBNtKWJYnE/+3xNE2nP5K7iMIZfBDKZVObk4+v+S7lR/4AUHJ
        ivuLVgS0h1t9yi9f0GuqDHWyPyu8pwIIi2rLYQ==
X-Google-Smtp-Source: ALg8bN4I8uEOgWuBV/Q46BjR9UpUotl4K5ogwo8Ujl9lcvRuFGgLAC5FdRVxWthtmGQ7BiwY8bQa0TCHy1smt9uujFE=
X-Received: by 2002:a0c:9e05:: with SMTP id p5mr47142289qve.246.1546540070302;
 Thu, 03 Jan 2019 10:27:50 -0800 (PST)
MIME-Version: 1.0
References: <20181228154609.14846-1-pawel.mikolaj.chmiel@gmail.com>
 <20181228154609.14846-6-pawel.mikolaj.chmiel@gmail.com> <20181228224707.GA7218@bogus>
 <CAKdAkRQ6iO5bSUkSuPOUXMy46W1kENqg3ev=i+75459wfWAhfw@mail.gmail.com>
In-Reply-To: <CAKdAkRQ6iO5bSUkSuPOUXMy46W1kENqg3ev=i+75459wfWAhfw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 3 Jan 2019 12:27:39 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLoyQDzyhFvXn=DEucdh-9uwvrcXBK38izeGPdQsuv=Zw@mail.gmail.com>
Message-ID: <CAL_JsqLoyQDzyhFvXn=DEucdh-9uwvrcXBK38izeGPdQsuv=Zw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] Input: dt-bindings: tm2-touchkey: Document new
 keycodes property
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, xc-racer2@live.ca,
        Simon Shields <simon@lineageos.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 4:52 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Fri, Dec 28, 2018 at 2:47 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, 28 Dec 2018 16:46:07 +0100, =3D?UTF-8?q?Pawe=3DC5=3D82=3D20Chmi=
el?=3D wrote:
> > > From: Jonathan Bakker <xc-racer2@live.ca>
> > >
> > > Document new optional property for setting custom keycodes.
> > >
> > > Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> > > Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > > ---
> > > Changes from v1:
> > >   - Because key codes could be bigger than 255, use ints for keycodes
> > > ---
> > >  .../devicetree/bindings/input/cypress,tm2-touchkey.txt        | 4 ++=
++
> > >  1 file changed, 4 insertions(+)
> > >
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
>
> Shouldn't this be "linux,keycodes" though?

Sigh, yes.

Rob
