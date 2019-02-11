Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41760C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0893F21855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pyR9SuFV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732865AbfBKPrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:47:14 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35462 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730324AbfBKPrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:47:12 -0500
Received: by mail-lj1-f195.google.com with SMTP id j13-v6so9186201ljc.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 07:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aZBR+NonzwcJxyxQ7q5FLlGbOTbnmJFkcVizWmrR9JE=;
        b=pyR9SuFV2h07vxKMXCK/tN+BGbC/P3IZ/IxgT6Zdg8pwIGvsDy75wpfj3UFAKAyEDh
         Xxo40fCRvdImS4o81yLaifuiZYc63rVk46s4rbLDk4jhJhJgO+mjrtp44SN7+PQvSCW4
         GR1fOPDRq8lJM3zNIVLKFaEJdSEZhMYSjEyrDpyPjRWRFD8vpAGIL6TLYO3tytsVqzlS
         6WCr4z+KQLA4mkgGSPWmiaTYHQDfOHpDotWN7D9gX3OvcrCT5l7nrdCvTtOocJuzxAVX
         Y6nwJfuEIsVm5yFpjWYTuLlExfgmtEsquqyM1Ffvl+A5s/weEAX7kV+dqEYas+QTbJEV
         rxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aZBR+NonzwcJxyxQ7q5FLlGbOTbnmJFkcVizWmrR9JE=;
        b=oj0yGj4dPWA4MG3HFB3qy3rdOqrbdN3UkBM5KHBKhp5d/JAtungD1PEK9MTgovwp7F
         8YJQSD1JwA043r4qA/o6rkVh4HyXo0IkyDvCMZsEyTyOHmCz+FCDw9DpC1skAU3Ox/LU
         20RLUGktNQZRQB/8D4KFUDyAMfXJG8e8W7qjXl550KZY96ginQl4r2YdCgxhRwVfLR34
         Nf8HLMRzf3/HRKoaiP8+PvrCk49feF0DMmWAge91vb2tmtiGC2yMXdn6m9R3L1ae8Ioq
         hP4osLFquE507KOQRk02l9Ld06zXUtKNYP4DGnt9e8sMoQg3MtA+i4wlAD6XeiJtA3cN
         71Lg==
X-Gm-Message-State: AHQUAuZ5l6GkuwejH8esEAWYvzBN1BMFaPKUJ9ghpJZMT26yVCt+0Bih
        kB9L6PzbO1R7eQmjpGCsedhnrr+EAffaaO8tPr6Pxg==
X-Google-Smtp-Source: AHgI3IY3g9GVNgoX3AqzChYIaQjXaP3Piq4a5gR37d2AJcziFLEAwKVDx4yAVgokRW3xbbn4J5iC1GloeYOHKQr0Qh0=
X-Received: by 2002:a2e:858e:: with SMTP id b14-v6mr15371445lji.43.1549900029646;
 Mon, 11 Feb 2019 07:47:09 -0800 (PST)
MIME-Version: 1.0
References: <20190211152602.GA5591@jordon-HP-15-Notebook-PC> <20190211154044.GA16105@kroah.com>
In-Reply-To: <20190211154044.GA16105@kroah.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 11 Feb 2019 21:21:19 +0530
Message-ID: <CAFqt6zYh2qxBKyOCH3xZmS_Jq5nU+nZyLhbmGOey4Y-VAk+ZoQ@mail.gmail.com>
Subject: Re: [PATCH] staging: android: vsoc: Remove VSOC_WAIT_FOR_INCOMING_INTERRUPT
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        christian@brauner.io, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 9:10 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Feb 11, 2019 at 08:56:02PM +0530, Souptick Joarder wrote:
> > As mentioned in TODO list, Removed VSOC_WAIT_FOR_INCOMING_INTERRUPT
> > ioctl. This functionality has been superseded by the futex and is
> > there for legacy reasons.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > ---
> >  drivers/staging/android/uapi/vsoc_shm.h | 7 -------
> >  drivers/staging/android/vsoc.c          | 5 -----
> >  2 files changed, 12 deletions(-)
>
> So userspace is all fixed up now and this ioctl can be dropped?  Any
> pointers to the userspace commit that did this?

I am not sure about user space part.
