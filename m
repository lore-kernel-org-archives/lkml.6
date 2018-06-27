Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A790C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52E725F94
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C52E725F94
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934370AbeF0OXX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 10:23:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60250 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932907AbeF0OXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 10:23:21 -0400
Received: from mail-wr0-f199.google.com ([209.85.128.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <christian.brauner@canonical.com>)
        id 1fYBLs-0000By-5m
        for linux-kernel@vger.kernel.org; Wed, 27 Jun 2018 14:23:20 +0000
Received: by mail-wr0-f199.google.com with SMTP id u7-v6so1349539wrr.22
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 07:23:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uae/eKtYlTBXyzD5wYDt6Pi0ZBTxqA7ZMDFKbN9bPNc=;
        b=pWyRC8nJnhpZCSFuSVBVAWBjsXVgB82/s8OgD7OWHz2gbnyKLTwYgQUpyYcAzminYZ
         XNgn4f/BkRmgaQrFCFvGHDHBnuzxcndchm0xfZa747pnQx5nrUlnTHUcn20kvAYToVFM
         enCrXuXkE4nsumJlsCu+WwJTreBBu0bNInpeeikYDzsibi5mlZttiFpM8qgstrRQ7Fl3
         4TFbko/3W9d4JqyDTD1zy+YhaR0m7QG1861heNGJzbmElAaL18ahWPjgiRgixo0VmAzn
         A6XM/FPA7rwu01f5lDd9shH31HJZbfSBYswKCsLBMzHM2htkEj0J6CgP1/hRA2KABKC+
         naRw==
X-Gm-Message-State: APt69E1cMx/2DuguvLN9sETyCRgg499RZf+4RrhLXtcq2Ny79JhqFJSN
        JWQHdMQfWsbHfxmL/U1AJIxf40c7KG0ApTRBgh/i2HiGYny7p9UW8Ih2nsZ2nzAUWEbxeTCef0t
        o3zcOAxWH1NP0hSRDWT8Ien4iBPtbdL/SRzDWCoggyQ==
X-Received: by 2002:a1c:9947:: with SMTP id b68-v6mr5117234wme.159.1530109399553;
        Wed, 27 Jun 2018 07:23:19 -0700 (PDT)
X-Google-Smtp-Source: AAOMgpeneUtM6CFRd53fmHYSuzfKBHw1yb7f0bYOJRV5s6CKKth36W/L/MuBbAC1o7wvqprVtCQ7DQ==
X-Received: by 2002:a1c:9947:: with SMTP id b68-v6mr5117213wme.159.1530109399193;
        Wed, 27 Jun 2018 07:23:19 -0700 (PDT)
Received: from gmail.com (eap108073.extern.uni-tuebingen.de. [134.2.108.73])
        by smtp.gmail.com with ESMTPSA id 16-v6sm7648442wmi.36.2018.06.27.07.23.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 07:23:18 -0700 (PDT)
From:   Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian@brauner.io>
Date:   Wed, 27 Jun 2018 16:23:16 +0200
To:     Jann Horn <jannh@google.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        security@kernel.org, Andy Lutomirski <luto@amacapital.net>,
        Kees Cook <keescook@chromium.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH] userns: move user access out of the mutex
Message-ID: <20180627142315.GC31443@gmail.com>
References: <20180625163419.216578-1-jannh@google.com>
 <20180626130757.GA10042@gmail.com>
 <CAG48ez2WwQVWtfh7sQCqn1E52V7V4_LxZaU+kV_r-YGOzNAsXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez2WwQVWtfh7sQCqn1E52V7V4_LxZaU+kV_r-YGOzNAsXg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 04:06:45PM +0200, Jann Horn wrote:
> On Tue, Jun 26, 2018 at 3:08 PM Christian Brauner
> <christian.brauner@canonical.com> wrote:
> >
> > On Mon, Jun 25, 2018 at 06:34:19PM +0200, Jann Horn wrote:
> > > The old code would hold the userns_state_mutex indefinitely if
> > > memdup_user_nul stalled due to e.g. a userfault region. Prevent that by
> > > moving the memdup_user_nul in front of the mutex_lock().
> > >
> > > Note: This changes the error precedence of invalid buf/count/*ppos vs
> > > map already written / capabilities missing.
> > >
> > > Fixes: 22d917d80e84 ("userns: Rework the user_namespace adding uid/gid...")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: Christian Brauner <christian@brauner.io>

> > > ---
> > >  kernel/user_namespace.c | 24 ++++++++++--------------
> > >  1 file changed, 10 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> > > index c3d7583fcd21..e5222b5fb4fe 100644
> > > --- a/kernel/user_namespace.c
> > > +++ b/kernel/user_namespace.c
> > > @@ -859,7 +859,16 @@ static ssize_t map_write(struct file *file, const char __user *buf,
> > >       unsigned idx;
> > >       struct uid_gid_extent extent;
> > >       char *kbuf = NULL, *pos, *next_line;
> > > -     ssize_t ret = -EINVAL;
> > > +     ssize_t ret;
> > > +
> > > +     /* Only allow < page size writes at the beginning of the file */
> > > +     if ((*ppos != 0) || (count >= PAGE_SIZE))
> > > +             return -EINVAL;
> > > +
> > > +     /* Slurp in the user data */
> > > +     kbuf = memdup_user_nul(buf, count);
> > > +     if (IS_ERR(kbuf))
> > > +             return PTR_ERR(kbuf);
> >
> > I'm not opposed to this but what is annoying is the changed error
> > reporting you pointed out. It seems conceptually way cleaner if missing
> > permissions are reported before more specific internal errors.
> >
> > The question I have is how bad it would be if memdup_user_nul() stalled
> > and if you see any issues security wise. Given that the mutex is only
> > taken on operations that are mostly performed when creating or setting
> > up a new user namespace
> >
> > map_write()
> > create_user_ns()
> > proc_setgroups_write()
> > userns_may_setgroups()
> >
> > and not when actually interacting with it it seems the worst that
> > happens is that creation of new user namespaces is not possible anymore.
> > That shouldn't have any effect on the host though which I would see as a
> > real issue. But I might be missing context. :)
> 
> userns_may_setgroups() is involved in sys_setgroups() via
> may_setgroups(), so if one thread is blocking the userns_state_mutex,
> nobody can log in anymore.

Thanks!

> 
> > >       /*
> > >        * The userns_state_mutex serializes all writes to any given map.
> > > @@ -895,19 +904,6 @@ static ssize_t map_write(struct file *file, const char __user *buf,
> > >       if (cap_valid(cap_setid) && !file_ns_capable(file, ns, CAP_SYS_ADMIN))
> > >               goto out;
> > >
> > > -     /* Only allow < page size writes at the beginning of the file */
> > > -     ret = -EINVAL;
> > > -     if ((*ppos != 0) || (count >= PAGE_SIZE))
> > > -             goto out;
> > > -
> > > -     /* Slurp in the user data */
> > > -     kbuf = memdup_user_nul(buf, count);
> > > -     if (IS_ERR(kbuf)) {
> > > -             ret = PTR_ERR(kbuf);
> > > -             kbuf = NULL;
> > > -             goto out;
> > > -     }
> > > -
> > >       /* Parse the user data */
> > >       ret = -EINVAL;
> > >       pos = kbuf;
> > > --
> > > 2.18.0.rc2.346.g013aa6912e-goog
> > >
