Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 6PazCFyMGVu/bgAAmS7hNA
	; Thu, 07 Jun 2018 19:50:19 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0738A6074D; Thu,  7 Jun 2018 19:50:19 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="cwOcmhM7"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4D16A60452;
	Thu,  7 Jun 2018 19:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4D16A60452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932770AbeFGTuP (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 15:50:15 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:45478 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753256AbeFGTuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 15:50:13 -0400
Received: by mail-yw0-f196.google.com with SMTP id v190-v6so3391209ywa.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 12:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9Ti5IeX06HpMb3fIBY0qQIdTl84Pd0kRrgPS37O6JFI=;
        b=cwOcmhM7JQs/ysc02eTdGqkf9yicwygBSvhXmbOFdm0vCIg2B+QXYSxLbZ8xiwhzr4
         lvWpF8sXdrN1jPVKZkUWt3Rz0o9duy1DFlnW84BP6AasFy8lLX8N6CkDoX/AK9BKK+sZ
         F6cIU+dtS8/X/2Vzj0ZJYdYhy3sWINjkQ/yo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9Ti5IeX06HpMb3fIBY0qQIdTl84Pd0kRrgPS37O6JFI=;
        b=JfkIm0ItT145ORrQ1HpXGDnZtLytwVU0DkTApAa5XNIAknBN04JxvoIurY1kHE2fE1
         RKnQO/rh6Fs7j3RWeSk+DGI/B82sRLgRt3Nihc7A/u3+YmmfqhlhlwsTI3KAAMaMBdiT
         nksFiZms9J0KBk3tzipokG+aR0p0KpZ4zfyX5zfpwrF0k/cTmIQDQI+DQOidcwlK41O8
         y6eLlqDGLod5t9633qxEotYwvjriRDm08uDJ6AROQ63KOCI2+IbvwpsnSpdDG0WtwyKX
         qnQLfJgMcLcxGQqthzlgGE2ALmirAfoibMOQSyLPwFl2zpeEE23Kn9gil30pKwbe1ZoB
         1aAA==
X-Gm-Message-State: APt69E1yvAY29AiBdGw1ANCtAuhg9cQ7H45siVaskZl59h3lu+lGP3ui
        sF/h0BoCP298sgrK4be53eWwxQ==
X-Google-Smtp-Source: ADUXVKK9wHLzmNvRPrmBaBSyYYXClWxJhhhpeMFhLDwBcrX60JHJVCjOxKXvA3w59Egh4Ov+Lq3ARg==
X-Received: by 2002:a81:d10c:: with SMTP id w12-v6mr1979896ywi.391.1528401012313;
        Thu, 07 Jun 2018 12:50:12 -0700 (PDT)
Received: from mail-yb0-f174.google.com (mail-yb0-f174.google.com. [209.85.213.174])
        by smtp.gmail.com with ESMTPSA id n204-v6sm11380190ywb.72.2018.06.07.12.50.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 12:50:11 -0700 (PDT)
Received: by mail-yb0-f174.google.com with SMTP id p22-v6so3616519yba.13;
        Thu, 07 Jun 2018 12:50:11 -0700 (PDT)
X-Received: by 2002:a25:7357:: with SMTP id o84-v6mr1965545ybc.130.1528401011191;
 Thu, 07 Jun 2018 12:50:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:8503:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 12:50:10 -0700 (PDT)
In-Reply-To: <152720678933.9073.11201500538963619904.stgit@warthog.procyon.org.uk>
References: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
 <152720678933.9073.11201500538963619904.stgit@warthog.procyon.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 7 Jun 2018 21:50:10 +0200
X-Gmail-Original-Message-ID: <CAELBmZCd4Nf7vZQQ4_uncx=03WYBOV=RTUDwN6QW2gqc+VK-TA@mail.gmail.com>
Message-ID: <CAELBmZCd4Nf7vZQQ4_uncx=03WYBOV=RTUDwN6QW2gqc+VK-TA@mail.gmail.com>
Subject: Re: [PATCH 10/32] VFS: Implement a filesystem superblock
 creation/configuration context [ver #8]
To: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-afs@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 2:06 AM, David Howells <dhowells@redhat.com> wrote:
> Implement a filesystem context concept to be used during superblock
> creation for mount and superblock reconfiguration for remount.
>
> The mounting procedure then becomes:
>
>  (1) Allocate new fs_context context.
>
>  (2) Configure the context.
>
>  (3) Create superblock.
>
>  (4) Mount the superblock any number of times.
>
>  (5) Destroy the context.
>
> Rather than calling fs_type->mount(), an fs_context struct is created and
> fs_type->init_fs_context() is called to set it up.
> fs_type->fs_context_size says how much space should be allocated for the
> config context.  The fs_context struct is placed at the beginning and any
> extra space is for the filesystem's use.
>
> A set of operations has to be set by ->init_fs_context() to provide
> freeing, duplication, option parsing, binary data parsing, validation,
> mounting and superblock filling.
>
> Legacy filesystems are supported by the provision of a set of legacy
> fs_context operations that build up a list of mount options and then invoke
> fs_type->mount() from within the fs_context ->get_tree() operation.  This
> allows all filesystems to be accessed using fs_context.
>
> It should be noted that, whilst this patch adds a lot of lines of code,
> there is quite a bit of duplication with existing code that can be
> eliminated should all filesystems be converted over.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
>
>  fs/Makefile                |    3
>  fs/fs_context.c            |  599 ++++++++++++++++++++++++++++++++++++++++++++
>  fs/internal.h              |    3
>  fs/libfs.c                 |   17 +
>  fs/namespace.c             |  350 +++++++++++++++++---------
>  fs/super.c                 |  311 ++++++++++++++++++++++-
>  include/linux/fs.h         |   13 +
>  include/linux/fs_context.h |   45 +++
>  include/linux/mount.h      |    3
>  9 files changed, 1201 insertions(+), 143 deletions(-)
>  create mode 100644 fs/fs_context.c
>
> diff --git a/fs/Makefile b/fs/Makefile
> index c9375fd2c8c4..6f2dae3c32da 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -12,7 +12,8 @@ obj-y :=      open.o read_write.o file_table.o super.o \
>                 attr.o bad_inode.o file.o filesystems.o namespace.o \
>                 seq_file.o xattr.o libfs.o fs-writeback.o \
>                 pnode.o splice.o sync.o utimes.o d_path.o \
> -               stack.o fs_struct.o statfs.o fs_pin.o nsfs.o
> +               stack.o fs_struct.o statfs.o fs_pin.o nsfs.o \
> +               fs_context.o
>
>  ifeq ($(CONFIG_BLOCK),y)
>  obj-y +=       buffer.o block_dev.o direct-io.o mpage.o
> diff --git a/fs/fs_context.c b/fs/fs_context.c
> new file mode 100644
> index 000000000000..bef68a12ddb5
> --- /dev/null
> +++ b/fs/fs_context.c
> @@ -0,0 +1,599 @@
> +/* Provide a way to create a superblock configuration context within the kernel
> + * that allows a superblock to be set up prior to mounting.
> + *
> + * Copyright (C) 2017 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public Licence
> + * as published by the Free Software Foundation; either version
> + * 2 of the Licence, or (at your option) any later version.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +#include <linux/fs_context.h>
> +#include <linux/fs.h>
> +#include <linux/mount.h>
> +#include <linux/nsproxy.h>
> +#include <linux/slab.h>
> +#include <linux/magic.h>
> +#include <linux/security.h>
> +#include <linux/parser.h>
> +#include <linux/mnt_namespace.h>
> +#include <linux/pid_namespace.h>
> +#include <linux/user_namespace.h>
> +#include <net/net_namespace.h>
> +#include "mount.h"
> +
> +enum legacy_fs_param {
> +       LEGACY_FS_UNSET_PARAMS,
> +       LEGACY_FS_NO_PARAMS,
> +       LEGACY_FS_MONOLITHIC_PARAMS,
> +       LEGACY_FS_INDIVIDUAL_PARAMS,
> +       LEGACY_FS_MAGIC_PARAMS,
> +};
> +
> +struct legacy_fs_context {
> +       struct fs_context       fc;
> +       char                    *legacy_data;   /* Data page for legacy filesystems */
> +       char                    *secdata;
> +       size_t                  data_size;
> +       enum legacy_fs_param    param_type;
> +};
> +
> +static const struct fs_context_operations legacy_fs_context_ops;
> +
> +static const match_table_t common_set_sb_flag = {
> +       { SB_DIRSYNC,           "dirsync" },
> +       { SB_LAZYTIME,          "lazytime" },
> +       { SB_MANDLOCK,          "mand" },
> +       { SB_POSIXACL,          "posixacl" },
> +       { SB_RDONLY,            "ro" },
> +       { SB_SYNCHRONOUS,       "sync" },
> +       { },
> +};
> +
> +static const match_table_t common_clear_sb_flag = {
> +       { SB_LAZYTIME,          "nolazytime" },
> +       { SB_MANDLOCK,          "nomand" },
> +       { SB_RDONLY,            "rw" },
> +       { SB_SILENT,            "silent" },
> +       { SB_SYNCHRONOUS,       "async" },
> +       { },
> +};
> +
> +static const match_table_t forbidden_sb_flag = {
> +       { 0,    "bind" },
> +       { 0,    "move" },
> +       { 0,    "private" },
> +       { 0,    "remount" },
> +       { 0,    "shared" },
> +       { 0,    "slave" },
> +       { 0,    "unbindable" },
> +       { 0,    "rec" },
> +       { 0,    "noatime" },
> +       { 0,    "relatime" },
> +       { 0,    "norelatime" },
> +       { 0,    "strictatime" },
> +       { 0,    "nostrictatime" },
> +       { 0,    "nodiratime" },
> +       { 0,    "dev" },
> +       { 0,    "nodev" },
> +       { 0,    "exec" },
> +       { 0,    "noexec" },
> +       { 0,    "suid" },
> +       { 0,    "nosuid" },
> +       { },
> +};
> +
> +/*
> + * Check for a common mount option that manipulates s_flags.
> + */
> +static int vfs_parse_sb_flag_option(struct fs_context *fc, char *data)
> +{
> +       substring_t args[MAX_OPT_ARGS];
> +       unsigned int token;
> +
> +       token = match_token(data, common_set_sb_flag, args);
> +       if (token) {
> +               fc->sb_flags |= token;
> +               return 1;
> +       }
> +
> +       token = match_token(data, common_clear_sb_flag, args);
> +       if (token) {
> +               fc->sb_flags &= ~token;
> +               return 1;
> +       }
> +
> +       token = match_token(data, forbidden_sb_flag, args);
> +       if (token)
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
> +/**
> + * vfs_parse_fs_option - Add a single mount option to a superblock config
> + * @fc: The filesystem context to modify
> + * @opt: The option to apply.
> + * @len: The length of the option.
> + *
> + * A single mount option in string form is applied to the filesystem context
> + * being set up.  Certain standard options (for example "ro") are translated
> + * into flag bits without going to the filesystem.  The active security module
> + * is allowed to observe and poach options.  Any other options are passed over
> + * to the filesystem to parse.
> + *
> + * This may be called multiple times for a context.
> + *
> + * Returns 0 on success and a negative error code on failure.  In the event of
> + * failure, supplementary error information may have been set.
> + */
> +int vfs_parse_fs_option(struct fs_context *fc, char *opt, size_t len)
> +{
> +       int ret;
> +
> +       ret = vfs_parse_sb_flag_option(fc, opt);
> +       if (ret < 0)
> +               return ret;
> +       if (ret == 1)
> +               return 0;

Why is vfs_parse_sb_flag_option() not called from ->parse_option()?

That way, filesystem can reject unsupported generic options.  We don't
have that in the current API, but that doesn't mean the new API
shouldn't handle that case.   Yeah, need to worry about backward
compat, so need a flag to say whether this comes from monolithic
option block or fsfd write.

Also thinking: if we are giving this brand new API to fs developers,
why not also give some helpers, so option parsing becomes easier, more
consistent, etc...  I'm thinking along the lines of module_param_*().
I.e. we give the parser a structure pointer and an array of {option
name, structure member name, type} or {option name, get/set ops} and
the helpers take care of the rest (parse, show). That isn't going to
cover everything, but it might be good enough for most.

Of course, that can come later, while doing the conversion of
filesystems to the new API.

Thanks,
Miklos
