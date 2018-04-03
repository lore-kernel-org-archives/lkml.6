Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754735AbeDCBYd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 21:24:33 -0400
Received: from mga03.intel.com ([134.134.136.65]:43531 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754675AbeDCBYb (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 21:24:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,398,1517904000";
   d="scan'208";a="213430424"
Subject: Re: [PATCH v4 4/6] perf version: Print the compiled-in status of
 libraries
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <1522402036-22915-1-git-send-email-yao.jin@linux.intel.com>
 <1522402036-22915-5-git-send-email-yao.jin@linux.intel.com>
 <20180402164738.GA23295@kernel.org>
From: "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <27e4500b-8bd1-14b0-8f5f-c09af2bf7d99@linux.intel.com>
Date: Tue, 3 Apr 2018 09:24:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180402164738.GA23295@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/3/2018 12:47 AM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Mar 30, 2018 at 05:27:14PM +0800, Jin Yao escreveu:
>> This patch checks the values passed by CFLAGS (-DHAVE_XXX) and then
>> print the status of libraries.
>>
>> For example, if HAVE_DWARF_SUPPORT is defined, that means the
>> library "dwarf" is compiled-in. The patch will print the status
>> "on" for this library otherwise it print the status "OFF".
>>
>> A new option '--build-options' created for 'perf version' supports
>> the printing of library status.
>>
>> For example:
>>
>> $ ./perf version --build-options
>>      or
>>    ./perf --version --build-options
>>      or
>>    ./perf -v --build-options
>>
>> perf version 4.13.rc5.g6727c5
>>                   dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
>>      dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
>>                   glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
>>                    gtk2: [ on  ]  # HAVE_GTK2_SUPPORT
>>                libaudit: [ OFF ]  # HAVE_LIBAUDIT_SUPPORT
> 
> Ok, while testing this I noticed the above, which may be distracting,
> i.e. on x86-64 and s/390 not having libaudit means nothing, it is not
> needed for anything.
> 
> It is only needed for architectures where HAVE_SYSCALL_TABLE is not
> defined, that, btw, is not listed here, so I suggest that we stop
> printing this "libaudit [ OFF ]" line if HAVE_SYSCALL_TABLE is
> available, and also add a line for HAVE_SYSCALL_TABLE.
> 
> Anyways, this can be done on top of this series, but please do a grep
> looking for other HAVE_* to fix, and we need to rename
> HAVE_SYSCALL_TABLE to HAVE_SYSCALL_TABLE_SUPPORT...
> 
> - Arnaldo
> 

Hi Arnaldo,

Thanks for the suggestions. Yes, some follow-up patches are needed.

1. Remove -DNO_LIBPERL and use -DHAVE_LIBPERL_SUPPORT in C code.

2. Remove -DNO_LIBPYTHON and use -DHAVE_LIBPYTHON_SUPPORT in C code.

3. Rename HAVE_SYSCALL_TABLE to HAVE_SYSCALL_TABLE_SUPPORT.

4. Don't print "libaudit [ OFF ]" line if HAVE_SYSCALL_TABLE_SUPPORT is 
available and add a line for HAVE_SYSCALL_TABLE_SUPPORT.

I will do it in follow-up patch.

Thanks
Jin Yao
