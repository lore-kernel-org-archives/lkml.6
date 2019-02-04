Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D97C282D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 04:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8478820821
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 04:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BUiBYZQ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbfBDEFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 23:05:08 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39954 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbfBDEFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 23:05:07 -0500
Received: by mail-oi1-f195.google.com with SMTP id t204so10422246oie.7
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 20:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fmRNggYBiKLfRbcMSANUCT+QV+nnn2LkuRHFiKIJJn8=;
        b=BUiBYZQ1VFU34sYCa6UU7xDTG2DA6OZEIzjiGGlgKqLxcs+tqIQr55Y6aEj0IJ2GBt
         rY/2g3D+FwckFWflnxBHZxpyXgTruWi+V4pEkIMeABUZeGWfui5LFyu/SPaxlpHc+0rc
         rFVsZu9mo+k3/cSMopL+d+Ie5LF3BrhAFY9jZe/G5VeFUADjA7kSZjpE8grchOp5QoIM
         tPYsPcJqemH8zQBwXoimyfTFoioLjgnfUioYPvCcsFErysFWN5it/1eJlIwFZ197+4zY
         0cf+JwRz3BjlzcKyQjemHRDL4OMAY+NLeLUscmvAWFKM2ltkEycSNHs8YvDexDHYdlRW
         emXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fmRNggYBiKLfRbcMSANUCT+QV+nnn2LkuRHFiKIJJn8=;
        b=GlIlAdtuZeO2QLWoZnZjMs7qjk7Z6g9ticMw2hwaOMCVrcUq/Ihq2gcDx9XFWYW5g0
         y8XYEec8SVflTf93EySwJgRv+JVOFUUBJIJu/FWdQXSiyORMVtwR/fLQT8DaTFx1wSlf
         BDiGF4ruLjCVuDkjN2FUKdfvgOfmKS0lS6ow//ttEqHXTlqOuQExQCiUaW2vIXCVV8uR
         x8e7i6/PiQHVecWz8i/iWduETU81Z+OtXae4Mt7Jk7fc6Q9wdn8Di5qS7oRLAAODUkos
         zAJP0cSSXui1pmmkeWqgd54jr/XvX0pkULyB09aXjPIJwNcHwM6SxLtDnLuPZwTE/Q8s
         StrA==
X-Gm-Message-State: AJcUukcXLoXs8OnQ1Wx7M/jge/BgS1BF8TMmii0/y7p18QeHNU0SUCyN
        UJ5tFEXPOuE/RQWnCexCTcVU4KHUVN7ksmKiwX1ilByX
X-Google-Smtp-Source: ALg8bN4S/ffVO607cm+ltd9DMYrrNcO85IuMNKUd+kdwIRXs13dvdznFC3hD80Fk4qs10LEuYQbR6+oE08Lp5QNAxTg=
X-Received: by 2002:aca:c413:: with SMTP id u19mr24283290oif.209.1549253106673;
 Sun, 03 Feb 2019 20:05:06 -0800 (PST)
MIME-Version: 1.0
References: <20181121195859.10894-1-jannh@google.com>
In-Reply-To: <20181121195859.10894-1-jannh@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 4 Feb 2019 05:04:40 +0100
Message-ID: <CAG48ez0fP2-nyRNU54=hPYnFAc64zKCqFvRw0jw+MK49Gw-zOA@mail.gmail.com>
Subject: Re: [PATCH] fs: add a comment explaining how MNT_NS_INTERNAL affects mnt_may_suid()
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 8:59 PM Jann Horn <jannh@google.com> wrote:
> commit 380cf5ba6b0a ("fs: Treat foreign mounts as nosuid"), in addition to
> the intended effect, also prevented suid execution of memfd files.
> (And I think that's a good change.)

Ping. Al, can you take this into your tree? fs/namespace.c is your stuff, right?


> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  fs/namespace.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index a7f91265ea67..e68488426e42 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3400,6 +3400,9 @@ bool mnt_may_suid(struct vfsmount *mnt)
>          * prevents namespaces from trusting potentially unsafe
>          * suid/sgid bits, file caps, or security labels that originate
>          * in other namespaces.
> +        *
> +        * check_mnt() rejects MNT_NS_INTERNAL mounts; this means that suid
> +        * execution is blocked for files on internal mounts, e.g. memfds.
>          */
>         return !(mnt->mnt_flags & MNT_NOSUID) && check_mnt(real_mount(mnt)) &&
>                current_in_userns(mnt->mnt_sb->s_user_ns);
> --
> 2.20.0.rc0.387.gc7a69e6b6c-goog
>
