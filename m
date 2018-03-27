Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752899AbeC0NVu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:21:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51300 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752370AbeC0NVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:21:48 -0400
Subject: Re: [PATCH] locking/rwsem: Add DEBUG_RWSEMS to look for lock/unlock
 mismatches
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
References: <1522091465-18102-1-git-send-email-longman@redhat.com>
 <201803271947.1UUNOFXk%fengguang.wu@intel.com>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <0f7f4e7e-7bdd-3069-8808-944cf34d509c@redhat.com>
Date: Tue, 27 Mar 2018 09:21:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <201803271947.1UUNOFXk%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/27/2018 07:24 AM, kbuild test robot wrote:
> Hi Waiman,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on tip/locking/core]
> [also build test ERROR on v4.16-rc7 next-20180326]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Waiman-Long/locking-rwsem-Add-DEBUG_RWSEMS-to-look-for-lock-unlock-mismatches/20180327-151310
> config: i386-allmodconfig (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
>
> All error/warnings (new ones prefixed by >>):
>
>    In file included from include/linux/kernel.h:10:0,
>                     from kernel/locking/rwsem.c:9:
>    kernel/locking/rwsem.c: In function 'up_read_non_owner':
>>> kernel/locking/rwsem.c:217:23: error: implicit declaration of function 'RWSEM_WRITER_OWNED'; did you mean 'RWSEM_READER_OWNED'? [-Werror=implicit-function-declaration]

Yes, I noticed that error right after sending out the patch. That is why
I sent out a v2 patch immediately to fix this. Thanks for the
notification anyway.

Cheers,
Longman
