Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753879AbeEHCR6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 22:17:58 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:57909 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753840AbeEHCR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 22:17:57 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, peterz@infradead.org,
        oleg@redhat.com, viro@zeniv.linux.org.uk, mingo@kernel.org,
        paulmck@linux.vnet.ibm.com, keescook@chromium.org, riel@redhat.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        marcos.souza.org@gmail.com, hoeun.ryu@gmail.com,
        pasha.tatashin@oracle.com, gs051095@gmail.com, dhowells@redhat.com,
        rppt@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        Balbir Singh <balbir@linux.vnet.ibm.com>, Tejun Heo <tj@kernel.org>
References: <87lgd1zww0.fsf_-_@xmission.com>
        <201805052304.9QOZSH4V%fengguang.wu@intel.com>
        <20180507161801.2641b71f63158839b9c528f3@linux-foundation.org>
Date: Mon, 07 May 2018 21:17:45 -0500
In-Reply-To: <20180507161801.2641b71f63158839b9c528f3@linux-foundation.org>
        (Andrew Morton's message of "Mon, 7 May 2018 16:18:01 -0700")
Message-ID: <87zi1azy9i.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fFsCP-0004b2-Ba;;;mid=<87zi1azy9i.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.90.247.198;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18mXV9hyNHSAVYmrCIDcV+Y1dKQuacAcWg=
X-SA-Exim-Connect-IP: 97.90.247.198
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.1 XMSolicitRefs_0 Weightloss drug
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Andrew Morton <akpm@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 268 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.6 (1.0%), b_tie_ro: 1.91 (0.7%), parse: 0.74 (0.3%),
        extract_message_metadata: 18 (6.7%), get_uri_detail_list: 1.85 (0.7%),
        tests_pri_-1000: 9 (3.5%), tests_pri_-950: 1.15 (0.4%), tests_pri_-900: 1.09
        (0.4%), tests_pri_-400: 27 (10.0%), check_bayes: 26 (9.6%), b_tokenize: 10
        (3.5%), b_tok_get_all: 8 (3.2%), b_comp_prob: 2.2 (0.8%), b_tok_touch_all:
        3.5 (1.3%), b_finish: 0.61 (0.2%), tests_pri_0: 187 (69.7%),
        check_dkim_signature: 0.64 (0.2%), check_dkim_adsp: 2.7 (1.0%),
        tests_pri_500: 19 (7.1%), poll_dns_idle: 11 (4.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] memcg: Replace mm->owner with mm->memcg
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> writes:

> On Sun, 6 May 2018 00:54:48 +0800 kbuild test robot <lkp@intel.com> wrote:
>
>> Hi Eric,
>> 
>> Thank you for the patch! Yet something to improve:
>> 
>> [auto build test ERROR on linus/master]
>> [also build test ERROR on v4.17-rc3]
>> [cannot apply to next-20180504]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>> 
>> url:    https://github.com/0day-ci/linux/commits/Eric-W-Biederman/memcg-Replace-mm-owner-with-mm-memcg/20180503-120054
>> config: xtensa-nommu_kc705_defconfig (attached as .config)
>> compiler: xtensa-de212-elf-gcc (crosstool-NG crosstool-ng-1.23.0-307-g452ee331) 7.3.0
>> reproduce:
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # save the attached .config to linux build tree
>>         make.cross ARCH=xtensa 
>> 
>> All errors (new ones prefixed by >>):
>> 
>>    kernel/fork.o: In function `sighand_ctor':
>> >> fork.c:(.text+0x3b0): undefined reference to `mm_update_memcg'
>>    kernel/fork.o: In function `mmdrop_async':
>>    fork.c:(.text+0x43a): undefined reference to `mm_update_memcg'
>>    kernel/fork.o: In function `set_task_stack_end_magic':
>>    fork.c:(.text+0x752): undefined reference to `mm_update_memcg'
>
> Due to the combination of CONFIG_MMU=n and CONFIG_MEMCG=y. 
> mm/memcontrol.c's mm_update_memcg() depends upon CONFIG_MMU=y.
>
> Is this a valid conbination?  Do we actually support (and test!) memcg
> on nommu systems?

So this was spotted by a human before any automated system so I presume
that the combination is actually supported and at least build tested.

In particular the incremental patch series that fixes that issue has
the subjects lines below.  Andrew if you could apply them that would be great.

[PATCH 0/2] mm->owner to mm->memcg fixes
[PATCH 1/2] memcg: Update the mm->memcg maintenance to work when !CONFIG_MMU
[PATCH 2/2] memcg: Close the race between migration and installing bprm->mm as mm


Andrew since this is essentially a mm patch I presume this work should
go through your tree.

Eric
