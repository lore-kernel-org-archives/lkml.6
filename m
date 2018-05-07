Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753489AbeEGXSF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 19:18:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60640 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753171AbeEGXSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 19:18:04 -0400
Date: Mon, 7 May 2018 16:18:01 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: kbuild test robot <lkp@intel.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, kbuild-all@01.org,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, peterz@infradead.org,
        oleg@redhat.com, viro@zeniv.linux.org.uk, mingo@kernel.org,
        paulmck@linux.vnet.ibm.com, keescook@chromium.org, riel@redhat.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        marcos.souza.org@gmail.com, hoeun.ryu@gmail.com,
        pasha.tatashin@oracle.com, gs051095@gmail.com, dhowells@redhat.com,
        rppt@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        Balbir Singh <balbir@linux.vnet.ibm.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] memcg: Replace mm->owner with mm->memcg
Message-Id: <20180507161801.2641b71f63158839b9c528f3@linux-foundation.org>
In-Reply-To: <201805052304.9QOZSH4V%fengguang.wu@intel.com>
References: <87lgd1zww0.fsf_-_@xmission.com>
        <201805052304.9QOZSH4V%fengguang.wu@intel.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 May 2018 00:54:48 +0800 kbuild test robot <lkp@intel.com> wrote:

> Hi Eric,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.17-rc3]
> [cannot apply to next-20180504]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Eric-W-Biederman/memcg-Replace-mm-owner-with-mm-memcg/20180503-120054
> config: xtensa-nommu_kc705_defconfig (attached as .config)
> compiler: xtensa-de212-elf-gcc (crosstool-NG crosstool-ng-1.23.0-307-g452ee331) 7.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=xtensa 
> 
> All errors (new ones prefixed by >>):
> 
>    kernel/fork.o: In function `sighand_ctor':
> >> fork.c:(.text+0x3b0): undefined reference to `mm_update_memcg'
>    kernel/fork.o: In function `mmdrop_async':
>    fork.c:(.text+0x43a): undefined reference to `mm_update_memcg'
>    kernel/fork.o: In function `set_task_stack_end_magic':
>    fork.c:(.text+0x752): undefined reference to `mm_update_memcg'

Due to the combination of CONFIG_MMU=n and CONFIG_MEMCG=y. 
mm/memcontrol.c's mm_update_memcg() depends upon CONFIG_MMU=y.

Is this a valid conbination?  Do we actually support (and test!) memcg
on nommu systems?
