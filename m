Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031112AbeEZDsI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 23:48:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52358 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031051AbeEZDsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 23:48:07 -0400
Date: Fri, 25 May 2018 20:48:04 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: kbuild test robot <lkp@intel.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>, kbuild-all@01.org,
        Paul Menzel <pmenzel+linux-kasan-dev@molgen.mpg.de>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] mm-kasan-dont-vfree-nonexistent-vm_area-fix
Message-Id: <20180525204804.3a655370ef4b41e0d96e03f3@linux-foundation.org>
In-Reply-To: <201805261122.HdUpobQm%fengguang.wu@intel.com>
References: <dabee6ab-3a7a-51cd-3b86-5468718e0390@virtuozzo.com>
        <201805261122.HdUpobQm%fengguang.wu@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 May 2018 11:31:35 +0800 kbuild test robot <lkp@intel.com> wrote:

> Hi Andrey,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on mmotm/master]
> [cannot apply to v4.17-rc6]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Andrey-Ryabinin/mm-kasan-dont-vfree-nonexistent-vm_area-fix/20180526-093255
> base:   git://git.cmpxchg.org/linux-mmotm.git master
> config: sparc-allyesconfig (attached as .config)
> compiler: sparc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=sparc 
> 
> All errors (new ones prefixed by >>):
> 
>    fs/autofs/inode.o: In function `autofs_new_ino':
>    inode.c:(.text+0x220): multiple definition of `autofs_new_ino'
>    fs/autofs/inode.o:inode.c:(.text+0x220): first defined here
>    fs/autofs/inode.o: In function `autofs_clean_ino':
>    inode.c:(.text+0x280): multiple definition of `autofs_clean_ino'
>    fs/autofs/inode.o:inode.c:(.text+0x280): first defined here

There's bot breakage here - clearly that patch didn't cause this error.

Ian, this autofs glitch may still not be fixed.
