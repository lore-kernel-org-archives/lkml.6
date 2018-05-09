Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933785AbeEIHix (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 03:38:53 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:26858 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933625AbeEIHiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 03:38:52 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="39724975"
Subject: Re: [PATCH] perf test shell: Add -D to check dynamic symbols for
 ubuntu/debian
To: <linux-kernel@vger.kernel.org>, <acme@kernel.org>
CC: <philip.li@intel.com>, <brueckner@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
References: <1514364645-1205-1-git-send-email-lizhijian@cn.fujitsu.com>
 <0dbb982d-9cca-cd13-9a31-cc2f6e93a748@cn.fujitsu.com>
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Organization: fnst-ulinux
Message-ID: <7d869226-4f44-09a3-3e52-e1a8c40c310e@cn.fujitsu.com>
Date: Wed, 9 May 2018 15:38:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <0dbb982d-9cca-cd13-9a31-cc2f6e93a748@cn.fujitsu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.167.226.45]
X-yoursite-MailScanner-ID: 82ADE4B34D23.AB3B7
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, just noticed this path is out-of-date
i will rebase it


On 05/09/2018 03:36 PM, Li Zhijian wrote:
> ping
>
>
> On 12/27/2017 04:50 PM, Li Zhijian wrote:
>> On Ubuntu and Debian, we can't find any symbol including "inet_pton" from 'nm -g'
>> root@vm-lkp-nex04-8G-5 ~# nm -g /lib/x86_64-linux-gnu/libc-2.25.so | grep inet_pton
>> nm: /lib/x86_64-linux-gnu/libc-2.25.so: no symbols
>>
>> it looks libc.so has different symbol compositions at different distros
>>
>> Usage: nm [option(s)] [file(s)]
>>   List symbols in [file(s)] (a.out by default).
>>   The options are:
>> ...snip...
>>    -D, --dynamic          Display dynamic symbols instead of normal symbols
>>        --defined-only     Display only defined symbols
>>    -e                     (ignored)
>>    -f, --format=FORMAT    Use the output format FORMAT.  FORMAT can be `bsd',
>>                             `sysv' or `posix'.  The default is `bsd'
>>    -g, --extern-only      Display only external symbols
>>
>> I tested both debian/ubuntu and RHEL, they work as expected
>>
>> CC: Thomas Richter <tmricht@linux.vnet.ibm.com>
>> CC: Arnaldo Carvalho de Melo <acme@redhat.com>
>> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>> ---
>>   tools/perf/tests/shell/trace+probe_libc_inet_pton.sh | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh b/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
>> index 8b3da21..f939bd6 100755
>> --- a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
>> +++ b/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
>> @@ -11,7 +11,7 @@
>>   . $(dirname $0)/lib/probe.sh
>>     libc=$(grep -w libc /proc/self/maps | head -1 | sed -r 's/.*[[:space:]](\/.*)/\1/g')
>> -nm -g $libc 2>/dev/null | fgrep -q inet_pton || exit 254
>> +nm -gD $libc 2>/dev/null | fgrep -q inet_pton || exit 254
>>     trace_libc_inet_pton_backtrace() {
>>       idx=0

-- 
Best regards.
Li Zhijian (8528)
