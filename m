Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CB8C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A86E12082F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzyU2Rfl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730891AbfA3Nx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:53:59 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36199 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfA3Nx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:53:58 -0500
Received: by mail-it1-f196.google.com with SMTP id c9so10577776itj.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 05:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LFf5duyIsG4ISnf996qHO7fE0MhjgHtqh1FA5Qg5fnw=;
        b=RzyU2RflcDHUU7FfcMSkGMYsPcoxhDRps7/W0copDgEkJh/HJ7ntuJSG1Pgij47pxD
         cQStxNbjgrFpNstqy3i5v8cJeGnlOlUA8d7b/GINHl1locKEJkSaL2CL+9KKemFT0x8q
         TVO8bmQGpvJWxkDwJPWePV8icWPD2f2jS8nvkoeWjeZk2upcI+G42fTSuuFAWFe4ZxVX
         kSaQZI2VB+vOGSmIDlfTbs0Tkg1IkR2eRyc/endmbmlZQ0EuMgT1h6wCYS857gzmBlcn
         KM7158ed81+ezCp/AgAFUTNnDYKoZgYB4gSp7tlTIbcUPc3xnzkWWflPrvzsxOhl1Qap
         VFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LFf5duyIsG4ISnf996qHO7fE0MhjgHtqh1FA5Qg5fnw=;
        b=R95AYYGcxkN4UY27jRZEcryRctwkJP2vJ+puG4LXkdVgjhPYH329868Wq87oWLvnpk
         uiSMWmjbnjtgV2+QTIVQfqnN60ge76C5pj3dsLn4UoB88x8BG+YlqhTNQPpS8/HIYsHR
         rrNU+WUbJVYZPwJCWx79yRfT4/z89TvmP69GOi2PvfkvuLExsQxLAkSZ1YJrkFxEDLvD
         zwjTXOcOJjbJ+EhFmix3w77aagIhTJnkFUUTzwAxjsdcx1i24mTRAt+TG4xWyerMqzBR
         NAXXAormJvRVOvygaYbFqcu3grLQNyI38ybXwn2syE4bfOWGMPv49wMELH4FamYcHYDW
         SM1g==
X-Gm-Message-State: AJcUukemGyd9Bv4Nqe5rSm9jwSv27FI70uOwWnAgnybXv9TEgpa0U6a/
        bDIWtmZxPiOzBnfRB5ThNEdAU090aYXFucNpqfY=
X-Google-Smtp-Source: AHgI3IaRRMrl3MZ7bN/d2OgmhIfMB+3oTWb0PZZBFhwz5L710C1wqvfYKnUAO323/WMAnTg3ijp92SaUitXnZ0XNkNE=
X-Received: by 2002:a24:648f:: with SMTP id t137mr14471615itc.176.1548856437757;
 Wed, 30 Jan 2019 05:53:57 -0800 (PST)
MIME-Version: 1.0
References: <20181109095101.GA2558@hp-pavilion-15-notebook-pc-brajeswar> <2429d30a-97f8-339e-2f80-03f38ae6f61b@nxp.com>
In-Reply-To: <2429d30a-97f8-339e-2f80-03f38ae6f61b@nxp.com>
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
Date:   Wed, 30 Jan 2019 19:23:46 +0530
Message-ID: <CAFqtX7nw3Ywv1j5_55CURmu03akdSO4kP1VayJUKCmVYmY4D1A@mail.gmail.com>
Subject: Re: [PATCH] drivers/bus/fsl-mc/dpbp.c: Remove duplicate header
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     "stuyoder@gmail.com" <stuyoder@gmail.com>,
        "jrdr.linux@gmail.com" <jrdr.linux@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sabyasachi.linux@gmail.com" <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 4:12 PM Laurentiu Tudor <laurentiu.tudor@nxp.com> wrote:
>
>
>
> On 09.11.2018 11:51, Brajeswar Ghosh wrote:
> > Remove linux/fsl/mc.h which is included more than once
> >
> > Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
>
> Acked-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>
> ---
> Best Regards, Laurentiu

If no further comment, can we get this patch in queue for 5.1 ?

>
> > ---
> >   drivers/bus/fsl-mc/dpbp.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/bus/fsl-mc/dpbp.c b/drivers/bus/fsl-mc/dpbp.c
> > index 17e3c5d2f22e..9003cd3698a5 100644
> > --- a/drivers/bus/fsl-mc/dpbp.c
> > +++ b/drivers/bus/fsl-mc/dpbp.c
> > @@ -5,7 +5,6 @@
> >    */
> >   #include <linux/kernel.h>
> >   #include <linux/fsl/mc.h>
> > -#include <linux/fsl/mc.h>
> >
> >   #include "fsl-mc-private.h"
> >
> >
