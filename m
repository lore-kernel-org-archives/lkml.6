Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752913AbeDQPiU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 11:38:20 -0400
Received: from mga12.intel.com ([192.55.52.136]:60886 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752800AbeDQPiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 11:38:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,464,1517904000";
   d="scan'208";a="34049513"
Subject: Re: 4.17-rc1: early boot crash on x86_64 & pti
To: Aaro Koskinen <aaro.koskinen@nokia.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
References: <20180417150130.GA11166@ak-laptop.emea.nsn-net.net>
 <20180417152801.GB11166@ak-laptop.emea.nsn-net.net>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <951f1bf7-4965-b6f4-fcf8-a22d96f9ef2d@linux.intel.com>
Date: Tue, 17 Apr 2018 08:38:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417152801.GB11166@ak-laptop.emea.nsn-net.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17/2018 08:28 AM, Aaro Koskinen wrote:
> 
>> [    0.000000] Kernel/User page tables isolation: enabled
>> [    0.000000] ------------[ cut here ]------------
>> [    0.000000] CPA: called for zero pte. vaddr = ffffffff8d000000 cpa->vaddr = ffffffff8d000000
>> [    0.000000] WARNING: CPU: 0 PID: 0 at arch/x86/mm/pageattr.c:1189 __cpa_process_fault+0x4d6/0x510
> I started enabling more .config options, and it seems that enabling
> CONFIG_XEN_PV does some magic to make booting work... But I shouldn't
> need it.

You're using "-cpu host".  What is your host CPU?  Also, could you send
along your .config?

I'll try to reproduce this.
