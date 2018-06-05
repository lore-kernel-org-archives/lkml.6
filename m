Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751925AbeFEL7r (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 07:59:47 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33168 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751622AbeFEL7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 07:59:46 -0400
X-Google-Smtp-Source: ADUXVKJcXGzqa94LCpdGJlGHRpLIj4msDLGEuDQ74NdxcvbALK8Ao3ovUkupFhjEwIKFmN4Pm29h5fHXogZK0HXHVBc=
MIME-Version: 1.0
In-Reply-To: <20180605114756.1517549-1-arnd@arndb.de>
References: <20180605114756.1517549-1-arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 5 Jun 2018 13:59:44 +0200
X-Google-Sender-Auth: 6KnvpouoNSI-vGtXOh7wgHngJEQ
Message-ID: <CAK8P3a0zjnrTv=skGn_-df-R_CXDXT2Lhz=a+D2hzhDqMd9oFA@mail.gmail.com>
Subject: Re: [PATCH] fs: stub out ioprio_check_cap for !CONFIG_BLOCK
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jeff Moyer <jmoyer@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Adam Manzanares <adam.manzanares@wdc.com>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 1:47 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> When CONFIG_BLOCK is disabled, we now run into a link error:
>
> fs/aio.o: In function `aio_prep_rw':
> aio.c:(.text+0xf68): undefined reference to `ioprio_check_cap'
>
> Since the priorities are unused without block devices, this adds a stub
> that always returns success.
>
> Fixes: d9a08a9e616b ("fs: Add aio iopriority support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Not sure if my assertion is correct, please check that returning zero
> actually makes sense here.

Nevermind, I just saw a different patch fixes this in today's linux-next

       Arnd
