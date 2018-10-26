Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49092C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EBBD20651
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X76BQREZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EBBD20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbeJZX2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:28:42 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:32770 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbeJZX2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:28:42 -0400
Received: by mail-it1-f193.google.com with SMTP id h6-v6so4770048ith.0;
        Fri, 26 Oct 2018 07:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MaONysL5Agp1vvXMb2D9FL4MPOKAVQs49dBxTujeo6A=;
        b=X76BQREZroqVVNyNMbK+eL4GJFcVISMAIh9ftA9A1Rhv7R7p8nQm/oF1zrljL8dg5P
         aLerx+/TI7ifdJ4l9TD+9uMhxiR2/jK0OTwf+Iaq7kjrmyI18bjNNdHDv6NIOEgsyHEN
         SqQ1sx6fxAQbxMgOUvXKBXn2rnvdFyKTIBuaxxHAnLH+CFeNZnEGEl7Cx5Ae7sfRLB9y
         WJ2kp05bWrjAVakhzlBaHe8HUIG03I/MM2tnqPrb6I0vzrUBCKoNgHlUl6VliAD8Y6ov
         HJsvexp1O/7D6BnQim/FCuBL4F8iua4t4Y/ixmOvLZf9nklol9gtLDufSYoR5B1ZeclH
         wSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MaONysL5Agp1vvXMb2D9FL4MPOKAVQs49dBxTujeo6A=;
        b=iGEjIw/UbXNj0BhAGKGUFSyDt+NfSVvLqDIFVv3MyWm/6BXCUxeb3/6qC/q7L11PYd
         dhf/SPpXY4MbpnCkGRyeAoeXIgjDRrn0WZzPKm/SxGs7p9g4U0IA4zi3aItznILzr6sv
         JuauXKm86qfa3TMo8lffugx4T9tMj/Y66wXUbP3UeeTjDYGzYsYw2FOHjmsyEZ/g0PGJ
         pR9H+Vgfaup/gzIzuLVVJk/+vD61+F1vShjvcBzHukXNlCVFdT7ote3tZAzDs9fnXvjD
         eqCu+Vf/dwhFfgcVXqzP+/8wqH20Nzh/OiJapdDz6OblMfzZDkd5irx7VV4W0AYIeMun
         phVQ==
X-Gm-Message-State: AGRZ1gJz2oZeh3/0eYn0f9FQauhcQhxt9jPd80kkJZw/HTV+kbXNLBON
        XHUEJcl5EFCxjXZXP7rRBht/RThKrCNCasep39s=
X-Google-Smtp-Source: AJdET5cnsZPzlot1aJ8BiWlZnh0gOOUeJTplp4jhE7RK0oUp+/vguXrSQ+qYkvhvMEa4Tx2GIgGMIb0wHnn12zifFSU=
X-Received: by 2002:a05:660c:b03:: with SMTP id f3mr3891957itk.60.1540565479492;
 Fri, 26 Oct 2018 07:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAEAjamtxZRiFUYb4re3jRf9naoSyJO7sskChfEgcBh-m-uEKWQ@mail.gmail.com>
 <46e927f8-268c-866c-75f7-d1406252759a@kernel.dk>
In-Reply-To: <46e927f8-268c-866c-75f7-d1406252759a@kernel.dk>
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Fri, 26 Oct 2018 10:51:07 -0400
Message-ID: <CAEAjamvAO-Y5-Zg3d3agk1pd84L=FMxB_173sTr4rRAVN9fmRA@mail.gmail.com>
Subject: Re: [PATCH] floppy: Avoid memory access beyond the array bounds in setup_rw_floppy()
To:     Jens Axboe <axboe@kernel.dk>
Cc:     jikos@kernel.org, Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do you mean mail client?? Well, I'm currently using gmail.

On Fri, Oct 26, 2018 at 10:41 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 10/26/18 8:39 AM, Kyungtae Kim wrote:
>
> > diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> > index a8cfa01..41160a1 100644
> > --- a/drivers/block/floppy.c
> > +++ b/drivers/block/floppy.c
> > @@ -3146,6 +3146,9 @@ static int raw_cmd_copyin(int cmd, void __user *param,
> >                          */
> >                 return -EINVAL;
> >
> > +       if (ptr->cmd_count > ARRAY_SIZE(ptr->cmd))
> > +               return -EINVAL;
> > +
> >         for (i = 0; i < 16; i++)
> >                 ptr->reply[i] = 0;
> >         ptr->resultcode = 0;
>
> Almost there, the tabs have been turned into spaces. This could be
> a mailer issue, what are you using to send out the patch?
>
> --
> Jens Axboe
>
