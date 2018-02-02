Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbeBBPw5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 10:52:57 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:50245 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751472AbeBBPws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 10:52:48 -0500
X-Google-Smtp-Source: AH8x225IyWD1cJt3+Dotm5RO3VYZuhuLZDGZhLCSaLfMq62H+4dBNZXWaFjamjbRrpa6uqJj+TcDX6YX9vCtHsgltVE=
MIME-Version: 1.0
In-Reply-To: <20180202154403.1605622-1-arnd@arndb.de>
References: <20180202154403.1605622-1-arnd@arndb.de>
From: =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date: Fri, 2 Feb 2018 16:52:47 +0100
Message-ID: <CAHpGcMLnpYunVvegYeMc7SaH644S3b4m+F101oZh5DY=ycpm+g@mail.gmail.com>
Subject: Re: [PATCH] gfs2: select CONFIG_LIBCRC32C
To: Arnd Bergmann <arnd@arndb.de>
Cc: Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

2018-02-02 16:43 GMT+01:00 Arnd Bergmann <arnd@arndb.de>:
> The new crc32c logic in gfs2_log_header_v2 causes a link
> error without libcrc32c:
>
> ERROR: "crc32c" [fs/gfs2/gfs2.ko] undefined!
>
> While the original patch selected CONFIG_CRYPTO_CRC32C to deal
> with this issue, it turned out to be the wrong symbol.
>
> Fixes: c1696fb85d33 ("GFS2: Introduce new gfs2_log_header_v2")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/gfs2/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/gfs2/Kconfig b/fs/gfs2/Kconfig
> index c0225d4b5435..3ed2b088dcfd 100644
> --- a/fs/gfs2/Kconfig
> +++ b/fs/gfs2/Kconfig
> @@ -3,8 +3,7 @@ config GFS2_FS
>         depends on (64BIT || LBDAF)
>         select FS_POSIX_ACL
>         select CRC32
> -       select CRYPTO
> -       select CRYPTO_CRC32C
> +       select LIBCRC32C
>         select QUOTACTL
>         select FS_IOMAP
>         help
> --
> 2.9.0
>

thanks for the fix, it's identical to what Bob has just asked Linus to
merge (https://lkml.org/lkml/2018/2/2/361).

Andreas
