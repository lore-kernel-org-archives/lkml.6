Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC99C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9699420862
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9699420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbeG0Imp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 04:42:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55632 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725861AbeG0Imp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 04:42:45 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6R7J5nG140867
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 03:22:11 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kfw67v62r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 03:22:10 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Fri, 27 Jul 2018 08:22:09 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 27 Jul 2018 08:22:05 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6R7M4sN24051730
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Jul 2018 07:22:04 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89C064C040;
        Fri, 27 Jul 2018 10:22:18 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 138EE4C050;
        Fri, 27 Jul 2018 10:22:18 +0100 (BST)
Received: from oc3784624756.ibm.com (unknown [9.152.212.85])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 27 Jul 2018 10:22:17 +0100 (BST)
Subject: Re: [PATCH v2] perf build: Build error in libbpf with
 EXTRA_CFLAGS="-Wp,-D_FORTIFY_SOURCE=2 -O2"
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     ast@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        wangnan0@huawei.com
References: <20180725072126.2232-1-tmricht@linux.ibm.com>
 <20180725184835.5d37bef4@cakuba.netronome.com>
 <08b6ed57-40a4-7468-b78d-f2a2c5ab10a8@iogearbox.net>
From:   Thomas-Mich Richter <tmricht@linux.ibm.com>
Organization: IBM
Date:   Fri, 27 Jul 2018 09:22:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <08b6ed57-40a4-7468-b78d-f2a2c5ab10a8@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18072707-4275-0000-0000-0000029F3AD9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072707-4276-0000-0000-000037A73D35
Message-Id: <325e3d58-89fb-1b50-8865-22c6f372671a@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807270075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/27/2018 04:16 AM, Daniel Borkmann wrote:
> On 07/26/2018 03:48 AM, Jakub Kicinski wrote:
>> On Wed, 25 Jul 2018 09:21:26 +0200, Thomas Richter wrote:
>>> commit a5b8bd47dcc57 ("bpf tools: Collect eBPF programs from their own sections")
>>
>> Hmm.. are you sure it's not 531b014e7a2f ("tools: bpf: make use of
>> reallocarray") that caused the issue?  That commit made us switch from
>> XSI-compliant to GNU-specific strerror_r() implementation..
>>
>> /me checks
>>
>> Yes it looks like 531b014e7a2f~ builds just fine.
>>
>> Daniel, did you try to apply v1 to the bpf tree?  Perhaps there is a
>> confusion about the trees here, if this is caused by my recent change
>> it's a bpf-next material.  strerror() works, but strerror_r() seems
>> nicer, so perhaps we could keep it if the patch worked in bpf-next?
> 
> Yeah indeed, the issue is only in bpf-next. When I compile libbpf from
> bpf tree with the below flags then it's all good> 
> Agree that we should rather use strerror_r() given this is a library.

Are you sure to stick with strerror_r? I ask because it is the only
occurence of strerror_r in this file. All other error messages use strerror
as in:
pr_warning("failed to create map (name: '%s'): %s\n",
                                   map->name,
                                   strerror(errno));


$ fgrep strerror tools/lib/bpf/libbpf.c
                                        strerror(errno));
          issue I try to solve--->  strerror_r(-err, errmsg, sizeof(errmsg));
                                   map->name, strerror(errno), errno);
                                   strerror(errno));
        pr_warning("load bpf program failed: %s\n", strerror(errno));
                pr_warning("failed to statfs %s: %s\n", dir, strerror(errno));
                pr_warning("failed to pin program: %s\n", strerror(errno));
                pr_warning("failed to mkdir %s: %s\n", path, strerror(-err));
                pr_warning("failed to pin map: %s\n", strerror(errno));
$

The next issue with strerror_r is to assign the return value to a variable.
Then we end up with variable set but not used:
libbpf.c: In function ‘bpf_object__elf_collect’:
libbpf.c:809:35: error: variable ‘cp’ set but not used [-Werror=unused-but-set-variable]
     char errmsg[STRERR_BUFSIZE], *cp;
                                   ^
cc1: all warnings being treated as errors
Here is the source:
                       if (err) {
                                char errmsg[STRERR_BUFSIZE], *cp;

                                cp = strerror_r(-err, errmsg, sizeof(errmsg));
                                pr_warning("failed to alloc program %s (%s): %s",
                                           name, obj->path, errmsg);
                        }

To fix this requires something like:
                               pr_warning("failed to alloc program %s (%s): %s",
                                           name, obj->path, cp);

And after pr_warning() is done, the local array errmsg is deleted.

A lot of overkill in my opinion, unless I miss something.


>>> causes a compiler error when building the perf tool in the linux-next tree.
>>> I compile it using a FEDORA 28 installation, my gcc compiler version:
>>> gcc (GCC) 8.0.1 20180324 (Red Hat 8.0.1-0.20)
>>>
>>> The file that causes the error is tools/lib/bpf/libbpf.c
>>>
>>> Here is the error message:
> [...]
>>> @@ -2334,7 +2331,7 @@ bpf_perf_event_read_simple(void *mem, unsigned long size,
>>>  	__u64 data_tail = header->data_tail;
>>>  	__u64 data_head = header->data_head;
>>>  	void *base, *begin, *end;
>>> -	int ret;
>>> +	int ret = 0;
>>>  
>>>  	asm volatile("" ::: "memory"); /* in real code it should be smp_rmb() */
>>>  	if (data_head == data_tail)
>>
>> This looks like a separate issue.  The ret variable should really be
>> enum bpf_perf_event_ret, so could you please initialize it to one of the
>> values of this enum?
>>
>> The uninitilized condition can only happen if (data_head != data_tail)
>> but at the same time (data_head % size == data_tail % size) which
>> should never really happen...  Perhaps initializing to
>> LIBBPF_PERF_EVENT_ERROR would make sense?
>>
>> Or better still adding:
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index f732237610e5..fa5a25945f19 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -2289,6 +2289,8 @@ bpf_perf_event_read_simple(void *mem, unsigned long size,
>>  
>>         begin = base + data_tail % size;
>>         end = base + data_head % size;
>> +       if (being == end)
>> +               return LIBBPF_PERF_EVENT_ERROR;
> 
> Sounds good to me.
> 

If you want I can send you a separate patch for this.


-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

