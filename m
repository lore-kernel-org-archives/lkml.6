Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751231AbeC0GE7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 02:04:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:11159 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751096AbeC0GE5 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 02:04:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,366,1517904000";
   d="scan'208";a="29151307"
Subject: Re: [PATCH v1 2/3] perf version: Print the status of compiled-in
 libraries
To: Ingo Molnar <mingo@kernel.org>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com
References: <1522080424-12912-1-git-send-email-yao.jin@linux.intel.com>
 <1522080424-12912-3-git-send-email-yao.jin@linux.intel.com>
 <20180327055859.s2tjsvgdwd7cdkf7@gmail.com>
From: "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <46ad7f7c-83bb-340b-1de9-486f5cf5ca95@linux.intel.com>
Date: Tue, 27 Mar 2018 14:04:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327055859.s2tjsvgdwd7cdkf7@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/27/2018 1:58 PM, Ingo Molnar wrote:
> 
> * Jin Yao <yao.jin@linux.intel.com> wrote:
> 
>> +#ifdef HAVE_DWARF_SUPPORT
>> +#ifdef HAVE_DWARF_GETLOCATIONS
>> +#ifdef NO_GLIBC
>> +#ifdef HAVE_GTK2_SUPPORT
>> +#ifdef HAVE_LIBAUDIT_SUPPORT
>> +#ifdef HAVE_LIBBFD_SUPPORT
>> +#ifdef HAVE_LIBELF_SUPPORT
>> +#ifdef HAVE_LIBNUMA_SUPPORT
>> +#ifdef NO_LIBPERL
>> +#ifdef NO_LIBPYTHON
>> +#ifdef HAVE_SLANG_SUPPORT
>> +#ifdef HAVE_LIBCRYPTO_SUPPORT
>> +#ifdef HAVE_LIBUNWIND_SUPPORT
>> +#ifdef HAVE_DWARF_SUPPORT
>> +#ifdef HAVE_ZLIB_SUPPORT
>> +#ifdef HAVE_LZMA_SUPPORT
>> +#ifdef HAVE_AUXTRACE_SUPPORT
>> +#ifdef HAVE_LIBBPF_SUPPORT
> 
> BTW., it would be nice at this point to fix those 3 outliers that have a negation
> in their library support status macro:
> 
>> +#ifdef NO_GLIBC
>> +#ifdef NO_LIBPERL
>> +#ifdef NO_LIBPYTHON
> 
> ... and invert them back to the HAVE_* side of the logic:
> 
>> +#ifdef HAVE_GLIBC
>> +#ifdef HAVE_LIBPERL
>> +#ifdef HAVE_LIBPYTHON
> 
> That should make all related code more consistent and more readable.
> 
> Thanks,
> 
> 	Ingo
> 

Yes, it's better, thanks!
I will try to convert them to the HAVE_*.

Thanks
Jin Yao
