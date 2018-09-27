Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F7BC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4433B21580
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bnNAMTz1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4433B21580
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeI0PEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:04:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39605 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbeI0PEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:04:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id s14-v6so1644103wrw.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 01:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SS501q2nk0JCjtwSzoLBddA6AbzxIwH+VUFgrD9LafA=;
        b=bnNAMTz1QvrfZisIbyM8X8zBfJo2mV7S3ql8qqCj376iLZrc7iISLsIyP4bLxjNtMe
         nIhUD+gs019qwtZv1YPzu3wQ5PgVPCrk+bIFVlsSNNycSIpeYRIJiavOGt3KQS32JGjA
         6r5cKzmK06Q8rMaAFBbw6Ya2YOfgh2BNgsYtHzLhnDAj0xlUzXvmSn9C0xyEexyaJazo
         vFQAXTLerhcNDtWyMWqi1yVn+xFhvaYw07ubzC/KRklYyyUolnFCKkhTElZxHbY+TFFE
         oHlUySalxGoP5ndDr/ofnScjS6O9B5oSBCmJPDUjEjVuBtkWvaUz41HRgkPQtW/Wv42U
         /n4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SS501q2nk0JCjtwSzoLBddA6AbzxIwH+VUFgrD9LafA=;
        b=jlfBxANWzEz+fT0g+ziqhB9jW7XO2bkbHO2JtZb6uvkhVRdp6/eaADombs/kZNn/Fb
         Naw423GNGaGv88FZL6gaeATNZTddCZaPE/l49VzOxXhx+V7fn50Kby4l01vH8j8o7Vvi
         KmHKPdxJZIrX9EHbTH89JqFRa2o+53GDJSszajV6RNzTKW6hGBMbzhYm4gyLrY2mPLW9
         k+r1vuLMOwGxHuLAx3jWXWugnHPV2yQSLPkqK8UA++yePeRGNSelIiIX5bV2lf7GZs0r
         dLyGc/CdtwWS/VcHUwZOzwyDnCYymd+NdJdRtbqartOtYdfC3dAUE/Ix3dz5DPXFJMLR
         qzUQ==
X-Gm-Message-State: ABuFfojoUhBOB88YMgC3XH51+1EoCc43QO4SIUszDErTCio2bNyMlMPE
        PAQL7SxuTrcGe4YOWNIpFSEUn9CXFB2CktbZkFcS3g==
X-Google-Smtp-Source: ACcGV63h0mZZGsG/N2NPxHFlenXXbZLAcWYOvqdk7gpAACmQ2iFVulFMaYHd5+klItU1hFvd6OSw2nhss2ev9oSTmUc=
X-Received: by 2002:adf:fdca:: with SMTP id i10-v6mr8327518wrs.276.1538038020902;
 Thu, 27 Sep 2018 01:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180911150938.3844-1-mjourdan@baylibre.com> <9c33c57e-2ce2-8752-b851-f85c03a7d761@xs4all.nl>
 <CAMO6nay7u4nMZcND6+g-GJAFsFcGrp_GDKBhVjeXVzpjF0ND4Q@mail.gmail.com> <8b8af340-8bd7-092a-4203-fd01fd0cc5c6@xs4all.nl>
In-Reply-To: <8b8af340-8bd7-092a-4203-fd01fd0cc5c6@xs4all.nl>
From:   Maxime Jourdan <mjourdan@baylibre.com>
Date:   Thu, 27 Sep 2018 10:46:49 +0200
Message-ID: <CAMO6naxf_+HiRf8fEs65NP+c1OLMvPSs71SKxwWg-zZO+mSiyw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add Amlogic video decoder driver
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
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

Le ven. 21 sept. 2018 =C3=A0 12:51, Hans Verkuil <hverkuil@xs4all.nl> a =C3=
=A9crit :
>
> On 09/17/18 18:36, Maxime Jourdan wrote:
> > 2018-09-17 16:51 GMT+02:00 Hans Verkuil <hverkuil@xs4all.nl>:
> >> On 09/11/2018 05:09 PM, Maxime Jourdan wrote:
> >>>  - Moved the single instance check (returning -EBUSY) to start/stop s=
treaming
> >>>  The check was previously in queue_setup but there was no great locat=
ion to
> >>>  clear it except for .close().
> >>
> >> Actually, you can clear it by called VIDIOC_REQBUFS with count set to =
0. That
> >> freed all buffers and clears this.
> >>
> >> Now, the difference between queue_setup and start/stop streaming is th=
at if you
> >> do this in queue_setup you'll know early on that the device is busy. I=
t is
> >> reasonable to assume that you only allocate buffers when you also want=
 to start
> >> streaming, so that it a good place to know this quickly.
> >>
> >> Whereas with start_streaming you won't know until you call STREAMON, o=
r even later
> >> if you start streaming with no buffers queued, since start_streaming w=
on't
> >> be called until you have at least 'min_buffers_needed' buffers queued =
(1 for this
> >> driver). So in that case EBUSY won't be returned until the first VIDIO=
C_QBUF.
> >>
> >> My preference is to check this in queue_setup, but it is up to you to =
decide.
> >> Just be aware of the difference between the two options.
> >>
> >> Regards,
> >>
> >>         Hans
> >
> > I could for instance keep track of which queue(s) have been called
> > with queue_setup, catch calls to VIDIOC_REQBUFS with count set to 0,
> > and clear the current session once both queues have been reset ?
>
> I see your point, this is rather awkward. The real problem here is that
> we don't have a 'queue_free' callback. If we'd had that this would be
> a lot easier.
>
> In any case, I am dropping my objections to doing this in start/stop_stre=
aming.

Ack.

> > You leverage another issue with min_buffers_needed. It's indeed set to
> > 1 but this value is wrong for the CAPTURE queue. The problem is that
> > this value changes depending on the codec and the amount of CAPTURE
> > buffers requested by userspace.
> > Ultimately I want it set to the total amount of CAPTURE buffers,
> > because the hardware needs the full buffer list before starting a
> > decode job.
> > Am I free to change this queue parameter later, or is m2m_queue_init
> > the only place to do it ?
>
> It has to be set before the VIDIOC_STREAMON. After that you cannot
> change it anymore.
>
> But I don't think this is all that relevant, since this is something
> that the job_ready() callback should take care of. min_buffers_needed
> is really for hardware where the DMA engine cannot start unless that
> many buffers are queued. But in that case the DMA runs continuously
> capturing video, whereas here these are jobs and the DMA is only
> started when you can actually execute a job.

After doing some testing, overriding min_buffers_needed in queue_setup
is what works best for me.

When doing the initialization in start_streaming, the complete buffer
list needs to be configured in HW. The firmware can then choose any
buffer from this list during decoding later on.

I do this initialization by iterating with v4l2_m2m_for_each_dst_buf,
which requires all CAPTURE buffers to be queued in.

Cheers,
Maxime

> Regards,
>
>         Hans
