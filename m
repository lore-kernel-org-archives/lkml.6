Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752253AbeEGOyZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 10:54:25 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:41519 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751951AbeEGOyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 10:54:24 -0400
X-Google-Smtp-Source: AB8JxZp6IM++OWQpnQmSWgocT5SQMNs7uqrPPBcacVXdzgwzLmq5mUxzh/8dTfI/lL7wrGcT61zPGYla2ujdrVXlDkc=
MIME-Version: 1.0
In-Reply-To: <20180507095841.6452-1-jens.wiklander@linaro.org>
References: <20180507095841.6452-1-jens.wiklander@linaro.org>
From: Volodymyr Babchuk <vlad.babchuk@gmail.com>
Date: Mon, 7 May 2018 17:54:02 +0300
Message-ID: <CAOcqxo3B1WYvrRqCVw=bDXFBwcCWQcPm3TT1XQB=NcahPcwEUA@mail.gmail.com>
Subject: Re: [Tee-dev] [PATCH] tee: shm: fix use-after-free via temporarily
 dropped reference
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tee-dev@lists.linaro.org, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On 7 May 2018 at 12:58, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> From: Jann Horn <jannh@google.com>
>
> Bump the file's refcount before moving the reference into the fd table,
> not afterwards. The old code could drop the file's refcount to zero for a
> short moment before calling get_file() via get_dma_buf().
>
> This code can only be triggered on ARM systems that use Linaro's OP-TEE.
>
> Fixes: 967c9cca2cc5 ("tee: generic TEE subsystem")
> Signed-off-by: Jann Horn <jannh@google.com>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Volodymyr Babchuk <vlad.babchuk@gmail.com>

-- 
WBR Volodymyr Babchuk aka lorc [+380976646013]
mailto: vlad.babchuk@gmail.com
