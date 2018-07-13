Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F16ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B337208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:55:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B337208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731914AbeGMII7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 04:08:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55362 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729768AbeGMII7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 04:08:59 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6D7sLl5103274
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 03:55:29 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k6m5vqrsa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 03:55:29 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Fri, 13 Jul 2018 08:55:27 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 13 Jul 2018 08:55:21 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6D7tK3Z40960036
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Jul 2018 07:55:20 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CCA911C054;
        Fri, 13 Jul 2018 10:55:41 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04EBA11C05B;
        Fri, 13 Jul 2018 10:55:38 +0100 (BST)
Received: from [9.124.31.56] (unknown [9.124.31.56])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 13 Jul 2018 10:55:37 +0100 (BST)
Subject: Re: [PATCH v5 06/10] Uprobes: Support SDT markers having reference
 count (semaphore)
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, srikar@linux.vnet.ibm.com,
        rostedt@goodmis.org, mhiramat@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        open list <linux-kernel@vger.kernel.org>, corbet@lwn.net,
        linux-doc@vger.kernel.org, ananth@linux.vnet.ibm.com,
        alexis.berlemont@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
 <20180701210935.GA14404@redhat.com>
 <0c543791-f3b7-5a4b-f002-e1c76bb430c0@linux.ibm.com>
 <20180702180156.GA31400@redhat.com>
 <f19e3801-d56a-4e34-0acc-1040a071cf91@linux.ibm.com>
 <20180703163645.GA23144@redhat.com> <20180703172543.GC23144@redhat.com>
 <f5a39a88-c21e-4606-a04d-11b5f32016b8@linux.ibm.com>
 <20180710152527.GA3616@redhat.com>
 <6e3ff60b-267a-d49d-4ebb-c4264f9c034b@linux.ibm.com>
 <20180712145849.GB15265@redhat.com>
 <CAPhsuW6kCtn-tWSj5eKf+kGt8ZEjVwJKLxj9C6zdaqMZByRytg@mail.gmail.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Fri, 13 Jul 2018 13:25:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW6kCtn-tWSj5eKf+kGt8ZEjVwJKLxj9C6zdaqMZByRytg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18071307-0028-0000-0000-000002DB2B79
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071307-0029-0000-0000-00002392DB60
Message-Id: <9b062a19-d9a7-b360-26b1-d28b8dfc35a3@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-13_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807130054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Song,

On 07/13/2018 01:23 AM, Song Liu wrote:
> I guess I got to the party late. I found this thread after I started developing
> the same feature...
> 
> On Thu, Jul 12, 2018 at 7:58 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>> On 07/11, Ravi Bangoria wrote:
>>>
>>>> However, I still think it would be better to avoid uprobe exporting and modifying
>>>> set_swbp/set_orig_insn. May be we can simply kill both set_swbp() and set_orig_insn(),
>>>> I'll re-check...
>>>
>>> Good that you bring this up. Actually, we can implement same logic
>>> without exporting uprobe. We can do "uprobe = container_of(arch_uprobe)"
>>> in uprobe_write_opcode(). No need to export struct uprobe outside,
>>> no need to change set_swbp() / set_orig_insn() syntax. Just that we
>>> need to pass arch_uprobe object to uprobe_write_opcode().
>>
>> Yes, but you still need to modify set_swbp/set_orig_insn to pass the new
>> arg to uprobe_write_opcode(). OK, this is fine.
>>
>>
>>> But, I wanted to discuss about making ref_ctr_offset a uprobe property
>>> or a consumer property, before posting v6:
>>>
>>> If we make it a consumer property, the design becomes flexible for
>>> user. User will have an option to either depend on kernel to handle
>>> reference counter or he can create normal uprobe and manipulate
>>> reference counter on his own. This will not require any changes to
>>> existing tools. With this approach we need to increment / decrement
>>> reference counter for each consumer. But, because of the fact that our
>>> install_breakpoint() / remove_breakpoint() are not balanced, we have
>>> to keep track of which reference counter have been updated in which
>>> mm, for which uprobe and for which consumer. I.e. Maintain a list of
>>> {uprobe, consumer, mm}.
> 
> Is it possible to maintain balanced refcount by modifying callers of
> install_breakpoint() and remove_breakpoint()? I am actually working
> toward this direction. And I found some imbalance between
>      register_for_each_vma(uprobe, uc)
> and
>      register_for_each_vma(uprobe, NULL)
> 
> From reading the thread, I think there are other sources of imbalance.
> But I think it is still possible to fix it? Please let me know if this is not
> realistic...


I don't think so. It all depends on memory layout of the process, the
execution sequence of tracer vs target, how binary is loaded or how mmap()s
are called. To achieve a balance you need to change current uprobe
implementation. (I haven't explored to change current implementation because
I personally think there is no need to). Let me show you a simple example on
my Ubuntu 18.04 (powerpc vm) with upstream kernel:

-------------
  $ cat loop.c
    #include <stdio.h>
    #include <unistd.h>
    
    void foo(int i)
    {
            printf("Hi: %d\n", i);
            sleep(1);
    }
    
    void main()
    {
            int i;
            for (i = 0; i < 100; i++)
                    foo(i);
    }
  
  $ sudo ./perf probe -x ~/loop foo
  $ sudo ./perf probe install_breakpoint uprobe mm vaddr
  $ sudo ./perf probe remove_breakpoint uprobe mm vaddr
  
  term1~$ ./loop
  
  term2~$ sudo ./perf record -a -e probe:* -o perf.data.kprobe
  
  term3~$ sudo ./perf record -a -e probe_loop:foo
          ^C
  
  term2~$ ...
          ^C[ perf record: Woken up 1 times to write data ]
          [ perf record: Captured and wrote 0.217 MB perf.data.probe (10 samples) ]
  
  term2~$ sudo ./perf script -i perf.data.kprobe
    probe:install_breakpoint: (c00000000032e4e8) uprobe=0xc0000000a40d0e00 mm=0xc0000000b5072900 vaddr=0x1108e0844
    probe:install_breakpoint: (c00000000032e4e8) uprobe=0xc0000000a40d0e00 mm=0xc0000000b5072900 vaddr=0x1108d0844
    probe:install_breakpoint: (c00000000032e4e8) uprobe=0xc0000000a40d0e00 mm=0xc0000000b5055500 vaddr=0x7fffa2620844
    probe:install_breakpoint: (c00000000032e4e8) uprobe=0xc0000000a40d0e00 mm=0xc0000000b5055500 vaddr=0x7fffa2620844
     probe:remove_breakpoint: (c00000000032e938) uprobe=0xc0000000a40d0e00 mm=0xc0000000b5072900 vaddr=0x1108e0844
     probe:remove_breakpoint: (c00000000032e938) uprobe=0xc0000000a40d0e00 mm=0xc0000000b5072900 vaddr=0x1108d0844
     probe:remove_breakpoint: (c00000000032e938) uprobe=0xc0000000a40d0e00 mm=0xc0000000b5072900 vaddr=0x1108d0844
     probe:remove_breakpoint: (c00000000032e938) uprobe=0xc0000000a40d0e00 mm=0xc0000000b5072900 vaddr=0x1108e0844
     probe:remove_breakpoint: (c00000000032e938) uprobe=0xc0000000a40d0e00 mm=0xc0000000b5072900 vaddr=0x1108e0844
     probe:remove_breakpoint: (c00000000032e938) uprobe=0xc0000000a40d0e00 mm=0xc0000000b5072900 vaddr=0x1108d0844
-------------

Here install_breakpoint() for our target (mm: 0xc0000000b5072900) was
called 2 times where as remove_breakpoint() was called 6 times.

Because, there is an imbalance, and if you make reference counter a
consumer property, you have two options. Either you have to fix
current uprobe infrastructure to solve this imbalance. Or maintain
a list of already updated counter as I've explained(in reply to Oleg).

Now,

  uprobe_register()
    register_for_each_vma()
      install_breakpoint()

gets called for each consumer, but

  uprobe_mmap()
    install_breakpoint()

gets called only once. Now, if you make ref_ctr_offset a consumer
property, you have to increment reference counter for each consumer
in case of uprobe_mmap(). Also, you have to make sure you update
reference counter only once for each consumer because install/
remove_breakpoint() are not balanced. Now, what if reference
counter increment fails for any one consumer? You have to rollback
already updated ones, which brings more complication.

Now, other complication is, generally vma holding reference counter
won't be present when install_breakpoint() gets called from
uprobe_mmap(). I've introduced delayed_uprobes for this. This is
anyway needed with any approach.

The only advantage I was seeing by making reference counter a
consumer property was a user flexibility to update reference counter
on his own. But I've already proposed a solution for that.

So, I personally don't suggest to make ref_ctr_offset a consumer
property because I, again personally, don't think it's a consumer
property.

Please feel free to say if this all looks crap to you :)


> 
> 
> About race conditions, I think both install_breakpoint() and remove_breakpoint()
> are called with
> 
>    down_write(&mm->mmap_sem);
> 


No. Not about updating in one mm. I meant, races in maintaining
all complication I've mentioned above.


> 
> As long as we do the same when modifying the reference counter,
> it should be fine, right?
> 
> Wait... sometimes we only down_read(). Is this by design?


Didn't get this.

Thanks,
Ravi

