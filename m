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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98D4C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70943218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeVa+flA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfAYKxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 05:53:22 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44776 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfAYKxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 05:53:22 -0500
Received: by mail-pf1-f196.google.com with SMTP id u6so4576582pfh.11;
        Fri, 25 Jan 2019 02:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L91MzvIDdYc15dcB4zub4pVbI3kUIlxSQxQ4CtMFeUg=;
        b=YeVa+flAOTHV/vGbsnDqk7YesNYLq2GhYxqwpObfIztwUsYl8R7CYn+SBIrYhvyHi6
         +IdqA0jIKu0sOooEUzGkRDlHXBH+QUKdOyPjjQu30eYuP23Uh7ZG3oFmW0oL8uQFxftn
         /nBs9qaEvHCXMuaevtRBw/2BXnCKUF12zeZyoYBrgBWU7ojcWMqbttLJq6A2qCE3wIw0
         ca4c8wkI8S7Lnq6kx1ZD7uT6E3MTrHgNX6chYgOXnZbjx0YNSYzADkTOSCakyMS3wQuP
         irXgKaOmszQHT0lW1+p0BsrUJ06rbGXkgtfymYr14rgSG/mNjFSZr8+UlG5WUh0lJv5c
         llxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L91MzvIDdYc15dcB4zub4pVbI3kUIlxSQxQ4CtMFeUg=;
        b=lKox0lyVceHpRSpMi3Rl1s0ygrE1BYU3rh5Ykx2RcqT/56tVELeBmTkVBSraOyLjLT
         QwEiX1ZfGA6ZJ2iXfU6jgr0YZ+4ElFLS4A6gMKEebywafJJ2R308U8/EQvPhUj3kFnAN
         RGNaf/BldAtRQEBJG0pikDUSTCqMRMi89JO46igUb6e41y8jk3bv65E6cTHTbrNoMrvb
         /vVp2MtDolBtp7KMbJXZ0GFMtkSb8A0CwsVs0pA++RmZVA4QmDyub5+em1T3tJAyufRT
         nQTQcqHg5H9ANxwzDojlcQQYQw/8SmrrgNAXlq3GPPgPII6qu/p1aZx9zRIPNfIjupcf
         1yWA==
X-Gm-Message-State: AJcUukfYf43spc2pzklGn7J3+4lZhyxP9H9VJcAAoipaEyuJQANiJ87V
        Kl7suP5+qm0cYGvU3rwsm70=
X-Google-Smtp-Source: ALg8bN5DtGRkf5lPkQvEyIQQLfiWgyn1s7cMEFjaH/WC5XUfqEtHpDDonw5CgnG4Dg+rftaxDd21mQ==
X-Received: by 2002:a62:2f06:: with SMTP id v6mr10560033pfv.216.1548413601065;
        Fri, 25 Jan 2019 02:53:21 -0800 (PST)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id q75sm49621022pfa.38.2019.01.25.02.53.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 02:53:20 -0800 (PST)
Date:   Fri, 25 Jan 2019 16:23:13 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Bharath Vedartham <linux.bhar@gmail.com>, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: iio: industrialio-core: add check when kzalloc
 fails
Message-ID: <20190125105313.GA16451@himanshu-Vostro-3559>
References: <20190124142755.GA31059@bhar.linux>
 <CA+U=Dsrefk01AbyKmkhLrwQyq8mkBKoO6kv_zXYEFSSCCqDObw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+U=Dsrefk01AbyKmkhLrwQyq8mkBKoO6kv_zXYEFSSCCqDObw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 08:55:27AM +0200, Alexandru Ardelean wrote:
> On Thu, Jan 24, 2019 at 4:28 PM Bharath Vedartham <linux.bhar@gmail.com> wrote:
> >
> > add code to handle the case when kzalloc fails to allocate memory to dev
> >
> > Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> > ---
> >  drivers/iio/industrialio-core.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index 4f5cd9f..93caa6b 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -1475,6 +1475,8 @@ struct iio_dev *iio_device_alloc(int sizeof_priv)
> >                 }
> >                 dev_set_name(&dev->dev, "iio:device%d", dev->id);
> >                 INIT_LIST_HEAD(&dev->buffer_list);
> > +       } else {
> > +               return NULL;
> 
> I'd argue that this is a bit redundant, because `dev` is NULL, the
> return below (return dev) will also return NULL.

+1

Also, subject title is incorrect.

Always use:

$ git log --oneline drivers/iio/industrialio-core.c

Use the most frequently tag/subject from the output of above
command.

"iio: core: ...." would be fine.


-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
