Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
X-Google-Smtp-Source: AG47ELt+bNSCG/EzWNkMH+v7kMaUj1iKp+J23QgA0WgOdnT39CbqzJuSK8AHW2Z/gNa6fIIEfOBK
ARC-Seal: i=1; a=rsa-sha256; t=1521450984; cv=none;
        d=google.com; s=arc-20160816;
        b=krNnHKq/rJI/CnvIJNIyRFpAYgqGiIpooflz12MXOsPsJ6iRTX4YDmjxcYoKDeCNoB
         Yeh6Bx4HZNw49anxejbo/jAMR0lrP60BYqfPdLZISU9DDn65UCoX2OJdsUq+4YQd4sJj
         TbEXh9iTXeWFbtLvWZlCZeroWdyFpOevCtmnwg75Pv5iZzj1Gjs36peNTiQ3TEQCCyis
         qKUltMgsqUEI5V5FGH3022DXWKLIGGT9atEoIeSYlr8mvWHlI0u2AAyLCmF6a29tl01A
         HCqcb5Ga/rtbdXqe/hBdIm0lC7akNZLAr7bjQXBFRwvj+oCIuVJe2DaK2Q8n98tG33/y
         iFQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-language:content-transfer-encoding:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=QVcPoatk5YOfEgWQu8uUkz9O/VMUlZwFK2l/dsQdQLg=;
        b=gdaYqgq9YaB7elBzhtVmUiw36dHd9FH+eUdJowIOrtIosazNad7kvxMLx6K+q2n1kd
         7u5hIo/BMMXwJZU0mVgXiL651flANdjeJVovzj3hhnF33+Aqg48zJ/4kXaCz03KycMU6
         jDprr5IC2NZICJ4SGvegUnm+5Lkmx8GergI2INMK9PF/KYQVQAykhaas87jieHBfHhP8
         oZ+k7h3ZbcY2NLpAnc2qWrpzicbOobCs9twKpYSHyThZ/+po6FDbEMgYIaCqA2hy9xVM
         GeRr1BDVu7ThIRtELM32LlIB5AQotEHw3UFUCcAWjIEWGqSHjjHwRtOiZuVHjWp/2cAn
         nXLw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
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
 <20180316175030.GA28770@redhat.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Mon, 19 Mar 2018 14:48:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316175030.GA28770@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18031909-0008-0000-0000-000004DFBFEA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031909-0009-0000-0000-00001E72D62E
Message-Id: <4b337afd-fc5e-6110-888b-d4fa36a797ee@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-19_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803190113
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827186487084438?=
X-GMAIL-MSGID: =?utf-8?q?1595356987498140350?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Oleg,

On 03/16/2018 11:20 PM, Oleg Nesterov wrote:
> On 03/16, Ravi Bangoria wrote:
>> On 03/15/2018 08:19 PM, Oleg Nesterov wrote:
>>> On 03/13, Ravi Bangoria wrote:
>>>> For tiny binaries/libraries, different mmap regions points to the
>>>> same file portion. In such cases, we may increment reference counter
>>>> multiple times.
>>> Yes,
>>>
>>>> But while de-registration, reference counter will get
>>>> decremented only by once
>>> could you explain why this happens? sdt_increment_ref_ctr() and
>>> sdt_decrement_ref_ctr() look symmetrical, _decrement_ should see
>>> the same mappings?
> ...
>
>>     # strace -o out python
>>       mmap(NULL, 2738968, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7fff92460000
>>       mmap(0x7fff926a0000, 327680, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x230000) = 0x7fff926a0000
>>       mprotect(0x7fff926a0000, 65536, PROT_READ) = 0
> Ah, in this case everything is clear, thanks.
>
> I was confused by the changelog, I misinterpreted it as if inc/dec are not
> balanced in case of multiple mappings even if the application doesn't play
> with mmap/mprotect/etc.
>
> And it seems that you are trying to confuse yourself, not only me ;) Just
> suppose that an application does mmap+munmap in a loop and the mapped region
> contains uprobe but not the counter.

this is fine because ...

>
> And this all makes me think that we should do something else. Ideally,
> install_breakpoint() and remove_breakpoint() should inc/dec the counter
> if they do not fail...

The whole point of adding this logic in trace_uprobe is we wanted to
decouple the counter inc/dec logic from uprobe patching. If user is just
doing mmap+munmap region in a loop which contains uprobe, the
instruction will be patched by the core uprobe infrastructure. Whenever
application mmap the region that holds to counter, it will be incremented.

Our initial design was to increment counter in install_breakpoint() but
uprobed instruction gets patched in a very early stage of binary loading
and vma that holds the counter may not be mapped yet.

>
> Btw, why do we need a counter, not a boolean? Who else can modify it?
> Or different uprobes can share the same counter?

Yes, multiple SDT markers can share the counter. Ex, there can be multiple
implementation of same function and thus each individual implementation
may contain marker which share the same counter. From mysql,

  # readelf -n /usr/lib64/mysql/libmysqlclient.so.18.0.0 | grep -A2 Provider
    Provider: mysql
    Name: net__write__start
    Location: 0x000000000003caa0, ..., Semaphore: 0x0000000000333532
  --
    Provider: mysql
    Name: net__write__start
    Location: 0x000000000003cd5c, ..., Semaphore: 0x0000000000333532

Here, both the markers has same name, but different location. Also they
share the counter (semaphore).

Apart from that, counter allows multiple tracers to trace on a single marker,
which is difficult with boolean flag.

Thanks,
Ravi
