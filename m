Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751674AbeBVVwt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 16:52:49 -0500
Received: from mga18.intel.com ([134.134.136.126]:35397 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751359AbeBVVws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 16:52:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,380,1515484800";
   d="scan'208";a="19718524"
Subject: Re: [RFC][PATCH 05/10] x86/mm: do not auto-massage page protections
To: Nadav Amit <namit@vmware.com>
References: <20180222203651.B776810C@viggo.jf.intel.com>
 <20180222203700.3FDE6BFD@viggo.jf.intel.com>
 <5659D3EF-CF51-4B1B-8306-CA2559A75789@vmware.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "keescook@google.com" <keescook@google.com>,
        "hughd@google.com" <hughd@google.com>,
        "jgross@suse.com" <jgross@suse.com>, "x86@kernel.org" <x86@kernel.org>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <754bf1d5-759b-0162-98ae-1800f075b8eb@linux.intel.com>
Date: Thu, 22 Feb 2018 13:52:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5659D3EF-CF51-4B1B-8306-CA2559A75789@vmware.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/22/2018 01:46 PM, Nadav Amit wrote:
>>
>> +static inline pgprotval_t check_pgprot(pgprot_t pgprot)
>> +{
>> +	pgprotval_t massaged_val = massage_pgprot(pgprot);
>> +
>> +	WARN_ONCE(pgprot_val(pgprot) != massaged_val,
>> +		  "attempted to set unsupported pgprot: %016lx "
>> +		  "bits: %016lx supported: %016lx\n",
>> +		  pgprot_val(pgprot),
>> +		  pgprot_val(pgprot) ^ massaged_val,
>> +		  __supported_pte_mask);
> Perhaps use VM_WARN_ONCE instead to avoid any overhead on production
> systems?

Sounds sane enough.  I'll change it.
