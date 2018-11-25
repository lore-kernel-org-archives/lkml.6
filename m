Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138CAC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 09:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED0220855
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 09:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1iQlIBa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED0220855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbeKYUjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 15:39:49 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:51596 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbeKYUjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 15:39:49 -0500
Received: by mail-it1-f194.google.com with SMTP id x19so24004298itl.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 01:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hYA40ccOKm/+Hu87I5aK4kUNRv6S874U6Aq5f9kDZoo=;
        b=Y1iQlIBaKvvs/4XNQfZGevm/XygYlttei81egdQqHXaaz2BYzh1eAmnbiqDhtVbxkG
         GhAK5yYy08kCgH+dsPvtfAJdFMK8aVYEA/7ANaOtcKrdnX3K+j1C7EzFHW4cxc6rR+Rv
         e+fsU46aOYYWT2CFqzj48d9QwPucCdArI3NiGvuwtnYOIcMDI/CfF/055ngT+Xff8prw
         Y+eJYPWiIg10u8q81jTlvueX7FxmwPif3QOPrO+Tzn8dks4lfEOlnh00KjkHZwWaaG5R
         6cHbO0Pin5kK/ZJHsgZc2CJbih2GUrmYsVrw4WZbYgk/1ncVB1+rAny44xSjIJ/8DQiy
         HNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hYA40ccOKm/+Hu87I5aK4kUNRv6S874U6Aq5f9kDZoo=;
        b=EgoW14T5hVeSmh+dY/VIJpX3uT+FazTOwoenY4LHb4CPi3ZmdAwCcHrkWe+WJRqkpd
         U2jsSJb3M+8+DjLySvVK7RUDQvewWWr4WlxnqdGShIk2PWAB/YnR4+UA07KTvWP5ImnD
         KVzCjmjDpH6ydyhEpOzm5HA24SYiOQPK5jsEQc9lz8Na/wHtp4vfVWdwEq1FMns1q9IB
         bOkRqNd5TTsqMQMCzj5BpXY1aBiTsN8LhrTqlZDcYOcRq+QMvmSARCGIezsmOXwY8m71
         koq0HcGXv1FR4qxrdk0jihGMedYwuZ5p1hHeNlypqygoZ5HseDCCEHbC4Nx4b65ZIWQr
         XMYw==
X-Gm-Message-State: AGRZ1gIryMQKXFhZVTA3gz8lzlm+uZ8+X0lvcI/hFrCDE6D8zlE6NBNr
        YgNvCoa08FEvh6fZx5X0ySIBMS2hTfy+jbQg598=
X-Google-Smtp-Source: AFSGD/Xm86mmjmLrzXI17xJeRyf/mFNejOr8s98zhkAn1nccASUxqkgOo43ekFl+TBEisOifV2LYtnk6kXB9M+ZxCr4=
X-Received: by 2002:a24:648f:: with SMTP id t137mr18569509itc.95.1543139346767;
 Sun, 25 Nov 2018 01:49:06 -0800 (PST)
MIME-Version: 1.0
References: <20181125050049.29685-1-tiny.windzz@gmail.com> <f4772a69-12c4-f79e-4ac2-4fe3add96f91@linaro.org>
In-Reply-To: <f4772a69-12c4-f79e-4ac2-4fe3add96f91@linaro.org>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sun, 25 Nov 2018 17:48:45 +0800
Message-ID: <CAEExFWuUU36hr3Xagy62GiJ-GeOytg7TJm+B0gpjW-W25hhc7w@mail.gmail.com>
Subject: Re: [PATCH v2] clocksource/drivers/integrator-ap: add missing of_node_put()
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 5:43 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 25/11/2018 06:00, Yangtao Li wrote:
> > of_find_node_by_path() acquires a reference to the node
> > returned by it and that reference needs to be dropped by its caller.
> > integrator_ap_timer_init_of() doesn't do that.The pri_node and the
> > sec_node are used as an identifier to compare against the current node,
> > we can directly drop the refcount after getting the node from path as
> > it is not used aspointer. In addition, a single variable is needed,
> > so fix it.
>
> I can apply the patch after adding a comment in the code below or
> alternatively you can resend a V3 after adding a comment yourself.
>
> What is your preference?
Hi Daniel:

You can add a comment in the code below,then apply the patch.

Thanks,
Yangtao
>
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> > Changes in v2:
> > -update changeelog
> > -simplify fix
> > -change two variable to one
> > ---
> >  drivers/clocksource/timer-integrator-ap.c | 22 +++++++++++++---------
> >  1 file changed, 13 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/clocksource/timer-integrator-ap.c b/drivers/clocks=
ource/timer-integrator-ap.c
> > index 76e526f58620..bbd0977d579a 100644
> > --- a/drivers/clocksource/timer-integrator-ap.c
> > +++ b/drivers/clocksource/timer-integrator-ap.c
> > @@ -181,8 +181,7 @@ static int __init integrator_ap_timer_init_of(struc=
t device_node *node)
> >       int irq;
> >       struct clk *clk;
> >       unsigned long rate;
> > -     struct device_node *pri_node;
> > -     struct device_node *sec_node;
> > +     struct device_node *alias_node;
> >
> >       base =3D of_io_request_and_map(node, 0, "integrator-timer");
> >       if (IS_ERR(base))
> > @@ -204,7 +203,14 @@ static int __init integrator_ap_timer_init_of(stru=
ct device_node *node)
> >               return err;
> >       }
> >
> > -     pri_node =3D of_find_node_by_path(path);
> > +     alias_node =3D of_find_node_by_path(path);
> > +
> > +     /* Drop the refcount of node */
> > +     of_node_put(alias_node);
> > +
> > +     if (node =3D=3D alias_node)
> > +             /* The primary timer lacks IRQ, use as clocksource */
> > +             return integrator_clocksource_init(rate, base);
> >
> >       err =3D of_property_read_string(of_aliases,
> >                               "arm,timer-secondary", &path);
> > @@ -213,14 +219,12 @@ static int __init integrator_ap_timer_init_of(str=
uct device_node *node)
> >               return err;
> >       }
> >
> > +     alias_node =3D of_find_node_by_path(path);
> >
> > -     sec_node =3D of_find_node_by_path(path);
> > -
> > -     if (node =3D=3D pri_node)
> > -             /* The primary timer lacks IRQ, use as clocksource */
> > -             return integrator_clocksource_init(rate, base);
> > +     /* Drop the refcount of node */
> > +     of_node_put(alias_node);
> >
> > -     if (node =3D=3D sec_node) {
> > +     if (node =3D=3D alias_node) {
> >               /* The secondary timer will drive the clock event */
> >               irq =3D irq_of_parse_and_map(node, 0);
> >               return integrator_clockevent_init(rate, base, irq);
> >
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
