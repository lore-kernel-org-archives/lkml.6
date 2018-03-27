Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751231AbeC0GMn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 02:12:43 -0400
Received: from mga11.intel.com ([192.55.52.93]:35461 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750880AbeC0GMm (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 02:12:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,366,1517904000";
   d="scan'208";a="29154056"
Subject: Re: [PATCH v1 3/3] perf: Support perf -vv
To: Ingo Molnar <mingo@kernel.org>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com
References: <1522080424-12912-1-git-send-email-yao.jin@linux.intel.com>
 <1522080424-12912-4-git-send-email-yao.jin@linux.intel.com>
 <20180327060336.gjdy442pkdc7k2rr@gmail.com>
From: "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <518dbf6a-4fe7-a662-984e-297c2f2ae63f@linux.intel.com>
Date: Tue, 27 Mar 2018 14:12:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327060336.gjdy442pkdc7k2rr@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/27/2018 2:03 PM, Ingo Molnar wrote:
> 
> * Jin Yao <yao.jin@linux.intel.com> wrote:
> 
>> +++ b/tools/perf/perf.c
>> @@ -64,6 +64,7 @@ static struct cmd_struct commands[] = {
>>   	{ "top",	cmd_top,	0 },
>>   	{ "annotate",	cmd_annotate,	0 },
>>   	{ "version",	cmd_version,	0 },
>> +	{ "version2",	cmd_version2,	0 },
>>   	{ "script",	cmd_script,	0 },
>>   	{ "sched",	cmd_sched,	0 },
>>   #ifdef HAVE_LIBELF_SUPPORT
>> @@ -190,6 +191,11 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>>   			break;
>>   		}
>>   
>> +		if (!strcmp(cmd, "-vv")) {
>> +			(*argv)[0] = "--version2";
>> +			break;
>> +		}
> 
> That is just lazy hackery, please use the regular option library to add options
> and document them!
> 
> Also, '--version2' is a sloppy name, the right solution is to do what Git does, it
> has a --build-options sub-option to 'perf version':
> 
>    triton:~/tip> git version -h
>    usage: git version [<options>]
> 
>        --build-options       also print build options
> 
> 
>    triton:~/tip> git version --build-options
>    git version 2.14.1
>    sizeof-long: 8
> 
> This should be done for perf as well, and _then_ maybe can we add a helper alias
> that maps '-vv' to 'version --build-options'.
> 
> Thanks,
> 
> 	Ingo
> 

Something like 'perf version --build-options' and that will be mapped to 
'-vv'.

It's a good idea, thanks!

Thanks
Jin Yao
