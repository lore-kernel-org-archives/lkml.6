Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
X-Google-Smtp-Source: AG47ELur/tgA2powRlVZVBHaIdfKY/nzh7H/lSCPjvRZKsMdtQzie1bmiTS0rRlmHxC4FqrrIkEf
ARC-Seal: i=1; a=rsa-sha256; t=1521190569; cv=none;
        d=google.com; s=arc-20160816;
        b=iEi8q68/yyS2Tlf6W0D8elcOzWw0+RrnW5DaA74ULUL87asxIoK7edjxx5BBhhjSb3
         5dkS3RwJDvnZrEbDfunTIcDSv4J0qPMda9LJC5Clgg/DK3XHd1ymfZInkJhjtaq/nOfT
         c26lfpk9n/GqKQMrFdvDVk6D/psSd/Ai25oTZoWze9xLdfKIJ1beGzxtWOdmQqrAlYc0
         PbYyPBr9w8CpcQ6wA17f+htrTKlG9gXJUE1a6YaNZo+Rzxki2yRk6SOWgkVV4+kriCUe
         V0cmeF1LW6cIZzZufExzunIX++HZRqodGWBjBatT5CmdlmcvP4sfrRiu+CWkLDbiMIvc
         4Ujg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-language:content-transfer-encoding:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=uhfmMcGZMvVdRq9HGxKi21h3Kp7by5wmdIQPPzYbpf8=;
        b=nVbPtwiF/m301rpGXI6xJwXltNnhkIWozKU/ujl+b2TSJb1ENQYV5bOez70Z3TOtrx
         jeEpXmdad/3WAmm4/3SdO+aHzJl2TzifYviWn0uEYdX8ScSbHG8sAOOyH4ImBs3JTR4w
         PDJ9NqGV27V3R/1NQhc77aIVsLNTtdyBvs4Pl4Siun5+LDaD+NWJ0BdAkA1uYlvFtRnC
         PDrrZyJiertNQn0hQKknSgB7KsXi/A9I5MGFNMbuLJ+0t/Esw4h63+0In792NSMsB8wF
         Tkab/MDj6XPUEwOKfNzdpfPQJUr8c7XkkjVKWk6TnD0982F+K8wovQOp4FzjiJH2A5L6
         DhwQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH 2/8] mm: Prefix vma_ to vaddr_to_offset() and
 offset_to_vaddr()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
        srikar@linux.vnet.ibm.com, acme@kernel.org, ananth@linux.vnet.ibm.com,
        akpm@linux-foundation.org, alexander.shishkin@linux.intel.com,
        alexis.berlemont@gmail.com, corbet@lwn.net, dan.j.williams@intel.com,
        gregkh@linuxfoundation.org, huawei.libin@huawei.com, hughd@google.com,
        jack@suse.cz, jglisse@redhat.com, jolsa@redhat.com,
        kan.liang@intel.com, kirill.shutemov@linux.intel.com,
        kjlx@templeofstupid.com, kstewart@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@suse.com, milian.wolff@kdab.com,
        mingo@redhat.com, namhyung@kernel.org, naveen.n.rao@linux.vnet.ibm.com,
        pc@us.ibm.com, pombredanne@nexb.com, tglx@linutronix.de,
        tmricht@linux.vnet.ibm.com, willy@infradead.org,
        yao.jin@linux.intel.com, fengguang.wu@intel.com,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
References: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180313125603.19819-3-ravi.bangoria@linux.vnet.ibm.com>
 <20180315122840.02ac36ec@vmware.local.home>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Fri, 16 Mar 2018 14:28:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315122840.02ac36ec@vmware.local.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18031608-0008-0000-0000-000004DED6FC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031608-0009-0000-0000-00001E71E44F
Message-Id: <6086d463-abdd-0c72-7e3c-3ea31ce52766@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-16_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803160110
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827168615885864?=
X-GMAIL-MSGID: =?utf-8?q?1595083922042604754?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/15/2018 09:58 PM, Steven Rostedt wrote:
> On Tue, 13 Mar 2018 18:25:57 +0530
> Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:
>
>> No functionality changes.
> Again, please add an explanation to why this patch is done.

Sure. Will add.

Thanks for the review,
Ravi

> -- Steve
>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
