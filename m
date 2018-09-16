Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,GAPPY_SUBJECT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093BDECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 16:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 952482083A
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 16:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="is7Scpd7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 952482083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbeIPWRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 18:17:53 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:45824 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbeIPWRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 18:17:52 -0400
Received: by mail-ua1-f66.google.com with SMTP id q7-v6so9313932uam.12;
        Sun, 16 Sep 2018 09:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Zm05z2oWbfcYv8BaZv2aVWN+md1XSi70xszmCbKzlog=;
        b=is7Scpd7rUiF6aGyUbrdHOznuZAy1zw/cO1M4/9zgyBNJmGrnwoPpcpxY+uV2HSmWM
         7RYrxCZzXj8KdoT3RDXhhYciud9umrw7QrInr5NckIDWpqjPRGbOeb0x5uXSQnRTzTxT
         yFU5Zm/GTvYzJxYxs8PcLObVxF+JyuebglhGgcWoCiwg4UVAje4o2g6P61qnwW3vaFxX
         Av+BLSWADQtKU6GzMi5psdlbaa+1pcn9jNEl/xUawHkKOxJ38ZXjLYmePK8WGpgyLM9H
         vfVORCIc1ktMaOYIZ2ZPQoS8BlcoUg9BcEoRKQhJmaQR6qkGol40781ynM5tasz1OWzO
         kpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Zm05z2oWbfcYv8BaZv2aVWN+md1XSi70xszmCbKzlog=;
        b=ArjFPC5zc1ehSIwhlktuClVYy3KYxryesth3HoNsH54VZmDPthgHIRHLZvLo2QVJX4
         1VzFGrb7SzR9+tYw4JTHUEWZ75fdaYQ2I0rWCFSsfnj9mNATFhObm3TDvYoO9NCKDShr
         v83tAqn1znS4E+xbP8JYbaBCPO42Pi+47uTCANKtvwrJ2TeNYknvdVuOxJ8xedoobNcZ
         U2Ez0+vdXMJNZEG7LkWRhyjLpj4m6BUIaeONoRqere9QsuPdOI/1Wu4lEzj3aLpe64RZ
         uU8Hwgt8OYE8bATj78jvUcmuVi+UkDr4byvewLnXYUmqrdBXGRrSqDMhzpLbwsidodyJ
         99JQ==
X-Gm-Message-State: APzg51AGiOf/TxRgiGwuEycH6cme4do1tOBrxME1iiOMQYHSgRyDAo1A
        Viw6PGkTbGIG7YGfuie+XY8xxZ+DTOhOoq2C6sI=
X-Google-Smtp-Source: ANB0VdZbE+4kTSy9z1TQpVdSJlNXfanqXiy2AtT5a2W1Z9vCSOPsww7HDe/CV0+OMhcboCNTPrx0aeoFnGsJ4g93I2Y=
X-Received: by 2002:a9f:2745:: with SMTP id a63-v6mr6491469uaa.175.1537116860164;
 Sun, 16 Sep 2018 09:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com> <alpine.LRH.2.21.1809130727310.19741@namei.org>
In-Reply-To: <alpine.LRH.2.21.1809130727310.19741@namei.org>
From:   Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date:   Sun, 16 Sep 2018 18:54:09 +0200
Message-ID: <CAJHCu1+Nja-XqfFKdxu2hDcUBzgvvjcf42yeGnUuVY3wsrZfSQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] LSM: Module stacking in support of S.A.R.A and Landlock
To:     James Morris <jmorris@namei.org>
Cc:     casey@schaufler-ca.com, mic@digikod.net,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        john.johansen@canonical.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-fsdevel@vger.kernel.org,
        adobriyan@gmail.com, casey.schaufler@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018, James Morris <jmorris@namei.org> wrote:
> Adding the SARA and LandLock authors for review & comment.
>
> Salvatore & Micka=C3=ABl: does this patchset meet your needs for merging =
to
> mainline?

Since the last time I submitted the patch to the ML, it grew a bit: now it =
needs
inode's blob stacking (which is already included for Landlock) and
kern_ipc_perm's
blob stacking.
The last one isn't implemented in this patchset, but it isn't
absolutely necessary.
I can merge a version of SARA that doesn't need it and than update it
when possible.
I can provide the same level of protection without using kern_ipc_perm
blob, I'm using it
just to minimize some potential side effects.

>
> On Tue, 11 Sep 2018, Casey Schaufler wrote:
>
> > LSM: Module stacking in support of S.A.R.A and Landlock
> >
> > v2: Reduce the patchset to what is required to support
> >     the proposed S.A.R.A. and LandLock security modules
> >
> > The S.A.R.A. security module is intended to be used
> > in conjunction with other security modules. It requires
> > state to be maintained for the credential, which
> > in turn requires a mechanism for sharing the credential
> > security blob. The module also requires mechanism for
> > user space manipulation of the credential information,
> > hence an additional subdirectory in /proc/.../attr.
> >
> > The LandLock security module provides user configurable
> > policy in the secmark mechanism. It requires data in
> > the credential, file and inode security blobs. For this
> > to be used along side the existing "major" security
> > modules mechanism for sharing these blobs is provided.
> >
> > A side effect of providing sharing of the crendential
> > security blob is that the TOMOYO module can be used at
> > the same time as the other "major" modules.
> >
> > The mechanism for configuring which security modules are
> > enabled has to change when stacking in enabled. Any
> > module that uses just the security blobs that are shared
> > can be selected. Additionally, one other "major" module
> > can be selected.
> >
> > The security module stacking issues around networking and
> > IPC are not addressed here as they are beyond what is
> > required for TOMOYO, S.A.R.A and LandLock.
> >
> > git://github.com/cschaufler/lsm-stacking.git#stacking-4.19-rc2-saralock
> >
> > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > ---
> >  Documentation/admin-guide/LSM/index.rst |  23 ++-
> >  fs/proc/base.c                          |  64 ++++++-
> >  fs/proc/internal.h                      |   1 +
> >  include/linux/lsm_hooks.h               |  20 ++-
> >  include/linux/security.h                |  15 +-
> >  kernel/cred.c                           |  13 --
> >  security/Kconfig                        |  92 ++++++++++
> >  security/apparmor/domain.c              |   2 +-
> >  security/apparmor/include/cred.h        |  24 ++-
> >  security/apparmor/include/file.h        |   9 +-
> >  security/apparmor/include/lib.h         |   4 +
> >  security/apparmor/lsm.c                 |  53 ++++--
> >  security/apparmor/task.c                |   6 +-
> >  security/security.c                     | 293 ++++++++++++++++++++++++=
++++++--
> >  security/selinux/hooks.c                | 215 ++++++++---------------
> >  security/selinux/include/objsec.h       |  37 +++-
> >  security/selinux/selinuxfs.c            |   5 +-
> >  security/selinux/xfrm.c                 |   4 +-
> >  security/smack/smack.h                  |  42 ++++-
> >  security/smack/smack_access.c           |   4 +-
> >  security/smack/smack_lsm.c              | 283 +++++++++++-------------=
------
> >  security/smack/smackfs.c                |  18 +-
> >  security/tomoyo/common.h                |  31 +++-
> >  security/tomoyo/domain.c                |   4 +-
> >  security/tomoyo/securityfs_if.c         |  15 +-
> >  security/tomoyo/tomoyo.c                |  57 +++++--
> >  26 files changed, 899 insertions(+), 435 deletions(-)
> >
>
> --
> James Morris
> <jmorris@namei.org>
