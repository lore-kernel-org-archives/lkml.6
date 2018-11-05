Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A449C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC06720825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mN54bIRc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC06720825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388159AbeKFHyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:54:43 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44166 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387974AbeKFHym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 02:54:42 -0500
Received: by mail-io1-f66.google.com with SMTP id c6-v6so7788656iob.11;
        Mon, 05 Nov 2018 14:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9jT8KMt482PAmoOYaAI+IfKQr30z48B/J1PUuehyUos=;
        b=mN54bIRc30Cxxk1MFvq2n+++8Sp19R9RrS5xDR9zdpfLtLp37Pe5hONf42tLbWKNTW
         fW33PUcjZovlFydCqdooagB7s4nCnuXgr5tqWVbQW212/q1RA5aoOlAZFXLt4SPb4J2y
         vbfprS460LKalDJoHxUW29keKwEV+be5uI0bsYNXPKoUL1XuxCLPuQyGREz9o3GeSx4o
         NSdOTNMbHIHhw7hSSJyiW92h91dYgTYZJ1lQP6qT1wOAgYbcg8OiFzPPFd66V+Slxq6e
         O/Tz8QV7WOjnRIdmtA7szDktBSq9mISa/1An3wuN4EblA+HskHgp2oDCFZ/9HIcclRtp
         qd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9jT8KMt482PAmoOYaAI+IfKQr30z48B/J1PUuehyUos=;
        b=H5qhhAuYeN/yR/IdPlt/SqOpP4tlhzOLsUKfYP9hN6J20B8N7UVICyk/xhTBvXqejK
         yRGL1kElr8iI5pvUprfZYadNhF/bEpwM17W61iBZUbfPyjOz+t8b80WuMZxoOQHG/q9h
         70Ao4ksZX2yQVBxd+Fo/R5mSTEkwwXLtuW8V7hlA4JtIb+SgzrEBVX4K3u6vXFEy3FXC
         7H3uAtjhTbg2v8kF+ol3qlbx6ZpxzrWlN+Zvn+tvPeqgbp0tTJIFvAnrss2ax3hl1Tt0
         m+49PsNYyANDxI/VLP/FCVLeea4q0G0l8d8h13rIp2H8n2ckDTo3cbzbPNoHOd08d7Un
         UPTQ==
X-Gm-Message-State: AGRZ1gIyFBnaUk9bgPgyI+3NsmlnYyXxLB1r1xT7i1s5ZpQLXk5Fhmfv
        myOGk123vajTr2xK5tfpJITuOrY8JTmKS8Nmf9o=
X-Google-Smtp-Source: AJdET5flP+7pPBzedmN7hCo/l3/db7EUN8FikuczLYpUP5oY1IfkVYArbMtXwHOXS5wVn4++2+eijoMtGMa1Hvb5Bvw=
X-Received: by 2002:a5e:a70e:: with SMTP id b14-v6mr19338979iod.126.1541457165813;
 Mon, 05 Nov 2018 14:32:45 -0800 (PST)
MIME-Version: 1.0
References: <20181022113306.GB2867@w540> <CAHCN7xJkc5RW73C0zruWBgyF7G0J3C5tLE=ZdfxTKbrUqs=-PQ@mail.gmail.com>
 <CAOMZO5ATm4BRzPEQOU+ZD6bHCP2Aqjp4raRYhuc+wNe0t4+C=w@mail.gmail.com>
 <CAHCN7x+csKEk25CF=teUv+F5_GoTe6_3Yqb5PODLn+AmCCm88w@mail.gmail.com>
 <d78877f8-2c23-2bf0-0a9c-cd98b855e95e@mentor.com> <CAHCN7xKhGAXs0jGv96CfOfLQfVubxzsdE9UjpDu+4NM6oLDGWw@mail.gmail.com>
 <bc034299-4a32-f248-d09a-0d1b5872a506@mentor.com> <CAHCN7xKVUgpyCb5k7s0PNXW-efySSwP25ZGMLdbFnohATPwKhg@mail.gmail.com>
 <20181023230259.GA3766@w540> <CAHCN7xJaY_916OLHvaN_q1FwM2vqH5UXzVxLAS4DuEV0icPUXg@mail.gmail.com>
 <20181024140820.GB3766@w540> <CAHCN7xKbAuTmic+L-a2o1NreSCmYBKzzvmHuUTGZtVHELFoirg@mail.gmail.com>
 <CAHCN7xLP13PDT_VhV_iQzRB+VS7N4AxY+BObtLpz4bJ6RfxfWg@mail.gmail.com> <CAOMZO5Dkwrv4k=KGit+4wFFSr=ec94OpjUW56_D_aamjNPQH6g@mail.gmail.com>
In-Reply-To: <CAOMZO5Dkwrv4k=KGit+4wFFSr=ec94OpjUW56_D_aamjNPQH6g@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 5 Nov 2018 16:32:33 -0600
Message-ID: <CAHCN7xKs=wO9dxVAo=yxjWm10jH6TmAfgYwAfAd=J2uBT3rK1w@mail.gmail.com>
Subject: Re: i.MX6 MIPI-CSI2 OV5640 Camera testing on Mainline Linux
To:     Fabio Estevam <festevam@gmail.com>
Cc:     jacopo@jmondi.org, steve_longerbeam@mentor.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        p.zabel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>,
        gstreamer-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 8:49 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Adam,
>
> On Sun, Oct 28, 2018 at 3:58 PM Adam Ford <aford173@gmail.com> wrote:
>
> > Does anyone know when the media branch get's merged into the mainline
> > kernel?  I assume we're in the merge window with 4.19 just having been
> > released.  Once these have been merged into the mainline, I'll go
> > through and start requesting they get pulled into 4.19 and/or 4.14
> > if/when appropriate.
>
> This should happen in 4.20-rc1, which will probably be out next  Sunday.
I sent an e-mail to stable with a list of a variety of patches for the
ov5640 to be applied to 4.19.y  So far all looks pretty good, but I
think I found on minor bug:

If I attempt to change just the resolution, it doesn't take.

Initial read
media-ctl --get-v4l2 "'ov5640 2-0010':0"
[fmt:UYVY8_2X8/640x480@1/30 field:none colorspace:srgb xfer:srgb
ycbcr:601 quantization:full-range]

Change resolution
# media-ctl --set-v4l2 "'ov5640 2-0010':0[fmt:UYVY2X8/720x480 field:none]"

Read it back
# media-ctl --get-v4l2 "'ov5640 2-0010':0"
[fmt:UYVY8_2X8/640x480@1/30 field:none colorspace:srgb xfer:srgb
ycbcr:601 quantization:full-range]

However, if I change the resolution AND the format to something other
than UYVY2x8, the resolution changes. I can then change the format
back to UYVY and capture and stream video at 1080p and 720x480.
I can work around this, but I thought I'd mention it.  I was trying to
figure out a patch to apply to the mailing list myself, but I wasn't
able to fix it quickly.

adam
adam
