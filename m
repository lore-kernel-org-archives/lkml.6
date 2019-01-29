Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0022CC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4572177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1DSyWMA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfA2HHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 02:07:40 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46772 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfA2HHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 02:07:39 -0500
Received: by mail-qk1-f195.google.com with SMTP id q1so10912780qkf.13;
        Mon, 28 Jan 2019 23:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jVmIIcZZ+L2IDOYKmmfAYEnJQHgohWz4yF+HkqdtjBY=;
        b=X1DSyWMAvhH3ydHrw2uplDCR9AGyWrVzyX0o0igG41OKfkNWIG4/IXe7teTEF+OH7r
         BImvVlI+9Gip3U9Qu8JErHCBf+V2JQUQ2OFE6D95mIY8e/7uH0+SGH6lFdFKvDu3FhLo
         gaORZ7FiqzdeEZ/mMbJ2xycEdQR2xqySL6l7Q4HgxqRA+Xvd4i2GJduPZu14HUHSwNcz
         gr0lxEAEs+aMibZ84YTHTSu49SlBKLg8a+0cqsRA9F1F4OyG50tDDDKwhrhSXryVwjbs
         GpCky+hKQl6Th/vTK6vHzo0DzaUvNkznpCGq25baxODz6dDPUyGWOFiK4CfpoXenN7dV
         UFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jVmIIcZZ+L2IDOYKmmfAYEnJQHgohWz4yF+HkqdtjBY=;
        b=XcRh7UPu/+xO5BsmzGL+QqAM22RigclxRPGA07JEr+4aVBBrvhocSmBlASb8zaCjyI
         th7XplVfyAM3Ev90927agFNMNzFYtCx9CM6GaJKrHQbSkeE3U2+pUCvXJ5NK+lUWGQzx
         HNU7smB3quMC5lz/SpD4rQVyVMwgl2q5JFKWNqzLI62TYCM7cAY/qxQJLlYCQSL6ol9f
         cwd20N9GKy/NFn9Ce42klYUCCYGfdwsgpwmnzBUffbHC+0SRgPPZxZXeW7STUZ1w7JGL
         k2oRFBxXvT7BK7UlMHsouHyr2uQgc7N45BpigiCZ9koNgP5Xn9WFzgp+Ds56fG/kYV/v
         xqbg==
X-Gm-Message-State: AJcUukehCE/HEaV9RLLj72TzqbKPYlaNB8fdnLTFdJyS9L/E+cYDg71T
        sv5R5p3SitX9n/aiR2H5fIF2ZRarPvCjbwnJBEM=
X-Google-Smtp-Source: ALg8bN691eQ0Pjg0vinHGLRnMQncXpn+az+My5S8wKTRuyBXqj+rexyeZlUDmoTVZjyTLbHpQiA2yJOHEr7kwBbxwQ0=
X-Received: by 2002:a37:cc4c:: with SMTP id r73mr22033036qki.120.1548745658674;
 Mon, 28 Jan 2019 23:07:38 -0800 (PST)
MIME-Version: 1.0
References: <10746.1548744426@turing-police.cc.vt.edu>
In-Reply-To: <10746.1548744426@turing-police.cc.vt.edu>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 28 Jan 2019 23:07:26 -0800
Message-ID: <CAPhsuW5CcdpCCppRv0FMLNdunNxgkO_AKFo+E_nFWHFqmq=6KQ@mail.gmail.com>
Subject: Re: [PATCH] kernel/bpf/cgroup.c - clean up kerneldoc warnings
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 10:48 PM <valdis.kletnieks@vt.edu> wrote:
>
> Building with W=1 reveals some bitrot
>
>   CC      kernel/bpf/cgroup.o
> kernel/bpf/cgroup.c:238: warning: Function parameter or member 'flags' not described in '__cgroup_bpf_attach'
> kernel/bpf/cgroup.c:367: warning: Function parameter or member 'unused_flags' not described in '__cgroup_bpf_detach'
>
> Add a kerneldoc line for 'flags'.
>
> Fixing the warning for 'unused_flags' is best approached by
> removing the unused parameter on the function call.
>
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

Thanks!

Acked-by: Song Liu <songliubraving@fb.com>

PS: For future patches, please specify which tree the patch should be
applied to with [PATCH bpf] or [PATCH bpf-next].

>
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index 588dd5f0bd85..695b2a880d9a 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -78,7 +78,7 @@ int cgroup_bpf_inherit(struct cgroup *cgrp);
>  int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
>                         enum bpf_attach_type type, u32 flags);
>  int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
> -                       enum bpf_attach_type type, u32 flags);
> +                       enum bpf_attach_type type);
>  int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
>                        union bpf_attr __user *uattr);
>
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index ab612fe9862f..d78cfec5807d 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -230,6 +230,7 @@ static int update_effective_progs(struct cgroup *cgrp,
>   * @cgrp: The cgroup which descendants to traverse
>   * @prog: A program to attach
>   * @type: Type of attach operation
> + * @flags: Option flags
>   *
>   * Must be called with cgroup_mutex held.
>   */
> @@ -363,7 +364,7 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
>   * Must be called with cgroup_mutex held.
>   */
>  int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
> -                       enum bpf_attach_type type, u32 unused_flags)
> +                       enum bpf_attach_type type)
>  {
>         struct list_head *progs = &cgrp->bpf.progs[type];
>         enum bpf_cgroup_storage_type stype;
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 6d03a27918f4..9802ab424397 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -6059,7 +6059,7 @@ int cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
>         int ret;
>
>         mutex_lock(&cgroup_mutex);
> -       ret = __cgroup_bpf_detach(cgrp, prog, type, flags);
> +       ret = __cgroup_bpf_detach(cgrp, prog, type);
>         mutex_unlock(&cgroup_mutex);
>         return ret;
>  }
>
