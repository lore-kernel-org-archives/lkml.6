Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB0CFC6182
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49BC420881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="hA2XvH6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49BC420881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbeINDCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 23:02:24 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:37158 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbeINDCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 23:02:24 -0400
Received: by mail-lj1-f175.google.com with SMTP id v9-v6so5879963ljk.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 14:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AYxGYmlNdLMee38p4W9/y307GfscSIHqjlP1wERClSw=;
        b=hA2XvH6oWD1K4vEn1JlkxIxO4Cld6IoqrHcb9ZPCb4rO5ChBtDViqXiR0osAgOkG7R
         UeScN86HFrkMpXGJ753B0p07QkUmH1eq/58P//nnkO46YY4OnfjIXiKgsRTZkeFpf7lb
         g+9krA3K1qC1E/L/d37lwhsvakm68IuiC0eM33Pez+lKWv6CihIakvwd1lTD7Y0tKxo1
         ZRYlpiMYN+kuh5O4PPHSgMD3gIt517eELR2gWEKBzBSggC24dg5itQRkVABJinyipMWp
         9dbJGw+TKA9iB7R5RPkgU3wy6i8D/iSgiXdJbbzrznL5ZGiHBxMc9seXloR4EB5D4VZ/
         CdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AYxGYmlNdLMee38p4W9/y307GfscSIHqjlP1wERClSw=;
        b=WoQVo1RCUSSXFQJQC9MT8Z6PZgUg9JvLacOW1pmcw+Vo5ZSmeAj7dYwoEv5p+uUA+V
         r0XSEno8psQ2BZby1aUb2jzugK3J1fBZVqDnVMnce8nvyr6Z4acfWmcQYjaGNUXIblEJ
         9sAUCJ8586qiqQ2AkzW7savkPQNa1qjrb+3QSOJHhZ6U/jSjl5sFZP7vwQ6kUwFgyB33
         QjQu/iVYvgTIq8vx5nIXpr/J1PLhmhTAi/Btzucc9bBilBT0ZRHMMBJGIP8rZAqpD7LU
         a6XwaDKwj1k2W5EiymY+Ua1O60ZvTPtDnuyo1gyqDXM2l/kt6HnVn9UzKY6/5xnzjJGP
         y2nA==
X-Gm-Message-State: APzg51AVkt9VpGEtLFjAJp5ErrsSD/MRSQj+1bJzwMHPbq4vxrI8xrCo
        LoOOn1EAla1O020HhoTgCNL7ehw3XuDu2f8EDzRX
X-Google-Smtp-Source: ANB0VdaScnVR68ZEHCuEdmceA1boVUaLQrScdvevjynrrJIUOToLIC/MU0orrXfwKefkzMz9demrA6YMPjWec5Wq2Rw=
X-Received: by 2002:a2e:2d0a:: with SMTP id t10-v6mr5594008ljt.8.1536875460321;
 Thu, 13 Sep 2018 14:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <99cb1ae7-8881-eb9a-a8cb-a787abe454e1@schaufler-ca.com> <CAGXu5jLONSfPHYYYTLSma-+arVHSQKaEWb9JxpOn6TNKtyLNhw@mail.gmail.com>
 <CAHC9VhQN0wq0zZS5BYU9jBomaWvCaJ_BqJjHF3AT7FG8Z0nLDQ@mail.gmail.com>
 <CAGXu5jJs6kmd6Tjgwqb2Zx7e-jNbHqfJ57poZuyz4Qj=AKVfmQ@mail.gmail.com>
 <CAHC9VhQ20tBAMwOJ9mg0tBHYUoxjh0Szr3d62HuPw2SyT4XDLw@mail.gmail.com> <tb3zfQ7fac9Oth8YArOo84SbMfqV1s0DjOmVy7op90J_o1XOaEjflZloOpj9PIiUQRhKJxhauXzJD3irkSSjOXK94qYlfQ1frIQiH1OTWPQ=@protonmail.ch>
In-Reply-To: <tb3zfQ7fac9Oth8YArOo84SbMfqV1s0DjOmVy7op90J_o1XOaEjflZloOpj9PIiUQRhKJxhauXzJD3irkSSjOXK94qYlfQ1frIQiH1OTWPQ=@protonmail.ch>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 13 Sep 2018 17:50:48 -0400
Message-ID: <CAHC9VhR0qfTn3qwVGpBV=LcM8O1jz-dmqxTW0OqJ-xfO+1k6ew@mail.gmail.com>
Subject: Re: [PATCH 10/10] LSM: Blob sharing support for S.A.R.A and LandLock
To:     Golden_Miller83@protonmail.ch
Cc:     keescook@chromium.org, casey@schaufler-ca.com,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-fsdevel@vger.kernel.org, casey.schaufler@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 4:58 PM Jordan Glover
<Golden_Miller83@protonmail.ch> wrote:
>
> On Thursday, September 13, 2018 9:12 PM, Paul Moore <paul@paul-moore.com> wrote:
>
> > On Thu, Sep 13, 2018 at 11:19 AM Kees Cook keescook@chromium.org wrote:
> >
> > > On Thu, Sep 13, 2018 at 6:16 AM, Paul Moore paul@paul-moore.com wrote:
> > >
> > > > On Thu, Sep 13, 2018 at 12:19 AM Kees Cook keescook@chromium.org wrote:

...

> > > > > I don't see a good reason to make this a config. Why shouldn't this
> > > > > always be enabled?
> > > >
> > > > I do. From a user perspective it is sometimes difficult to determine
> > > > the reason behind a failed operation; its is a DAC based denial, the
> > > > LSM, or some other failure? Stacking additional LSMs has the
> > > > potential to make this worse. The boot time configuration adds to the
> > > > complexity.
> > >
> > > Let me try to convince you otherwise. :) The reason I think there's no
> > > need for this is because the only functional change here is how
> > > TOMOYO gets stacked. And in my proposal, we can convert TOMOYO to be
> > > enabled/disabled like LoadPin. Given the configs I showed, stacking
> > > TOMOYO with the other major LSMs becomes a config (and/or boottime)
> > > option.
> > > The changes for TOMOYO are still needed even with SECURITY_STACKING,
> > > and I argue that the other major LSMs remain the same. It's only
> > > infrastructure that has changed. So, I think having SECURITY_STACKING
> > > actually makes things more complex internally (all the ifdefs, weird
> > > enable logic) and for distros ("what's this stacking option", etc?)
> >
> > None of the above deals with the user experience or support burden a
> > distro would have by forcing stacking on. If we make it an option the
> > distros can choose for themselves; picking a kernel build config is
> > not something new to distros, and I think Casey's text adequately
> > explains CONFIG_SECURITY_STACKING in terms that would be sufficient.
>
> CONFIG_SECURITY_STACKING doesn't make any user visible changes on
> itself as it doesn't automatically enable any new LSM. The LSM
> specific configs are place where users/distros make decisions. If
> there is only one LSM enabled to run then there's nothing to stack.
> If someone choose to run two or more LSM in config/boot cmdline
> then we can assume having it stacked is what they wanted. As Kees
> pointed there is already CONFIG_SECURITY_DEFAULT_XXX. In both cases
> CONFIG_SECURITY_STACKING is redundant and only adds burden instead
> of removing it.

See my last response to Kees.

> > I currently have a neutral stance on stacking, making it mandatory
> > pushes me more towards a "no".
>
> This implies that your real concern is something else than
> CONFIG_SECURITY_STACKING which only allows you to ignore the whole
> thing. Please reveal it. There are a lot of people waiting for LSM
> stacking which is several years late and it would be great to
> resolve potential issues earlier  rather later.

What?  I resent the implication that I'm hiding anything; there are a
lot of fair criticisms you could level at me, but I take offense at
the idea that I'm not being honest here.  I've been speaking with
Casey, John, and others about stacking for years, both on-list and
in-person at conferences, and my
neutral-opinion-just-make-it-work-for-everything-and-make-it-optional
stance has been pretty consistent and isn't new.

Also, let's be really clear here: I'm only asking that stacking be
made a build time option (as it is in Casey's patchset).  That seems
like a pretty modest ask for something so significant and "several
years late" as you put it.

-- 
paul moore
www.paul-moore.com
