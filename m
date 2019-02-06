Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B70C4151A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 05:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0798218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 05:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R2S8rtMP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfBFFtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 00:49:17 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38638 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfBFFtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 00:49:17 -0500
Received: by mail-ot1-f67.google.com with SMTP id e12so10044102otl.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 21:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5XdPfqI5m+QtBZBDbz3/feAm23EVaZed+O1YYU9qedo=;
        b=R2S8rtMPTFUISHM1rv3K057AbyoiOjhtENAu29Ov712/yOcqYH1YPu258SopWxhtDP
         G6/HeegaMrlUEkyj9DqZV6+a4WBbPbZmx/nUAp1r4DTtxSBWAGUJpP662hwxcLQxNMAp
         JOJKS0ip4MxEpc+o/0A6HIGjnezJx6yJX2TiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5XdPfqI5m+QtBZBDbz3/feAm23EVaZed+O1YYU9qedo=;
        b=TwExYnLq2Vd8ldgDRnoMQgybXZ/Sp3L7P/pGYACceRDmClL05/Eh4w9T6QqNJXjxP5
         WEuleJU8bnIgiQszOhIYTxJeSyTWmeXG9SoOON+DqGBJLJaMfpYdU9cp5yeEnqsqtEbq
         nW5frjie5l0TWJqbM/dWWIPq/H/ekQ4RTQy47ZliExfgzOuqCqdM9eIDPWFZ15cM70GB
         QTQ5vbVkYpwgduIZvUvDP06IOkLRsSuy4Ttroo5Q+tjMSOQX9oyYI+S2jOSoOKf2k3BK
         1bOjJp62LvCzB0fUYerIKBUMY2n5jhaYukF0/mBFZTBtGihJg2HCXYX3feAm73fYV9pu
         RH/w==
X-Gm-Message-State: AHQUAuafjNho2wY4+ms9nDzf+EjjmzCHbOxP/4um/6ssrrFv+Gh2c315
        UNnyDzWQ6IZlaRxQl32ESsbshsX6OxkqxQ==
X-Google-Smtp-Source: AHgI3Ia6qMpdJ9//ywWUw0o5/Y9DK7jiK7gir+1U0PgMClFGZQk/IUNFh92hQBsTmeDggNM4czLszw==
X-Received: by 2002:aca:3856:: with SMTP id f83mr4612066oia.147.1549432155294;
        Tue, 05 Feb 2019 21:49:15 -0800 (PST)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com. [209.85.210.44])
        by smtp.gmail.com with ESMTPSA id z18sm8545423otp.41.2019.02.05.21.49.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 21:49:14 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id w25so9946014otm.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 21:49:13 -0800 (PST)
X-Received: by 2002:aca:c312:: with SMTP id t18mr4773464oif.92.1549432153279;
 Tue, 05 Feb 2019 21:49:13 -0800 (PST)
MIME-Version: 1.0
References: <20181022144901.113852-1-tfiga@chromium.org> <20181022144901.113852-3-tfiga@chromium.org>
 <4cd223f0-b09c-da07-f26c-3b3f7a8868d7@xs4all.nl> <CAAFQd5DthE3vL+gycEBgm+aF0YhRncrfBVBNLLF4g+oKhBHEWQ@mail.gmail.com>
 <75334288-69af-6680-fbe7-2dd5ef2462ea@xs4all.nl> <0452db20a894c1c4cce263b7e07ba274a58aa8fa.camel@ndufresne.ca>
 <CAAFQd5DGQvmdvV42Qz_yRVk1XCaYH6AMxWJgJ_PrECBM+U65uA@mail.gmail.com> <9fd20ee01384d0bd8e395c6cf52ed8dc9d47ff06.camel@ndufresne.ca>
In-Reply-To: <9fd20ee01384d0bd8e395c6cf52ed8dc9d47ff06.camel@ndufresne.ca>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 6 Feb 2019 14:49:02 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BSvbeRB4XSpaORKmKP1_fhEtqm9Q10M7zJ0Evp0GPMLg@mail.gmail.com>
Message-ID: <CAAFQd5BSvbeRB4XSpaORKmKP1_fhEtqm9Q10M7zJ0Evp0GPMLg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] media: docs-rst: Document memory-to-memory video
 encoder interface
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?B?UGF3ZcWCIE/Fm2NpYWs=?= <posciak@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Kamil Debski <kamil@wypas.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jeongtae Park <jtp.park@samsung.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Todor Tomov <todor.tomov@linaro.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dave.stevenson@raspberrypi.org,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Maxime Jourdan <maxi.jourdan@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 12:06 AM Nicolas Dufresne <nicolas@ndufresne.ca> wr=
ote:
>
> Le vendredi 25 janvier 2019 =C3=A0 12:59 +0900, Tomasz Figa a =C3=A9crit =
:
> > On Fri, Jan 25, 2019 at 5:14 AM Nicolas Dufresne <nicolas@ndufresne.ca>=
 wrote:
> > > Le mercredi 23 janvier 2019 =C3=A0 14:04 +0100, Hans Verkuil a =C3=A9=
crit :
> > > > > > Does this return the same set of formats as in the 'Querying Ca=
pabilities' phase?
> > > > > >
> > > > >
> > > > > It's actually an interesting question. At this point we wouldn't =
have
> > > > > the OUTPUT resolution set yet, so that would be the same set as i=
n the
> > > > > initial query. If we set the resolution (with some arbitrary
> > > > > pixelformat), it may become a subset...
> > > >
> > > > But doesn't setting the capture format also set the resolution?
> > > >
> > > > To quote from the text above:
> > > >
> > > > "The encoder will derive a new ``OUTPUT`` format from the ``CAPTURE=
`` format
> > > >  being set, including resolution, colorimetry parameters, etc."
> > > >
> > > > So you set the capture format with a resolution (you know that), th=
en
> > > > ENUM_FMT will return the subset for that codec and resolution.
> > > >
> > > > But see also the comment at the end of this email.
> > >
> > > I'm thinking that the fact that there is no "unset" value for pixel
> > > format creates a certain ambiguity. Maybe we could create a new pixel
> > > format, and all CODEC driver could have that set by default ? Then we
> > > can just fail STREAMON if that format is set.
> >
> > The state on the CAPTURE queue is actually not "unset". The queue is
> > simply not ready (yet) and any operations on it will error out.
>
> My point was that it's just awkward to have this "not ready" state, in
> which you cannot go back. And in which the enum-format will ignore the
> format configured on the other side.
>
> What I wanted to say is that this special case is not really needed.
>

Yeah, I think we may actually end up going in that direction, as you
probably noticed in the discussion over the "venus: dec: make decoder
compliant with stateful codec API" patch [1].

[1] https://patchwork.kernel.org/patch/10768539/#22462703

> >
> > Once the application sets the coded resolution on the OUTPUT queue or
> > the decoder parses the stream information, the CAPTURE queue becomes
> > ready and one can do the ioctls on it.
> >
> > > That being said, in GStreamer, I have split each elements per CODEC,
> > > and now only enumerate the information "per-codec". That makes me thi=
nk
> > > this "global" enumeration was just a miss-use of the API / me learnin=
g
> > > to use it. Not having to implement this rather complex thing in the
> > > driver would be nice. Notably, the new Amlogic driver does not have
> > > this "Querying Capabilities" phase, and with latest GStreamer works
> > > just fine.
> >
> > What do you mean by "doesn't have"? Does it lack an implementation of
> > VIDIOC_ENUM_FMT and VIDIOC_ENUM_FRAMESIZES?
>
> What it does is that it sets a default value for the codec format, so
> if you just open the device and do enum_fmt/framesizes, you get that is
> possible for the default codec that was selected. And I thin it's
> entirely correct, doing ENUM_FMT(capture) without doing an
> S_FMT(output) can easily be documented as undefined behaviour.

Okay.

>
> For proper enumeration would be:
>
> for formats on OUTPUT device:
>   S_FMT(OUTPUT):
>   for formats on CAPTURE device:
>     ...
>
> (the pseudo for look represent an enum operation)

And that's how it's defined in v3. There is no default state without
any codec selected.

Best regards,
Tomasz
