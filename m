Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51136C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE58820861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="IUE6kX1x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE58820861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbeIMS0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:26:19 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45944 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbeIMS0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:26:19 -0400
Received: by mail-lj1-f195.google.com with SMTP id u83-v6so4544951lje.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 06:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9AiYgXrIawJIgvYrQKzVn6hFt7fxHpMJ7RkWi2T3eow=;
        b=IUE6kX1xirh+LJxA0cT2FIzessZBKhxrfpfJ11cFlHltEoP+pyaB9tgTOuQIkKwemz
         aiVrzm+KdhTP6ajh+2TDqTHZXpyrCkM66EPbC0Zho5DcSlNZa68fIkxqloAi9G2G3O7o
         aQA0HHMqvLoSzGsK6HYVMAZE4swh4qcRpVbrMAtH3zFssP8mo1fYb3OtilsIaliM2ZYO
         /PeTVckPzB9Nav73seu1mL7YCCMoqf6HUWjHNDWyfdYtFQaL0tVqulSjjKbbH1pqwfdl
         lXLTKc3SoMvyslb24u1bmduNY5dzMm94OG814Uyj1joWK02KmrNg6JhoVpGK2W+Eeuua
         H6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9AiYgXrIawJIgvYrQKzVn6hFt7fxHpMJ7RkWi2T3eow=;
        b=Ry0B5Pskf57t7cqC6+N2RQt37+N7TV3lDLQ8oD2TGH6Ss7S25IDOoSGemwgm5bPy4y
         Roc8dTQZEK3x4BKjZliUcBVgKZg3tfBh9crzSYEGDkA7ifRCrn5zHtA/JHjqPf1XGoG5
         woPmHgNoEbnRgzL9pzAOx5oxP4pzb+3FcSr4t7FgJX/uxg8DXXZWoJ271vouyCy7KoKM
         VlngY3+P5+TagBDELB8P5TJRw/XxFHJSgo0yScJVr7YxzNJoPMsC4WI5zVE8CbUutzHY
         1+vjeG0jzlZpCBu2jq1gqzuz79N3uF4uW65Mrp7Wx+Sl20iPBrGdGs7E36wHXTOZic6T
         geDA==
X-Gm-Message-State: APzg51BofVA/sS2MutWIURPnGOeaEBo20ttEGKuHOZTXguJh4cH6v2SB
        zBlN5jm1YtGeU7d36r+uSHmIewQp41rmIrP9EhIV
X-Google-Smtp-Source: ANB0VdafVv6ytbFjcNYWWPFejEHIziv7f8fOSVmdwC4qfm9YfDTvk3y4+kPshghyObBRyriZ9BG4WW1vwEoZ0S+FoNc=
X-Received: by 2002:a2e:811:: with SMTP id 17-v6mr4795832lji.140.1536844610768;
 Thu, 13 Sep 2018 06:16:50 -0700 (PDT)
MIME-Version: 1.0
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <99cb1ae7-8881-eb9a-a8cb-a787abe454e1@schaufler-ca.com> <CAGXu5jLONSfPHYYYTLSma-+arVHSQKaEWb9JxpOn6TNKtyLNhw@mail.gmail.com>
In-Reply-To: <CAGXu5jLONSfPHYYYTLSma-+arVHSQKaEWb9JxpOn6TNKtyLNhw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 13 Sep 2018 09:16:39 -0400
Message-ID: <CAHC9VhQN0wq0zZS5BYU9jBomaWvCaJ_BqJjHF3AT7FG8Z0nLDQ@mail.gmail.com>
Subject: Re: [PATCH 10/10] LSM: Blob sharing support for S.A.R.A and LandLock
To:     keescook@chromium.org
Cc:     casey@schaufler-ca.com, linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-fsdevel@vger.kernel.org, adobriyan@gmail.com,
        casey.schaufler@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 12:19 AM Kees Cook <keescook@chromium.org> wrote:
> On Tue, Sep 11, 2018 at 9:42 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> > Two proposed security modules require the ability to
> > share security blobs with existing "major" security modules.
> > These modules, S.A.R.A and LandLock, provide significantly
> > different services than SELinux, Smack or AppArmor. Using
> > either in conjunction with the existing modules is quite
> > reasonable. S.A.R.A requires access to the cred blob, while
> > LandLock uses the cred, file and inode blobs.
> >
> > The use of the cred, file and inode blobs has been
> > abstracted in preceding patches in the series. This
> > patch teaches the affected security modules how to access
> > the part of the blob set aside for their use in the case
> > where blobs are shared. The configuration option
> > CONFIG_SECURITY_STACKING identifies systems where the
> > blobs may be shared.
> >
> > The mechanism for selecting which security modules are
> > active has been changed to allow non-conflicting "major"
> > security modules to be used together. At this time the
> > TOMOYO module can safely be used with any of the others.
> > The two new modules would be non-conflicting as well.
> >
> > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > ---
> >  Documentation/admin-guide/LSM/index.rst | 14 +++--
> >  include/linux/lsm_hooks.h               |  2 +-
> >  security/Kconfig                        | 81 +++++++++++++++++++++++++
> >  security/apparmor/include/cred.h        |  8 +++
> >  security/apparmor/include/file.h        |  9 ++-
> >  security/apparmor/include/lib.h         |  4 ++
> >  security/apparmor/lsm.c                 |  8 ++-
> >  security/security.c                     | 30 ++++++++-
> >  security/selinux/hooks.c                |  3 +-
> >  security/selinux/include/objsec.h       | 18 +++++-
> >  security/smack/smack.h                  | 19 +++++-
> >  security/smack/smack_lsm.c              | 17 +++---
> >  security/tomoyo/common.h                | 12 +++-
> >  security/tomoyo/tomoyo.c                |  3 +-
> >  14 files changed, 200 insertions(+), 28 deletions(-)

...

> > diff --git a/security/Kconfig b/security/Kconfig
> > index 22f7664c4977..ed48025ae9e0 100644
> > --- a/security/Kconfig
> > +++ b/security/Kconfig
> > @@ -36,6 +36,28 @@ config SECURITY_WRITABLE_HOOKS
> >         bool
> >         default n
> >
> > +config SECURITY_STACKING
> > +       bool "Security module stacking"
> > +       depends on SECURITY
> > +       help
> > +         Allows multiple major security modules to be stacked.
> > +         Modules are invoked in the order registered with a
> > +         "bail on fail" policy, in which the infrastructure
> > +         will stop processing once a denial is detected. Not
> > +         all modules can be stacked. SELinux, Smack and AppArmor are
> > +         known to be incompatible. User space components may
> > +         have trouble identifying the security module providing
> > +         data in some cases.
> > +
> > +         If you select this option you will have to select which
> > +         of the stackable modules you wish to be active. The
> > +         "Default security module" will be ignored. The boot line
> > +         "security=" option can be used to specify that one of
> > +         the modules identifed for stacking should be used instead
> > +         of the entire stack.
> > +
> > +         If you are unsure how to answer this question, answer N.
>
> I don't see a good reason to make this a config. Why shouldn't this
> always be enabled?

I do.  From a user perspective it is sometimes difficult to determine
the reason behind a failed operation; its is a DAC based denial, the
LSM, or some other failure?  Stacking additional LSMs has the
potential to make this worse.  The boot time configuration adds to the
complexity.

I think we should leave this decision to the individual distros so
that they can make their own decision on LSM stacking based on the
savviness of their user base and the quality of their support
infrastructure.

-- 
paul moore
www.paul-moore.com
