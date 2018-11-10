Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F6AC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 06:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6B82086C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 06:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B5uUPUx9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F6B82086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbeKJQWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 11:22:08 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36656 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728644AbeKJQWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 11:22:08 -0500
Received: by mail-lf1-f65.google.com with SMTP id h192so2884960lfg.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 22:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CWqz3DjLLmg+s3XuvAvcG7DA2KqfIjnBfFPWEJlzW5c=;
        b=B5uUPUx9IFG5d4DjsO91uTQCgz+/ifl3l1Au17BZtYxq3qcgQt41kyGCZvO0yPcI8W
         0rOvL5Dk1J7xsL28J1P6t27y/xBAxD39yOn0gaPjhuDL4SIR3rRi+vb21cI4whKTh2d4
         wKBd/CN9xj81WiOjbASvFaDGEVSe9/KmTg1By5Sw8JXDw6MV08X14uhJxq3R4vCCq0I9
         nUW/F58VU6Ce6mA2DmXjcwbubNWXntPhKNgqoXKsHO6y25rdHRwTZonSfhAl4hHGuLoJ
         YSQ71stCY5fMqY+JArOeJV9b19qAlT7KWb287arhSYr95Lh+fZwDR31sbBehq8xdyq4J
         5bQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CWqz3DjLLmg+s3XuvAvcG7DA2KqfIjnBfFPWEJlzW5c=;
        b=MhKGeSnxirlOgfzW8pBovOc9USYBXvShlTFBoh7YvN8+wN7G9QC748piON/XAvycAS
         8+iZE7XWTDYMTI1t56NB5ZW5we/pHt+WWk+ABPgvgNZunlCpG6eSeIlMNGh9qEHjF5oM
         vxv2MMkf8ldevZypN7yRel7EPy+4oSYizIojUlwyzzYqHoEXzrme/UaJR2HvCARh6CiW
         zzCHLwQBj2PZ3k3lqk/hlpXNADurQtz2gJwy5r5HVab48oMN3o3rEevQcRXY1Hm1Yk/s
         dRQQtyBFrXbM0hHSjIgXhIW/GhSIfrX/CovJSMNOK2YyjVHzN/H4/12m3CTJOGamt28j
         lGSg==
X-Gm-Message-State: AGRZ1gJcRRGrDbLl306lE7q2kppBms3NQVU73VCKdPaKElrEpdU56jex
        bAayyKbw2cOI35s6r1WZZFK7O4UKAfRtFE03shX4vQ==
X-Google-Smtp-Source: AJdET5fcBOMnJMz2C1c91zakLfFAu/YYZNhWz+7CwAjO8QqpkgRnVNz+NbssjjMCr1Go/YQGkpINBkK0g0w5ybbOdwE=
X-Received: by 2002:a19:1cb:: with SMTP id 194mr7070838lfb.61.1541831894492;
 Fri, 09 Nov 2018 22:38:14 -0800 (PST)
MIME-Version: 1.0
References: <5FBCBE569E134E4CA167B91C0A77FD610198F851AC@EXMBX-SZMAIL022.tencent.com>
 <CAHRSSExukqyS5V=fgdBP1Jn_KXZEMsWR+wMLNtxBq8+G3wkgSQ@mail.gmail.com>
 <5FBCBE569E134E4CA167B91C0A77FD610198F8A217@EXMBX-SZMAIL022.tencent.com>
 <CAHRSSEx=z_CCfM5dmdm_cVtH-Az5eKCL5N_S-52qqSsMmGDUbQ@mail.gmail.com>
 <5FBCBE569E134E4CA167B91C0A77FD610198F8A4B2@EXMBX-SZMAIL022.tencent.com>
 <CAHRSSEwjNYu1345KFvkTTvvy6Qb+T6=4WXEZ-t8wcGtkCUa_UA@mail.gmail.com> <5FBCBE569E134E4CA167B91C0A77FD610198F8A65C@EXMBX-SZMAIL022.tencent.com>
In-Reply-To: <5FBCBE569E134E4CA167B91C0A77FD610198F8A65C@EXMBX-SZMAIL022.tencent.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Fri, 9 Nov 2018 22:38:02 -0800
Message-ID: <CAHRSSEynQoksQiQk2x8ZNSnuSM4rQkiD2kk1=AwSQ5o4Lqks3g@mail.gmail.com>
Subject: Re: Re: [PATCH V3] binder: ipc namespace support for android
 binder(Internet mail)
To:     chouryzhou@tencent.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>, akpm@linux-foundation.org,
        dave@stgolabs.net,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>, chouryzhou@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 9:43 PM chouryzhou(=E5=91=A8=E5=A8=81) <chouryzhou@t=
encent.com> wrote:
>
> > >
> > > If IPC_NS is disabled, "current-nsporxy->ipc_ns" will also exists,  i=
t will be a static
> > > reference of "init_ipc_ns" (in ipc/msgutil.c, not defined in binder.c=
 by me) with
> > > no namespace-ization. You will get the same one in all processes, eve=
rything is
> > > the same as  without this patch.
> >
> > except, as far as I can tell, binder_init_ns() would never have been
> > called on it so the mutex and list heads are not initialized so its
> > completely broken. Am I missing something? How do those fields get
> > initialized in this case?
>
> > @@ -5832,8 +5888,12 @@ static int __init binder_init(void)
> >                         goto err_init_binder_device_failed;
> >         }
> >
> > -       return ret;
> > +       ret =3D binder_init_ns(&init_ipc_ns);
> > +       if (ret)
> > +               goto err_init_namespace_failed;
> >
> > +       return ret;
>
> They are initialized here.

Ok, This init_ipc_ns is a global declared in msgutil.c if SYSVIPC ||
POSIX_MQUEUE. This seems kinda hacky, but now I finally see why the
dependancy... msgutil.c is the only file we can count on if !IPC_NS &&
(SYSVIPC || POSIX_MQUEUE). There must be a cleaner way to do this, I
really don't like this dependency... wouldn't it be cleaner to do:

#ifndef CONFIG_IPC_NS
static struct ipc_namespace binder_ipc_ns;
#define ipcns  (&binder_ipc_ns)
#else
#define ipcns  (current->nsproxy->ipc_ns)
#endif

(and make the initialization of binder_ipc_ns conditional on IPC_NS)

This gets us the same thing without the incestuous dependency on the
msgutil.c version of init_ipc_ns...and then binder doesn't rely on
SYSVIPC or POSIX_MQUEUE directly.

>
> - choury -
>
