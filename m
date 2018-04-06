Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbeDFH5A (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 03:57:00 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:36654 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751704AbeDFH45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 03:56:57 -0400
X-Google-Smtp-Source: AIpwx48v+uPCgFtAeX3s4J06iUpL38QJLoO+7+YpSFsj4cHGoNBXpKUVi5S4BLarAekTDZXvtAiAezObxQrkUvVoMMw=
MIME-Version: 1.0
In-Reply-To: <20180406072517.27709-1-tobias.regnery@gmail.com>
References: <20180406072517.27709-1-tobias.regnery@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 6 Apr 2018 09:56:55 +0200
X-Google-Sender-Auth: Qke7Apt2x4VgPzOhZeFPqFDdMwg
Message-ID: <CAK8P3a0dnD48qGWL098_fvqC=BOCm5x6DfC9aQ8qv0JZ-EehYA@mail.gmail.com>
Subject: Re: [PATCH v2] pstore: fix crypto dependencies without compression
To: Tobias Regnery <tobias.regnery@gmail.com>
Cc: Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 6, 2018 at 9:25 AM, Tobias Regnery <tobias.regnery@gmail.com> wrote:
> Commit 58eb5b670747 ("pstore: fix crypto dependencies") fixed up the crypto
> dependencies but missed the case when no compression is selected.
>
> With CONFIG_PSTORE=y, CONFIG_PSTORE_COMPRESS=n  and CONFIG_CRYPTO=m we see
> the following link error:
>
> fs/pstore/platform.o: In function `pstore_register':
> (.text+0x1b1): undefined reference to `crypto_has_alg'
> (.text+0x205): undefined reference to `crypto_alloc_base'
> fs/pstore/platform.o: In function `pstore_unregister':
> (.text+0x3b0): undefined reference to `crypto_destroy_tfm'
>
> Fix this by checking at compile-time if CONFIG_PSTORE_COMPRESS is enabled.
>
> Fixes: 58eb5b670747 ("pstore: fix crypto dependencies")
> Signed-off-by: Tobias Regnery <tobias.regnery@gmail.com>
> ---
> v2: check the config at compile-time rather than change the
>     kconfig-dependency as suggested by Arnd.

Thanks!

Acked-by: Arnd Bergmann <arnd@arndb.de>
