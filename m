Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBD8C282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59FD2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HlYComox"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbfA3GSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 01:18:04 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37210 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfA3GSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 01:18:02 -0500
Received: by mail-ot1-f66.google.com with SMTP id s13so20183135otq.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 22:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GfCCtscXzLcTgBfRtd84na+8CHfmvOKBgex8G5OBlQU=;
        b=HlYComox3+pCn2czVeA91Mt70maiWPhR92XarngZ15ztgKD9tzMUbwAzZb2Gmwmnnp
         XuFBC9Pob6HZymPD5s5gSJX1K+aXG4wO6o6GrxDX/zsKR60h5Nk50BKKiTsMDIVkmdk6
         TKIduGAvBOuE3RtHP+AEtfD9b/rcSPNZMqpic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GfCCtscXzLcTgBfRtd84na+8CHfmvOKBgex8G5OBlQU=;
        b=aHrajrsuBNEw9zcYu85rvW7h+cyJhYpFnI4ws/TwuarIPZorqr4UyMtqXU+ENObu4D
         ttI+ARPJ0QQeqdB4AufasFZkgghTU7FUxGbxJClIbEFZP+5b+k79bXaGlq9UWEMqmzMI
         LqzNnbRiD2fCrhYnVtDOtMK7qxrY4zvc9Re/QP9NKRAHsGdgTnOJKSu/hvUtncMpc/Fk
         kycnBNHylVvjPZBSORD0PXxj1agkhHPh94ro5z+Xjafak9BCRdjhZnDlg8I+0kEJ6n01
         ZtLaAEussvmZ4GF9PzGO/c3hO2cTeECDT5ysOd6yW9C6aHzu6acDwS/7JDzmqhdVQnNK
         SVEA==
X-Gm-Message-State: AJcUukfz9+20TYUKo4+8zOQyVwm1E4mipoj3p9f7LgbNBLzeyo7elpNa
        0s7wUicLnkiujUgGa8DE7vp5Nh+0wD4=
X-Google-Smtp-Source: ALg8bN442liN3/H0ShFznjPBWn6xl19P7ksz8fuaIGCBjc146nxADItFmFIrBQNPi61fwo8fYlOnBQ==
X-Received: by 2002:a9d:6197:: with SMTP id g23mr21007032otk.324.1548829081389;
        Tue, 29 Jan 2019 22:18:01 -0800 (PST)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com. [209.85.210.44])
        by smtp.gmail.com with ESMTPSA id y25sm249382otk.50.2019.01.29.22.17.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 22:17:58 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id n8so20185142otl.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 22:17:58 -0800 (PST)
X-Received: by 2002:a9d:6546:: with SMTP id q6mr22782709otl.288.1548829077886;
 Tue, 29 Jan 2019 22:17:57 -0800 (PST)
MIME-Version: 1.0
References: <20190117162008.25217-1-stanimir.varbanov@linaro.org>
 <20190117162008.25217-11-stanimir.varbanov@linaro.org> <CAAFQd5Cm1zyPzJnixwNmWzxn2zh=63YrA+ZzH-arW-VZ_x-Awg@mail.gmail.com>
 <28069a44-b188-6b89-2687-542fa762c00e@linaro.org> <CAAFQd5BevOV2r1tqmGPnVtdwirGMWU=ZJU85HjfnH-qMyQiyEg@mail.gmail.com>
 <affce842d4f015e13912b2c3941c9bf02e84d194.camel@ndufresne.ca>
 <CAAFQd5Ahg4Di+SBd+-kKo4PLVyvqLwcuG6MphU5Rz1PFXVuamQ@mail.gmail.com> <e8a90694c306fde24928a569b7bcb231b86ec73b.camel@ndufresne.ca>
In-Reply-To: <e8a90694c306fde24928a569b7bcb231b86ec73b.camel@ndufresne.ca>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 30 Jan 2019 15:17:46 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DFfQRd1VoN7itVXnWGKW_WBKU-sm6vo5CdgjkzjEEkFg@mail.gmail.com>
Message-ID: <CAAFQd5DFfQRd1VoN7itVXnWGKW_WBKU-sm6vo5CdgjkzjEEkFg@mail.gmail.com>
Subject: Re: [PATCH 10/10] venus: dec: make decoder compliant with stateful
 codec API
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Malathi Gottam <mgottam@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 1:21 PM Nicolas Dufresne <nicolas@ndufresne.ca> wro=
te:
>
> Le mercredi 30 janvier 2019 =C3=A0 12:38 +0900, Tomasz Figa a =C3=A9crit =
:
> > > Yes, unfortunately, GStreamer still rely on G_FMT waiting a minimal
> > > amount of time of the headers to be processed. This was how things wa=
s
> > > created back in 2011, I could not program GStreamer for the future. I=
f
> > > we stop doing this, we do break GStreamer as a valid userspace
> > > application.
> >
> > Does it? Didn't you say earlier that you end up setting the OUTPUT
> > format with the stream resolution as parsed on your own? If so, that
> > would actually expose a matching framebuffer format on the CAPTURE
> > queue, so there is no need to wait for the real parsing to happen.
>
> I don't remember saying that, maybe I meant to say there might be a
> workaround ?
>
> For the fact, here we queue the headers (or first frame):
>
> https://gitlab.freedesktop.org/gstreamer/gst-plugins-good/blob/master/sys=
/v4l2/gstv4l2videodec.c#L624
>
> Then few line below this helper does G_FMT internally:
>
> https://gitlab.freedesktop.org/gstreamer/gst-plugins-good/blob/master/sys=
/v4l2/gstv4l2videodec.c#L634
> https://gitlab.freedesktop.org/gstreamer/gst-plugins-good/blob/master/sys=
/v4l2/gstv4l2object.c#L3907
>
> And just plainly fails if G_FMT returns an error of any type. This was
> how Kamil designed it initially for MFC driver. There was no other
> alternative back then (no EAGAIN yet either).

Hmm, was that ffmpeg then?

So would it just set the OUTPUT width and height to 0? Does it mean
that gstreamer doesn't work with coda and mtk-vcodec, which don't have
such wait in their g_fmt implementations?

>
> Nicolas
>
> p.s. it's still in my todo's to implement source change event as I
> believe it is a better mechanism (specially if you header happened to
> be corrupted, then the driver can consume the stream until it finds a
> sync). So these sleep or normally wait exist all over to support this
> legacy thing. It is unfortunate, the question is do you want to break
> userspace now ? Without having first placed a patch that would maybe
> warn or something for a while ?
>

I don't want and my understanding was that we could workaround it by
the propagation of format from OUTPUT to CAPTURE. Also see above.

Best regards,
Tomasz
