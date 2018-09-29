Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEA4C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 14:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4547720880
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 14:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Pqo+DHiq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4547720880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbeI2VHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 17:07:05 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45187 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728246AbeI2VHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 17:07:04 -0400
Received: by mail-ed1-f67.google.com with SMTP id h6-v6so9051904eds.12
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 07:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gxdPNvgAJ+TxxhzjL0ltwCdfwPzhdeTiFbUe+rqneDs=;
        b=Pqo+DHiqnxP7sK5TqyJMRn+9jvUb9T5UPHO2yAfnMEphLUShVw6S40oE/DrcFP5pXo
         uyuNqbk37KANraK0tyr/Xi4VHo78+Y+iWXCsB4INUJ+SNcFnYXv5j3fKUeKl5wzv5RwP
         OKeTtqItRvzrZF4AK44FbdRiqzxX1SULdxcHZ81XUAAshhOJoRjpe3hSVcWftS0af4eZ
         XDOKonJxluz5+JfZBq6Qhw7+Q7AGTLCoZFdND2B5YW+r7QsIU/KH7lprWGNoGah08HBZ
         Bq7FvGHmmzAKdwqwHRTgSQRMTCmtWW5lTz5qSjHWoEmBU0OS2kDuWKukzbB0B4BKs+YF
         N1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gxdPNvgAJ+TxxhzjL0ltwCdfwPzhdeTiFbUe+rqneDs=;
        b=VIzyaZONXOXXPbfw0mjbX60LB79oaPD+dCQMxkXRyKQA60RwO5z0CdZ4vVdxJ+imVj
         yUY3ZfyuUqHSwl1sjodA021xNeJFeft5jPPk1Hlsn6amE1PANWoNUPrtPnNuokQy/HHD
         RIfQrEtKHRY07H6JgBDhLJtrCt2WvjlgCzlz+cSIa8UgbWPyBqn1SD8JPMzUQoFvUANv
         7eTABnmOJNY3/kKjH2IWLk6Ma1z4HtgJ8VWmUSfOZgUV7XDubX4TSjJk3/1vkwJH0dtb
         34eTqpqiVXtIalcG/dbSyFebE2gnsxZOUOMbDtP704AbPr6O9Dy7Khtc+aBnrKzFX/90
         O67A==
X-Gm-Message-State: ABuFfojI4wWbKASOpzPo/J4gWLwhDjdHzfPWDbrFiX1/BiEJncDMaAg2
        MuOmcaQty3iqTJgWPuSH1X42LA==
X-Google-Smtp-Source: ACcGV61hyo1vZ+eV2FYHRcKwfCxq0O+wkNz3tmLbBd7Yd8WPiNBBx3t6WgytGWTWTlEEzB7Bw1a1Ww==
X-Received: by 2002:a17:906:344b:: with SMTP id d11-v6mr7222427ejb.130.1538231902354;
        Sat, 29 Sep 2018 07:38:22 -0700 (PDT)
Received: from brauner.io ([2a02:8109:a740:27e9:2824:7b8c:14f1:9980])
        by smtp.gmail.com with ESMTPSA id g20-v6sm2710697edm.36.2018.09.29.07.38.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Sep 2018 07:38:21 -0700 (PDT)
Date:   Sat, 29 Sep 2018 16:38:15 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Tycho Andersen <tycho@tycho.ws>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, dev@opencontainers.org,
        containers@lists.linux-foundation.org
Subject: Re: [PATCH 0/3] namei: implement various scoping AT_* flags
Message-ID: <20180929143814.yfo6rud7dkyb5ip4@brauner.io>
References: <20180929103453.12025-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180929103453.12025-1-cyphar@cyphar.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 08:34:50PM +1000, Aleksa Sarai wrote:
> The need for some sort of control over VFS's path resolution (to avoid
> malicious paths resulting in inadvertent breakouts) has been a very
> long-standing desire of many userspace applications. This patchset is a
> revival of Al Viro's old AT_NO_JUMPS[1] patchset with a few additions.
> 
> The most obvious change is that AT_NO_JUMPS has been split as dicussed
> in the original thread, along with a further split of AT_NO_PROCLINKS
> which means that each individual property of AT_NO_JUMPS is now a
> separate flag:
> 
>   * Path-based escapes from the starting-point using "/" or ".." are
>     blocked by AT_BENEATH.
>   * Mountpoint crossings are blocked by AT_XDEV.
>   * /proc/$pid/fd/$fd resolution is blocked by AT_NO_PROCLINKS (more
> 	correctly it actually blocks any user of nd_jump_link() because it
> 	allows out-of-VFS path resolution manipulation).
> 
> AT_NO_JUMPS is now effectively (AT_BENEATH|AT_XDEV|AT_NO_PROCLINKS). At
> Linus' suggestion in the original thread, I've also implemented
> AT_NO_SYMLINKS which just denies _all_ symlink resolution (including
> "proclink" resolution).
> 
> An additional improvement was made to AT_XDEV. The original AT_NO_JUMPS
> path didn't consider "/tmp/.." as a mountpoint crossing -- this patch
> blocks this as well (feel free to ask me to remove it if you feel this
> is not sane).

Imho, these flags are very much needed and they all are pretty useful
not just for container runtimes but in general.

> 
> Currently I've only enabled these for openat(2) and the stat(2) family.
> I would hope we could enable it for basically every *at(2) syscall --
> but many of them appear to not have a @flags argument and thus we'll
> need to add several new syscalls to do this. I'm more than happy to send
> those patches, but I'd prefer to know that this preliminary work is
> acceptable before doing a bunch of copy-paste to add new sets of *at(2)
> syscalls.

We should really make sure that we can't make due with openat() alone
before adding a bunch of new syscalls. So there's no need to rush into
this. :)

> 
> One additional feature I've implemented is AT_THIS_ROOT (I imagine this
> is probably going to be more contentious than the refresh of
> AT_NO_JUMPS, so I've included it in a separate patch). The patch itself
> describes my reasoning, but the shortened version of the premise is that
> continer runtimes need to have a way to resolve paths within a
> potentially malicious rootfs. Container runtimes currently do this in
> userspace[2] which has implicit race conditions that are not resolvable
> in userspace (or use fork+exec+chroot and SCM_RIGHTS passing which is
> inefficient). AT_THIS_ROOT allows for per-call chroot-like semantics for
> path resolution, which would be invaluable for us -- and the
> implementation is basically identical to AT_BENEATH (except that we
> don't return errors when someone actually hits the root).
> 
> I've added some selftests for this, but it's not clear to me whether
> they should live here or in xfstests (as far as I can tell there are no
> other VFS tests in selftests, while there are some tests that look like
> generic VFS tests in xfstests). If you'd prefer them to be included in
> xfstests, let me know.
> 
> [1]: https://lore.kernel.org/patchwork/patch/784221/
> [2]: https://github.com/cyphar/filepath-securejoin
> 
> Aleksa Sarai (3):
>   namei: implement O_BENEATH-style AT_* flags
>   namei: implement AT_THIS_ROOT chroot-like path resolution
>   selftests: vfs: add AT_* path resolution tests
> 
>  fs/fcntl.c                                    |   2 +-
>  fs/namei.c                                    | 158 ++++++++++++------
>  fs/open.c                                     |  10 ++
>  fs/stat.c                                     |  15 +-
>  include/linux/fcntl.h                         |   3 +-
>  include/linux/namei.h                         |   8 +
>  include/uapi/asm-generic/fcntl.h              |  20 +++
>  include/uapi/linux/fcntl.h                    |  10 ++
>  tools/testing/selftests/Makefile              |   1 +
>  tools/testing/selftests/vfs/.gitignore        |   1 +
>  tools/testing/selftests/vfs/Makefile          |  13 ++
>  tools/testing/selftests/vfs/at_flags.h        |  40 +++++
>  tools/testing/selftests/vfs/common.sh         |  37 ++++
>  .../selftests/vfs/tests/0001_at_beneath.sh    |  72 ++++++++
>  .../selftests/vfs/tests/0002_at_xdev.sh       |  54 ++++++
>  .../vfs/tests/0003_at_no_proclinks.sh         |  50 ++++++
>  .../vfs/tests/0004_at_no_symlinks.sh          |  49 ++++++
>  .../selftests/vfs/tests/0005_at_this_root.sh  |  66 ++++++++
>  tools/testing/selftests/vfs/vfs_helper.c      | 154 +++++++++++++++++
>  19 files changed, 707 insertions(+), 56 deletions(-)
>  create mode 100644 tools/testing/selftests/vfs/.gitignore
>  create mode 100644 tools/testing/selftests/vfs/Makefile
>  create mode 100644 tools/testing/selftests/vfs/at_flags.h
>  create mode 100644 tools/testing/selftests/vfs/common.sh
>  create mode 100755 tools/testing/selftests/vfs/tests/0001_at_beneath.sh
>  create mode 100755 tools/testing/selftests/vfs/tests/0002_at_xdev.sh
>  create mode 100755 tools/testing/selftests/vfs/tests/0003_at_no_proclinks.sh
>  create mode 100755 tools/testing/selftests/vfs/tests/0004_at_no_symlinks.sh
>  create mode 100755 tools/testing/selftests/vfs/tests/0005_at_this_root.sh
>  create mode 100644 tools/testing/selftests/vfs/vfs_helper.c
> 
> -- 
> 2.19.0
> 
