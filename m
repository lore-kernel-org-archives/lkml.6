Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753251AbeFAR5B (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 13:57:01 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37332 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752252AbeFAR46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 13:56:58 -0400
X-Google-Smtp-Source: ADUXVKKJzAsIsxsNm1zBOKzjHz2GvU522V283QAIu99JnLopBAEhWkcOGKnIdn+TDQhW7kqGNEbV//He+VpVZeZvwV0=
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
In-Reply-To: <CA+icZUVkajCqc0Opg3EB8Jg915Nu4mCjgmU54twLeBrq3hHvgg@mail.gmail.com>
References: <CA+icZUVkajCqc0Opg3EB8Jg915Nu4mCjgmU54twLeBrq3hHvgg@mail.gmail.com>
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Fri, 1 Jun 2018 19:56:57 +0200
Message-ID: <CA+icZUVsB48bgcm2bY_eN5iShCw4=T+=9k4E1ZFjkZWOrKpzHQ@mail.gmail.com>
Subject: Re: module: x86/modules: Skipping invalid relocation target, existing
 value is nonzero for type 1
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 1, 2018 at 6:01 PM, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> Hi,
>
> can someone tell me what this exactly means?
>
> What is the root cause for this?
> GNU binutils/ld?
> Compiler?
> Curently I test with clang-7.
> VirtualBox and compiler incompatible?
>
> Steps to reproduce the failure...
>
> root# modprobe -v vboxdrv
> insmod /lib/modules/4.14.47-1-iniza-llvmlinux/updates/dkms/vboxdrv.ko
> modprobe: ERROR: could not insert 'vboxdrv': Exec format error
>
> root# dmesg | tail -1
> [13437.021825] module: x86/modules: Skipping invalid relocation
> target, existing value is nonzero for type 1, loc ffffffffc1453360,
> val ffffffffc142f8a2
>
> Tanks in advance.
>

Looks like DKMS kernel-modules were built with gcc-7, unsure how to
force usage of clang-7.

- sed@ -
