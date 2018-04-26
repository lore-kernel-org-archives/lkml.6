Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753628AbeDZHPE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 03:15:04 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:32883 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752148AbeDZHPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 03:15:03 -0400
X-Google-Smtp-Source: AB8JxZr2OJEIAag3/MPEXObhWs61RZJdLic8tvfj+zOKDeBnCEr92A+wDPXLUACB6z4+zFgjyh2Eiaw58rX97xGbuXk=
MIME-Version: 1.0
In-Reply-To: <201804261013.6YZ6XwpM%fengguang.wu@intel.com>
References: <201804261013.6YZ6XwpM%fengguang.wu@intel.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 26 Apr 2018 09:15:01 +0200
X-Google-Sender-Auth: a9rOlvO0fe4GJd7bjfR4dnRfvu4
Message-ID: <CAK8P3a0tpU7RFasJUuG7V2ZYUoR-iYDzjO13neF08ToAdnLX+w@mail.gmail.com>
Subject: Re: Makefile:636: arch/score/Makefile: No such file or directory
To: kbuild test robot <lkp@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>
Cc: kbuild-all@01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 4:23 AM, kbuild test robot <lkp@intel.com> wrote:
> Hi Arnd,
>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   26ed24e429d89e045e5eb2d2b75215244347b7f2
> commit: b8c9c8f0190f4004d3d4364edb2dea5978dfc824 arch: remove score port
> date:   7 weeks ago
> config: score-spct6600_defconfig

Please stop trying to build the removed architectures: tile, blackfin,
metag, m32r, frv, mn10300, cris and score.

https://lwn.net/Articles/748074/ has details about why this broke.

Note that we do have a few new architectures that you may want
to add if you haven't done this already: nds32 and riscv were added
this year, and a couple of older architectures that didn't have upstream
gcc releases now have those, and I uploaded gcc binaries to
https://cdn.kernel.org/pub/tools/crosstool/.

This should allow building everything we have in the kernel now.
Unfortunately the nds32 toolchain I uploaded is a little incomplete,
but I have a gcc-6.4 build that (mostly) works and gcc-8 should
be fine as well once it gets released.

      Arnd
