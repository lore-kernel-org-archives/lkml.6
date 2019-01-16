Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBF0C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E13F420657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547654097;
	bh=C5CIlE4toBlqslt9LNBrYsapV2C5LGhAL0BcPXuuugg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2P0ykHiQXEzivdibQYCJEBeD/l87nltJs5FMUcY3YjpPi0RV+NuOtsDyw4dIKBJzv
	 VLVO6HZ3hBupfXJuqt8WQiMxRfNqEXbDZf5uzXo/AiBrL/DUuBegJp43jAVjrvSQFO
	 ZmwXaoCKFGm+/jX/dIWb56E6jo2G67AcPHd938R4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393478AbfAPPyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:54:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:55960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbfAPPyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:54:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E065F20657;
        Wed, 16 Jan 2019 15:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547654093;
        bh=C5CIlE4toBlqslt9LNBrYsapV2C5LGhAL0BcPXuuugg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rb4XPzMNy8Bjd4uXiu/xap7fhrehjCrigpEDSz2NWh7eQfNryXgIKPNipvRBA8gTJ
         ZyqdWP1LYzqNlOGHKgqqRSfpn6pedXjterL2Vn+PjaSGa1UvgcuvCZxO/B1uXfO223
         DXMfyTlE7BfwZrkKYNiaE41KmdGs6O27o7qXEVlY=
Date:   Wed, 16 Jan 2019 16:54:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     tkjos@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        arve@android.com, maco@android.com, tkjos@google.com
Subject: Re: [PATCH] selftests: add binderfs selftests
Message-ID: <20190116155450.GA3508@kroah.com>
References: <20190116131903.8515-1-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116131903.8515-1-christian@brauner.io>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 02:19:03PM +0100, Christian Brauner wrote:
> This adds the promised selftest for binderfs. It will verify the following
> things:
> - binderfs mounting works
> - binder device allocation works
> - performing a binder ioctl() request through a binderfs device works
> - binder device removal works
> - binder-control removal fails
> - binderfs unmounting works
> 
> Cc: Todd Kjos <tkjos@google.com>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  tools/testing/selftests/Makefile              |   1 +
>  .../selftests/filesystems/binderfs/.gitignore |   1 +
>  .../selftests/filesystems/binderfs/Makefile   |   6 +
>  .../filesystems/binderfs/binderfs_test.c      | 120 ++++++++++++++++++
>  .../selftests/filesystems/binderfs/config     |   3 +
>  5 files changed, 131 insertions(+)
>  create mode 100644 tools/testing/selftests/filesystems/binderfs/.gitignore
>  create mode 100644 tools/testing/selftests/filesystems/binderfs/Makefile
>  create mode 100644 tools/testing/selftests/filesystems/binderfs/binderfs_test.c
>  create mode 100644 tools/testing/selftests/filesystems/binderfs/config
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 1a2bd15c5b6e..400ee81a3043 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -10,6 +10,7 @@ TARGETS += drivers/dma-buf
>  TARGETS += efivarfs
>  TARGETS += exec
>  TARGETS += filesystems
> +TARGETS += filesystems/binderfs
>  TARGETS += firmware
>  TARGETS += ftrace
>  TARGETS += futex
> diff --git a/tools/testing/selftests/filesystems/binderfs/.gitignore b/tools/testing/selftests/filesystems/binderfs/.gitignore
> new file mode 100644
> index 000000000000..8a5d9bf63dd4
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/binderfs/.gitignore
> @@ -0,0 +1 @@
> +binderfs_test
> diff --git a/tools/testing/selftests/filesystems/binderfs/Makefile b/tools/testing/selftests/filesystems/binderfs/Makefile
> new file mode 100644
> index 000000000000..58cb659b56b4
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/binderfs/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +CFLAGS += -I../../../../../usr/include/
> +TEST_GEN_PROGS := binderfs_test
> +
> +include ../../lib.mk
> diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> new file mode 100644
> index 000000000000..ca4d9b616e84
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <sched.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/ioctl.h>
> +#include <sys/mount.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include <linux/android/binder.h>
> +#include <linux/android/binderfs.h>
> +#include "../../kselftest.h"
> +
> +int main(int argc, char *argv[])
> +{
> +	int fd, ret, saved_errno;
> +	size_t len;
> +	struct binderfs_device device = { 0 };
> +	struct binder_version version = { 0 };
> +
> +	ret = unshare(CLONE_NEWNS);
> +	if (ret < 0)
> +		ksft_exit_fail_msg("%s - Failed to unshare mount namespace\n",
> +				   strerror(errno));
> +
> +	ret = mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
> +	if (ret < 0)
> +		ksft_exit_fail_msg("%s - Failed to mount / as private\n",
> +				   strerror(errno));
> +
> +	ret = mkdir("/dev/binderfs", 0755);
> +	if (ret < 0 && errno != EEXIST)
> +		ksft_exit_fail_msg(
> +			"%s - Failed to create binderfs mountpoint\n",
> +			strerror(errno));
> +
> +	ret = mount(NULL, "/dev/binderfs", "binder", 0, 0);
> +	if (ret < 0)
> +		ksft_exit_fail_msg("%s - Failed to mount binderfs\n",
> +				   strerror(errno));

Can you check first to see if the kernel under test really even has
binderfs in it?  If not, you need to just abort the test, not fail it,
so as to allow newer versions of kselftests to run on older kernels.

thanks,

greg k-h
