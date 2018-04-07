Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752128AbeDGArb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 20:47:31 -0400
Received: from mga07.intel.com ([134.134.136.100]:63205 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751528AbeDGAra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 20:47:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,417,1517904000";
   d="scan'208";a="48676428"
Subject: Re: [PATCH 4/9] x86, pkeys: override pkey when moving away from
 PROT_EXEC
To: Ram Pai <linuxram@us.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20180326172721.D5B2CBB4@viggo.jf.intel.com>
 <20180326172727.025EBF16@viggo.jf.intel.com>
 <20180407000943.GA15890@ram.oc3035372033.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, shakeelb@google.com,
        stable@kernel.org, tglx@linutronix.de, mpe@ellerman.id.au,
        mingo@kernel.org, akpm@linux-foundation.org, shuah@kernel.org
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <6e3f8e1c-afed-64de-9815-8478e18532aa@intel.com>
Date: Fri, 6 Apr 2018 17:47:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180407000943.GA15890@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/2018 05:09 PM, Ram Pai wrote:
>> -	/*
>> -	 * Look for a protection-key-drive execute-only mapping
>> -	 * which is now being given permissions that are not
>> -	 * execute-only.  Move it back to the default pkey.
>> -	 */
>> -	if (vma_is_pkey_exec_only(vma) &&
>> -	    (prot & (PROT_READ|PROT_WRITE))) {
>> -		return 0;
>> -	}
>> +
> Dave,
> 	this can be simply:
> 
> 	if ((vma_is_pkey_exec_only(vma) && (prot != PROT_EXEC))
> 		return ARCH_DEFAULT_PKEY;

Yes, but we're removing that code entirely. :)
