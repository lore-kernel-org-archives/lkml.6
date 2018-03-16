Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
X-Google-Smtp-Source: AG47ELvH4nauM0Dw26oVlL+6HhoqdX9Pijj5bfFterRhjs3PSwGJn2UR03rYGueMMBhoqEuJPR/S
ARC-Seal: i=1; a=rsa-sha256; t=1521190793; cv=none;
        d=google.com; s=arc-20160816;
        b=XJaUV1sABe/AplG9v74Psw5EcYvsrqVK+UvhfrBCgXpdKsAAHXTa+X+GHtJFNuSmLm
         exMO5Hbv9gQfFJu1j5baELUv9htE4Fk/sRvHulb4BK9wul5flyBInhnn9oxEO+i7a0/j
         jlOufWlduXBmPD+vG5IwxRytXysaQbKWHklaNpNKWduI18PXsP5Tbf9MurNe0xNtKkJS
         jEDkUjZrVfjniFmW1tf8GqWomMeiz/+04j7Vq2uGsdIxsrlRGUyEaH00vBfPhrQyQnm2
         HCMjsIxevXKhshETu9/bD8yLFn5nevLr9Yoez26CXNUB8H5xzu8m0XdRHTYvPrBJNRkY
         98CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-language:content-transfer-encoding:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=yvQz998w4Xj3kW9iUe4EvAT6qWpbPTtDlN1OfNnhIpA=;
        b=gjKltaOtT7IiVf+yoNxcT8NuSMiA/dJI9c8PtrYmcLDxaEHvEG/0KKB/wjtBxvPv0l
         JB9ooT0lgt4cZ/SbkwM6xG9QuXx3OvXV7Y3VUyamGndhmXdt38tlQfwyYDXaNtUNBBz4
         DQ4QmUy1Wung4Zbcy0CYFVX4/xfAtungFKMvC9+apMphTu3nOCjJZK6C7+Gs+SzITrtD
         dV5HH3M1/LxDQN+FCBwtYBJtwuiC1H5z5Nyb4ZESpETx80YfHFyFbQ5KfKFn3lvNOC8o
         XkJqi5iyiax8pOVEyYpUQb8gp8z19Rq48+4t9UAZBS6hS1V4mYLHhEA1vGulDYCDkLx6
         c5bw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH 5/8] trace_uprobe: Support SDT markers having reference
 count (semaphore)
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
 <20180313125603.19819-6-ravi.bangoria@linux.vnet.ibm.com>
 <20180315124816.6aa3d4e2@vmware.local.home>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Fri, 16 Mar 2018 14:31:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315124816.6aa3d4e2@vmware.local.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18031608-0040-0000-0000-00000421D604
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031608-0041-0000-0000-00002624E218
Message-Id: <90b06fcf-e041-a0c0-d034-69f64d3eca36@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-16_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803160111
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827101403620100?=
X-GMAIL-MSGID: =?utf-8?q?1595084157504966026?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/15/2018 10:18 PM, Steven Rostedt wrote:
> On Tue, 13 Mar 2018 18:26:00 +0530
> Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:
>
>> +static void sdt_increment_ref_ctr(struct trace_uprobe *tu)
>> +{
>> +	struct uprobe_map_info *info;
>> +	struct vm_area_struct *vma;
>> +	unsigned long vaddr;
>> +
>> +	uprobe_start_dup_mmap();
> Please add a comment here that this function ups the mm ref count for
> each info returned. Otherwise it's hard to know what that mmput() below
> matches.

Sure. Will add it.

Thanks for the review,
Ravi
