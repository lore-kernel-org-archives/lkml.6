Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD926C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E868218DE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tEf2tPrp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfAYLlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 06:41:01 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43086 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfAYLlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 06:41:00 -0500
Received: by mail-pf1-f193.google.com with SMTP id w73so4630575pfk.10;
        Fri, 25 Jan 2019 03:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vn/VFDFGKo7EAeSEgz1HUxsLFd2UXKIdl6RTX3F9HNc=;
        b=tEf2tPrpuHspmPp8Oq2Sr+rd/ft6ovZFUieIg3wdD4zjN8sUl/kZuz5ek8GrEoC/ui
         vFyIezZZ3A/TimGIrgql6VHC8sjX0ZxVq6YXufTKWAFvV+3R/5AdGOjgo06+yzFBLX7P
         uirf11/6kwz5xSXsDRAJSO6AhEb8Z4JCT6rQ4FT719fDIViqlAmM2lo26Hd33yxNUNQP
         wj1IVI4TybgDi27jc/apAavunjXDKfmAsuF3VMfhiU3bwv3l2e9hpbQ+b3Uh86xRiMjO
         U1BionTvbST7qyMGCkO/b4o5BLSHrJY2ed0nTzue33Xt4ss7q/g4ucTT/I0WOCaH+Ghd
         R3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vn/VFDFGKo7EAeSEgz1HUxsLFd2UXKIdl6RTX3F9HNc=;
        b=NiWO+vT2+qnN33MXWvkJeK2iVJ1JSC3s7wnSKKdlnllCqUt+mpOApnp4tBpMHFlohg
         uqU1fstG/879fYoffKtAt1gSbnVBLETU6lKOSL1NlX/TwK9jcJKlq9Sj3OvQa3sxgbqZ
         WW7a8SMdJNY0KWZDa4g2gkPVkajE+FMzL/B+zhbtuKpW58cf30v23hGUWsei5dPYzkfP
         IvxZg8knSZ0MvokX2nAChQ+KR8rvpH4ZTro+y3WCMeZl7g94vmaahJaiobQfuhWgjiFx
         qf2lBta4ql+msjaHjV/4hd3IyF8Oub5zWV3MDHeAyEoBtuuU5GgyuckHtw/4jStCWgmm
         zrpA==
X-Gm-Message-State: AJcUukcUgcb/mSB7aWte/LzJn6Q7pSfpG/TaUZQynGvx/mHf4V4OcRLk
        N6NeAHWnX+PhPd6W6KbykZg=
X-Google-Smtp-Source: ALg8bN4YBgXQGtsqcVvmWP0fW8ErEwD0lLtHE0pn4/TCXlHA6sAMTThBL216Z0l2fJx919C29obnjQ==
X-Received: by 2002:a63:dd15:: with SMTP id t21mr9255127pgg.347.1548416459763;
        Fri, 25 Jan 2019 03:40:59 -0800 (PST)
Received: from bharath12345-Inspiron-5559 ([117.198.99.29])
        by smtp.gmail.com with ESMTPSA id p24sm37961226pfk.155.2019.01.25.03.40.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 03:40:59 -0800 (PST)
Date:   Fri, 25 Jan 2019 17:10:52 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     Himanshu Jha <himanshujha199640@gmail.com>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: iio: industrialio-core: add check when kzalloc
 fails
Message-ID: <20190125114052.GA2982@bharath12345-Inspiron-5559>
References: <20190124142755.GA31059@bhar.linux>
 <CA+U=Dsrefk01AbyKmkhLrwQyq8mkBKoO6kv_zXYEFSSCCqDObw@mail.gmail.com>
 <20190125105313.GA16451@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125105313.GA16451@himanshu-Vostro-3559>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 04:23:13PM +0530, Himanshu Jha wrote:
> On Fri, Jan 25, 2019 at 08:55:27AM +0200, Alexandru Ardelean wrote:
> > On Thu, Jan 24, 2019 at 4:28 PM Bharath Vedartham <linux.bhar@gmail.com> wrote:
> > >
> > > add code to handle the case when kzalloc fails to allocate memory to dev
> > >
> > > Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> > > ---
> > >  drivers/iio/industrialio-core.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > > index 4f5cd9f..93caa6b 100644
> > > --- a/drivers/iio/industrialio-core.c
> > > +++ b/drivers/iio/industrialio-core.c
> > > @@ -1475,6 +1475,8 @@ struct iio_dev *iio_device_alloc(int sizeof_priv)
> > >                 }
> > >                 dev_set_name(&dev->dev, "iio:device%d", dev->id);
> > >                 INIT_LIST_HEAD(&dev->buffer_list);
> > > +       } else {
> > > +               return NULL;
> > 
> > I'd argue that this is a bit redundant, because `dev` is NULL, the
> > return below (return dev) will also return NULL.
Agreed. I will read the code more carefully from next time.
Thank you :)
> 
> +1
> 
> Also, subject title is incorrect.
> 
> Always use:
> 
> $ git log --oneline drivers/iio/industrialio-core.c
> 
> Use the most frequently tag/subject from the output of above
> command.
> 
> "iio: core: ...." would be fine.
> 
> 
> -- 
> Himanshu Jha
> Undergraduate Student
> Department of Electronics & Communication
> Guru Tegh Bahadur Institute of Technology
Yes will do that from next time. I was of the understanding that this header 
was good enough.

Thank you,
Bharath
