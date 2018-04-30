Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754721AbeD3Paq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 11:30:46 -0400
Received: from mga14.intel.com ([192.55.52.115]:3426 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754474AbeD3Pap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 11:30:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,346,1520924400";
   d="scan'208";a="47183377"
Subject: Re: [PATCH 0/9] [v3] x86, pkeys: two protection keys bug fixes
To: Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20180427174527.0031016C@viggo.jf.intel.com>
 <20180428070553.yjlt22sb6ntcaqnc@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxram@us.ibm.com,
        tglx@linutronix.de, mpe@ellerman.id.au, akpm@linux-foundation.org,
        shuah@kernel.org, shakeelb@google.com
From: Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Message-ID: <a176ae33-eb01-d275-f372-a33829e865a7@intel.com>
Date: Mon, 30 Apr 2018 08:30:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180428070553.yjlt22sb6ntcaqnc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/28/2018 12:05 AM, Ingo Molnar wrote:
> In the above kernel that was missing the PROT_EXEC fix I was repeatedly running 
> the 64-bit and 32-bit testcases as non-root and as root as well, until I got a 
> hang in the middle of a 32-bit test running as root:
> 
>   test  7 PASSED (iteration 19)
>   test  8 PASSED (iteration 19)
>   test  9 PASSED (iteration 19)
> 
>   < test just hangs here >

For the hang, there is a known issue with the use of printf() in the
signal handler and a resulting deadlock.  I *thought* there was a patch
merged to fix this from Ram Pai or one of the other IBM folks.
