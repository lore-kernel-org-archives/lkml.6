Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D867C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B6C20857
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBE8Vnde"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731278AbfA3Obx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:31:53 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:55455 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbfA3Obx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:31:53 -0500
Received: by mail-it1-f193.google.com with SMTP id m62so10497025ith.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 06:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3jth/yFjRvB5e72Fke80fgY65OcjOxzPlPiXrXLS4wY=;
        b=bBE8VndeTq/rJtGrLEfWejc2E1bC6GToRpX2NbBMJvWePD1axbDtzM3LHY3iJxq/85
         YALn8EXRiCgW194ABaqi4jctRwkeVUpbP1boSFt8bqIzt6MQ3GYNsW1R+GkL4zYivdWz
         mQKRwLpsoiouzVfofBpoWFU2BTm91vu4tXzeogtDSIJKTpjmZ3uwBZf7SoZMyfEu7RC7
         kVnXVn+6qIyQLBdDAFDS/k6TiMrcFbaxeB1omR3xM5QkgWNIgJrTnwM5J8uvoxkiRI2T
         sjiTsHq8Mivf1Qq08JmWEl269n2hBoDZFzO+rX0uJkVe5OBSA1OkOrDmPEOYpkmuU8+C
         z+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3jth/yFjRvB5e72Fke80fgY65OcjOxzPlPiXrXLS4wY=;
        b=UHGgyQmuZKNOtKo+PKhUapO7DfPPYRPXKwDPggevkWkltzzBtIvisx0zmQcfu04pl7
         mCVjmZqBHbd6lCtZ6TB9fkdY3IL3PNEkxGsxPjql3RmKXJ1mKzlgNNxEmGwnLLLsrakl
         6EoHZ9HP2+dZqzNPOQdchD0/CSUz7g9sTiYGe5kFmu7T5jWPxRZc+xVMbQMP/4R5Zo/k
         BJYAtgK6qO9ORXn09jyPX63gaWvtJAARXQUCWKfkIZ9o6AQWIr7VLOUI18dR17z4/6Q8
         n79RGT9iLQZaH3Yat8LU4q7Slb3pOhZyanLzs2FnZO/Xk4Kr2CHVwgksRDjR/92G78Zp
         ueIw==
X-Gm-Message-State: AJcUukedmyrv8Dgyxc1HVg9BH9E3okER7JNOuUqg+wcQgcqeKvCJGfkB
        ev9kwITTMn2HI/3/XYuu8pX/FDJ3knuQvcs1aCQDvHZe/ck=
X-Google-Smtp-Source: ALg8bN5m8C0Uy1Bx1u7X/j0Kn2EE088UaiKtxU4iQQMKoRnEkR7fBXD0Eraqkzbe3MQX4CvOhN4/4Z1DKX3yk7fR0zw=
X-Received: by 2002:a05:660c:a45:: with SMTP id j5mr15879160itl.83.1548858711968;
 Wed, 30 Jan 2019 06:31:51 -0800 (PST)
MIME-Version: 1.0
References: <20190117143004.GA2916@hp-pavilion-15-notebook-pc-brajeswar> <20190118063016.GA20463@guoren-Inspiron-7460>
In-Reply-To: <20190118063016.GA20463@guoren-Inspiron-7460>
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
Date:   Wed, 30 Jan 2019 20:01:40 +0530
Message-ID: <CAFqtX7kVZsZKnqo0bjv+0Cs+kTBA+Za1+KgUtxBOp7=ZNoU7Hg@mail.gmail.com>
Subject: Re: [PATCH] csky/kernel/entry: Remove duplicate heade
To:     Guo Ren <guoren@kernel.org>
Cc:     ren_guo@c-sky.com, Arnd Bergmann <arnd@arndb.de>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 12:00 PM Guo Ren <guoren@kernel.org> wrote:
>
> Thx Brajeswar,
>
> Tested-by: Guo Ren <ren_guo@c-sky.com>
> Acked-by: Guo Ren <ren_guo@c-sky.com>

If no further comment, can we get this patch in queue for 5.1 ?

>
> On Thu, Jan 17, 2019 at 08:00:04PM +0530, Brajeswar Ghosh wrote:
> > Remove duplicate headers which are included more than once
> >
> > Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
> > ---
> >  arch/csky/kernel/entry.S | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
> > index 79f92b8606c8..f2081ddcc398 100644
> > --- a/arch/csky/kernel/entry.S
> > +++ b/arch/csky/kernel/entry.S
> > @@ -9,7 +9,6 @@
> >  #include <asm/unistd.h>
> >  #include <asm/asm-offsets.h>
> >  #include <linux/threads.h>
> > -#include <asm/setup.h>
> >  #include <asm/page.h>
> >  #include <asm/thread_info.h>
> >
> > --
> > 2.17.1
> >
