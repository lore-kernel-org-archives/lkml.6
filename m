Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754752AbeDPJky (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 05:40:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37220 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754285AbeDPJkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 05:40:51 -0400
Subject: Re: [PATCH 3/3] perf/buildid-cache: Support --purge-all option
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: acme@redhat.com, kstewart@linuxfoundation.org, tglx@linutronix.de,
        pombredanne@nexb.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, uneedsihyeon@gmail.com, kjlx@templeofstupid.com,
        ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20180409110633.20767-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180409110633.20767-4-ravi.bangoria@linux.vnet.ibm.com>
 <20180416182735.4399e94b3c7e6d190ec7dc3e@kernel.org>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Mon, 16 Apr 2018 15:10:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180416182735.4399e94b3c7e6d190ec7dc3e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18041609-0020-0000-0000-00000412617B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041609-0021-0000-0000-000042A69AD9
Message-Id: <f921f16f-578a-955c-4301-e596adbdcd4b@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-16_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804160090
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On 04/16/2018 02:57 PM, Masami Hiramatsu wrote:
> On Mon,  9 Apr 2018 16:36:33 +0530
> Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:
>
>> User can remove files from cache using --remove/--purge options
>> but both needs list of files as an argument. It's not convenient
>> when you want to flush out entire cache. Add an option to purge
>> all files from cache.
>>
>> Ex,
>>   # perf buildid-cache -l
>>     /tmp/a.out (8a86ef73e44067bca52cc3f6cd3e5446c783391c)
>>     /tmp/a.out.1 (ebe71fdcf4b366518cc154d570a33cd461a51c36)
>>   # perf buildid-cache -P -v
>>     Removing /tmp/a.out (8a86ef73e44067bca52cc3f6cd3e5446c783391c): Ok
>>     Removing /tmp/a.out.1 (ebe71fdcf4b366518cc154d570a33cd461a51c36): Ok
>>     Purged all: Ok
> Hmm, for purging all caches will be done by
>
> $ rm -rf ~/.debug
>
> Are there any difference?

No logical difference if you know it's ~/.debug where it goes. :)
I also used to do rm -rf earlier.

This option is for a perf users. But I'm fine if it's not really needed.
Will drop it.

Thanks,
Ravi
