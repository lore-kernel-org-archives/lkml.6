Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD2BC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A092089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2LBMzFB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A092089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbeJCOsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 10:48:13 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46530 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbeJCOsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 10:48:12 -0400
Received: by mail-qt1-f195.google.com with SMTP id d8-v6so4899548qtk.13;
        Wed, 03 Oct 2018 01:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4m0nKHGcdBzOprfw5dJXGsHaVwfwzct9r0tlTmIvcrA=;
        b=Z2LBMzFBV5w0syVrLvdiAbLoiQpJMUqYbtTAvHeG0pjYXiooUVHKlln1otvWx60U1m
         C+/B3GlK3vnKwqJTIU3hMNSlkx+UFa5UP3WxEzSePhNt+tLgTGSx0+yYm/TiX47n5dTA
         R1U5BBl3IfcEkWxAopDelt8YbSTUM1gGrVy5se3mkszVH0Gkons/J9kChFZfzUae/QWy
         6/VH6IIgQONc8AE9z6vRrkUGFjDDh6T8VJsB00R7hMtLluQOgrqs9z+74DD6NWENk0Tc
         hrkIRTXqLBqrpJ/raEtSQFxL/PfmvCywsHbtrg5aruJCoBEkvqIHs1Ew4qNbY3dfXfHg
         D8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4m0nKHGcdBzOprfw5dJXGsHaVwfwzct9r0tlTmIvcrA=;
        b=iyAcgh4HEmecdRRSX8lnWeitStR+soWji66R01/yVaMKbOxrfkwvBFeTxBDUlHZI7d
         vIY+Fshe6hXIjRuR5AbMdeQLJdcM/njFPQOqJKCXBU35esZri0kMdeZDesSXybnqdVWw
         VMnUdI9vldtGH+d7iGhU6ntnsXnDlFHZEDaFyCVe58hvOGq576mii821Gix02GfLRzIX
         JbnM3+r78l2fs5v8zFxzKU5TsSzyOSf8tmd5dlDA44ay3ddmENGTyLfx5PKzC2yIPt9X
         vYxX/HOWhhSUZlO7GbWjZFk+DirkcYJva/JJ7GU9yQt7RVjHm9grNku0IVb44Y4VpjSW
         isWg==
X-Gm-Message-State: ABuFfoidkeueBNY57fxeW566dPd1qxJQx0yLOgGztv1cdsFU6Fd40cm6
        3EcoM0EZScIXbo3jd7gctsdVa45W+oprs1/DV7Q=
X-Google-Smtp-Source: ACcGV63ZVV4E6ryARi/4F7SXhkP9q+mIoUS/5Gdj9bqcMzK/tk8x9Pf75Jv//OsxpIMHIlKjYCB7SCZcvOwNSalksFg=
X-Received: by 2002:ac8:29d3:: with SMTP id 19-v6mr228459qtt.174.1538553655187;
 Wed, 03 Oct 2018 01:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20181002191818.1c2eec51@canb.auug.org.au> <b019c375-1157-778f-99b2-1d09aa4b4e6a@infradead.org>
In-Reply-To: <b019c375-1157-778f-99b2-1d09aa4b4e6a@infradead.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 3 Oct 2018 11:00:44 +0300
Message-ID: <CAHp75VdU1u9VueXB+f68c5TA4QsxBNihv_VtWw2zPpWvehV1vQ@mail.gmail.com>
Subject: Re: linux-next: Tree for Oct 2 (dell: dcdbas)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Stuart Hayes <stuart.w.hayes@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 2, 2018 at 7:52 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 10/2/18 2:18 AM, Stephen Rothwell wrote:
> > Hi all,
> >
> > Changes since 20180928:
> >
>
> on i386 or x86_64:
>
>   CC      drivers/platform/x86/dcdbas.o
> ../drivers/platform/x86/dcdbas.c: In function 'dcdbas_check_wsmt':
> ../drivers/platform/x86/dcdbas.c:572:2: error: implicit declaration of function 'memremap' [-Werror=implicit-function-declaration]
>   eps_buffer = memremap(eps->smm_comm_buff_addr, remap_size, MEMREMAP_WB);
>   ^
> ../drivers/platform/x86/dcdbas.c:572:61: error: 'MEMREMAP_WB' undeclared (first use in this function)
>   eps_buffer = memremap(eps->smm_comm_buff_addr, remap_size, MEMREMAP_WB);
>                                                              ^
> ../drivers/platform/x86/dcdbas.c:572:61: note: each undeclared identifier is reported only once for each function it appears in
> ../drivers/platform/x86/dcdbas.c: In function 'dcdbas_exit':
> ../drivers/platform/x86/dcdbas.c:748:3: error: implicit declaration of function 'memunmap' [-Werror=implicit-function-declaration]
>    memunmap(eps_buffer);
>    ^
>
>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>

Sorry for that. Arnd sent a fix and I'm going to apply it soon.

>
> --
> ~Randy



-- 
With Best Regards,
Andy Shevchenko
