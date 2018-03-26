Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752709AbeCZRjP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 13:39:15 -0400
Received: from mga14.intel.com ([192.55.52.115]:58056 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751908AbeCZRjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 13:39:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,365,1517904000";
   d="scan'208";a="38264255"
Subject: Re: [PATCH 1/9] x86, pkeys: do not special case protection key 0
To: Ram Pai <linuxram@us.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20180323180903.33B17168@viggo.jf.intel.com>
 <20180323180905.B40984E6@viggo.jf.intel.com>
 <20180326173522.GB5743@ram.oc3035372033.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, tglx@linutronix.de,
        mpe@ellerman.id.au, mingo@kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <e63d1ea6-4a1e-063c-6cc0-ad80fb554515@intel.com>
Date: Mon, 26 Mar 2018 10:39:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180326173522.GB5743@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/26/2018 10:35 AM, Ram Pai wrote:
>>  #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
>>  	if (cpu_feature_enabled(X86_FEATURE_OSPKE)) {
>> -		/* pkey 0 is the default and always allocated */
>> +		/* pkey 0 is the default and allocated implicitly */
>>  		mm->context.pkey_allocation_map = 0x1;
> In the second patch, you introduce DEFAULT_KEY. Maybe you 
> should introduce here and express the above code as
> 
> 		mm->context.pkey_allocation_map = (0x1 << DEFAULT_KEY);
> 
> Incase your default key changes to something else, you are still good.

That's a good cleanup, but I'd rather limit _this_ set to bug fixes.
