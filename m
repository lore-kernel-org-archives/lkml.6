Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B245C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9AA22391
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:39:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB9AA22391
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sai.msu.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbeHIVFg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 17:05:36 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:44520 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbeHIVFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 17:05:36 -0400
Received: by mail-oi0-f67.google.com with SMTP id s198-v6so11515387oih.11;
        Thu, 09 Aug 2018 11:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W+1y2GxiH4DN3kXD8ovtIQjeupOlKaeYHU48lcHxP5M=;
        b=CyC0HVyJbY8OSedb6l6N5VLGHzpZtuWRM4uUpI7A/Qee/YnXBVertSoTI2jnQTVfNe
         23l/9D3ski+5XIj9T0zS6HY91T310g0XYf13Myf1vRENB0eQQ6eGlcRO4AkmYRvmJcDK
         dYwSBjCVLFT4pe7EpjYFG4zYUmgInUvg9EwDuXFB3bim48QUabUjnG+04rYiZXTdMuMT
         9Q4P/mSO/SCi8lsp1ftoyJbimMcJQtAPpuVWA7SuNLVoxynmotcPTwPbX3gyGV50Gmgx
         zTaG5ZXmrhI+iuvqjGRGcL82HNTVxneL6cLrp0lGjMXsqhKkef/TVMbXWNmsgfDkDf1B
         tYfQ==
X-Gm-Message-State: AOUpUlHjSMVHfBjoXc9Fo9DW99P5iHKAkXbyLQZNHNjxi7Ilo16MuOBZ
        +JQE8AhaBJOMnjzIR4ZiQ0ZDQ/8IGARlLSrWP3c=
X-Google-Smtp-Source: AA+uWPywmXfyB6Hnq3qPF/B82kFE5FDuFEnCKNKisKgXruxMImaozbJgBg4hLOnbr1OEgj6mBohi5fbcl/opjy06QlI=
X-Received: by 2002:aca:c514:: with SMTP id v20-v6mr3454440oif.153.1533839968968;
 Thu, 09 Aug 2018 11:39:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180809181103.15437-1-matwey@sai.msu.ru> <20180809181103.15437-2-matwey@sai.msu.ru>
 <20180809142618.34e58d5d@gandalf.local.home>
In-Reply-To: <20180809142618.34e58d5d@gandalf.local.home>
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
Date:   Thu, 9 Aug 2018 21:39:17 +0300
Message-ID: <CAJs94EbYZe59zZdM2xqoxxfTPp++0=pEVVRk8LWRB4maeX5Z7Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] media: usb: pwc: Introduce TRACE_EVENTs for pwc_isoc_handler()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>, mingo@redhat.com,
        Mike Isely <isely@pobox.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Colin King <colin.king@canonical.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        keiichiw@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

чт, 9 авг. 2018 г. в 21:26, Steven Rostedt <rostedt@goodmis.org>:
>
> On Thu,  9 Aug 2018 21:11:02 +0300
> "Matwey V. Kornilov" <matwey@sai.msu.ru> wrote:
>
> > Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
> > ---
> >  drivers/media/usb/pwc/pwc-if.c |  7 +++++
> >  include/trace/events/pwc.h     | 65 ++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 72 insertions(+)
> >  create mode 100644 include/trace/events/pwc.h
> >
> > diff --git a/drivers/media/usb/pwc/pwc-if.c b/drivers/media/usb/pwc/pwc-if.c
> > index 54b036d39c5b..72d2897a4b9f 100644
> > --- a/drivers/media/usb/pwc/pwc-if.c
> > +++ b/drivers/media/usb/pwc/pwc-if.c
> > @@ -76,6 +76,9 @@
> >  #include "pwc-dec23.h"
> >  #include "pwc-dec1.h"
> >
> > +#define CREATE_TRACE_POINTS
> > +#include <trace/events/pwc.h>
> > +
> >  /* Function prototypes and driver templates */
> >
> >  /* hotplug device table support */
> > @@ -260,6 +263,8 @@ static void pwc_isoc_handler(struct urb *urb)
> >       int i, fst, flen;
> >       unsigned char *iso_buf = NULL;
> >
> > +     trace_pwc_handler_enter(urb, pdev);
> > +
> >       if (urb->status == -ENOENT || urb->status == -ECONNRESET ||
> >           urb->status == -ESHUTDOWN) {
> >               PWC_DEBUG_OPEN("URB (%p) unlinked %ssynchronously.\n",
> > @@ -348,6 +353,8 @@ static void pwc_isoc_handler(struct urb *urb)
> >       }
> >
> >  handler_end:
> > +     trace_pwc_handler_exit(urb, pdev);
> > +
> >       i = usb_submit_urb(urb, GFP_ATOMIC);
> >       if (i != 0)
> >               PWC_ERROR("Error (%d) re-submitting urb in pwc_isoc_handler.\n", i);
> > diff --git a/include/trace/events/pwc.h b/include/trace/events/pwc.h
> > new file mode 100644
> > index 000000000000..84807fea2217
> > --- /dev/null
> > +++ b/include/trace/events/pwc.h
> > @@ -0,0 +1,65 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#if !defined(_TRACE_PWC_H) || defined(TRACE_HEADER_MULTI_READ)
> > +#define _TRACE_PWC_H
> > +
> > +#include <linux/usb.h>
> > +#include <linux/tracepoint.h>
> > +
> > +#undef TRACE_SYSTEM
> > +#define TRACE_SYSTEM pwc
> > +
> > +TRACE_EVENT(pwc_handler_enter,
> > +     TP_PROTO(struct urb *urb, struct pwc_device *pdev),
> > +     TP_ARGS(urb, pdev),
> > +     TP_STRUCT__entry(
> > +             __field(struct urb*, urb)
> > +             __field(int, urb__status)
> > +             __field(u32, urb__actual_length)
> > +             __string(name, pdev->v4l2_dev.name)
> > +             __field(struct pwc_frame_buf*, fbuf)
> > +             __field(int, fbuf__filled)
>
> I should have mentioned this before. The above is a structure, and the
> fields of that structure are created in the same order as this list.
> It's best to try to make sure there's no "holes". I would recommend:
>
>                 __field(struct urb*, urb)
>                 __field(struct pwc_frame_buf*, fbuf)
>                 __field(int, urb__status)
>                 __field(u32, urb__actual_length)
>                 __field(int, fbuf__filled)
>                 __string(name, pdev->v4l2_dev.name)
>
> Best to have names at the end, as in the future I may be able to
> optimize dynamic arrays (like strings) better, if there's only one and
> its at the end of the structure.

I see, thank you!

>
> > +     ),
> > +     TP_fast_assign(
> > +             __entry->urb = urb;
> > +             __entry->urb__status = urb->status;
> > +             __entry->urb__actual_length = urb->actual_length;
> > +             __assign_str(name, pdev->v4l2_dev.name);
> > +             __entry->fbuf = pdev->fill_buf;
> > +             __entry->fbuf__filled = (pdev->fill_buf
> > +                                      ? pdev->fill_buf->filled : 0);
> > +     ),
> > +     TP_printk("dev=%s (fbuf=%p filled=%d) urb=%p (status=%d actual_length=%u)",
> > +             __get_str(name),
> > +             __entry->fbuf,
> > +             __entry->fbuf__filled,
> > +             __entry->urb,
> > +             __entry->urb__status,
> > +             __entry->urb__actual_length)
> > +);
> > +
> > +TRACE_EVENT(pwc_handler_exit,
> > +     TP_PROTO(struct urb *urb, struct pwc_device *pdev),
> > +     TP_ARGS(urb, pdev),
> > +     TP_STRUCT__entry(
> > +             __field(struct urb*, urb)
> > +             __string(name, pdev->v4l2_dev.name)
> > +             __field(struct pwc_frame_buf*, fbuf)
> > +             __field(int, fbuf__filled)
>
> This I would just move name to the end.
>
> Thanks!
>
> -- Steve
>
> > +     ),
> > +     TP_fast_assign(
> > +             __entry->urb = urb;
> > +             __assign_str(name, pdev->v4l2_dev.name);
> > +             __entry->fbuf = pdev->fill_buf;
> > +             __entry->fbuf__filled = pdev->fill_buf->filled;
> > +     ),
> > +     TP_printk(" dev=%s (fbuf=%p filled=%d) urb=%p",
> > +             __get_str(name),
> > +             __entry->fbuf,
> > +             __entry->fbuf__filled,
> > +             __entry->urb)
> > +);
> > +
> > +#endif /* _TRACE_PWC_H */
> > +
> > +/* This part must be outside protection */
> > +#include <trace/define_trace.h>
>


-- 
With best regards,
Matwey V. Kornilov.
Sternberg Astronomical Institute, Lomonosov Moscow State University, Russia
119234, Moscow, Universitetsky pr-k 13, +7 (495) 9392382
