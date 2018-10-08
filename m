Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C010FC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8370A2087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=profitbricks-com.20150623.gappssmtp.com header.i=@profitbricks-com.20150623.gappssmtp.com header.b="PpHBGMum"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8370A2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=profitbricks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbeJHPe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 11:34:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35200 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbeJHPeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 11:34:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id e187-v6so7369852wmf.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 01:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=profitbricks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9uNm47/7PVk1oJRS7FKzZMkqSI+Mtia96gqRXUeO16E=;
        b=PpHBGMum5YRr+FsTGgm98/ZT+QdtYRwL5qxa8miOpPFtN3PjcQWkYBVsaIEEZEOdvQ
         sIQJfER7KR+sNbfuoYkhb6I9YIAeA6ahTIfD0LhNa1zFSXkVdr8I7+hz3uSax7Fg50HF
         9hacDQdmEyJlnVPxWttmYIDcHJyEmiuiVED1f8OW+Fx4sUdbyleHTIuMBZuj10kPKU9o
         sEUWj9c4aBrANqstBbd+LahIMtS63Z/65/W3csCo8vXdRv7oivMZMqvWYIx9dBh9vmdT
         1IQRNbytnwn3UlVRnCi6v2djka9krfF21QQLTc64F+74spubuDf+UbPW/75jb7xu2NcB
         OP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9uNm47/7PVk1oJRS7FKzZMkqSI+Mtia96gqRXUeO16E=;
        b=sF8EYGkA5h8jFvwhE+YhNt5MZ6e0zhboPh4D58Gx5R0RUZNnukxV6d2Hz+4pDTBPFD
         Ch+acnz8wtkJaHeqWTdVljCmSzFkHJeirsW3acfOoA0GD2E2YUnfW3qgleWLA2MvsnQE
         wuKyr7IR6J7TA/LuhORpeEHuO5G08Fpv+qR+ZbAkzVjVWPU2yp/lU120kUgzTET8Toel
         EYqZ8vFETlWlrgado2k3qroAM9n8+VzWHMmaFmoyqQFhX1+rAlW+Fttj+8/ub0FEVvsw
         vU1UZ75AZ7WjOzuvYwVLxZuWiUNcFrHHsPalExpnZUczEmOoHTJ78XMGjVQdISfrnxzj
         Zirg==
X-Gm-Message-State: ABuFfogLInYNEQanq0eeutce8bOJDY6Nj433q6QfyhiJ1nPGdBCqxw/J
        5BbHRbf00+KOT/zTxnhSOLaQzB2/Ltx7GZ6ihZSJqHVmD5g=
X-Google-Smtp-Source: ACcGV61HoPcdvam0qCwLHPqQuGrhp9yUHFgEz0tRtSIsToP0em8oEjPETI6H/JY1aMCGrBQsECbm7Adwn4Tk3VxlnlU=
X-Received: by 2002:a1c:448a:: with SMTP id r132-v6mr14865321wma.132.1538987032735;
 Mon, 08 Oct 2018 01:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <1538035677-20770-1-git-send-email-jinpuwang@gmail.com> <20180928183044.GA12491@kernel.org>
In-Reply-To: <20180928183044.GA12491@kernel.org>
From:   Jinpu Wang <jinpu.wang@profitbricks.com>
Date:   Mon, 8 Oct 2018 10:23:41 +0200
Message-ID: <CAMGffEk=XmRpRpTK1MKMykfJc8F7ZbUP5=ULPx2aM80V+i2-tQ@mail.gmail.com>
Subject: Re: [PATCH] md/bitmap: use mddev_suspend/resume instead of ->quiesce()
To:     Shaohua Li <shli@kernel.org>
Cc:     Wang Jinpu <xjtuwjp@gmail.com>, NeilBrown <neilb@suse.com>,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 8:30 PM Shaohua Li <shli@kernel.org> wrote:
>
> On Thu, Sep 27, 2018 at 10:07:57AM +0200, Jack Wang wrote:
> > From: Jack Wang <jinpu.wang@profitbricks.com>
> >
> > After 9e1cc0a54556 ("md: use mddev_suspend/resume instead of ->quiesce(=
)")
> > We still have similar left in bitmap functions.
> >
> > Replace quiesce() with mddev_suspend/resume.
> >
> > Also move md_bitmap_create out of mddev_suspend. and move mddev_resume
> > after md_bitmap_destroy. as we did in set_bitmap_file.
> >
> > Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
> > Reviewed-by: Gioh Kim <gi-oh.kim@profitbricks.com>
> >
> > ---
> > v2->v1: add reviewed-by.
> > ---
> >  drivers/md/md-bitmap.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
> > index 2fc8c113977f..c369f1753ea6 100644
> > --- a/drivers/md/md-bitmap.c
> > +++ b/drivers/md/md-bitmap.c
> > @@ -2123,7 +2123,7 @@ int md_bitmap_resize(struct bitmap *bitmap, secto=
r_t blocks,
> >       }
> >
> >       if (!init)
> > -             bitmap->mddev->pers->quiesce(bitmap->mddev, 1);
> > +             mddev_suspend(bitmap->mddev);
>
>
> mddev_suspend is supposed to be called with reconfig_mutex hold. At least=
 one
> place this isn't true with this change, for example, raid_preresume doesn=
't
> call md_bitmap_resize with the lock hold. Could you please double check t=
he
> lock usage?
You're right, I missed this one, will double check.

Thanks for review!



--=20
Jack Wang
Linux Kernel Developer

ProfitBricks GmbH
Greifswalder Str. 207
D - 10405 Berlin

Tel:       +49 30 577 008  042
Fax:      +49 30 577 008 299
Email:    jinpu.wang@profitbricks.com
URL:      https://www.profitbricks.de

Sitz der Gesellschaft: Berlin
Registergericht: Amtsgericht Charlottenburg, HRB 125506 B
Gesch=C3=A4ftsf=C3=BChrer: Achim Weiss, Matthias Steinberg, Christoph Steff=
ens
