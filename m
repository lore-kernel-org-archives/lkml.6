Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25EDC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 23:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F36206B2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 23:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWCd4fSV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F36206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbeJBFxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 01:53:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36045 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeJBFxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 01:53:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id y16so57019wrw.3;
        Mon, 01 Oct 2018 16:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xP3YSfpbBAej3DJj6KaDuaNukmmCg3YjkxoiG7ZhhyU=;
        b=RWCd4fSV0EnX5yF5uf8kRcSSyNuFhSIna0Wol2AN1Db61L2Uwj/8ivMcI+t71Ij7is
         11cmuJFfsaxAwCUYNzSV5sAEbcxR9U25zpdUI3YQ80IHIew1PHbsFla+rAtqCfP8bAT6
         SInjOwWV/FViBegqUlZZGhMgQAdwfhNpbNtY4An28njvwom3uJpswQNoAX45YyKltq8j
         lTeXACLZY8VhUskNAbxXZ1TLGZxjXs017/Qwk/zpJJMFV7kA2z81nPOizJXH+NbPbc93
         19DBo+50s6JjTEgZ0dnXkJOwipTw9WXSaQ3Bi5vsF1XYSWQq2sgVPPUfWmQiBVARPNEO
         Qbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xP3YSfpbBAej3DJj6KaDuaNukmmCg3YjkxoiG7ZhhyU=;
        b=Tdn2im115wGmNo5NgpvNK2fPN1+4oSHzDZWkjUexw5khdoUr4noAYcXdgb+F2R3Cec
         ti/7ng8mt3UqYr4xqTG3Vwi93BPCmlx8r+deFjy1vLgP/kFIwnz4bl/Vbj3S2HnbYlqL
         I9yBEe1PAwjOYKryzq8oRTmgcca613H6Px7qvShTbjsZtCtRh0E9i5oPKlveldCvuXgH
         h3nOe7jc2xnl1ybTCUgbwBJp1Y7ImRKT+Ugm9MzmIhNDrmsYI88zXTVBr18R+CAxluqm
         GvTq2QbREGfqxRIaYwPlXvaP6tFxpygx0WdGXUaQ9xT+O5B6o11ZUC1vxJ9tLPxpWhkH
         TKHw==
X-Gm-Message-State: ABuFfog9+9ZhD6YEjf9A8jSxswZDUSU9s/4z1DaY32MvU/Dxkgzw2a5A
        FD6phbyZlJ+5oqT/ikQjljg=
X-Google-Smtp-Source: ACcGV60jwLqB/j91lz7IC8lqQzXFXcL2OhVbQrW5XhoawJGZ0zi/GJH8MXRtMbvC5e7mmBAmPFdwxQ==
X-Received: by 2002:adf:e792:: with SMTP id n18-v6mr8235079wrm.136.1538435574409;
        Mon, 01 Oct 2018 16:12:54 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id a18sm14083672wrx.55.2018.10.01.16.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 16:12:53 -0700 (PDT)
Date:   Mon, 1 Oct 2018 16:12:51 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     awalls@md.metrocast.net,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        hverkuil@xs4all.nl, linux-media@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] media: cx18: Don't check for address of video_dev
Message-ID: <20181001231251.GA1593@flashbox>
References: <20180921195736.7977-1-natechancellor@gmail.com>
 <20181001152110.20780-1-natechancellor@gmail.com>
 <CAKwvOdk6Z2und-7U6SVHqKxiEk6Ahpuc8_=O7Os5axx43itp5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdk6Z2und-7U6SVHqKxiEk6Ahpuc8_=O7Os5axx43itp5Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 04:05:57PM -0700, Nick Desaulniers wrote:
> On Mon, Oct 1, 2018 at 8:22 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Clang warns that the address of a pointer will always evaluated as true
> > in a boolean context.
> >
> > drivers/media/pci/cx18/cx18-driver.c:1255:23: warning: address of
> > 'cx->streams[i].video_dev' will always evaluate to 'true'
> > [-Wpointer-bool-conversion]
> >                 if (&cx->streams[i].video_dev)
> >                 ~~   ~~~~~~~~~~~~~~~^~~~~~~~~
> > 1 warning generated.
> >
> > Check whether v4l2_dev is null, not the address, so that the statement
> > doesn't fire all the time. This check has been present since 2009,
> > introduced by commit 21a278b85d3c ("V4L/DVB (11619): cx18: Simplify the
> > work handler for outgoing mailbox commands")
> >
> > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >
> > v1 -> v2:
> >
> > * Fix build error and logic per review from Hans
> >
> >  drivers/media/pci/cx18/cx18-driver.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/pci/cx18/cx18-driver.c b/drivers/media/pci/cx18/cx18-driver.c
> > index 56763c4ea1a7..a6ba4ca5aa91 100644
> > --- a/drivers/media/pci/cx18/cx18-driver.c
> > +++ b/drivers/media/pci/cx18/cx18-driver.c
> > @@ -1252,7 +1252,7 @@ static void cx18_cancel_out_work_orders(struct cx18 *cx)
> >  {
> >         int i;
> >         for (i = 0; i < CX18_MAX_STREAMS; i++)
> > -               if (&cx->streams[i].video_dev)
> > +               if (cx->streams[i].video_dev.v4l2_dev)
> 
> There we go, that looks better!  Thanks for respinning this patch.  I
> would've given Hans credit in a Suggested-by tag, but there's not
> necessarily strict rules on that (and doesn't necessitate a v3).
> Maybe the maintainer could apply that to the commit message when
> applying?  Either way:
> 
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> 

Very fair point, I should have done that. Will be better about that in
the future.

Thank you for the review,
Nathan

> >                         cancel_work_sync(&cx->streams[i].out_work_order);
> >  }
> >
> > --
> > 2.19.0
> >
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
