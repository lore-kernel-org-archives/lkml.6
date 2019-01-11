Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF51BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F8A20879
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUEZ+CYo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbfAKCNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 21:13:42 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:50528 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbfAKCNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 21:13:42 -0500
Received: by mail-it1-f196.google.com with SMTP id z7so163828iti.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 18:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kEZdN51o1+hf6/Y7NR4RDDsCJeXFicE4OQDNDEqwPeI=;
        b=WUEZ+CYoaKOC3IT9P2iHOaxR8VPvDsRp8z9DIhlw7xWjXG4Cn6Yij2swtYRiwzVTgY
         YJJOBOdEhGLqnuc+sdgTcR+pYGmuJuN34Zzx/wu2Z7jluvyUF3C8ZdpKvK7HlKAjFaAN
         gmLbS/nqeA5Tv6q9nhi9gKXS9GIE0aNFppbFWxt+NTvg4DtIuShtIQZNdhx9Tnkj1hTA
         FzJ3CIrEVZo9EYMtXet/Qm/JNOLvOInMx1B9/avy8Vmlov3vp/KpW9q9cKDrdUpYkzK0
         klYYxqEH1yq1jTvrZRw4CjZW32q3g1OOChWL8R563lY499ApdvAtuhvm+wBAPbvX9Qw3
         9ozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kEZdN51o1+hf6/Y7NR4RDDsCJeXFicE4OQDNDEqwPeI=;
        b=HlX5rU1IAqeDnTLa+hLWhceyxtFdDuVtYvJTTJOO9imTSdqZMdPuJktb112/sGrDja
         JmAEParFGzfu8YZ3w9FCllbVZxcbKMNqfTAnSbduzqI7Rg8M0a9j3wUmWzpzUoB4DTUx
         kpUNERcoYVVyoU5vDnE8s3M79zJ2elRFk0+8r7zHKBpTvoQofqza3wM01a6f7cMm0fRp
         40283iPQcLvqgpjpeG+2iglrm0lcSyr6CxIgCzZjNZg+8SXzVVcTv55THAtwEp/ny3xP
         YnEy414nmz+g0Di4JtAOv1s9vJGhcURYbEt2aURStyOHWvEa88pg6iCbZ2M3Ax7xAjhw
         iXvA==
X-Gm-Message-State: AJcUuke6esywA0miGbtbfaEPJfk/E2UGkGNpwq/ei5bL+XWTVv/WHj9S
        ppSl8T6bwIWLRbAooxvWjadJeLtpIxNoSdoQALFtxPKHjwo=
X-Google-Smtp-Source: ALg8bN6u87d43hWSzvh4trK37lNVTX8PZ3niN42zwGg/8Lr+zdaLIgSZIZCmCU0qd1OJ2J2SxzhZgpz/p+oBdeVWRSA=
X-Received: by 2002:a24:dd8f:: with SMTP id t137mr48946itf.10.1547172820931;
 Thu, 10 Jan 2019 18:13:40 -0800 (PST)
MIME-Version: 1.0
References: <CACmrr9gHucWaWtz07kQms6AsquLKAHbK+_Q0kF=92RGo6HmAFA@mail.gmail.com>
 <20190111004337.7223-1-thirtythreeforty@gmail.com> <874laggf9y.fsf@notabene.neil.brown.name>
In-Reply-To: <874laggf9y.fsf@notabene.neil.brown.name>
From:   George Hilliard <thirtythreeforty@gmail.com>
Date:   Thu, 10 Jan 2019 19:13:29 -0700
Message-ID: <CACmrr9hiU2rwncd9sTrh0WVznybJaTP_JMXCaNMzOKDUTJwGEQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Move ralink-gdma to its own directory
To:     NeilBrown <neil@brown.name>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019, 6:21 PM NeilBrown <neil@brown.name wrote:
>
> On Thu, Jan 10 2019, thirtythreeforty@gmail.com wrote:
>
> > From: George Hilliard <thirtythreeforty@gmail.com>
> >
> > This is in preparation to allow it and the mt7621-dma drivers to be
> > built separately.  They are completely independent pieces of software,
> > and the Kconfig specifies very different requirements.
> >
> > Cc: linux-kernel@vger.kernel.org
> > Cc: devel@driverdev.osuosl.org
> > Cc: Neil Brown <neil@brown.name>
> > Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
>
> Hi,
>  thanks for taking an interest in these drivers.
>  I original submitted this code because I though I needed it for my
>  mt7621 hardware, but I've subsequently realized that neither of these
>  dma drivers are used in this hardware.
>  Consequently I cannot test any changes you make.
>  But maybe you can - which would be excellent!
>
>  So this is just letting you and Greg know that despite my stated
>  interest, I cannot actually review or test this.
>
> Thanks,
> NeilBrown
>
>

Thanks for the heads up. Honestly I am not sure to what extent I can
test code changes either, at least with the DMA driver. I'm working
with the MT7688, and official docs for it and its cousin the MT7628
are pretty sparse, so I'm currently not even certain that the ralink
gdma driver works for my SoC.

Onion lists these drivers in their OpenWRT device trees' compatible
strings, so they're related. The SPI driver works out of the box at
least. The MMC driver wants to work but needs debugging. All the
drivers need to be better documented. etc. I hope I can improve them,
and I'll make sure I test any actual kernel code I change!

George
