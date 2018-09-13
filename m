Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C73DFC6182
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3AE20861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="VqjbanJg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB3AE20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbeINCtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 22:49:49 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38988 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbeINCts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 22:49:48 -0400
Received: by mail-lj1-f194.google.com with SMTP id l15-v6so5859085lji.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 14:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vn5KVySxqyK2pXiK33nF0WGu0qI20e7bm7jRZPo/m9c=;
        b=VqjbanJgsp/cEV3kRYw9e/lBeqNHUrAgHd50tsS95xrVm1TIBhuyW5bdctjmNTZ8qQ
         Ymfa5R6dhsOcJOP0rilhC3T/5cEaLmHnB+NzMh2yK1asSVAlGaxNZlMqohlgMrpVpYLE
         66KEysxSTW+ENRvNLN7xhNmPZCvXfRBRaCx3bCc6FkKkdy8hUNrSxdx5ZZzlgeGRiN9h
         ynkVsAbea//dfMfmiji5eJrMZJpbL1vnkRDTZURt/b7JutSo1YE5JhjZQ6Tgeyha5I62
         jrTKYY/hjPR7UMIhh8bAE+0oQg9FyL3pWG22G/la4w9I2wJ/YSEvIWRGTdUybqdXXGRy
         X8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vn5KVySxqyK2pXiK33nF0WGu0qI20e7bm7jRZPo/m9c=;
        b=GahhvcbskAFPSq9MyEPZMa9yjBqVz/wpMH0Vm8Itqq3cDxueFXhHLReknOlZwUPnij
         estWaet5cDB+ZA9WaewkeCzeWZCkuElxuScbe2vp97JQlHVEWymBM6fxvv66dVdysh3G
         MoaSRcjiPY9tdKSSVGWdtiZA4lP++YLvelPrsxF8H3qQ3edYBALEnceyl59HowOkYyI+
         XutLdPWbsWhKbjZfeogaQ8Vi4BhvYI3HP60QDmZbBAtmINY+kT+3gwpMFIJlqdMV1COt
         eArc7vXrJE01kSlIvc3UtPUunoRpxzwpq9lGfUsUB7rGJRXYKWqJcfuXRJJ0YHF9BisO
         5t4w==
X-Gm-Message-State: APzg51Cw1DDI3xZz7mIeLh9NBv+6+2+4+GzmN8MTYcXGt8a/zGO5iyR9
        ht/Pz6zFnp3yFfb1mfO7O4QclP5a/n3DCha2hLxj
X-Google-Smtp-Source: ANB0VdZIrOSLaPIj5WhRsaIy/eu2hwyAJo+kJF+yCPARQuCiBsbj2uxFozuXUcBs1So5tMgNXpXDf7h/Ue98ad55pPA=
X-Received: by 2002:a2e:8743:: with SMTP id q3-v6mr5821335ljj.139.1536874707357;
 Thu, 13 Sep 2018 14:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <99cb1ae7-8881-eb9a-a8cb-a787abe454e1@schaufler-ca.com> <CAGXu5jLONSfPHYYYTLSma-+arVHSQKaEWb9JxpOn6TNKtyLNhw@mail.gmail.com>
 <CAHC9VhQN0wq0zZS5BYU9jBomaWvCaJ_BqJjHF3AT7FG8Z0nLDQ@mail.gmail.com>
 <CAGXu5jJs6kmd6Tjgwqb2Zx7e-jNbHqfJ57poZuyz4Qj=AKVfmQ@mail.gmail.com>
 <CAHC9VhQ20tBAMwOJ9mg0tBHYUoxjh0Szr3d62HuPw2SyT4XDLw@mail.gmail.com> <CAGXu5jKec1JTsoqwKGThcJoamdL618AHu4jfFbqqQiauz1kjyg@mail.gmail.com>
In-Reply-To: <CAGXu5jKec1JTsoqwKGThcJoamdL618AHu4jfFbqqQiauz1kjyg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 13 Sep 2018 17:38:15 -0400
Message-ID: <CAHC9VhQwT4d3wC37cVrrX-hZq1L3e6=TEAse4m-YH9SiFnkieA@mail.gmail.com>
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

On Thu, Sep 13, 2018 at 5:01 PM Kees Cook <keescook@chromium.org> wrote:
> On Thu, Sep 13, 2018 at 12:12 PM, Paul Moore <paul@paul-moore.com> wrote:
> > None of the above deals with the user experience or support burden a
> > distro would have by forcing stacking on.  If we make it an option the
>
> Just to make sure we're clear here: this series does not provide
> "extreme" stacking: SELinux, AppArmor, and SMACK remain boot-exclusive
> no matter what the CONFIGs.
>
> > distros can choose for themselves; picking a kernel build config is
> > not something new to distros, and I think Casey's text adequately
> > explains CONFIG_SECURITY_STACKING in terms that would be sufficient.
>
> I absolutely want stacking to be configurable, but I want to point out
> that there is no operational difference between
> CONFIG_SECURITY_STACKING=n and CONFIG_SECURITY_STACKING=y in the code
> here:
>
> - all the new accessor and allocation code is exercised in both cases
>
> - with stacking enabled: selinux, apparmor, and smack have an offset
> of 0 into blobs (and only one can be enabled at a time)
>
> - with stacking disabled: selinux, apparmor, and smack have an offset
> of 0 into blobs (and only one can be enabled at a time)
>
> The only behavioral difference is TOMOYO:
>
> 1- with stacking disabled and TOMOYO as the only major LSM, it will
> have a 0 offset into blobs (like above)
>
> 2- with stacking enabled and TOMOYO as the only major LSM, it will
> have a 0 offset into blobs (like above)
>
> 3- with stacking disabled and another major LSM is enabled, TOMOYO
> will be disabled (like always)
>
> 4- with stacking enabled and another major LSM is enabled, TOMOYO will
> have a non-0 offset into blobs and will run after selinux or smack or
> run before apparmor (based on link ordering defined by the Makefile).

Case #3/#4 is what I'm getting at, and I would argue demonstrates an
operational difference that is user visible/configurable.

Unless something has changed and I missed it, you can currently build
all of the LSMs into a single kernel image, and the admin/user can
choose one at boot time.  CONFIG_SECURITY_STACKING=y enables the
admin/user to stack LSMs (albeit with restrictions in the current
iteration) and CONFIG_SECURITY_STACKING=n limits the admin/user to a
single LSM (what we have now).  I understand that as of this moment we
are talking only about TOMOYO and AppArmor/Smack/SELinux, but everyone
knows that S.A.R.A/SARA and LandLock are going to follow shortly -
that's the whole point of this latest spin, isn't it?

> > I currently have a neutral stance on stacking, making it mandatory
> > pushes me more towards a "no".
>
> This is why I'm trying to explain myself: the infrastructure proposed
> here is always exercised, no matter the CONFIG. From that sense it is
> "mandatory" no matter what the config is. There isn't a reality where
> you could "turn off stacking", because it's not stacking until you
> actually stack something, and that will be disabled by default as I've
> proposed it.
>
> Let me put this another way: if we simply leave off patch 10, we can
> take the other 9 patches (modulo feedback), and we only have to decide
> how to expose "stacking"; all the infrastructure work for supporting
> it is done.
>
> I'm arguing that "security=" is likely insufficient to describe what
> we want, and instead we should focus on individual LSM enablement via
> parameters ("tomoyo.enabled=1"). If _ordering_ becomes an issue, we
> could either use parameter order, or use "security=" again maybe, but
> for now, ordering is already defined by the Makefile (and
> security/security.c).

The infrastructure bits aren't really my concern; in fact I *like*
that the infrastructure is always exercised, it makes
testing/debugging easier.  I also like the ability to limit the
user/admin to one LSM at boot time to make support easier; my goal is
to allow a distro to build support for multiple LSMs without also
requiring that distro to support *stacked* LSMs (see my earlier
comments about the difficulty in determining the source of a failed
operation).

-- 
paul moore
www.paul-moore.com
