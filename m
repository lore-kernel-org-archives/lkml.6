Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
X-Google-Smtp-Source: AG47ELvln0mk4NthozWJ3OAo1f3XkN4iuLfdBoNPUOJ7taXxb28ZvRJo9Z1HqcOmB9iCuzwOMOpw
ARC-Seal: i=1; a=rsa-sha256; t=1521193232; cv=none;
        d=google.com; s=arc-20160816;
        b=DqlKTpixqNFaPNb39FmLUcW+6RLesXLJDKiBiZmUxic1Xrl86hPRzTYbzYnjOyw+AV
         Q1KUHhyw8Lm+YA8psur3B8aHDiDk5IfZ7rMAkPeAAdvBigNCJ2rJY78JTFHuUrrqqkuu
         5Zfja1bzFAF251BpfZT/WbZnaZ52uz2H73WQnCU//WvPdAiBpG6oC073tp2hpjRXljPN
         UYFxz5OjQ/0TXS9zCPIMm3uPzpB2yCHfU1ICY+6sTkbAepPsQdD+0Nxtu57Y8pjoPjAU
         i8KP6dHe3EGorOnyY3KLV47QGk1TbTSp45XMD7YwRHdLycitiDwMWxFc0eUgt3o0gAEo
         hfUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-language:content-transfer-encoding:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=Mv5MRJtXr3BwcCn/LDy77ZvB4yWaRjL+laF9AjSttvA=;
        b=Z+X3g8wwLMyI3v6kbimNo+xPTFBsz2GNRa81WOpnM862ytWDK7duOJli5wwIe7z2Pd
         Qd5IuLrn6A1Sv7DE9ZyNlP+h4qCVFDHi2t9E0+PG3j8DM4L60/oWDxQTmz5vmnf9zKDH
         EqQnZsKTQzKtGKkkLCFopbPL/vpxS1elxZgofndcqmZqEVPLuEV0cjszsCJ5EMdTD4Th
         sO8DlzSRk2p83UPklTh8n/fz0Obui6Ldz3RHoEibBR8O1F877ckiaE4Oh7TBQPTb4pkd
         EV/HkzF2FcxzLY9+9zvmgW9wpENnQhD5w3bgF0z+DSilR7GRcS1I5lad0fNLrd8ydggV
         chAw==
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
 <ec9c4ef7-0117-7c7c-64bc-f6bf4261721d@linux.vnet.ibm.com>
 <20180315214750.fc1d53d01045d8e6c1e8e491@kernel.org>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Fri, 16 Mar 2018 15:12:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315214750.fc1d53d01045d8e6c1e8e491@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18031609-0040-0000-0000-00000441DC30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031609-0041-0000-0000-000020E4E9EF
Message-Id: <e991f9e2-6488-7739-548d-6ca28c57826d@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-16_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803160116
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827212550255650?=
X-GMAIL-MSGID: =?utf-8?q?1595086715092861315?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/15/2018 06:17 PM, Masami Hiramatsu wrote:
> Hi Ravi,
>
> On Wed, 14 Mar 2018 20:52:59 +0530
> Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:
>
>> On 03/14/2018 07:20 PM, Masami Hiramatsu wrote:
>>> On Tue, 13 Mar 2018 18:26:03 +0530
>>> Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:
>>>
>>>> No functionality changes.
>>> Please consider to describe what is this change and why, here.
>> Will add in next version.
> Thanks, and could you also move this before perf-probe patch?
> Also Could you make perf-probe check the tracing/README whether
> the kernel supports reference counter syntax or not?
>
> perf-tool can be used on older (or stable) kernel.

Sure, Will do that.

Thanks,
Ravi
