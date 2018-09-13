Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298A4C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD0420882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="k63fn5OH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD0420882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbeINAXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 20:23:36 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41477 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbeINAXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 20:23:36 -0400
Received: by mail-lf1-f66.google.com with SMTP id l26-v6so5760408lfc.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 12:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ajm61pB9iHSHnvvR65GFl7S/DlH0y2qC+PZRFLEopns=;
        b=k63fn5OHzj4FpXjt3BdEpcLnxAXiECzJ2ufVre4HY50CB9qIYqjRQlpe9ajiEBYVmf
         VbHKcYovLAUjhPbwwxj79SVatJAXdVUsERiGh5l/uf99N+tgrVq6n1C/YlAuNxjmBqCx
         PIGVehgeMSfmnPnzTdzAD2hhTbMRfObacYKUKt9Vp9kaDNt4vmIrWP3BhHgV9RnbG0YC
         OanWNgZBWOkHghDLAVzUfXT7Qn5I69u9jdo4fKJNAFl6mtCp//t/2Pu+jZDRmt5K6yVz
         7jhvrUil3Lh0uhh9GiMCGDbgUC20QKjKiujTX6mP3JmT6QvAxc/JpyJCgsSKALprMS3Y
         QDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ajm61pB9iHSHnvvR65GFl7S/DlH0y2qC+PZRFLEopns=;
        b=smh9VDHSG2ONgi6ylhcE2UjFXNAYqAEBWLR9qESNhuGoP75Ja/iVfAV3doKwajBkdl
         RPi/1D8MkX8xUFydl+FpCunT1y6mqDrgUsM2AUDg3Tb6U6aigBjFfE74b6+yB47MpyyW
         TtninLuzlmhtbEPWt3+T8q5yRJCnyDZy8ac4OAyFsWLPGyAE/s2X0G2xc9ktfp3GZ/8R
         4pwXTwLh815tKhCIiESTqgdDvBCbW7unJQRusaMdDO6nnGNQ8TWaT9LUdbrTzzq6jp6l
         5quI7V4abZ9c53lc1Pd3TnTOdqg3jTJ9kX6gR80/i2VGFLCpOTBhBgD0PuuWDDmLdOcH
         Q/qQ==
X-Gm-Message-State: APzg51AUIGK7YZ+JgoMSy0xkURqLEPpcuDD+yWw6rKbkba/ouyriw1U5
        f1KVgis0pR82GYckAuEDnnToW+G9iYw1dd7CyEqs
X-Google-Smtp-Source: ANB0VdYapaqU9uyrwsLTGETEjMcnE6W612Q6EKq1QXEIcKUg72UZIqAPSoOwrATBYUQTlRbm9r7QKXK8VQUx+Bwe22E=
X-Received: by 2002:a19:14e6:: with SMTP id 99-v6mr5891841lfu.26.1536865963518;
 Thu, 13 Sep 2018 12:12:43 -0700 (PDT)
MIME-Version: 1.0
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <99cb1ae7-8881-eb9a-a8cb-a787abe454e1@schaufler-ca.com> <CAGXu5jLONSfPHYYYTLSma-+arVHSQKaEWb9JxpOn6TNKtyLNhw@mail.gmail.com>
 <CAHC9VhQN0wq0zZS5BYU9jBomaWvCaJ_BqJjHF3AT7FG8Z0nLDQ@mail.gmail.com> <CAGXu5jJs6kmd6Tjgwqb2Zx7e-jNbHqfJ57poZuyz4Qj=AKVfmQ@mail.gmail.com>
In-Reply-To: <CAGXu5jJs6kmd6Tjgwqb2Zx7e-jNbHqfJ57poZuyz4Qj=AKVfmQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 13 Sep 2018 15:12:32 -0400
Message-ID: <CAHC9VhQ20tBAMwOJ9mg0tBHYUoxjh0Szr3d62HuPw2SyT4XDLw@mail.gmail.com>
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

On Thu, Sep 13, 2018 at 11:19 AM Kees Cook <keescook@chromium.org> wrote:
> On Thu, Sep 13, 2018 at 6:16 AM, Paul Moore <paul@paul-moore.com> wrote:
> > On Thu, Sep 13, 2018 at 12:19 AM Kees Cook <keescook@chromium.org> wrote:
> >> On Tue, Sep 11, 2018 at 9:42 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> > Two proposed security modules require the ability to
> >> > share security blobs with existing "major" security modules.
> >> > These modules, S.A.R.A and LandLock, provide significantly
> >> > different services than SELinux, Smack or AppArmor. Using
> >> > either in conjunction with the existing modules is quite
> >> > reasonable. S.A.R.A requires access to the cred blob, while
> >> > LandLock uses the cred, file and inode blobs.
> >> >
> >> > The use of the cred, file and inode blobs has been
> >> > abstracted in preceding patches in the series. This
> >> > patch teaches the affected security modules how to access
> >> > the part of the blob set aside for their use in the case
> >> > where blobs are shared. The configuration option
> >> > CONFIG_SECURITY_STACKING identifies systems where the
> >> > blobs may be shared.
> >> >
> >> > The mechanism for selecting which security modules are
> >> > active has been changed to allow non-conflicting "major"
> >> > security modules to be used together. At this time the
> >> > TOMOYO module can safely be used with any of the others.
> >> > The two new modules would be non-conflicting as well.
> >> >
> >> > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> > ---
> >> >  Documentation/admin-guide/LSM/index.rst | 14 +++--
> >> >  include/linux/lsm_hooks.h               |  2 +-
> >> >  security/Kconfig                        | 81 +++++++++++++++++++++++++
> >> >  security/apparmor/include/cred.h        |  8 +++
> >> >  security/apparmor/include/file.h        |  9 ++-
> >> >  security/apparmor/include/lib.h         |  4 ++
> >> >  security/apparmor/lsm.c                 |  8 ++-
> >> >  security/security.c                     | 30 ++++++++-
> >> >  security/selinux/hooks.c                |  3 +-
> >> >  security/selinux/include/objsec.h       | 18 +++++-
> >> >  security/smack/smack.h                  | 19 +++++-
> >> >  security/smack/smack_lsm.c              | 17 +++---
> >> >  security/tomoyo/common.h                | 12 +++-
> >> >  security/tomoyo/tomoyo.c                |  3 +-
> >> >  14 files changed, 200 insertions(+), 28 deletions(-)
> >
> > ...
> >
> >> > diff --git a/security/Kconfig b/security/Kconfig
> >> > index 22f7664c4977..ed48025ae9e0 100644
> >> > --- a/security/Kconfig
> >> > +++ b/security/Kconfig
> >> > @@ -36,6 +36,28 @@ config SECURITY_WRITABLE_HOOKS
> >> >         bool
> >> >         default n
> >> >
> >> > +config SECURITY_STACKING
> >> > +       bool "Security module stacking"
> >> > +       depends on SECURITY
> >> > +       help
> >> > +         Allows multiple major security modules to be stacked.
> >> > +         Modules are invoked in the order registered with a
> >> > +         "bail on fail" policy, in which the infrastructure
> >> > +         will stop processing once a denial is detected. Not
> >> > +         all modules can be stacked. SELinux, Smack and AppArmor are
> >> > +         known to be incompatible. User space components may
> >> > +         have trouble identifying the security module providing
> >> > +         data in some cases.
> >> > +
> >> > +         If you select this option you will have to select which
> >> > +         of the stackable modules you wish to be active. The
> >> > +         "Default security module" will be ignored. The boot line
> >> > +         "security=" option can be used to specify that one of
> >> > +         the modules identifed for stacking should be used instead
> >> > +         of the entire stack.
> >> > +
> >> > +         If you are unsure how to answer this question, answer N.
> >>
> >> I don't see a good reason to make this a config. Why shouldn't this
> >> always be enabled?
> >
> > I do.  From a user perspective it is sometimes difficult to determine
> > the reason behind a failed operation; its is a DAC based denial, the
> > LSM, or some other failure?  Stacking additional LSMs has the
> > potential to make this worse.  The boot time configuration adds to the
> > complexity.
>
> Let me try to convince you otherwise. :) The reason I think there's no
> need for this is because the only functional change here is how
> _TOMOYO_ gets stacked. And in my proposal, we can convert TOMOYO to be
> enabled/disabled like LoadPin. Given the configs I showed, stacking
> TOMOYO with the other major LSMs becomes a config (and/or boottime)
> option.
>
> The changes for TOMOYO are still needed even _with_ SECURITY_STACKING,
> and I argue that the other major LSMs remain the same. It's only
> infrastructure that has changed. So, I think having SECURITY_STACKING
> actually makes things more complex internally (all the ifdefs, weird
> enable logic) and for distros ("what's this stacking option", etc?)

None of the above deals with the user experience or support burden a
distro would have by forcing stacking on.  If we make it an option the
distros can choose for themselves; picking a kernel build config is
not something new to distros, and I think Casey's text adequately
explains CONFIG_SECURITY_STACKING in terms that would be sufficient.
I currently have a neutral stance on stacking, making it mandatory
pushes me more towards a "no".

As far as the cpp ifdef's, and other conditionals are concerned, I
remain unconvinced this is any worse than any other significant
feature that is a build time option.

-- 
paul moore
www.paul-moore.com
