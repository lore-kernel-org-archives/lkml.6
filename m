Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932904AbeE2KfX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 06:35:23 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:37340 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932629AbeE2KfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 06:35:16 -0400
X-Google-Smtp-Source: ADUXVKL5bx6jnxMlZU/AI8uQk7l5V/B+Wt9Vpi++mkiHKzxC839uEFTZQBnAZci3U2utUTVtnOL0bULuyJWG+fF6MZQ=
MIME-Version: 1.0
In-Reply-To: <20180529024018.12740-1-yuehaibing@huawei.com>
References: <20180529024018.12740-1-yuehaibing@huawei.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 29 May 2018 12:35:14 +0200
X-Google-Sender-Auth: GlkcUeRX0tCzVjo5mH1PIMDM08E
Message-ID: <CAK8P3a0jnU69RQ8jLF82GofE=fgENMVoWkObYvro82f+q=p_XA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: hide the unused 'off' variable
To: YueHaibing <yuehaibing@huawei.com>
Cc: David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4TAZUbG013310

On Tue, May 29, 2018 at 4:40 AM, YueHaibing <yuehaibing@huawei.com> wrote:
> The local variable is only used while CONFIG_IPV6 enabled
>
> net/core/filter.c: In function ‘sk_msg_convert_ctx_access’:
> net/core/filter.c:6489:6: warning: unused variable ‘off’ [-Wunused-variable]
>   int off;
>       ^
> This puts it into #ifdef.
>
> Fixes: 303def35f64e ("bpf: allow sk_msg programs to read sock fields")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

I was about to send the same patch and found you had already sent one.

Acked-by: Arnd Bergmann <arnd@arndb.de>
