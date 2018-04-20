Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752812AbeDTVAs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 17:00:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37988 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752733AbeDTVAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 17:00:46 -0400
Date: Fri, 20 Apr 2018 14:00:44 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: kbuild test robot <lkp@intel.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        kbuild-all@01.org, Cyrill Gorcunov <gorcunov@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>, Andrey Vagin <avagin@openvz.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: Re: [PATCH] prctl: Don't compile some of prctl functions when CRUI
Message-Id: <20180420140044.478b4c88d3cf238bd440f2a7@linux-foundation.org>
In-Reply-To: <201804210452.WobkyJdV%fengguang.wu@intel.com>
References: <20180420072903.GA594@jagdpanzerIV>
        <201804210452.WobkyJdV%fengguang.wu@intel.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Apr 2018 04:37:41 +0800 kbuild test robot <lkp@intel.com> wrote:

> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.17-rc1 next-20180420]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Sergey-Senozhatsky/prctl-Don-t-compile-some-of-prctl-functions-when-CRUI/20180421-040826
> config: i386-tinyconfig (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
>    kernel/sys.c: In function 'prctl_set_mm':
> >> kernel/sys.c:2108:10: error: implicit declaration of function 'prctl_set_mm_exe_file'; did you mean 'set_mm_exe_file'? [-Werror=implicit-function-declaration]
>       return prctl_set_mm_exe_file(mm, (unsigned int)addr);
>              ^~~~~~~~~~~~~~~~~~~~~

"prctl: don't compile some of prctl functions when CRUI disabled" was a
fix against "prctl: remove non PR_SET_MM_MAP operations", and it
appears that the base patch wasn't applied when this test was
performed.
