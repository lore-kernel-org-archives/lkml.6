Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477EBC169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 03:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1302F21473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 03:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b9fo+dCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbfA3Dic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 22:38:32 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38961 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfA3Dia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 22:38:30 -0500
Received: by mail-oi1-f193.google.com with SMTP id i6so18090407oia.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 19:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WG16T5Ta916xsxxTdbwaAVukFnFvT60koCeC9bKHP24=;
        b=b9fo+dCXOtV2UAICwX2irmAy0bzv0tGyteSB6I0PueO6hUmnPPd6CMr7XDq1kItQPW
         BQs89WoP9CqzbO0Qhe4AtZMM8v8sja7ouuAOZpG2kpJrQKv7uhl0Ll4/AgnUdHTZvJdZ
         2nONWJ8WCeZp+KQqe8X7KloPhLpcidh2LX7do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WG16T5Ta916xsxxTdbwaAVukFnFvT60koCeC9bKHP24=;
        b=NUNqtVnPw+heSw5wLU/JXDeRZH1NMkqM/ZHxqGYj8DVzauE82bLamN5yiHkqhyou9P
         lnWCA3aFUKY4ZY7JcBsRqGB2dNxDkC5sQqqmkDWR1bbrlQsJovy9+86jc2aKqF3Gjy/7
         GNRBTtkrhf6c5Z7L3g7NkUguTApVp6z/SxGPR+g+N3U+XqVmY9x5TP3sMGKiAKbbdr2E
         Xe3dC4JcZsjazRUvG8vniXZPXk2WdpkxCnHxK9oB+ptgh/aT+j+jinkIJHJpdVB70fiw
         sqE1sXRgCMCcj93W087nWZ5cDiYUZAKZzMmtnIGSGUJBXdY19PegM/U0AJbgF91NqSLt
         5y+w==
X-Gm-Message-State: AJcUukcMTs/0SRIxIBwws3fy+DFwx3g6eClCo3b+pBigIf0H6iZjpLth
        dr2FCg188PK655i/2KtLLxnfC7FMFxY=
X-Google-Smtp-Source: AHgI3IZIlI736l8hC4ajwpc1DlosZrRu8g2OZknMgkClqKUqPdCfw3t8Rl1gTaVVx1ORo3f09FJthw==
X-Received: by 2002:aca:b302:: with SMTP id c2mr10665263oif.144.1548819509195;
        Tue, 29 Jan 2019 19:38:29 -0800 (PST)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com. [209.85.210.46])
        by smtp.gmail.com with ESMTPSA id u109sm157833otb.8.2019.01.29.19.38.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 19:38:28 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id a11so19929218otr.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 19:38:27 -0800 (PST)
X-Received: by 2002:a9d:6f8e:: with SMTP id h14mr20775029otq.241.1548819507218;
 Tue, 29 Jan 2019 19:38:27 -0800 (PST)
MIME-Version: 1.0
References: <20190117162008.25217-1-stanimir.varbanov@linaro.org>
 <20190117162008.25217-11-stanimir.varbanov@linaro.org> <CAAFQd5Cm1zyPzJnixwNmWzxn2zh=63YrA+ZzH-arW-VZ_x-Awg@mail.gmail.com>
 <28069a44-b188-6b89-2687-542fa762c00e@linaro.org> <CAAFQd5BevOV2r1tqmGPnVtdwirGMWU=ZJU85HjfnH-qMyQiyEg@mail.gmail.com>
 <affce842d4f015e13912b2c3941c9bf02e84d194.camel@ndufresne.ca>
In-Reply-To: <affce842d4f015e13912b2c3941c9bf02e84d194.camel@ndufresne.ca>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 30 Jan 2019 12:38:16 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Ahg4Di+SBd+-kKo4PLVyvqLwcuG6MphU5Rz1PFXVuamQ@mail.gmail.com>
Message-ID: <CAAFQd5Ahg4Di+SBd+-kKo4PLVyvqLwcuG6MphU5Rz1PFXVuamQ@mail.gmail.com>
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

On Wed, Jan 30, 2019 at 12:18 PM Nicolas Dufresne <nicolas@ndufresne.ca> wr=
ote:
>
> Le lundi 28 janvier 2019 =C3=A0 16:38 +0900, Tomasz Figa a =C3=A9crit :
> > > > Nope, that's not what is expected to happen here. Especially since
> > > > you're potentially in non-blocking IO mode. Regardless of that, the
> > >
> > > OK, how to handle that when userspace (for example gstreamer) hasn't
> > > support for v4l2 events? The s5p-mfc decoder is doing the same sleep =
in
> > > g_fmt.
> >
> > I don't think that sleep in s5p-mfc was needed for gstreamer and
> > AFAICT other drivers don't have it. Doesn't gstreamer just set the
> > coded format on OUTPUT queue on its own? That should propagate the
> > format to the CAPTURE queue, without the need to parse the stream.
>
> Yes, unfortunately, GStreamer still rely on G_FMT waiting a minimal
> amount of time of the headers to be processed. This was how things was
> created back in 2011, I could not program GStreamer for the future. If
> we stop doing this, we do break GStreamer as a valid userspace
> application.

Does it? Didn't you say earlier that you end up setting the OUTPUT
format with the stream resolution as parsed on your own? If so, that
would actually expose a matching framebuffer format on the CAPTURE
queue, so there is no need to wait for the real parsing to happen.

>
> This is not what I want long term, but I haven't got time to add event
> support, and there is a certain amount of time (years) when this is
> implemented before all the old code goes away.
>
> Nicolas
>
