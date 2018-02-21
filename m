Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbeBUMmN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 07:42:13 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42025 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbeBUMmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 07:42:11 -0500
X-Google-Smtp-Source: AH8x225eEJ682OI7a9hbZRrUAQN0aoDlRjgcIPznCuJ6rc9Cs9tjeKQlIVMzpkxz61KX4eXJNzElYkuHHO1MxNo5kcc=
MIME-Version: 1.0
In-Reply-To: <5a8c6a34.8880a70a.2a9a1.afc7@mx.google.com>
References: <5a8c6a34.8880a70a.2a9a1.afc7@mx.google.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 21 Feb 2018 13:42:10 +0100
X-Google-Sender-Auth: V5qbgplFVPqmndVcbpy6J4Ep-m8
Message-ID: <CAK8P3a0OaN6QjPdTXXXzMeYQt+WnMfvVuhza5Rb2wqdq_iEFVA@mail.gmail.com>
Subject: Re: mainline build: 15 warnings 0 failures (mainline/v4.16-rc2-64-gaf3e79d)
To: "Olof's autobuilder" <build@lixom.net>
Cc: Olof Johansson <olof@lixom.net>,
        Kernel Build Reports Mailman List
        <kernel-build-reports@lists.linaro.org>,
        linux-rdma <linux-rdma@vger.kernel.org>, selvin.xavier@broadcom.com,
        devesh.sharma@broadcom.com, Somnath Kotur <somnath.kotur@broadcom.com>,
        sriharsha.basavapatna@broadcom.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 7:34 PM, Olof's autobuilder <build@lixom.net> wrote:
> Here are the build results from automated periodic testing.
>
> The tree being built was mainline, found at:
>
> URL: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>
>
> Warnings:
>
>         arm64.allmodconfig:
> include/uapi/linux/byteorder/big_endian.h:31:52: warning: passing argument 1 of '__fswab64' makes integer from pointer without a cast [-Wint-conversion]

I sent two patches to the bnxt_re maintainers yesterday. I expect them
to get applied
soon, but haven't heard back yet.

> WARNING: modpost: missing MODULE_LICENSE() in drivers/phy/qualcomm/phy-qcom-ufs.o

Still waiting for Kishon to apply an older patch I sent for this.

>         arm.allmodconfig:
> /tmp/ccQBDjc9.s:18123: Warning: using r15 results in unpredictable behaviour
> /tmp/ccQBDjc9.s:18195: Warning: using r15 results in unpredictable behaviour

I have done multiple versions of a patch for this, none was
universally liked, but
we need to decide on one of them.

> include/linux/bitops.h:7:24: warning: left shift count >= width of type [-Wshift-count-overflow]
> include/linux/bitops.h:7:24: warning: left shift count >= width of type [-Wshift-count-overflow]
> include/linux/bitops.h:7:24: warning: left shift count >= width of type [-Wshift-count-overflow]
> drivers/infiniband/hw/bnxt_re/qplib_fp.c:333:23: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> drivers/infiniband/hw/bnxt_re/qplib_fp.c:336:12: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> include/uapi/linux/swab.h:127:46: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]

Also bnxt_re, same as above

> drivers/infiniband/core/cq.c:78:1: warning: the frame size of 1032 bytes is larger than 1024 bytes [-Wframe-larger-than=]

Sent a patch yesterday, my workaround was suboptimal, discussion about
a better fix
is ongoing.

>         arm.spear3xx_defconfig:
> net/core/filter.c:3382:6: warning: unused variable 'val' [-Wunused-variable]
>
>         arm.spear6xx_defconfig:
> net/core/filter.c:3382:6: warning: unused variable 'val' [-Wunused-variable]
>
>         arm.tct_hammer_defconfig:
> net/core/filter.c:3382:6: warning: unused variable 'val' [-Wunused-variable]

Sent two versions of a patch yesterday, the second version was applied and
should make it into mainline next week.

       Arnd
