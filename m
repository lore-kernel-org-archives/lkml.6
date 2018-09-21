Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EC0C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C05C421477
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNv9e54K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C05C421477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391458AbeIVCaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 22:30:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34624 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391089AbeIVCaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 22:30:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id t15so6110301wrx.1;
        Fri, 21 Sep 2018 13:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sFrHYUzr5dfpn5MzaWYpHANfqkrG5DMJzBOBmW8PCvc=;
        b=WNv9e54K4QApKmtRj424oih/5ndjtfFQqlLM6wKjqSMHia/qlLQIsZS+4Cm53p7S/I
         B4ZfHs4euvho82dcGNPPdlmEXkzRRxiDZ79yPpQ2+mgw0nJ88575sQWTAUh0iE0Q4EV9
         J/j862dph3JJeAJ4TdVe6RKxNng7SINDasjFMcANUKz49yPu59oMssMNtA9UL3s7Dd76
         LrVyVRwUkFpp7sdPUpocNECKs/Ax3VCeRKkkTUet/DPQg69/hxsa6KOdZbRI0tG2LF2w
         YOsxEwf5J5uxrs3gFkJ4ttCPAU6apm3VNyCdKjoAjYqXI5Vye532YZB6DP15MqT3h+/M
         98FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sFrHYUzr5dfpn5MzaWYpHANfqkrG5DMJzBOBmW8PCvc=;
        b=sgEMDrOFlVVP8XGWnycZ742P9pTQ5qjwyePf4HiSBNaooQRjbpRAQcXpl3QsYAIgUL
         zMVlvSRqQu4ZYHS3/sWF+9hxHWZmO8cU6iKIEBvdRpvMneTpumD024lmstOT7BDenhyI
         /4gblNkNYQqBtmxB/WwE1OIztbCY+wq8fHkDw0LASXeHkW6g/iObJgKnRwGUdLuNDur/
         /7MDwQMxNvJI+a23xxsd7xcz5Z4QulbsgV4IvXzU0b9NbYAdbnY6pH3EfOR9GzbQScNO
         AgIqybQ9pZVh6PfCtO0NgZAqyLJ2znPsFg9cvM4jNZ7dFet/viaTBJKH23bBVbEiS/99
         D6TA==
X-Gm-Message-State: APzg51A8U28Jvc/HM92Sj+VmG9hZxYoInUyDsCalAOL922xY1zVtEjgN
        JAMrp0jx8A1iAJ4DXN+Kz4s=
X-Google-Smtp-Source: ANB0VdbAtxlo9LN4DCdxK3nzvYEH6QZOzwqdZ6ycm+x7WwgYB9RxivroeGDkHZU4h5hjNbLaBk0X7Q==
X-Received: by 2002:adf:db51:: with SMTP id f17-v6mr38884877wrj.212.1537562410621;
        Fri, 21 Sep 2018 13:40:10 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id w15-v6sm24158775wrs.8.2018.09.21.13.40.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 13:40:09 -0700 (PDT)
Date:   Fri, 21 Sep 2018 13:40:08 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     awalls@md.metrocast.net,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: cx18: Don't check for address of video_dev
Message-ID: <20180921204008.GA13928@flashbox>
References: <20180921195736.7977-1-natechancellor@gmail.com>
 <CAKwvOdk-w04qavrzeOg_yCH6gYRE4UEX49TJBEb8wMjRssPDdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdk-w04qavrzeOg_yCH6gYRE4UEX49TJBEb8wMjRssPDdQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 01:31:37PM -0700, Nick Desaulniers wrote:
> On Fri, Sep 21, 2018 at 1:03 PM Nathan Chancellor
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
> > Presumably, the contents of video_dev should have been checked, not the
> > address. This check has been present since 2009, introduced by commit
> > 21a278b85d3c ("V4L/DVB (11619): cx18: Simplify the work handler for
> > outgoing mailbox commands")
> >
> > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >
> > Alternatively, this if statement could just be removed since it has
> > evaluated to true since 2009 and I assume some issue with this would
> > have been discovered by now.
> >
> >  drivers/media/pci/cx18/cx18-driver.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/pci/cx18/cx18-driver.c b/drivers/media/pci/cx18/cx18-driver.c
> > index 56763c4ea1a7..753a37c7100a 100644
> > --- a/drivers/media/pci/cx18/cx18-driver.c
> > +++ b/drivers/media/pci/cx18/cx18-driver.c
> > @@ -1252,7 +1252,7 @@ static void cx18_cancel_out_work_orders(struct cx18 *cx)
> >  {
> >         int i;
> >         for (i = 0; i < CX18_MAX_STREAMS; i++)
> > -               if (&cx->streams[i].video_dev)
> > +               if (cx->streams[i].video_dev)
> 
> cx->streams[i].video_dev has the type `struct video_device video_dev`.
> So wouldn't this change always be true as well, since the struct is
> embedded?
> 

Guess I forgot to compile this with Clang before sending because I now
get a build error (sigh...)

drivers/media/pci/cx18/cx18-driver.c:1255:3: error: statement requires
expression of scalar type ('struct video_device' invalid)                                                                              
                if (cx->streams[i].video_dev)
                                ^   ~~~~~~~~~~~~~~~~~~~~~~~~
                                1 error generated.

I guess the whole if statement should go unless I'm missing something
else.

Thanks for the review!
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
