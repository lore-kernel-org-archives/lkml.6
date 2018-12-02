Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCC4C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 07:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 909142080A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 07:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2WFka8G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 909142080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbeLBHeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 02:34:16 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:32901 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbeLBHeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 02:34:16 -0500
Received: by mail-it1-f195.google.com with SMTP id m8so5633490itk.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 23:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rKJtAFp7xYLl+tunnmHgFhccq0oh1yGFWywmWN3qhJc=;
        b=E2WFka8GKT2Pg4Bo1PgY53T2wrdZIS8QWY2/CFXeNbqQyWwE5op8dZ8qgA9Ii38tg9
         F3N87fba+G6gTDQlp7OIOlM8KeSlPh+aV4rP6iecEFknUsyW9oUYU7omFK7dlONGSecd
         14sl9gPV7ZpGM/Fb5rRbgMT6frBnvg3ND/61EouIJMSCjOTScgyo7kq+b69CbtOc+Zvu
         TXQI1U61oLXzGDhWSaCkbsrryngnTNVztkPWzk0IJ5XLLcW3Z64DX3/KElXt5CaWEqLa
         AE8vKgf1ZE3tf3aVTNU4UOLfYl3HsjQT0JsiakrV7wF7+yZccBcPiQkFraqxxid0GcUK
         0tng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rKJtAFp7xYLl+tunnmHgFhccq0oh1yGFWywmWN3qhJc=;
        b=tIkcZlOdsg2JYWXrFE6vaBDxVoOszaEwmEppFQn6t7JZcQX52TUQe73wH1zB6gk7TD
         z3wVixmCIF3CHYXyrLUqHpbGSz9xXAgQd6SASgpgJCRH1M9ypP3OBGw1Xa0HD00r3QM5
         b3ur/E/5LjnJjYUEBhrxAxARiGyOPEtZ87Ge6xXrfnR9sNqKStb3GqEgzUOk67c1TXYP
         E/2Mv54uT5WBvSSrdiUaEP7C0ox92hDU+8USPtiL1PBcXMFxzPShTbYs7CKM4GiMVB3l
         rLUT5YZL5vNjvZmc4zXj923JHPw680pbHBHLvq4yIz3NZp0rXRLkQCsCZhot0NJS6DoA
         Kfaw==
X-Gm-Message-State: AA+aEWZEpN8LDXAnPOS6p4GZBqThzKxvfFf9zcT+p7g4oWSwcc/wXHlw
        2V85ICP3Fm6g5xzi2jIUl/tkEgPtbs39cg3K2EA=
X-Google-Smtp-Source: AFSGD/WV9bT08mm77JaIDc++Ot10YykVmj+kqN0LrAZLbYBMOW6QN5tr6Vd3OnZ6sG8W4ftoI2tMiJcWwZOYNhGLyRM=
X-Received: by 2002:a24:7b90:: with SMTP id q138mr4083492itc.37.1543736048120;
 Sat, 01 Dec 2018 23:34:08 -0800 (PST)
MIME-Version: 1.0
References: <20181202015417.9100-1-tiny.windzz@gmail.com> <20181202081832.08de39b2@bbrezillon>
In-Reply-To: <20181202081832.08de39b2@bbrezillon>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sun, 2 Dec 2018 15:33:45 +0800
Message-ID: <CAEExFWtho0qZd6mNZnT_uiYhXcfKzEaTnj81cx21Ny5m1xFgfA@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: remove DEBUGFS_RO_ATTR()
To:     boris.brezillon@bootlin.com
Cc:     robert.jarzmik@free.fr, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marek.vasut@gmail.com>,
        richard@nod.at, miquel.raynal@bootlin.com,
        Kees Cook <keescook@chromium.org>,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 2, 2018 at 3:18 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
>
> On Sat,  1 Dec 2018 20:54:17 -0500
> Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> > We already have the DEFINE_SHOW_ATTRIBUTE.There is no need to define
> > such a macro,so remove DEBUGFS_RO_ATTR.Also use DEFINE_SHOW_ATTRIBUTE
> > to simplify some code.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> > Changes in v2:
> > -Remove a missing DEBUGFS_RO_ATTR
> > ---
> >  drivers/mtd/devices/docg3.c    | 20 ++++++++++++--------
> >  drivers/mtd/devices/docg3.h    | 11 -----------
> >  drivers/mtd/mtdswap.c          | 12 +-----------
> >  drivers/mtd/nand/raw/nandsim.c | 16 +++-------------
> >  4 files changed, 16 insertions(+), 43 deletions(-)
> >
> > diff --git a/drivers/mtd/devices/docg3.c b/drivers/mtd/devices/docg3.c
> > index 512bd4c2eec0..80143972963e 100644
> > --- a/drivers/mtd/devices/docg3.c
> > +++ b/drivers/mtd/devices/docg3.c
> > @@ -1603,7 +1603,7 @@ static void doc_unregister_sysfs(struct platform_device *pdev,
> >  /*
> >   * Debug sysfs entries
> >   */
> > -static int dbg_flashctrl_show(struct seq_file *s, void *p)
> > +static int flashcontrol_show(struct seq_file *s, void *p)
> >  {
> >       struct docg3 *docg3 = (struct docg3 *)s->private;
> >
> > @@ -1623,9 +1623,10 @@ static int dbg_flashctrl_show(struct seq_file *s, void *p)
> >
> >       return 0;
> >  }
> > -DEBUGFS_RO_ATTR(flashcontrol, dbg_flashctrl_show);
> >
> > -static int dbg_asicmode_show(struct seq_file *s, void *p)
> > +DEFINE_SHOW_ATTRIBUTE(flashcontrol);
>
> Just nitpicking, but can you remove the blank line between the function
> definition and DEFINE_SHOW_ATTRIBUTE()?
The third edition has been sent, can you review it?

Yours,
Yangtao
