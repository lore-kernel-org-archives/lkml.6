Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B475EC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 16:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307992083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 16:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="q0djaeRS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 307992083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=protonmail.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbeJBXS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 19:18:29 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:32249 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbeJBXS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 19:18:29 -0400
Date:   Tue, 02 Oct 2018 16:33:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1538498043;
        bh=hPyXiMQiL414yBVhB7CdX5Zhfl5Qn5IIHIIPDV54Ioc=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=q0djaeRSpXLNuDwkMzmoXc/xqkvEWC1SY7Bclj8rkoRLvc0yREUB1QOalzX/h1Y5G
         5doJCeKWD19cgOMFvhzKGIQXZ6jjmUplCqpeSjjItELyTpIwPuGvqpXyMAcZcS8o0p
         Zjsf0hkag7jlpQExulKlwCNsvAh0eBMSt6K3sjXw=
To:     Stephen Smalley <sds@tycho.nsa.gov>
From:   Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Reply-To: Jordan Glover <Golden_Miller83@protonmail.ch>
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
Message-ID: <QpdcE4QSCQKJqDmB2QBEGBlnlioHuRHlM0g5HF8KbHjU1zIUAOjnQ2r9EIMu3m0S2OWNR3_M_TSp_M6CVDqkp6kKuFPUvegsyDPNw1AGju4=@protonmail.ch>
In-Reply-To: <809f1cfd-077b-ee58-51ba-b22daf46d12b@tycho.nsa.gov>
References: <20181002005505.6112-1-keescook@chromium.org>
 <20181002005505.6112-24-keescook@chromium.org>
 <CAHC9VhQjMfH6Q+Tif8nBknZojgxrb6x+oDz4vHRiZN8rb8MZ5Q@mail.gmail.com>
 <785ef6a9-ae46-3533-0348-74bcf6f10928@tycho.nsa.gov>
 <CAGXu5jKNzG3rGUAV39D0w4txHRG3H2qU1Z1e_b+03OgycTaWqA@mail.gmail.com>
 <809f1cfd-077b-ee58-51ba-b22daf46d12b@tycho.nsa.gov>
Feedback-ID: QEdvdaLhFJaqnofhWA-dldGwsuoeDdDw7vz0UPs8r8sanA3bIt8zJdf4aDqYKSy4gJuZ0WvFYJtvq21y6ge_uQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Tuesday, October 2, 2018 4:57 PM, Stephen Smalley <sds@tycho.nsa.gov> wr=
ote:

> On 10/02/2018 10:44 AM, Kees Cook wrote:
>
> > On Tue, Oct 2, 2018 at 6:42 AM, Stephen Smalley sds@tycho.nsa.gov wrote=
:
> >
> > > On 10/02/2018 08:12 AM, Paul Moore wrote:
> > >
> > > > On Mon, Oct 1, 2018 at 9:04 PM Kees Cook keescook@chromium.org wrot=
e:
> > > >
> > > > > Since LSM enabling is now centralized with CONFIG_LSM_ENABLE and
> > > > > "lsm.enable=3D...", this removes the LSM-specific enabling logic =
from
> > > > > SELinux.
> > > > >
> > > > > Signed-off-by: Kees Cook keescook@chromium.org
> > > > >
> > > > > -----------------------------------------------
> > > > >
> > > > > .../admin-guide/kernel-parameters.txt | 9 ------
> > > > > security/selinux/Kconfig | 29 -------------------
> > > > > security/selinux/hooks.c | 15 +---------
> > > > > 3 files changed, 1 insertion(+), 52 deletions(-)
> > > > > diff --git a/Documentation/admin-guide/kernel-parameters.txt
> > > > > b/Documentation/admin-guide/kernel-parameters.txt
> > > > > index cf963febebb0..0d10ab3d020e 100644
> > > > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > > > @@ -4045,15 +4045,6 @@
> > > > > loaded. An invalid security module name will be
> > > > > treated
> > > > > as if no module has been chosen.
> > > > >
> > > > > -         selinux=3D        [SELINUX] Disable or enable SELinux a=
t boot time.
> > > > >
> > > > >
> > > > > -                         Format: { "0" | "1" }
> > > > >
> > > > >
> > > > > -                         See security/selinux/Kconfig help text.
> > > > >
> > > > >
> > > > > -                         0 -- disable.
> > > > >
> > > > >
> > > > > -                         1 -- enable.
> > > > >
> > > > >
> > > > > -                         Default value is set via kernel config =
option.
> > > > >
> > > > >
> > > > > -                         If enabled at boot time, /selinux/disab=
le can be
> > > > >
> > > > >
> > > > >
> > > > > used
> > > > >
> > > > > -                         later to disable prior to initial polic=
y load.
> > > > >
> > > > >
> > > >
> > > > No comments yet on the rest of the patchset, but the subject line o=
f
> > > > this patch caught my eye and I wanted to comment quickly on this on=
e
> > > > ...
> > > > Not a fan unfortunately.
> > > > Much like the SELinux bits under /proc/self/attr, this is a user
> > > > visible thing which has made its way into a lot of docs, scripts, a=
nd
> > > > minds; I believe removing it would be a big mistake.
> > >
> > > Yes, we can't suddenly break existing systems that had selinux=3D0 in=
 their
> > > grub config. We have to retain the support.
> >
> > Is it okay to only support selinux=3D0 (instead of also selinux=3D1)?
>
> For Fedora/RHEL kernels, selinux=3D1 would be redundant since it is the
> default. However, in other distros where SELinux is not the default, I
> think they have documented selinux=3D1 as the way to enable SELinux. So
> users may be relying on that as well. I don't think we can safely drop
> support for either one. Sorry.

It's always documented as: "selinux=3D1 security=3Dselinux" so security=3D =
should
still do the job and selinux=3D1 become no-op, no?

Jordan
