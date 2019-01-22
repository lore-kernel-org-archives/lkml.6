Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE45C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D3E320879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PngEKGY9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfAVITn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 03:19:43 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:40422 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfAVITm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 03:19:42 -0500
Received: by mail-ot1-f53.google.com with SMTP id s5so22873983oth.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 00:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=flLZvB78DwXtSH1+mFWCoN/M9S4PPYEMAJHVIXh4lZw=;
        b=PngEKGY9Fuc8eQS1fo9NdT1JWYZQX1VeUnkUe839bJLiXi+BUQSt2CTvjLxvRdSm5K
         3wumfKoTamjm4XHYna0D/V3LfcKuxo5jafCc9mC7aX3TQoKz55BI1fY1LBdAPW7+viHl
         c0beAc0BUTdRwR7ConsXITbZD6mJJBvNwwqLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=flLZvB78DwXtSH1+mFWCoN/M9S4PPYEMAJHVIXh4lZw=;
        b=VeNgG8mjwdwogR5itIfTlMvpJyw92OlybQFyHhtwM0zzCBy9qCbiQUVL8el6+OfDCq
         M8wykqU3L6LUoe+VRg0lMO4Xxt4DWJgsIJQWFAq3Gtk54ys/8OJuggjpavE1mh4Vw4Ot
         vutNkGkvJIq7KNMICMH+G88S8dbfGHtMe2XAaeSze/7gcUdUFiCWwdJ1rS6tMsAzwikY
         89x+AQM1CUTBrKGdS+xOqsXlAOd4fk3po6QBE1kjvjBgt3eAVjR8dhG5blUf6RQ1+8/J
         vWvuqfBv8bOoxQN/nc/mo9qEtAGUAGl2L2/0320v3dL9fYQt90g+Mma1MkhBalIoGZ6t
         M1Dg==
X-Gm-Message-State: AJcUukexEPmcFtycaTtAOQuYbSPDDOqf8Ubz6JFbxlqcRu5dbrawen/8
        c4rrr48lQUJJoL5S6jHCjavQmrh3Fr1nHQ==
X-Google-Smtp-Source: ALg8bN6zZ1n1XXmr0SLUnGkWKsHWMUl8o6isObuUibhZkx+iyeQ3ME7+5gyEv2BM2lfwXQtahjzHng==
X-Received: by 2002:a9d:1715:: with SMTP id i21mr20939334ota.149.1548145181141;
        Tue, 22 Jan 2019 00:19:41 -0800 (PST)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com. [209.85.167.181])
        by smtp.gmail.com with ESMTPSA id h16sm6450229otl.29.2019.01.22.00.19.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 00:19:40 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id u18so16677252oie.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 00:19:40 -0800 (PST)
X-Received: by 2002:a54:4486:: with SMTP id v6mr7923636oiv.233.1548145180322;
 Tue, 22 Jan 2019 00:19:40 -0800 (PST)
MIME-Version: 1.0
References: <20190122062616.164838-1-acourbot@chromium.org> <9c6ceddc-62c4-e4e7-9e27-b8213d8adb42@xs4all.nl>
In-Reply-To: <9c6ceddc-62c4-e4e7-9e27-b8213d8adb42@xs4all.nl>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Tue, 22 Jan 2019 17:19:28 +0900
X-Gmail-Original-Message-ID: <CAPBb6MVSJ1jfGXknJMFFkYjCy1z_mJ_MLOKB=kW1tYg33cppmg@mail.gmail.com>
Message-ID: <CAPBb6MVSJ1jfGXknJMFFkYjCy1z_mJ_MLOKB=kW1tYg33cppmg@mail.gmail.com>
Subject: Re: [PATCH v2] media: docs-rst: Document m2m stateless video decoder interface
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <posciak@chromium.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 5:06 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 01/22/2019 07:26 AM, Alexandre Courbot wrote:
> > Documents the protocol that user-space should follow when
> > communicating with stateless video decoders.
> >
> > The stateless video decoding API makes use of the new request and tags
> > APIs. While it has been implemented with the Cedrus driver so far, it
> > should probably still be considered staging for a short while.
> >
> > Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> > ---
> > Changes since v1:
> >
> > * Use timestamps instead of tags to reference frames,
> > * Applied Paul's suggestions to not require one frame worth of data per OUTPUT
> >   buffer
> >
> > One of the effects of requiring sub-frame units to be submitted per request is
> > that the stateless decoders are not exactly "stateless" anymore: if a frame is
> > made of several slices, then the decoder must keep track of the buffer in which
> > the current frame is being decoded between requests, and all the slices for the
> > current frame must be submitted before we can consider decoding the next one.
> >
> > Also if we decide to force clients to submit one slice per request, then doesn't
> > some of the H.264 controls need to change? For instance, in the current v2
> > there is still a v4l2_ctrl_h264_decode_param::num_slices member. It is used in
> > Chromium to specify the number of slices given to the
> > V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAMS control, but is apparently ignored by the
> > Cedrus driver. Maxime, can you comment on this?
> >
> >  Documentation/media/uapi/v4l/dev-codec.rst    |   5 +
> >  .../media/uapi/v4l/dev-stateless-decoder.rst  | 378 ++++++++++++++++++
> >  2 files changed, 383 insertions(+)
> >  create mode 100644 Documentation/media/uapi/v4l/dev-stateless-decoder.rst
> >
>
> Thank you! I have uploaded a version of the V4L2 spec with this and the two older
> stateful codec patches applied:
>
> https://hverkuil.home.xs4all.nl/codec-api/uapi/v4l/dev-codec.html

Thanks! A v3 will likely be necessary (and I'll likely be more
reactive producing it) because of that one-slice-per-request
requirement. After discussing with Tomasz we think it would be
safer/simpler to require one frame per request in a first time, as we
initially agreed.

Anyway, we can discuss the details once Tomasz chimes in.
