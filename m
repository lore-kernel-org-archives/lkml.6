Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751476AbeEVLpG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 07:45:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34628 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751302AbeEVLpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 07:45:03 -0400
Subject: Re: [PATCH v11 01/26] mm: introduce CONFIG_SPECULATIVE_PAGE_FAULT
To: Matthew Wilcox <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, peterz@infradead.org,
        kirill@shutemov.name, ak@linux.intel.com, dave@stgolabs.net,
        jack@suse.cz, khandual@linux.vnet.ibm.com,
        aneesh.kumar@linux.vnet.ibm.com, benh@kernel.crashing.org,
        mpe@ellerman.id.au, paulus@samba.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        sergey.senozhatsky.work@gmail.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Ganesh Mahendran <opensource.ganesh@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Punit Agrawal <punitagrawal@gmail.com>,
        vinayak menon <vinayakm.list@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, haren@linux.vnet.ibm.com, npiggin@gmail.com,
        bsingharora@gmail.com, paulmck@linux.vnet.ibm.com,
        Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org
References: <1526555193-7242-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1526555193-7242-2-git-send-email-ldufour@linux.vnet.ibm.com>
 <2cb8256d-5822-d94d-b0e6-c46f21d84852@infradead.org>
 <20180517171951.GB26718@bombadil.infradead.org>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Tue, 22 May 2018 13:44:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180517171951.GB26718@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18052211-0012-0000-0000-000005D94011
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052211-0013-0000-0000-0000195683E2
Message-Id: <9a95bb6b-78cb-52a6-9c3a-4869f7cdb079@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-22_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805220138
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2018 19:19, Matthew Wilcox wrote:
> On Thu, May 17, 2018 at 09:36:00AM -0700, Randy Dunlap wrote:
>>> +	 If the speculative page fault fails because of a concurrency is
>>
>> 	                                     because a concurrency is
> 
> While one can use concurrency as a noun, it sounds archaic to me.  I'd
> rather:
> 
> 	If the speculative page fault fails because a concurrent modification
> 	is detected or because underlying PMD or PTE tables are not yet

Thanks Matthew, I'll do that.

> 
>>> +	 detected or because underlying PMD or PTE tables are not yet
>>> +	 allocating, it is failing its processing and a classic page fault
>>
>> 	 allocated, the speculative page fault fails and a classic page fault
>>
>>> +	 is then tried.
> 
