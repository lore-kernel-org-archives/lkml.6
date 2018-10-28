Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA10C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 12:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C8FF20665
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 12:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qqpuT2l+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C8FF20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbeJ1V2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 17:28:07 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37214 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbeJ1V2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 17:28:06 -0400
Received: by mail-yw1-f67.google.com with SMTP id v77-v6so2293220ywc.4;
        Sun, 28 Oct 2018 05:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mvWfHfJBZwvGtnu+XYX6yhLYvwzquy04EJDa09e+OAw=;
        b=qqpuT2l+3E+1bd3GPzdflJ9fqSZlQKcI+yzRm8IGCICsf34xsImwEuZezqbKEbtT7J
         nJ8+HoGRSS32D0I2Jj7Ozwi9z4rL9Dw1ukxDnVl5/vF4O3qDs1aYxDmr8UTW9tO1Vi1L
         2LB8cCZ4aVcQNDYmiaHRMxoxYVVZJcjcH7FIcP/+Z3z5CIve0yr/svpcX7Ag1CrlGtnD
         PF3uqXJW7aJN6SEiF1yqNgiYNA7NFuUhS+AqVEN+SlXAnnthJwejptLCRXvh6rp0eml5
         E2CrP+VQqAIg9qCXfH4iuH4vON9ZYgz3NoDeQOWg4twB3Tc5Z8ctj8EIHxYGcrH0y84l
         LWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mvWfHfJBZwvGtnu+XYX6yhLYvwzquy04EJDa09e+OAw=;
        b=U9DykvSDyP3W5tmP/Z796xmHO/lNX4ZGIvpV//gzFqHVxxcp8z+O3wQ2yMTIkMqmbV
         yCXaBbFHhQ0EUd4HvHdcaO/vPBrycdRHMOuj5B2oCQ5xlS6inCOqhGnasBwG/4B9V/dO
         3samn1jNQj8g2b4Le0P5cjoweUP98bGZfKxTm0DYNRSVZ9iajFnrWooui+Xv5+cPHpe3
         ZSEwqoAijqyx5jPhp6REUpROXL24zrBhJ3vMvku0fw4qqLKic0i/CdsEHXfhaiQ0OJre
         Ak+v8VcMaeY2oA//YMuLWkV1MWAZ/0AuvZMgG14+5BatUL2EBM6X5VWPSQrlxUm1Lxse
         LZgQ==
X-Gm-Message-State: AGRZ1gINEzs1LlG4ibd6ikLuobMEFKonYfb5ZYEN95llavd/67qHIgjg
        iruXCLA8Haa2rx1Hdh7rPkobnYH+pQ/nnSK3sak=
X-Google-Smtp-Source: AJdET5dlht/ikCvwPQ2Nrpjx85OSZz/4TGO1Oidg3lsrjYIIhW4HS5SEnkqPd7l0DnfqXvxyqAo0K1azPnwJ/3cVQSg=
X-Received: by 2002:a81:2a83:: with SMTP id q125-v6mr1259913ywq.480.1540730613138;
 Sun, 28 Oct 2018 05:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <20181026134516.1234-1-diego.viola@gmail.com> <3d9dd60b-7bfe-bc1c-b971-0935a84dcf45@kernel.dk>
 <CA+ToGPHR7s4kTKdSh3rpjvxPQN+Y+Qfv=vT2icJ1Gh55X3-mTg@mail.gmail.com>
 <CA+ToGPFMgT2co9c+QWN=7etS9w0OaRfUz69hduOn5rRvMwdsbg@mail.gmail.com> <539a21b1-7d09-4f30-0421-d083d1c48ee4@redhat.com>
In-Reply-To: <539a21b1-7d09-4f30-0421-d083d1c48ee4@redhat.com>
From:   Diego Viola <diego.viola@gmail.com>
Date:   Sun, 28 Oct 2018 09:43:21 -0300
Message-ID: <CA+ToGPG8xkW0p1cb-fx4By1pfL4UxnaJgU86ZL1QxLx6LUb4Kg@mail.gmail.com>
Subject: Re: [PATCH v3] libata: Apply NOLPM quirk for SAMSUNG MZ7TD256HAFV-000L9
To:     hdegoede@redhat.com
Cc:     axboe@kernel.dk, tj@kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Sun, Oct 28, 2018 at 7:48 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 28-10-18 05:13, Diego Viola wrote:
> > On Fri, Oct 26, 2018 at 5:36 PM Diego Viola <diego.viola@gmail.com> wrote:
> >>
> >> On Fri, Oct 26, 2018 at 11:21 AM Jens Axboe <axboe@kernel.dk> wrote:
> >>>
> >>> On 10/26/18 7:45 AM, Diego Viola wrote:
> >>>> med_power_with_dipm causes my T450 to freeze with a SAMSUNG
> >>>> MZ7TD256HAFV-000L9 SSD (firmware DXT02L5Q).
> >>>>
> >>>> Switching the LPM to max_performance fixes this issue.
> >>>
> >>> Applied, thanks.
> >>>
> >>> --
> >>> Jens Axboe
> >>>
> >>
> >> Jens, Hans,
> >>
> >> Thank you.
> >>
> >> Diego
> >
> > Hi Hans and Jens,
> >
> > I just wanted to give you guys an update about this problem.
> >
> > I've managed to update my SSD firmware to the latest version[1].
> >
> > For running the update, I've had to install Windows 10, ran the
> > firmware update, remove Windows and reinstall Arch Linux.
> >
> > The latest version of the firmware is DXT04L5Q, and it looks like
> > there hasn't been a new update since 2015.
> >
> > I'll be running with med_power_with_dipm and hope this firmware update
> > fixes the problem, if it doesn't and I get another freeze, I'll send
> > another patch blacklisting the drive completely. Is that OK?
>
> Yes, if it still happens with the latest firmware then blacklisting
> it completely is the right thing to do.
>
> Unfortunately for reasons which I do not understand OEM SSDs often use
> different (customized?) firmware compared to the model on which they
> are based and often see less updates and seem to have more bugs :|
>
> Regards,
>
> Hans

I've just got another freeze with the latest firmware while I was
watching some YouTube videos. I think it's safe to assume this drive
is borked and won't get better, I'll send another patch.

Thanks,
Diego
