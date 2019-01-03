Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB82C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E652184B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="SDM1Fo5Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfACUeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 15:34:24 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38476 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbfACUeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 15:34:24 -0500
Received: by mail-wm1-f68.google.com with SMTP id m22so31567284wml.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 12:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B1C4nMN8mcad579t2R30nMwuMSX28nSWg0EOCATgRKs=;
        b=SDM1Fo5ZhGAoyS1gGQSYKy+weqLP9FVwVk6poRRZ71V+jLzEJDFz5mXC7RPe4MPd/j
         C46J5EwI6LtYzByu4S3NimkQtgeVldtCe7uCGirWu0+S6pJT+DTBr+gxM3PyaaoDi3EX
         uOYfIav6DtcrDe6oSFj7ujnpV8qsal5MOjM5DPwg2AwXdc/LTUL3Ms1AVpffdcBykZ7x
         CzdR1ijxmgLyosjbhSmaFRZBsFT3RVXSPjCEE1Q4EAD9CVSvRsl5txoLU1sYQ71AS5ni
         VmBa14AvZGMNZwViL/h10A9/pV4JJxHfu9EoJgOY49rf5vzFNXNEyC4syY0yydd/IofV
         WVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B1C4nMN8mcad579t2R30nMwuMSX28nSWg0EOCATgRKs=;
        b=U/2PmT66RbE0Ivkg19rXF4mPsQEr0Y+0Qhnklgqn7owIu5hAOshVYsopCwDsAhrHME
         TnmJKZX1MmMgkx6EZotT7G9HEgeWt9zcwmCq+GJI+7JGP3EssbO05NnYdb4i23kBCufD
         IVlNlU6MMOeprnQh80R3difrG4NPANatKgY0FHM0bnZeIhWijkmEzSa5mjggJWMTq4Qy
         kdqm5CyvmstKyZoumkX5DnW1IP8ZVtCr6l6ObI6Jei2UJvmgNPKnvCb44Bzsdj6bWfnI
         /AfGRNTnBD4Lkl2YDVP7SmfyPHMWMpS2Nu5aFV40HJDendN+orN7WK5PsBzPWvAegYLK
         PV9A==
X-Gm-Message-State: AJcUukcZHF5xY7i+aXM/7U9nX/g9YZSmBjOjEQSV/oUYNUB1mgjAgMBv
        TFHatoNIZDpYaVJ0X47eYCLNww==
X-Google-Smtp-Source: AFSGD/X0UDdnkx+Y1CSsvVM0bCBh+0h780O8BWobpjVErjocKH6M02ykenmxsoM6NF8NQStXpb6xwA==
X-Received: by 2002:a1c:544f:: with SMTP id p15mr38544365wmi.37.1546547661355;
        Thu, 03 Jan 2019 12:34:21 -0800 (PST)
Received: from brauner.io (p200300EA6F0B706E700BB2FADE8A175D.dip0.t-ipconnect.de. [2003:ea:6f0b:706e:700b:b2fa:de8a:175d])
        by smtp.gmail.com with ESMTPSA id l6sm42408454wrv.70.2019.01.03.12.34.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 12:34:20 -0800 (PST)
Date:   Thu, 3 Jan 2019 21:34:19 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Todd Kjos <tkjos@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Todd Kjos <tkjos@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Martijn Coenen <maco@android.com>, joel@joelfernandes.org
Subject: Re: [PATCH v1 2/2] binderfs: reserve devices for initial mount
Message-ID: <20190103203418.rpx3wcs3ozncpnhu@brauner.io>
References: <20181223143550.10672-1-christian@brauner.io>
 <20181223143550.10672-2-christian@brauner.io>
 <CAHRSSEythiuV6HH9c-q5TwU=tDyZ-K5gjgF+uYZmd6pmAJTovw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHRSSEythiuV6HH9c-q5TwU=tDyZ-K5gjgF+uYZmd6pmAJTovw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 12:25:24PM -0800, Todd Kjos wrote:
> On Sun, Dec 23, 2018 at 6:36 AM Christian Brauner <christian@brauner.io> wrote:
> >
> > The binderfs instance in the initial ipc namespace will always have a
> > reserve of 4 binder devices unless explicitly capped by specifying a lower
> > value via the "max" mount option.
> > This ensures when binder devices are removed (on accident or on purpose)
> > they can always be recreated without risking that all minor numbers have
> > already been used up.
> >
> > Cc: Todd Kjos <tkjos@google.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> > v1:
> > - patch introduced
> > v0:
> > - patch not present
> > ---
> >  drivers/android/binderfs.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> > index 873adda064ac..aa635c7ea727 100644
> > --- a/drivers/android/binderfs.c
> > +++ b/drivers/android/binderfs.c
> > @@ -40,6 +40,8 @@
> >  #define INODE_OFFSET 3
> >  #define INTSTRLEN 21
> >  #define BINDERFS_MAX_MINOR (1U << MINORBITS)
> > +/* Ensure that the initial ipc namespace always has a devices available. */
> > +#define BINDERFS_MAX_MINOR_CAPPED (BINDERFS_MAX_MINOR - 4)
> 
> Why do you ever need more minors per instance than the number of
> devices listed in CONFIG_ANDROID_BINDER_DEVICES?

Are you asking asking why this is 4 and not 3? In that case we should
probably parse CONFIG_ANDROID_BINDER_DEVICES once at init time and then
reserve that many binder devices. Thoughts?

Christian
