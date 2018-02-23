Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752049AbeBWADV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 19:03:21 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:33564 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751283AbeBWADU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 19:03:20 -0500
X-Google-Smtp-Source: AG47ELslFKJ0JrKy+3kiAaBTlYTvo5TvKgS7T0lerPXXc9A8C+Tjk/iV033Pb6N2VYfetN+aVN8t9vKuG8/XOfsftg4=
MIME-Version: 1.0
In-Reply-To: <201802230613.8bqOOUnw%fengguang.wu@intel.com>
References: <20180222002854.GA29269@beast> <201802230613.8bqOOUnw%fengguang.wu@intel.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 22 Feb 2018 16:03:13 -0800
X-Google-Sender-Auth: qawVAqkIO-BGWY600KQbpd2OGHE
Message-ID: <CAGXu5jKx+ReiTOVnxANL=NsOTWuxzuATUYqtfi91GvFKVgR6Yg@mail.gmail.com>
Subject: Re: [PATCH v2] kconfig.h: Include compiler types to avoid missed
 struct attributes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kbuild-all@01.org, kbuild test robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 2:26 PM, kbuild test robot <lkp@intel.com> wrote:
> Hi Kees,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.16-rc2 next-20180222]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Kees-Cook/kconfig-h-Include-compiler-types-to-avoid-missed-struct-attributes/20180223-040717
> config: mips-jz4740 (attached as .config)
> compiler: mipsel-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=mips
>
> All errors (new ones prefixed by >>):
>
>>> Error: arch/mips/boot/vmlinux.gz.its:201.1-2 syntax error
>    FATAL ERROR: Unable to parse input tree
>    /usr/bin/mkimage: Can't read arch/mips/boot/vmlinux.gz.itb.tmp: Invalid argument
>    /usr/bin/mkimage Can't add hashes to FIT blob

Ugh, the compiler_types.h commit breaks MIPS. I've reproduced this
failure; debugging now....

-Kees

-- 
Kees Cook
Pixel Security
