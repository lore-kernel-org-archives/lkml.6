Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B41C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72CF21B68
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBno6xkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731842AbfBMDZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:25:52 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44687 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfBMDZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 22:25:52 -0500
Received: by mail-ot1-f68.google.com with SMTP id g1so1559784otj.11;
        Tue, 12 Feb 2019 19:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4bkgZFc/8Q3xOXDvpsueCN2/ExuocXIiElyX/Xh257c=;
        b=WBno6xknNk8YySAGU/UUuhbJuFAt5fCigADkR+WKghxGoKm65tWx1sG7XMIeuXLazR
         Pk7tCdlvtBSfxFo8sRik3vPi7gSoCQDsoHGmIjmfCwAE3Y/UiExs6WmLVu80cOPRwnfh
         iGVVAwtz0lYdylwuy7LL6d+XAksOQMkp0UMAmLHaq4Ju6DUUAj/Nmw5mSyK0om0keynB
         3MtXc5Jh93JAfRYae06qdBqiqIjMUYOVCSy/l3XKSJ3+nbQCNe2/4eFckLZp5vf3bO8M
         Zq5t/bJBCxs3WirVEf0UhPGMPgP1NTqW+jHlfibHQISG4r8yj6ZzVvFGaBSEEgzufBzp
         p2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4bkgZFc/8Q3xOXDvpsueCN2/ExuocXIiElyX/Xh257c=;
        b=MHMoxd/yJsgmFlItBfFbHkCBELN486T0AaLIk0f+jY3vxgcean1mEh9B8cNIaqv7G3
         E9LF141WpDmnspRP/6PT5WodEmmeMo209Cg+5VeaIFfQTTpLQqbrbVGsNTTfDoWph+1f
         USOfQoQU3UvrYWGWFC8mocbRvo9AxZ9kKQECnuMLz6eqnuiHhHM5KXBy6QWGaKXHOVUQ
         RJpzp4Thu6e5PIzWLxoQkBlS2Bw0hDJpdX15d150DEqMb3Ov5F6kqhMMj6Htwssg2Sx+
         PChSjUomt7Kf3L2DYqH9dxcmU+KoXobHImtzExys18wRcBP4NucA8QyabJJ4zBueuoJn
         smSg==
X-Gm-Message-State: AHQUAua4uZGbj0Dpd0RLyuEzcbrpvf+OrmLvvp9WQgkDbq8YNYaVGpgC
        wmuadsaYtSbEOdcedRsWyobABIdKaG+VDBAUIx0=
X-Google-Smtp-Source: AHgI3IZ8F40LlwKG9xjwbQiKgnZEczzVRq9GmRoCfDWdwe61ij31H+yDKHCcFlI1HzmDjLZm9cFRKENWJUqaerme0Bc=
X-Received: by 2002:a05:6830:1317:: with SMTP id p23mr7323846otq.55.1550028350950;
 Tue, 12 Feb 2019 19:25:50 -0800 (PST)
MIME-Version: 1.0
References: <89716a4433cd83aea5f4200359b184b0ee2cc8bd.1549828313.git.bobbyeshleman@gmail.com>
 <CAGngYiXPsj-TAZxC43UtAZYTkbztFtDB-z4jW29CthmaoeNy_w@mail.gmail.com> <20190213021753.GA19621@bobby.localdomain>
In-Reply-To: <20190213021753.GA19621@bobby.localdomain>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 12 Feb 2019 22:25:39 -0500
Message-ID: <CAGngYiUvEpSgESzFGJOtYjLi+_xmZ18GwiSTxaaMjEmjk2pu4Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: light: Add driver for ap3216c
To:     Robert Eshleman <bobbyeshleman@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bobby,

On Tue, Feb 12, 2019 at 9:17 PM Robert Eshleman <bobbyeshleman@gmail.com> wrote:
>
> First, thank you for the feedback.

First of all, thank _you_ for doing the hard work on this driver !
I very much respect what you've done here.

>
> I had initially went with a similar design, but there is
> the case in which the interrupt fires and then before the status
> register is read by the handler a user process reads the data and
> clears the interrupt.  When the handler continues execution it will
> read a zero status and return IRQ_NONE.  My understanding of how
> Linux handles IRQ_NONE is pretty poor, but I felt that this behavior
> is incorrect even if inconsequential.  This could be avoided by
> doing a status register read with every data read, and buffering
> that as well, but then we lose the benefit altogether by increasing
> I2C reads.
>
> In the approach you describe here, it seems like that would
> work if this driver wasn't supporting shared interrupts.  In the
> case that a user-space read happens to clear the interrupt before
> the handler reads the status register, I think we would end up
> falsely returning IRQ_NONE.
>
> Is my understanding of this correct?  It's very possible I'm
> misunderstanding IRQ_NONE and shared interrupts.
>

Yes, I can see how one can run into those issues.

I believe that this whole class of problems goes away if PS/ALS
are _exclusively_ read inside the interrupt, and cached.

Then, whenever a user process wants to read the data, the function
does not touch the h/w, but simply return the cached value.

But hang on, I will have more to say on this when replying to Jonathan's
feedback.
