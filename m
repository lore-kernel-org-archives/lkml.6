Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752446AbeDLNov (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 09:44:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36482 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751819AbeDLNou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 09:44:50 -0400
Subject: Re: [PATCH v9 21/24] perf tools: Add support for the SPF perf event
To: David Rientjes <rientjes@google.com>, Andi Kleen <ak@linux.intel.com>
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
        akpm@linux-foundation.org, kirill@shutemov.name, mhocko@kernel.org,
        dave@stgolabs.net, jack@suse.cz, Matthew Wilcox <willy@infradead.org>,
        benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
        sergey.senozhatsky.work@gmail.com,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
        npiggin@gmail.com, bsingharora@gmail.com,
        Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org
References: <1520963994-28477-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1520963994-28477-22-git-send-email-ldufour@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1803261443560.255554@chino.kir.corp.google.com>
 <20180327034936.GO13724@tassilo.jf.intel.com>
 <alpine.DEB.2.21.1804092346090.225864@chino.kir.corp.google.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Thu, 12 Apr 2018 15:44:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1804092346090.225864@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18041213-0044-0000-0000-000005468050
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041213-0045-0000-0000-00002886BBAE
Message-Id: <de5f854b-fd39-21e1-1ce9-1c5c2d292eb8@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-12_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804120136
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2018 08:47, David Rientjes wrote:
> On Mon, 26 Mar 2018, Andi Kleen wrote:
> 
>>> Aside: should there be a new spec_flt field for struct task_struct that 
>>> complements maj_flt and min_flt and be exported through /proc/pid/stat?
>>
>> No. task_struct is already too bloated. If you need per process tracking 
>> you can always get it through trace points.
>>
> 
> Hi Andi,
> 
> We have
> 
> 	count_vm_event(PGFAULT);
> 	count_memcg_event_mm(vma->vm_mm, PGFAULT);
> 
> in handle_mm_fault() but not counterpart for spf.  I think it would be 
> helpful to be able to determine how much faulting can be done 
> speculatively if there is no per-process tracking without tracing.

That sounds to be a good idea, I will create a separate patch a dedicated
speculative_pgfault counter as PGFAULT is.

Thanks,
Laurent.
