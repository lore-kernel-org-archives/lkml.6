Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
X-Google-Smtp-Source: AG47ELuCZ8B0KcpoxPUYG27y7g7pu8S6PHmhAMAaNchJQNeJb38Blk2GhWl0twGL6qvjVEdjaxax
ARC-Seal: i=1; a=rsa-sha256; t=1521208056; cv=none;
        d=google.com; s=arc-20160816;
        b=Vos7F0LihHKwhfxDWrfPJGkkcI9B4BHqix0RU8TYRFnOKX+u8aJJtnUQFrgdQEfeDi
         Oqd1hgDHA/w1q3pJKdio7jOjkkrXDZkcZnCPImWntQzBHfAuzyaQbCN+M3spdVqqHH8+
         3WBQLOkuN4F7zxz9U51g1b8s4mj1WjEI6ulI36JgGz8tOBgCNV3iPVJyepZtnN6dlFRE
         Qj88aBnFlaC5FeZ2IEX/SkpN0Rvvy+elUF4KeLR9ttcM6PxM2GqoiVn0E+9pvU/e11T+
         dR6tdr+qShAwPPGYEq1MnKbuY6WOuXoWkbJCGVkxXWyUDS17eq9xeTt9b57o5HYsQtSe
         ZOfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-language:content-transfer-encoding:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=SqskjiqSk67h9ehOVswLKs1v94q8UwAa0pn6i0kxPJM=;
        b=EkUdsdD2NCQkT60IV6NN38T5FztjjI8kobkrXVl0ETyN2ByPE1s0GhnPbTtOQKpUt/
         /7R0WtYyHaJl3YBWEKtLCR9GO179tZbrqlY2PIi5eguvtPf21dy+Spy5OMuGB0rhQwPo
         pgug4atL+b4yJ5GXDJPkLWEg7JvmNyyucmh7bDLAhoJFRRs6GI1XpRI5FJImNcmiuZod
         q9YAWUY6ohG18SoeSV/CqK/sDeVBHStKSyfAN+KXL11PZws/ihu55UmolpaQu7B+5eRW
         pCgIPjoaoJ+aMUd+Zvmhk80QGndFlLDs8Z0wGsAtxhBVRuJvSy5r0sn7Z+rDZ3yXU/8x
         pc2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH 6/8] trace_uprobe/sdt: Fix multiple update of same
 reference counter
To: Oleg Nesterov <oleg@redhat.com>
Cc: mhiramat@kernel.org, peterz@infradead.org, srikar@linux.vnet.ibm.com,
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
 <20180315144959.GB19643@redhat.com>
 <c93216a4-a4e1-dd8f-00be-17254e308cd1@linux.vnet.ibm.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Fri, 16 Mar 2018 19:19:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <c93216a4-a4e1-dd8f-00be-17254e308cd1@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18031613-0008-0000-0000-000004DEF76B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031613-0009-0000-0000-00001E72061F
Message-Id: <20efff94-de74-dcbe-68e4-a72476fab209@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-16_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803160167
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827186487084438?=
X-GMAIL-MSGID: =?utf-8?q?1595102259316690404?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/16/2018 05:42 PM, Ravi Bangoria wrote:
>
> On 03/15/2018 08:19 PM, Oleg Nesterov wrote:
>> On 03/13, Ravi Bangoria wrote:
>>> For tiny binaries/libraries, different mmap regions points to the
>>> same file portion. In such cases, we may increment reference counter
>>> multiple times.
>> Yes,
>>
>>> But while de-registration, reference counter will get
>>> decremented only by once
>> could you explain why this happens? sdt_increment_ref_ctr() and
>> sdt_decrement_ref_ctr() look symmetrical, _decrement_ should see
>> the same mappings?
> Sorry, I thought this happens only for tiny binaries. But that is not the case.
> This happens for binary / library of any length.
>
> Also, it's not a problem with sdt_increment_ref_ctr() / sdt_increment_ref_ctr().
> The problem happens with trace_uprobe_mmap_callback().
>
> To illustrate in detail, I'm adding a pr_info() in trace_uprobe_mmap_callback():
>
>                 vaddr = vma_offset_to_vaddr(vma, tu->ref_ctr_offset);
> +             pr_info("0x%lx-0x%lx : 0x%lx\n", vma->vm_start, vma->vm_end, vaddr);
>                 sdt_update_ref_ctr(vma->vm_mm, vaddr, 1);
>
>
> Ok now, libpython has SDT markers with reference counter:
>
>     # readelf -n /usr/lib64/libpython2.7.so.1.0 | grep -A2 Provider
>         Provider: python
>         Name: function__entry
>         ... Semaphore: 0x00000000002899d8
>
> Probing on that marker:
>
>     # cd /sys/kernel/debug/tracing/
>     # echo "p:sdt_python/function__entry /usr/lib64/libpython2.7.so.1.0:0x16a4d4(0x2799d8)" > uprobe_events
>     # echo 1 > events/sdt_python/function__entry/enable
>
> When I run python:
>
>     # strace -o out python
>       mmap(NULL, 2738968, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7fff92460000
>       mmap(0x7fff926a0000, 327680, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x230000) = 0x7fff926a0000
>       mprotect(0x7fff926a0000, 65536, PROT_READ) = 0
>
> The first mmap() maps the whole library into one region. Second mmap()
> and third mprotect() split out the whole region into smaller vmas and sets
> appropriate protection flags.
>
> Now, in this case, trace_uprobe_mmap_callback() updates reference counter
> twice -- by second mmap() call and by third mprotect() call -- because both
> regions contain reference counter offset. This I can verify in dmesg:
>
>     # dmesg | tail
>       trace_kprobe: 0x7fff926a0000-0x7fff926f0000 : 0x7fff926e99d8
>       trace_kprobe: 0x7fff926b0000-0x7fff926f0000 : 0x7fff926e99d8
>
> Final vmas of libpython:
>
>     # cat /proc/`pgrep python`/maps | grep libpython
>       7fff92460000-7fff926a0000 r-xp 00000000 08:05 403934  /usr/lib64/libpython2.7.so.1.0
>       7fff926a0000-7fff926b0000 r--p 00230000 08:05 403934  /usr/lib64/libpython2.7.so.1.0
>       7fff926b0000-7fff926f0000 rw-p 00240000 08:05 403934  /usr/lib64/libpython2.7.so.1.0
>
>
> I see similar problem with normal binary as well. I'm using Brendan Gregg's
> example[1]:
>
>     # readelf -n /tmp/tick | grep -A2 Provider
>         Provider: tick
>         Name: loop2
>         ... Semaphore: 0x000000001005003c
>
> Probing that marker:
>
>     # echo "p:sdt_tick/loop2 /tmp/tick:0x6e4(0x10036)" > uprobe_events
>     # echo 1 > events/sdt_tick/loop2/enable
>
> Now when I run the binary
>
>     # /tmp/tick
>
> load_elf_binary() internally calls mmap() and I see trace_uprobe_mmap_callback()
> updating reference counter twice:
>
>     # dmesg | tail
>       trace_kprobe: 0x10010000-0x10030000 : 0x10020036
>       trace_kprobe: 0x10020000-0x10030000 : 0x10020036
>
> proc/<pid>/maps of the tick:
>
>     # cat /proc/`pgrep tick`/maps
>       10000000-10010000 r-xp 00000000 08:05 1335712  /tmp/tick
>       10010000-10020000 r--p 00000000 08:05 1335712  /tmp/tick
>       10020000-10030000 rw-p 00010000 08:05 1335712  /tmp/tick
>
> [1] https://github.com/iovisor/bcc/issues/327#issuecomment-200576506

Also, while de-registration, we look for all existing mms using
uprobe_build_mmap_info() and decrement the counter in each
of the mm. i.e. we decrement the counter only once.

-Ravi
