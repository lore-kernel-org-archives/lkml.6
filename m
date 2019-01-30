Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C813C169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4992175B
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJQcxTuS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbfA3C0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 21:26:24 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44927 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbfA3C0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 21:26:24 -0500
Received: by mail-pl1-f194.google.com with SMTP id e11so10304330plt.11;
        Tue, 29 Jan 2019 18:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9v18WNnlxt2j5NxBkqvzTad9BMWhmAfeZLIKxCBDpTA=;
        b=TJQcxTuSs3jEy3nq/JWmtxcrhNFImnpEcDuNzARif3Suqs+cgH2aGJAuv3Cxs6nN5H
         ntyl78QGL8n+Snc8c+wja9bfNpoP4RTxFub4N9aHX0SpeAnGoC87lLeCM6tEA+2Kg7zU
         mWxaFzlLc6pJ9YkUAv5ieo6oj04a/IfVvzuRaGzoJVvVsclulAypCQsQBfgiGOagpeBw
         O7H7FCfTqXg1yBNp9+UodpmX6Hwk9imukQ5jgZ9Rrid4uT84xGjtccdPsqaK+DjjYT1n
         NNr8Q8ufyjB37IZqQ5j+Korf/ez7L1CP+TBgtMrGsUQuzBZ/BC/DsoMz/UOrITof/2t4
         K8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9v18WNnlxt2j5NxBkqvzTad9BMWhmAfeZLIKxCBDpTA=;
        b=I81lugtga7+sOlUzDzCy38m4VDR0NCtdKmmPAb7kTolZEsKcGh3/CAok+LghY4OE7Q
         gdGONxMq8aZAHfCwouXXXtx0upB5wJtCe55VM/1qStTZ/5prgDW21MEHkz1Dr86WfyvT
         DzZDjnBMYBiSYiTlpqsXmz+1i0q/G2THImWzdofJQtRHv4+Zc1isqpn1yW1igy18lKw4
         iRNk8RPaRTCtNRkUZ7AgBayCs4dC8mlTluXdgvH/g3RaqKZZKzkO5JcUBiF3J6o4jj0B
         Ua+E0dJbCpibfV8vyz/v10907ZqlKvOKAb8QYIcBs5V7M4I088x0L/UhPifCjBhrogtr
         OxyA==
X-Gm-Message-State: AJcUukf+T2DIvc6XcpnmC9ykup0lm4WIkUCMRYOr2cpYgmJNIDiCs5qN
        lOxCX7aO70aPOtp4Chx7bz1CWzuxd/hBMbtdHW8=
X-Google-Smtp-Source: ALg8bN7o43r4//EpL9ATFeNcIXSUvRBez0yxvIiW1oZe6iBuavkV7ErL9cph9Nif061Sw7VFmU1OGo7GFiRTKaLtOco=
X-Received: by 2002:a17:902:4d46:: with SMTP id o6mr27311476plh.302.1548815183394;
 Tue, 29 Jan 2019 18:26:23 -0800 (PST)
MIME-Version: 1.0
References: <5c3763f1.1c69fb81.f2570.4457@mx.google.com> <CAFqt6zawA928gHRtSiKbBC0QcXxZs3U-rZdDF1yyaLjdTHqgFQ@mail.gmail.com>
In-Reply-To: <CAFqt6zawA928gHRtSiKbBC0QcXxZs3U-rZdDF1yyaLjdTHqgFQ@mail.gmail.com>
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date:   Wed, 30 Jan 2019 07:56:11 +0530
Message-ID: <CAJr6mf02+B4BrWC8AyLCXNu5wE8u5MPfWC4WrgrJ_9B6Z9DMbQ@mail.gmail.com>
Subject: Re: [PATCH] fs/block_dev.c: Remove duplicate header
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 5:46 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Thu, Jan 10, 2019 at 8:55 PM Sabyasachi Gupta
> <sabyasachi.linux@gmail.com> wrote:
> >
> > Remove linux/dax.h which is included more than once.
> >
> > Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
>
> Acked-by: Souptick Joarder <jrdr.linux@gmail.com>
>
If no further comment, can we get this patch in queue for 5.1 ?
> > ---
> >  fs/block_dev.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/fs/block_dev.c b/fs/block_dev.c
> > index cdda48f..8abcdb6 100644
> > --- a/fs/block_dev.c
> > +++ b/fs/block_dev.c
> > @@ -29,7 +29,6 @@
> >  #include <linux/namei.h>
> >  #include <linux/log2.h>
> >  #include <linux/cleancache.h>
> > -#include <linux/dax.h>
> >  #include <linux/badblocks.h>
> >  #include <linux/task_io_accounting_ops.h>
> >  #include <linux/falloc.h>
> > --
> > 2.7.4
> >
