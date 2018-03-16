Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
X-Google-Smtp-Source: AG47ELtDpSzNgzlysQ3SIqcev5Dh9ILEAgJQPQtwCJTBKWLnoO30ZWv9mk1I7mAUTqrOWqdMv2OT
ARC-Seal: i=1; a=rsa-sha256; t=1521200685; cv=none;
        d=google.com; s=arc-20160816;
        b=ohUZ434nmxSnP9dZZ7zD4ojmcpaTysw22SMnbboEDyTQXFAw9xcdgWPsVj4j5AnuXD
         poKIxPLqGaCZW6NyAlE56BvLtY9P36efqXwiW6AZD7PTeLW7c/D3QdmDDFC8blCYEIgq
         Qec3QZIE0peGLPgKN8Mw9VUwCejmoOCPNAuwwpk4r5gFBJMw6+IMbgXqnTDYrEc8Shgm
         Pec28Zmw+SB8lbo8gQfH6mXaCG1LMASpQl4Lqbt0XNmjAbIJC1MIsBR5XCVwWrxuMrig
         5HVdb57j3j/bhDOli8vSK+HqSy9r6Hg0m3EMhTwiBQ1t2ymU8hHe7OKKm50z8xt+0tMT
         5ThQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-language:content-transfer-encoding:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=mj16SVehscUWHOIgXnLqCeNyZD0YbJvzqVtsijwaKQ4=;
        b=OzWVU1jqXk/iNUt7aYhbsr1QFbKn7TyRj17m3FL9jPm/wOXafbYIMzRYIVNADrIVzF
         ymDXjcKrf216B3QcgxWlnHzN7Mu8ZDnGnCSlIPPbGAPFEjNgbXmK/I1q4zgqaQfibjlF
         3sdwoj2+3TQv1O+GbjoQFWAwSSj49GWOl97IUhnV7U9d8scSjsJ3OTp2VLDVZZMvPdHH
         zKOHFK7B+g4ikYzzhCye5RogVx53V/M96zDoTU2OTiXWNb4exS2iI33boOZjTEGT1vV4
         VwpkcGUP3URCpdJGGc9Yk+Cupvv7G7AT8YclCzUpUOiza4HopObOmqEOBphkS/dCeznx
         gCvg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH 5/8] trace_uprobe: Support SDT markers having reference
 count (semaphore)
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
 <20180313125603.19819-6-ravi.bangoria@linux.vnet.ibm.com>
 <20180315142120.GA19218@redhat.com> <20180315143044.GA19643@redhat.com>
 <3b303a2d-35dd-9178-fc03-de9f2d588797@linux.vnet.ibm.com>
 <20180316113917.GA21303@redhat.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Fri, 16 Mar 2018 17:16:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316113917.GA21303@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18031611-0012-0000-0000-000005BFE71C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031611-0013-0000-0000-0000193BF526
Message-Id: <663244e6-2de0-48bb-08d1-fbc66b3c736b@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-16_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803160142
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827101403620100?=
X-GMAIL-MSGID: =?utf-8?q?1595094529597442043?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/16/2018 05:09 PM, Oleg Nesterov wrote:
> On 03/16, Ravi Bangoria wrote:
>> On 03/15/2018 08:00 PM, Oleg Nesterov wrote:
>>> Note to mention that sdt_find_vma() can return NULL but the callers do
>>> vma_offset_to_vaddr(vma) without any check.
>> If the "mm" we are passing to sdt_find_vma() is returned by
>> uprobe_build_map_info(ref_ctr_offset), sdt_find_vma() must
>> _not_ return NULL.
> Not at all.
>
> Once build_map_info() returns any mapping can go away. Otherwise, why do
> you think the caller has to take ->mmap_sem and use find_vma()? If you
> were right, build_map_info() could just return the list of vma's instead
> of list of mm's.

Oh.. okay.. I was under wrong impression then. Will add a check there.

Thanks for the review :)
Ravi
