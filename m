Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BF5C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10EB723F2A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="hS9TJm3m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10EB723F2A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932648AbeGCOPT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:15:19 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:46437 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932145AbeGCOPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:15:17 -0400
Received: by mail-lf0-f68.google.com with SMTP id l16-v6so1744058lfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 07:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p73J5ZfrhskD+gVSd2690bZcO86JyOwb5DRFZ8wOzBc=;
        b=hS9TJm3mYv1bFnPAAag5zh1+OeN51xz0KcEuMGM/7DTHs0mfqc+T699uysOwhLNg2k
         TN6fsNX/2udm8emqbz4AYq0UMTAtujFYcD2oj8aIL+5lFYDAwh92yDIzomE98AihVc6S
         jOSDyQ2iPoJYm5C2vV1iyAXzDe70CyoXC9x7DEPWzgjGeIRpheoS3gFYyNbouRjehtHc
         n3yJGQ+0PusyekqWOH2nP9DC6O7fYYH8Sb7dFGc2d1jv9FUNuluyZyEn6jzR5WR2rM0l
         ly77qQdgX2XVTki1T9VHAja2ZdkNJ6iJFZuR5q3hufjHOnOMppwLKBki67IZKFcprZn9
         Ckqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p73J5ZfrhskD+gVSd2690bZcO86JyOwb5DRFZ8wOzBc=;
        b=QDpblwO+I6Cs1vXB93RHcGq8MPMoJ7e1Wt6PCTT/eCEPwUyN8fB/HOgwtM6wrpJRZD
         PzOsBEIidrDGv2PgNnj6P43FwQ7O4YmsCSKwSk2pGTKKL8ygXag5t88uBbwCxXRYFaJQ
         PmF1ThLm0bUCVtXrqxgihz2ACZUvP34pxuSFPa64dI7RzXu2X1XOL5r/NtXhEkgJ2BV1
         g0bXs36byrhmOzl6dolyfpLvH5Ab+foBDBvmQfYK7+okSx53KnBuuKqYaPdjWP0WniUl
         LOzUmLyerFzWlWeaM+QqzeVJbD9NbcaLMnFILQ3gHYV9vs4A0DWYO280qaiL+vJjgQSI
         eIoQ==
X-Gm-Message-State: APt69E3BzLKDL++s6n75xRVTYGpkV/aIllKVcsfru/LgOdpiCNSgbZab
        Cllfn8YbItDUzUE2jJgYfZPATL41a0VLY5mrENRr
X-Google-Smtp-Source: AAOMgpcHgrfaTBhkcD6VSo47XGVak3LYlraGPmS8gWybfXgEsycbvu6EGiM5TnmFPytDBtPuzUiGrBWgj69ErRwWvJE=
X-Received: by 2002:a19:d7d1:: with SMTP id q78-v6mr19208717lfi.40.1530627315894;
 Tue, 03 Jul 2018 07:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180618145954.785509-1-arnd@arndb.de> <20180622202436.tlowdotb2xo4pc6l@madcap2.tricolour.ca>
In-Reply-To: <20180622202436.tlowdotb2xo4pc6l@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 3 Jul 2018 10:15:04 -0400
Message-ID: <CAHC9VhQh5+=MSepRRuSGbG4KGmeUH=Y0w_8okhqwk_t6iaoAag@mail.gmail.com>
Subject: Re: [PATCH] audit: use ktime_get_coarse_ts64() for time access
To:     arnd@arndb.de
Cc:     Eric Paris <eparis@redhat.com>, martin.petersen@oracle.com,
        ktkhai@virtuozzo.com, sgrubb@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, rgb@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 4:26 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2018-06-18 16:58, Arnd Bergmann wrote:
> > The API got renamed for consistency with the other time accessors,
> > this changes the audit caller as well.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> This looks reasonable to me.
> Not that I think it matters, but any reason it was swapped in a
> different code location other than aesthetics?  Time and serial are
> usually used together in our code.
>
> Reviewed-by: Richard Guy Briggs <rgb@redhat.com>

Looks fine to me too.  Merged, thanks.

> > ---
> >  kernel/audit.c   | 2 +-
> >  kernel/auditsc.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/audit.c b/kernel/audit.c
> > index e7478cb58079..3e34b9f03cfe 100644
> > --- a/kernel/audit.c
> > +++ b/kernel/audit.c
> > @@ -1724,7 +1724,7 @@ static inline void audit_get_stamp(struct audit_context *ctx,
> >                                  struct timespec64 *t, unsigned int *serial)
> >  {
> >       if (!ctx || !auditsc_get_stamp(ctx, t, serial)) {
> > -             *t = current_kernel_time64();
> > +             ktime_get_coarse_ts64(t);
> >               *serial = audit_serial();
> >       }
> >  }
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index ceb1c4596c51..dbbf02f513a8 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -1540,10 +1540,10 @@ void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
> >       context->argv[2]    = a3;
> >       context->argv[3]    = a4;
> >       context->serial     = 0;
> > -     context->ctime = current_kernel_time64();
> >       context->in_syscall = 1;
> >       context->current_state  = state;
> >       context->ppid       = 0;
> > +     ktime_get_coarse_ts64(&context->ctime);
> >  }
> >
> >  /**
> > --
> > 2.9.0
> >
>
> - RGB
>
> --
> Richard Guy Briggs <rgb@redhat.com>
> Sr. S/W Engineer, Kernel Security, Base Operating Systems
> Remote, Ottawa, Red Hat Canada
> IRC: rgb, SunRaycer
> Voice: +1.647.777.2635, Internal: (81) 32635



-- 
paul moore
www.paul-moore.com
