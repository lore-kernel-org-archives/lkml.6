Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752763AbeCPFwa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 01:52:30 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:16348 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752236AbeCPFw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 01:52:28 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="37871655"
Subject: Re: linux-next: build warning after merge of the tip tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
CC: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
References: <20180316163716.5525294f@canb.auug.org.au>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <3b2889c6-3f0b-b0f4-d5a7-3b4cf5c5ef75@cn.fujitsu.com>
Date: Fri, 16 Mar 2018 13:52:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180316163716.5525294f@canb.auug.org.au>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 8E0114D0EFD4.AB06A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

At 03/16/2018 01:37 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the tip tree, yesterday's linux-next build (x86_64 allnoconfig)
> produced this warning:
> 
> kernel/cpu.c:129:13: warning: 'cpuhp_is_ap_state' defined but not used [-Wunused-function]
>   static bool cpuhp_is_ap_state(enum cpuhp_state state)
>               ^~~~~~~~~~~~~~~~~
> 

Yes, Jiangshan has replaced it with cpuhp_hp_states. So it is obsolete,
it should be removed.

Thanks,
	dou.
> Introduced by commit
> 
>    17a2f1ced028 ("cpu/hotplug: Merge cpuhp_bp_states and cpuhp_ap_states")
> 
