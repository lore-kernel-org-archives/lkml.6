Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
X-Google-Smtp-Source: AG47ELvVB+sqjDQOZ1rOWl1jM+lHXptUjGecS2GYD5GCCTee+YZ6A7yV6MZ4qXGvgbUotc2rFrjw
ARC-Seal: i=1; a=rsa-sha256; t=1521040861; cv=none;
        d=google.com; s=arc-20160816;
        b=z1yku1e6cgKzv0ZvKEE+NIYYTk+nltGjIcHWMD99jg9Bj268KRYPjqrmcqY9JP/DSI
         61YjV2yCyNguf7kCjJRQsW5U6KnTOduZBdimD3XEGNhQUklwfrBHy2YisjZZkwlsna2J
         or2KqPnCb3OY777f9mHl0hWrJ/tE7P2z1/Xgt2kDnVtyo2PgNxygVCKaOCBGhXQQ6EXz
         jTaYSN64qUgsj5PwrW+7ZDYusvpbNnQOFQcCMfuQ/sFHXQaIf0JNFvzqVPRgBJKTlbZR
         8geyCXGx2JvISwgRl0+G61aCsy5Ck56rjDsqBuQOP8hj5Pt1uyysCG2/qgXvuIXjBuHo
         QifQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-language:content-transfer-encoding:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=VQ2mKYqGhiOaBRZ6y2iqI6Ybw4RZbRw2ubzL9s7VMwQ=;
        b=lzhh24GwbCjegmMfSyQzmZtiUcif6DxT58l38MYECAjlcCUvIi+rVkzFkqIazoLtIl
         MatMhavnrQx4E5yIbyInWAVgdGnZWHrfnCPjfuFCs0QTkEuaPWbbOqyX1vzdiK2jD+n4
         g0S+dna9tPykoBQrx8swsDpF2oOgrov2+zwHAP/4ngnnAFO5x2RXayiO5M7LHb9Dbn0/
         PdN2AoT7u4P8k1yTBuYAGjmYukghhSE4yrRsUAuGKjNBqhpqQ42ootqRSgAqBWAHtMIp
         QrCb2IOE0KlY6yofJySgGnzpbgC0raFMyDzI5shRP5PmZYRZbaR/tXsHATY/oW1G9Tl2
         ZcYw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH 8/8] trace_uprobe/sdt: Document about reference counter
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
 <20180313125603.19819-9-ravi.bangoria@linux.vnet.ibm.com>
 <20180314225021.64109239de8b14b0aec1e1c5@kernel.org>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Wed, 14 Mar 2018 20:52:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314225021.64109239de8b14b0aec1e1c5@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18031415-0020-0000-0000-000004046E9A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031415-0021-0000-0000-000042987334
Message-Id: <ec9c4ef7-0117-7c7c-64bc-f6bf4261721d@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-14_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803140171
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827212550255650?=
X-GMAIL-MSGID: =?utf-8?q?1594926941775099489?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/14/2018 07:20 PM, Masami Hiramatsu wrote:
> On Tue, 13 Mar 2018 18:26:03 +0530
> Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:
>
>> No functionality changes.
> Please consider to describe what is this change and why, here.

Will add in next version.

>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
>> ---
>>  Documentation/trace/uprobetracer.txt | 16 +++++++++++++---
>>  kernel/trace/trace.c                 |  2 +-
>>  2 files changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/trace/uprobetracer.txt b/Documentation/trace/uprobetracer.txt
>> index bf526a7c..8fb13b0 100644
>> --- a/Documentation/trace/uprobetracer.txt
>> +++ b/Documentation/trace/uprobetracer.txt
>> @@ -19,15 +19,25 @@ user to calculate the offset of the probepoint in the object.
>>  
>>  Synopsis of uprobe_tracer
>>  -------------------------
>> -  p[:[GRP/]EVENT] PATH:OFFSET [FETCHARGS] : Set a uprobe
>> -  r[:[GRP/]EVENT] PATH:OFFSET [FETCHARGS] : Set a return uprobe (uretprobe)
>> -  -:[GRP/]EVENT                           : Clear uprobe or uretprobe event
>> +  p[:[GRP/]EVENT] PATH:OFFSET[(REF_CTR_OFFSET)] [FETCHARGS]
>> +  r[:[GRP/]EVENT] PATH:OFFSET[(REF_CTR_OFFSET)] [FETCHARGS]
> Ah, OK in this context, [] means optional syntax :)

Correct.

Thanks,
Ravi
