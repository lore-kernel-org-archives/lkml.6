Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751983AbeE1ENX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 00:13:23 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45351 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750710AbeE1ENW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 00:13:22 -0400
X-ME-Proxy: <xmx:4YELWw81JUPH37ldyv85ApMq4m4pCNf0JqUiSHsvijNckxFzlPpxnA>
X-ME-Proxy: <xmx:4YELWz16yjQMJrUtU_kP0mj1dBBxC53Kbyf5P-6TdRoseF8wgRjQCg>
X-ME-Proxy: <xmx:4YELW8aA8oxnCVu5Xan_GztEjstph_xmbutdf36hG5yBy7ebJM-xJg>
X-ME-Proxy: <xmx:4YELW7aoDZDVSlaPNhW5-5L-Jg8pMCL47KkjgLhPYm6VVvBVrqgIBA>
X-ME-Proxy: <xmx:4YELW3mO3MpcalhjQQ_tJZp2kj0Q5W1fiVAKgosvvIlY1ef50o_L6Q>
X-ME-Proxy: <xmx:4YELWxTjSB-USFLqjphNeep-P6Vzv7yXNZCE_vMfuLiV-y98TNsbKw>
X-ME-Sender: <xms:4YELW3F73sv5fTsaa-UI_lrh8gixjHtbfcNUwA8LduukMoH0WGrQ8Q>
Message-ID: <1527480795.2693.4.camel@themaw.net>
Subject: Re: [PATCH] mm-kasan-dont-vfree-nonexistent-vm_area-fix
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Paul Menzel <pmenzel+linux-kasan-dev@molgen.mpg.de>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>
Date: Mon, 28 May 2018 12:13:15 +0800
In-Reply-To: <20180525204804.3a655370ef4b41e0d96e03f3@linux-foundation.org>
References: <dabee6ab-3a7a-51cd-3b86-5468718e0390@virtuozzo.com>
         <201805261122.HdUpobQm%fengguang.wu@intel.com>
         <20180525204804.3a655370ef4b41e0d96e03f3@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-05-25 at 20:48 -0700, Andrew Morton wrote:
> On Sat, 26 May 2018 11:31:35 +0800 kbuild test robot <lkp@intel.com> wrote:
> 
> > Hi Andrey,
> > 
> > I love your patch! Yet something to improve:
> > 
> > [auto build test ERROR on mmotm/master]
> > [cannot apply to v4.17-rc6]
> > [if your patch is applied to the wrong git tree, please drop us a note to
> > help improve the system]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Andrey-Ryabinin/mm-kasan-do
> > nt-vfree-nonexistent-vm_area-fix/20180526-093255
> > base:   git://git.cmpxchg.org/linux-mmotm.git master
> > config: sparc-allyesconfig (attached as .config)
> > compiler: sparc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/m
> > ake.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> >         make.cross ARCH=sparc 
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    fs/autofs/inode.o: In function `autofs_new_ino':
> >    inode.c:(.text+0x220): multiple definition of `autofs_new_ino'
> >    fs/autofs/inode.o:inode.c:(.text+0x220): first defined here
> >    fs/autofs/inode.o: In function `autofs_clean_ino':
> >    inode.c:(.text+0x280): multiple definition of `autofs_clean_ino'
> >    fs/autofs/inode.o:inode.c:(.text+0x280): first defined here
> 
> There's bot breakage here - clearly that patch didn't cause this error.
> 
> Ian, this autofs glitch may still not be fixed.

Yes, autofs-make-autofs4-Kconfig-depend-on-AUTOFS_FS.patch should have
fixed that.

I tied a bunch of .config combinations and I was unable to find any that
lead to both CONFIG_AUTOFS_FS and CONFIG_AUTOFS4_FS being defined.

I must be missing something else, I'll investigate.

Ian
