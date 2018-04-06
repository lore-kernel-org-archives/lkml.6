Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752737AbeDFWoU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 18:44:20 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:34470 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752171AbeDFWoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 18:44:19 -0400
X-Google-Smtp-Source: AIpwx4/y7itQbNkXZbawZgKnF1qvYsv6zMsIIr6eNq7R8YYMjTSKwAB+Yw1rvWNLTHYR+fHhsW2HV32fsrPVCMCoSNk=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0dnD48qGWL098_fvqC=BOCm5x6DfC9aQ8qv0JZ-EehYA@mail.gmail.com>
References: <20180406072517.27709-1-tobias.regnery@gmail.com> <CAK8P3a0dnD48qGWL098_fvqC=BOCm5x6DfC9aQ8qv0JZ-EehYA@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 6 Apr 2018 15:44:17 -0700
X-Google-Sender-Auth: sGSrJdOk3zPZREDNJKlloKIfxMw
Message-ID: <CAGXu5jK40MDiPT6Ks-ZnvSdd8s++36KVR9D_E7XNYxi_-dc+NQ@mail.gmail.com>
Subject: Re: [PATCH v2] pstore: fix crypto dependencies without compression
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tobias Regnery <tobias.regnery@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 6, 2018 at 12:56 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Apr 6, 2018 at 9:25 AM, Tobias Regnery <tobias.regnery@gmail.com> wrote:
>> Commit 58eb5b670747 ("pstore: fix crypto dependencies") fixed up the crypto
>> dependencies but missed the case when no compression is selected.
>>
>> With CONFIG_PSTORE=y, CONFIG_PSTORE_COMPRESS=n  and CONFIG_CRYPTO=m we see
>> the following link error:
>>
>> fs/pstore/platform.o: In function `pstore_register':
>> (.text+0x1b1): undefined reference to `crypto_has_alg'
>> (.text+0x205): undefined reference to `crypto_alloc_base'
>> fs/pstore/platform.o: In function `pstore_unregister':
>> (.text+0x3b0): undefined reference to `crypto_destroy_tfm'
>>
>> Fix this by checking at compile-time if CONFIG_PSTORE_COMPRESS is enabled.
>>
>> Fixes: 58eb5b670747 ("pstore: fix crypto dependencies")
>> Signed-off-by: Tobias Regnery <tobias.regnery@gmail.com>
>> ---
>> v2: check the config at compile-time rather than change the
>>     kconfig-dependency as suggested by Arnd.
>
> Thanks!
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks! I'll apply this.

-Kees

-- 
Kees Cook
Pixel Security
