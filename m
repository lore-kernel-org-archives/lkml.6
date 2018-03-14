Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
X-Google-Smtp-Source: AG47ELsUgTitxThYsmuvtRfci8if24Lc+a+YNHabYW7TYnlQ2TeydZtUkUyIn8KDqKFsNEsiM2s0
ARC-Seal: i=1; a=rsa-sha256; t=1521040394; cv=none;
        d=google.com; s=arc-20160816;
        b=W+qhe75ikpYJOthpYKxBODUI09770fnig6Ty5JXUqlb1AVkutN0Ajn97oh2HYgNt/a
         0elxkWOewAqZ2xx7VkAN4lj0v61o366X/9U98Jd24ZH5kHCx+9BTDijNVlX7dc37ayYc
         6D9Y6jjzO8p6wQzRGoR8zOrofsj6YATWFO4A81i0Gq3hx/7maVHY8/W1mIO5Iq/6gwpR
         B2rQNo37ybo8ArNXUHJRhDZ5SqjHbQDEuw/MnNyLEsCE4k+Zrwm/Lk8KAKBEiVgUW63/
         NkRUvNrjRuIJpBTM9x8lDJTenG5buIkIgCbSv7J7jOEPuIoCS2qtrO+2O5+ffTZGt0Rf
         aT+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-language:content-transfer-encoding:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=Gpl99H+g+4NLnAIRi1cPvUOcZIHoCgO9Icw0mI8vTMQ=;
        b=MwLuJloCVlzMaMDdTOyofFv9cvFIkcdAtM7kL70f8PYe9AGBrvYzEOaokrd0+ij4Ac
         ASK6x67wfQQ8p2K1hZHfVM0LNZQOWjwwFqSUiPyEziM+htoketOhqVy/W8mihkLeMVke
         ji9QbF8YPKVh0+vFhNVf4YtULMs8j8ZQh5EpzttItyBrvtsiLp2hPre+Vb9W+/ynvHw5
         gzOYU862uV2kQZK941HUo4b2JEx7eBblA3aWBxZssssqZrMC5Ww20VMqaufcPuJcKdjJ
         RoReGN3yJgeurdMkDV1DFABtVYO1HjWvyQDTXkGlSdvXikmJOZvXr55JyVFmL/gWDIZr
         ojUg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH 6/8] trace_uprobe/sdt: Fix multiple update of same
 reference counter
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: oleg@redhat.com, peterz@infradead.org, srikar@linux.vnet.ibm.com,
        acme@kernel.org, ananth@linux.vnet.ibm.com, akpm@linux-foundation.org,
        alexander.shishkin@linux.intel.com, alexis.berlemont@gmail.com,
        corbet@lwn.net, dan.j.williams@intel.com, gregkh@linuxfoundation.org,
        huawei.libin@huawei.com, hughd@google.com, jack@suse.cz,
        jglisse@redhat.com, jolsa@redhat.com, kan.liang@intel.com,
        kirill.shutemov@linux.intel.com, kjlx@templeofstupid.com,
        kstewart@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        milian.wolff@kdab.com, mingo@redhat.com, namhyung@kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, pc@us.ibm.com, pombredanne@nexb.com,
        rostedt@goodmis.org, tglx@linutronix.de, tmricht@linux.vnet.ibm.com,
        willy@infradead.org, yao.jin@linux.intel.com, fengguang.wu@intel.com,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
References: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180313125603.19819-7-ravi.bangoria@linux.vnet.ibm.com>
 <20180314231540.b98c74a153255f59f54ebc46@kernel.org>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Wed, 14 Mar 2018 20:45:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314231540.b98c74a153255f59f54ebc46@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18031415-0040-0000-0000-000004206C0F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031415-0041-0000-0000-0000262370F8
Message-Id: <1e51042b-d05b-dd55-82e6-818bb5be03d1@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-14_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803140171
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827186487084438?=
X-GMAIL-MSGID: =?utf-8?q?1594926452567596902?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/14/2018 07:45 PM, Masami Hiramatsu wrote:
> On Tue, 13 Mar 2018 18:26:01 +0530
> Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:
>
>> For tiny binaries/libraries, different mmap regions points to the
>> same file portion. In such cases, we may increment reference counter
>> multiple times. But while de-registration, reference counter will get
>> decremented only by once leaving reference counter > 0 even if no one
>> is tracing on that marker.
>>
>> Ensure increment and decrement happens in sync by keeping list of
>> mms in trace_uprobe. Increment reference counter only if mm is not
>> present in the list and decrement only if mm is present in the list.
>>
>> Example
>>
>>   # echo "p:sdt_tick/loop2 /tmp/tick:0x6e4(0x10036)" > uprobe_events
>>
>> Before patch:
>>
>>   # perf stat -a -e sdt_tick:loop2
>>   # /tmp/tick
>>   # dd if=/proc/`pgrep tick`/mem bs=1 count=1 skip=$(( 0x10020036 )) 2>/dev/null | xxd
>>    0000000: 02                                       .
>>
>>   # pkill perf
>>   # dd if=/proc/`pgrep tick`/mem bs=1 count=1 skip=$(( 0x10020036 )) 2>/dev/null | xxd
>>   0000000: 01                                       .
>>
>> After patch:
>>
>>   # perf stat -a -e sdt_tick:loop2
>>   # /tmp/tick
>>   # dd if=/proc/`pgrep tick`/mem bs=1 count=1 skip=$(( 0x10020036 )) 2>/dev/null | xxd
>>   0000000: 01                                       .
>>
>>   # pkill perf
>>   # dd if=/proc/`pgrep tick`/mem bs=1 count=1 skip=$(( 0x10020036 )) 2>/dev/null | xxd
>>   0000000: 00                                       .
>>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
>> ---
>>  kernel/trace/trace_uprobe.c | 105 +++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 103 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
>> index b6c9b48..9bf3f7a 100644
>> --- a/kernel/trace/trace_uprobe.c
>> +++ b/kernel/trace/trace_uprobe.c
>> @@ -50,6 +50,11 @@ struct trace_uprobe_filter {
>>  	struct list_head	perf_events;
>>  };
>>  
>> +struct sdt_mm_list {
>> +	struct mm_struct *mm;
>> +	struct sdt_mm_list *next;
>> +};
> Oh, please use struct list_head instead of defining your own pointer-chain :(

Sure, will change it.

>> +
>>  /*
>>   * uprobe event core functions
>>   */
>> @@ -61,6 +66,8 @@ struct trace_uprobe {
>>  	char				*filename;
>>  	unsigned long			offset;
>>  	unsigned long			ref_ctr_offset;
>> +	struct sdt_mm_list		*sml;
>> +	struct rw_semaphore		sml_rw_sem;
> BTW, is there any reason to use rw_semaphore? (mutex doesn't fit?)

Hmm.. No specific reason.. will use a mutex instead.

Thanks for the review :)
Ravi
