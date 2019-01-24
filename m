Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F74C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70DEE20854
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eLwzymyw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfAXJHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 04:07:13 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33241 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbfAXJHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 04:07:10 -0500
Received: by mail-oi1-f196.google.com with SMTP id c206so4288133oib.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 01:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kcuJ7o6GNo8x17v/dH/5G6NdXueyDstuYD8Zc4S9Y7s=;
        b=eLwzymywGD+CIk/31TbpTyWXUjDdnn811AZrBe5if7mUFts3Hx2POFLLXiqOvzu0XS
         iqI1nzMkWWSVMGrpr3r6HUmz4woqu0H14TEtWeU3SaT53N9gvYLeTEyPrOjj4FLCF3kx
         EwmvkfGOt2tORe2Lt/T3s5TKFolFWT1TqfDJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kcuJ7o6GNo8x17v/dH/5G6NdXueyDstuYD8Zc4S9Y7s=;
        b=IosdS+FjKF95NnSascvMD+aYJGRqtXA7IcgOzorexn+6GB/H0K04rzDQNYSNumMFCI
         bmWRIppbexFldMCdeceplo164N9p3D8Usn/DJkciUpoLpaP6qcjxn0Evd9/x8LpPFamD
         uy4GdedIz8w1YNK+fHX0gVnfdSt0Nuw/O09orrmYuzRKftR4nhftPlZOwAUdgKHqQpaq
         FzYdsuXOB2J6Flx4FuFrbLzklSZ9D+YNf6sdA3DJ0vYqBhRcv+6JaQ5wYwWtH86xiQVN
         1OxNE1KQn7Gcn8NvUJLnAfFyXwrVxY0J19UdNt+sqJVHCE5TIM6A+8/v9/OMylKaclFE
         /TaA==
X-Gm-Message-State: AHQUAuZ531yS+b3D0vX7Cm4kTjLxIaaw6lRsD935Bb0JbtZBfAXYq6Ty
        i3ZUdzSbEZYNObK4tQ3c8c1vg8eI2qA=
X-Google-Smtp-Source: ALg8bN69KkV1dQU2s1yTKF53KfBgFj6WHTSFlYJzh94j0EaGxJjWcGKzcmjOQv4kZzDMzRsSIc7F9w==
X-Received: by 2002:a54:458c:: with SMTP id z12mr605186oib.293.1548320828944;
        Thu, 24 Jan 2019 01:07:08 -0800 (PST)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com. [209.85.167.177])
        by smtp.gmail.com with ESMTPSA id k11sm11604915oib.35.2019.01.24.01.07.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 01:07:07 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id a77so4250880oii.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 01:07:06 -0800 (PST)
X-Received: by 2002:aca:c2c3:: with SMTP id s186mr604655oif.173.1548320826474;
 Thu, 24 Jan 2019 01:07:06 -0800 (PST)
MIME-Version: 1.0
References: <20181022144901.113852-1-tfiga@chromium.org> <20181022144901.113852-2-tfiga@chromium.org>
 <cf0fc2fc-72c6-dbca-68f7-a349879a3a14@xs4all.nl> <CAAFQd5AORjMjHdavdr3zM13BnyFnKnEb-0aKNjvwbB_xJEnxgQ@mail.gmail.com>
 <9b7c1385-d482-6e92-2222-2daa835dbc91@xs4all.nl> <CAAFQd5DwjLt8UeDohzrMausaLGnOStvrmp5p7frYbG1hbGjx3Q@mail.gmail.com>
In-Reply-To: <CAAFQd5DwjLt8UeDohzrMausaLGnOStvrmp5p7frYbG1hbGjx3Q@mail.gmail.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 24 Jan 2019 18:06:54 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BPJv3cbJOWrziEjz_yE32DhfZv9vb-pG1Ltx-KS2=PQg@mail.gmail.com>
Message-ID: <CAAFQd5BPJv3cbJOWrziEjz_yE32DhfZv9vb-pG1Ltx-KS2=PQg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] media: docs-rst: Document memory-to-memory video
 decoder interface
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <posciak@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Kamil Debski <kamil@wypas.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jeongtae Park <jtp.park@samsung.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        =?UTF-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        =?UTF-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <andrew-ct.chen@mediatek.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Todor Tomov <todor.tomov@linaro.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dave.stevenson@raspberrypi.org,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Maxime Jourdan <maxi.jourdan@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 2:27 PM Tomasz Figa <tfiga@chromium.org> wrote:
>
> On Tue, Jan 22, 2019 at 11:47 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
> >
> > On 01/22/19 11:02, Tomasz Figa wrote:
[snip]
> > >>> +   one ``CAPTURE`` buffer, the following cases are defined:
> > >>> +
> > >>> +   * one ``OUTPUT`` buffer generates multiple ``CAPTURE`` buffers: the same
> > >>> +     ``OUTPUT`` timestamp will be copied to multiple ``CAPTURE`` buffers,
> > >>> +
> > >>> +   * multiple ``OUTPUT`` buffers generate one ``CAPTURE`` buffer: timestamp of
> > >>> +     the ``OUTPUT`` buffer queued last will be copied,
> > >>> +
> > >>> +   * the decoding order differs from the display order (i.e. the
> > >>> +     ``CAPTURE`` buffers are out-of-order compared to the ``OUTPUT`` buffers):
> > >>> +     ``CAPTURE`` timestamps will not retain the order of ``OUTPUT`` timestamps
> > >>> +     and thus monotonicity of the timestamps cannot be guaranteed.
> >
> > I think this last point should be rewritten. The timestamp is just a value that
> > is copied, there are no monotonicity requirements for m2m devices in general.
> >
>
> Actually I just realized the last point might not even be achievable
> for some of the decoders (s5p-mfc, mtk-vcodec), as they don't report
> which frame originates from which bitstream buffer and the driver just
> picks the most recently consumed OUTPUT buffer to copy the timestamp
> from. (s5p-mfc actually "forgets" to set the timestamp in some cases
> too...)
>
> I need to think a bit more about this.

Actually I misread the code. Both s5p-mfc and mtk-vcodec seem to
correctly match the buffers.

Best regards,
Tomasz
