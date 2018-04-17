Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753859AbeDQRGX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 13:06:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:41894 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753088AbeDQRGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 13:06:22 -0400
Date: Tue, 17 Apr 2018 09:52:10 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, peterz@infradead.org, tglx@linutronix.de,
        mingo@kernel.org, longman@redhat.com, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbues@suse.de>
Subject: Re: [PATCH 2/2] rtmutex: Reduce top-waiter blocking on a lock
Message-ID: <20180417165210.xxtplqjkv46q4d4f@linux-n805>
References: <20180410162750.8290-2-dave@stgolabs.net>
 <201804112023.tAv7vUah%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <201804112023.tAv7vUah%fengguang.wu@intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Apr 2018, kbuild test robot wrote:

>Hi Davidlohr,
>
>I love your patch! Perhaps something to improve:
>
>[auto build test WARNING on linus/master]
>[also build test WARNING on v4.16 next-20180411]
>[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
>url:    https://github.com/0day-ci/linux/commits/Davidlohr-Bueso/locking-rtmutex-Delete-save_state-member-of-struct-rt_mutex/20180411-155733
>reproduce:
>        # apt-get install sparse
>        make ARCH=x86_64 allmodconfig
>        make C=1 CF=-D__CHECK_ENDIAN__

Ok.

>
>
>sparse warnings: (new ones prefixed by >>)
>
>>> kernel/locking/rtmutex_common.h:62:9: sparse: context imbalance in '__rt_mutex_slowlock' - unexpected unlock

I did:

make C=1 CF=-D__CHECK_ENDIAN__ kernel/locking/rtmutex.o

But cannot trigger this message. There are however a ton of other
sparse issues with 'indirect_branch'. Ie:

./arch/x86/include/asm/nospec-branch.h:144:38: warning: Unknown escape '@'
./include/linux/init.h:134:6: error: attribute 'indirect_branch': unknown attribute
./include/linux/init.h:135:5: error: attribute 'indirect_branch': unknown attribute

More importantly, I don't follow where this "unexpected unlock" would come from
considering that rtmutex doesn't use __acquires/__releases annotations. Nor do
I understand why this patch would produce a new context imbalance.

Thanks,
Davidlohr
