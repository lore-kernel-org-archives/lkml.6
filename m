Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D69C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6607206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VLI1IOjL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732216AbfAIPRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 10:17:11 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:41477 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730725AbfAIPRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 10:17:10 -0500
Received: by mail-vk1-f195.google.com with SMTP id t127so1732125vke.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 07:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wQyqmC0gu61Qarv1hQhLAtGsvcLURGacNluwzCkEZB0=;
        b=VLI1IOjLXvqruH3GGhbDAxUssjVcLPNDHV1Sxeo1aWKVJClMYuwbgsEacK2It5QT25
         vgQhF6AxLYK4B+Ep90NS4VVylbzey3+I8PkaclGMpKVDaZ8ms4cHw7HBvSCZF4ogW0MJ
         pswXBtnEST6VZhAlWdjNRTY6aI6ttFLo2qW1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wQyqmC0gu61Qarv1hQhLAtGsvcLURGacNluwzCkEZB0=;
        b=m1gfnSfUx/wwozFROedGS3qyLMyoZmSh6uc48+EItV9a+KgYsTsqkPdHf7tzZXjENs
         JlEl0ksjvgrJJjo6E27vqgj8G3z9WLgg92clwNKkinR+TMg92kA72pT1KcN2MzkrIqaW
         b/7sWQ/qTR209UdHyjwwga5ZdQsIXCDIOrEBYbvSLeyauw7kDpDsvj9EL2uldq1KoSi/
         QAvRMuBx0XLs5INIrS+SXT4GYq0pq7Pm9ddFKGcgxFeeFOnR9iYve/zRval4ZAlAQ5g1
         SrmaDOuRWGV6+49deVPjCFwLF/BoWdltCjYt9UPpUKJnPKy46xsdf0zFthzR/ftXNxVg
         rEFQ==
X-Gm-Message-State: AJcUukftU6OWm2ao+KdXgfIsNiBoq4xcZd/s/7DKfsgSetXNrNr4s9gm
        METrxRjTlLaEuE1AGJSrHqMFnu3WbmA=
X-Google-Smtp-Source: ALg8bN4Xoz8ibdvvVlIC9S3NRnM1pyg/t63mhhXcz0ZqS6PoxLHWs17B9l1srU7u7yTvGuU+IiR0ng==
X-Received: by 2002:a1f:9ec9:: with SMTP id h192mr2407019vke.68.1547047028319;
        Wed, 09 Jan 2019 07:17:08 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id r8sm20935709uan.0.2019.01.09.07.17.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 07:17:07 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id v205so4958631vsc.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 07:17:06 -0800 (PST)
X-Received: by 2002:a67:2c13:: with SMTP id s19mr2629580vss.172.1547047026185;
 Wed, 09 Jan 2019 07:17:06 -0800 (PST)
MIME-Version: 1.0
References: <8593f7faf89812a9987d44d9ae615d64dca4d77f.1544800744.git.christophe.leroy@c-s.fr>
 <CAGXu5jKeGp_z_69SybtkSaE381Ui7aXCxp9yBxv=TS0=hSsm-A@mail.gmail.com> <2d2e8cef-dd12-75e8-4779-fe4437e2169c@c-s.fr>
In-Reply-To: <2d2e8cef-dd12-75e8-4779-fe4437e2169c@c-s.fr>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 9 Jan 2019 07:16:55 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKUArQAkirjTTrPM-xayT1aYEGzmyveDZwrLuqmvRqD+A@mail.gmail.com>
Message-ID: <CAGXu5jKUArQAkirjTTrPM-xayT1aYEGzmyveDZwrLuqmvRqD+A@mail.gmail.com>
Subject: Re: [PATCH] lkdtm: Add a tests for NULL pointer dereference
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 10:31 PM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
>
>
> Le 09/01/2019 =C3=A0 02:14, Kees Cook a =C3=A9crit :
> > On Fri, Dec 14, 2018 at 7:26 AM Christophe Leroy
> > <christophe.leroy@c-s.fr> wrote:
> >>
> >> Introduce lkdtm tests for NULL pointer dereference: check
> >> access or exec at NULL address.
> >
> > Why is this not already covered by the existing tests? (Is there
> > something special about NULL that is being missed?) I'd expect SMAP
> > and SMEP to cover NULL as well.
>
> Most arches print a different message whether the faulty address is
> above or under PAGE_SIZE. Below is exemple from x86:
>
>         pr_alert("BUG: unable to handle kernel %s at %px\n",
>                  address < PAGE_SIZE ? "NULL pointer dereference" : "pagi=
ng request",
>                  (void *)address);
>
>
> Until recently, the powerpc arch didn't do it. When I implemented it
> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3D49a502ea23bf9dec47f8f3c3960909ff409cd1bb),
> I needed a way to test it and couldn't find an existing one, hence this
> new LKDTM test.
>
> But maybe I missed something ?

Okay, gotcha. You're getting more complete reporting coverage. Sounds
good to me. Thanks!

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

>
> Christophe
>
> >
> > -Kees
> >
> >>
> >> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> >> ---
> >>   drivers/misc/lkdtm/core.c  |  2 ++
> >>   drivers/misc/lkdtm/lkdtm.h |  2 ++
> >>   drivers/misc/lkdtm/perms.c | 18 ++++++++++++++++++
> >>   3 files changed, 22 insertions(+)
> >>
> >> diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
> >> index bc76756b7eda..36910e1d5c09 100644
> >> --- a/drivers/misc/lkdtm/core.c
> >> +++ b/drivers/misc/lkdtm/core.c
> >> @@ -157,7 +157,9 @@ static const struct crashtype crashtypes[] =3D {
> >>          CRASHTYPE(EXEC_VMALLOC),
> >>          CRASHTYPE(EXEC_RODATA),
> >>          CRASHTYPE(EXEC_USERSPACE),
> >> +       CRASHTYPE(EXEC_NULL),
> >>          CRASHTYPE(ACCESS_USERSPACE),
> >> +       CRASHTYPE(ACCESS_NULL),
> >>          CRASHTYPE(WRITE_RO),
> >>          CRASHTYPE(WRITE_RO_AFTER_INIT),
> >>          CRASHTYPE(WRITE_KERN),
> >> diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
> >> index 3c6fd327e166..b69ee004a3f7 100644
> >> --- a/drivers/misc/lkdtm/lkdtm.h
> >> +++ b/drivers/misc/lkdtm/lkdtm.h
> >> @@ -45,7 +45,9 @@ void lkdtm_EXEC_KMALLOC(void);
> >>   void lkdtm_EXEC_VMALLOC(void);
> >>   void lkdtm_EXEC_RODATA(void);
> >>   void lkdtm_EXEC_USERSPACE(void);
> >> +void lkdtm_EXEC_NULL(void);
> >>   void lkdtm_ACCESS_USERSPACE(void);
> >> +void lkdtm_ACCESS_NULL(void);
> >>
> >>   /* lkdtm_refcount.c */
> >>   void lkdtm_REFCOUNT_INC_OVERFLOW(void);
> >> diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
> >> index fa54add6375a..62f76d506f04 100644
> >> --- a/drivers/misc/lkdtm/perms.c
> >> +++ b/drivers/misc/lkdtm/perms.c
> >> @@ -164,6 +164,11 @@ void lkdtm_EXEC_USERSPACE(void)
> >>          vm_munmap(user_addr, PAGE_SIZE);
> >>   }
> >>
> >> +void lkdtm_EXEC_NULL(void)
> >> +{
> >> +       execute_location(NULL, CODE_AS_IS);
> >> +}
> >> +
> >>   void lkdtm_ACCESS_USERSPACE(void)
> >>   {
> >>          unsigned long user_addr, tmp =3D 0;
> >> @@ -195,6 +200,19 @@ void lkdtm_ACCESS_USERSPACE(void)
> >>          vm_munmap(user_addr, PAGE_SIZE);
> >>   }
> >>
> >> +void lkdtm_ACCESS_NULL(void)
> >> +{
> >> +       unsigned long tmp;
> >> +       unsigned long *ptr =3D (unsigned long *)NULL;
> >> +
> >> +       pr_info("attempting bad read at %px\n", ptr);
> >> +       tmp =3D *ptr;
> >> +       tmp +=3D 0xc0dec0de;
> >> +
> >> +       pr_info("attempting bad write at %px\n", ptr);
> >> +       *ptr =3D tmp;
> >> +}
> >> +
> >>   void __init lkdtm_perms_init(void)
> >>   {
> >>          /* Make sure we can write to __ro_after_init values during __=
init */
> >> --
> >> 2.13.3
> >>
> >
> >



--=20
Kees Cook
