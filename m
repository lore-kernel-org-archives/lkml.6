Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCF2C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A303208E7
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Nkcb1F8p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A303208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbeJASxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 14:53:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40204 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbeJASxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 14:53:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id y8-v6so13682336wrh.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 05:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KZZaCkBotGjkg40kkrl1ywVdBe8BVVORb0GnXfIW6HQ=;
        b=Nkcb1F8pfoNGfGromIUsWKXOSa4oR50OtkaaVgGk7rsMMUmP4r41QM1DUUxC0xZQW3
         +6muR/jp/+eLxX05FAF8CgFcVCyRxYOEm16++2g8pzBTjBGueNu4xzxQDFhOF9Vv3Q4I
         a5sdIfCkUnJDCOAQdx1aCXjhE3FQiDm8YEkBt0GOeV0nWXClCkq9ec95rTHNELweBapA
         puJzAfD4XkGll4ax0FWYHAbJZ7loOVNmQA5OPenJtR7Kx8sKhlXeeA6/gEVK0uWjMnbZ
         5ACm3TZGCXnw9YHVLUU6jim84zYdAQqDZcF9kItru8o9HYMqcHLXP0ZmfQF0QooRGVfS
         5Lnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KZZaCkBotGjkg40kkrl1ywVdBe8BVVORb0GnXfIW6HQ=;
        b=Ji85/WyscoNE7ciGilkokIKLv0Cgzuz3qlISo93jXBEUweIgc0qZ6gWVeqrAbLDMWR
         1Rtett33t6mdfakkBchM/CurmYB/CCOgTHqOdyicqUG42soGQKPeSNx/kZhkH3/t1vIg
         RQ9K16fQEHWeUBugkWov3sOxxJmxqP9O90mJW4SyLZ85REB3yBFODo1FZf13b4ExLg5a
         4SvoRyh7Pe6phK36Rdn3Qhnkk9meHXzoIrEaOqfK2TeHD6dnTEFlce2sU0q4bUkGHlpp
         GZSGzSrDEjsuR7FhyNC090SXRHQCMsGRpYwOUEVz9z/d7ZerMQ4jH6lcazsXCHajiK7Z
         8Xuw==
X-Gm-Message-State: ABuFfoi7s7SAboN3rzQOgW58YEDZRL7ZABJ/E3M+yUrlcRMAf7t38SCd
        PuIzDIKlGbupiwbIP/uX1Bd0/5A6J6giv6DAsE0a+Q==
X-Google-Smtp-Source: ACcGV63fvHt7NQDXFs3DhQfhtOuYiEnIuQv4JqKFTNNGRrU1OHvPTiAz4QsYhJ60q+dyEXjvL1YUOkYRx8zju6gPYJg=
X-Received: by 2002:adf:a547:: with SMTP id j7-v6mr7512322wrb.220.1538396164489;
 Mon, 01 Oct 2018 05:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180928142816.4311-1-mjourdan@baylibre.com> <cfb89cf9-4fce-7fab-48e1-a0311b80d993@xs4all.nl>
In-Reply-To: <cfb89cf9-4fce-7fab-48e1-a0311b80d993@xs4all.nl>
From:   Maxime Jourdan <mjourdan@baylibre.com>
Date:   Mon, 1 Oct 2018 14:15:53 +0200
Message-ID: <CAMO6nayt+3e7m5AkTbsJJHzO-uyc-Jh66i3kG97CX5FabwHUOA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Add Amlogic video decoder driver
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun. 1 oct. 2018 =C3=A0 12:29, Hans Verkuil <hverkuil@xs4all.nl> a =C3=
=A9crit :
>
> On 09/28/2018 04:28 PM, Maxime Jourdan wrote:
> > Hi everyone,
> >
> > This patch series adds support for the Amlogic video decoder,
> > as well as the corresponding dt bindings for GXBB/GXL/GXM chips.
> >
> > It features decoding for the following formats:
> > - MPEG 1
> > - MPEG 2
> >
> > The following formats will be added in future patches:
> > - MJPEG
> > - MPEG 4 (incl. Xvid, H.263)
> > - H.264
> > - HEVC (incl. 10-bit)
> >
> > The following formats' development has still not started, but they are
> > supported by the hardware:
> > - VC1
> > - VP9
> >
> > The code was made in such a way to allow easy inclusion of those format=
s
> > in the future.
> >
> > The decoder is single instance.
> >
> > Files:
> >  - vdec.c handles the V4L2 M2M logic
> >  - esparser.c manages the hardware bitstream parser
> >  - vdec_helpers.c provides helpers to DONE the dst buffers as well as
> >  various common code used by the codecs
> >  - vdec_1.c manages the VDEC_1 block of the vdec IP
> >  - codec_mpeg12.c enables decoding for MPEG 1/2.
> >  - vdec_platform.c links codec units with vdec units
> >  (e.g vdec_1 with codec_mpeg12) and lists all the available
> >  src/dst formats and requirements (max width/height, etc.),
> >  per compatible chip.
> >
> > Firmwares are necessary to run the vdec. They can currently be found at=
:
> > https://github.com/chewitt/meson-firmware
>
> Are you trying to get this into the linux-firmware repository?
>
> I believe that Mauro requires that before he will merge this driver.
>
> So I think this driver will be ready to be merged once v4 is posted,
> dt-bindings is Acked and the firmware is merged to the linux-firmware rep=
o.

It was planned indeed to get the firmwares into linux-firmware, I'll
speed this up.

dt-bindings was reviewed by Rob but I forgot to add it in v3, I'll fix
that in v4.

Cheers,
Maxime

> Regards,
>
>         Hans
