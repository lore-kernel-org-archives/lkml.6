Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751173AbeEVG2g (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 02:28:36 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:36892 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751039AbeEVG2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 02:28:33 -0400
X-Google-Smtp-Source: AB8JxZqhAZjVH60GbecIHiiPKVeEQOFqC2lyp/CU/PX+j/urA3G5AZRLGC1TwCwQ+U3L1DVCQ8YPaHHfqKw2Se5Kveg=
MIME-Version: 1.0
In-Reply-To: <20180322202007.23088-1-malat@debian.org>
References: <20180322202007.23088-1-malat@debian.org>
From: Mathieu Malaterre <malat@debian.org>
Date: Tue, 22 May 2018 08:28:12 +0200
X-Google-Sender-Auth: z5i9UCsUqkHCGVFqNQSk6lQPqHU
Message-ID: <CA+7wUsxFbou9TEqL8df3Y8_PVNYwoTR4HKN8Zp7iPQhHBQsmKg@mail.gmail.com>
Subject: Re: [PATCH 00/19] powerpc/ppc32: make W=1 compilation errors free
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>, kvm-ppc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any chance this could be applied to powerpc/next ?

On Thu, Mar 22, 2018 at 9:19 PM, Mathieu Malaterre <malat@debian.org> wrote:
> Here is another batch for warnings treated as error on ppc32. Tested with:
>
> $ make ARCH=powerpc ppc32_defconfig
> $ make -j8 ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- W=1
>
> Using:
>
> $ powerpc-linux-gnu-gcc --version
> powerpc-linux-gnu-gcc (Debian 6.3.0-18) 6.3.0 20170516
>
> Mathieu Malaterre (19):
>   powerpc/powermac: Mark variable x as unused
>   powerpc/powermac: Mark variable x as unused
>   powerpc: Mark variables as unused
>   powerpc/kvm: Mark variable tmp unused
>   powerpc/chrp/setup: Add attribute unused and make some functions
>     static
>   powerpc: Make function btext_initialize static
>   powerpc/powermac: Make some functions static
>   powerpc/tau: Make some function static
>   powerpc/chrp/pci: Make some functions static
>   powerpc/chrp/time: Make some functions static, add missing header
>     include
>   powerpc/powermac: Move pmac_pfunc_base_install prototype to header
>     file
>   powerpc/powermac: Add missing prototype for note_bootable_part()
>   powerpc/52xx: Add missing functions prototypes
>   powerpc/altivec: Add missing prototypes for altivec
>   powerpc: Add missing prototype
>   powerpc/powermac: Add missing include of header pmac.h
>   powerpc/32: Add a missing include header
>   powerpc: Add a missing include header
>   powerpc/tau: Synchronize function prototypes and body
>
>  arch/powerpc/include/asm/mpc52xx.h           |  6 +++---
>  arch/powerpc/include/asm/pmac_pfunc.h        |  1 +
>  arch/powerpc/include/asm/rheap.h             |  3 +++
>  arch/powerpc/kernel/btext.c                  |  2 +-
>  arch/powerpc/kernel/irq.c                    |  2 +-
>  arch/powerpc/kernel/kvm.c                    |  2 +-
>  arch/powerpc/kernel/pci_32.c                 |  1 +
>  arch/powerpc/kernel/prom_init.c              |  4 ++--
>  arch/powerpc/kernel/setup-common.c           |  6 ------
>  arch/powerpc/kernel/setup.h                  |  6 ++++++
>  arch/powerpc/kernel/tau_6xx.c                | 15 +++++++++------
>  arch/powerpc/kernel/vecemu.c                 |  1 +
>  arch/powerpc/lib/xor_vmx.h                   | 14 ++++++++++++++
>  arch/powerpc/platforms/chrp/pci.c            |  8 ++++----
>  arch/powerpc/platforms/chrp/setup.c          | 10 +++++-----
>  arch/powerpc/platforms/chrp/time.c           |  6 ++++--
>  arch/powerpc/platforms/powermac/bootx_init.c |  2 +-
>  arch/powerpc/platforms/powermac/pci.c        | 10 +++++-----
>  arch/powerpc/platforms/powermac/setup.c      |  1 +
>  arch/powerpc/platforms/powermac/smp.c        |  1 -
>  arch/powerpc/platforms/powermac/time.c       |  4 +++-
>  arch/powerpc/platforms/powermac/udbg_scc.c   |  2 +-
>  22 files changed, 67 insertions(+), 40 deletions(-)
>
> --
> 2.11.0
>
