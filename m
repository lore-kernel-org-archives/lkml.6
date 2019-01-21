Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006EAC37123
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C60ED2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfAUVWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 16:22:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57970 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726694AbfAUVWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 16:22:22 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0LLJXIW086614
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 16:22:21 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q5jywxegh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 16:22:21 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 21 Jan 2019 21:22:19 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 21 Jan 2019 21:22:15 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0LLMEgk62521572
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Jan 2019 21:22:14 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07BFF52051;
        Mon, 21 Jan 2019 21:22:14 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.206.250])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 8EF9952050;
        Mon, 21 Jan 2019 21:22:12 +0000 (GMT)
Date:   Mon, 21 Jan 2019 23:22:10 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Doug Berger <opendmb@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jinbum Park <jinb.park7@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: mm: initialize pfn limits with find_limits()
References: <1545954447-22513-1-git-send-email-opendmb@gmail.com>
 <c05d7dcf-ab03-1313-d7b8-d630cdaed167@gmail.com>
 <ab09bcea-a55d-e562-6637-0df909b03e22@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab09bcea-a55d-e562-6637-0df909b03e22@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19012121-0008-0000-0000-000002B40EC4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012121-0009-0000-0000-00002220382D
Message-Id: <20190121212209.GA16047@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-21_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901210166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 12:48:09PM -0800, Florian Fainelli wrote:
> On 1/10/19 11:07 AM, Doug Berger wrote:
> > On 12/27/18 3:47 PM, Doug Berger wrote:
> >> The max_low_pfn value must be set before sparse_init() is called to
> >> keep the early memblock allocations and frees balanced for kmemleak
> >> initialization when sparsemem is enabled.
> >>
> >> This commit accomplishes that by replacing the local variables min,
> >> max_low, and max_high with the global limit variables min_low_pfn,
> >> max_low_pfn, and max_pfn respectively in bootmem_init(). The global
> >> variables are initialized directly by find_limits() and used in the
> >> remainder of the function.
> >>
> >> Fixes: 9099daed9c69 ("mm: kmemleak: avoid using __va() on addresses that don't have a lowmem mapping")
> >> Signed-off-by: Doug Berger <opendmb@gmail.com>
> >> ---
> >>  arch/arm/mm/init.c | 20 ++++----------------
> >>  1 file changed, 4 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> >> index 32e4845af2b6..98a733f3a5b9 100644
> >> --- a/arch/arm/mm/init.c
> >> +++ b/arch/arm/mm/init.c
> >> @@ -302,15 +302,12 @@ void __init arm_memblock_init(const struct machine_desc *mdesc)
> >>  
> >>  void __init bootmem_init(void)
> >>  {
> >> -	unsigned long min, max_low, max_high;
> >> -
> >>  	memblock_allow_resize();
> >> -	max_low = max_high = 0;
> >>  
> >> -	find_limits(&min, &max_low, &max_high);
> >> +	find_limits(&min_low_pfn, &max_low_pfn, &max_pfn);
> >>  
> >> -	early_memtest((phys_addr_t)min << PAGE_SHIFT,
> >> -		      (phys_addr_t)max_low << PAGE_SHIFT);
> >> +	early_memtest((phys_addr_t)min_low_pfn << PAGE_SHIFT,
> >> +		      (phys_addr_t)max_low_pfn << PAGE_SHIFT);
> >>  
> >>  	/*
> >>  	 * Sparsemem tries to allocate bootmem in memory_present(),
> >> @@ -328,16 +325,7 @@ void __init bootmem_init(void)
> >>  	 * the sparse mem_map arrays initialized by sparse_init()
> >>  	 * for memmap_init_zone(), otherwise all PFNs are invalid.
> >>  	 */
> >> -	zone_sizes_init(min, max_low, max_high);
> >> -
> >> -	/*
> >> -	 * This doesn't seem to be used by the Linux memory manager any
> >> -	 * more, but is used by ll_rw_block.  If we can get rid of it, we
> >> -	 * also get rid of some of the stuff above as well.
> >> -	 */
> >> -	min_low_pfn = min;
> >> -	max_low_pfn = max_low;
> >> -	max_pfn = max_high;
> >> +	zone_sizes_init(min_low_pfn, max_low_pfn, max_pfn);
> >>  }
> >>  
> >>  /*
> >>
> > 
> > Any feedback on this patch?
> 
> Mike, Catalin, does this looks sensible to you? If so, should this be
> thrown into Russell's patch tracking system?

Makes perfect sense to me, so

Acked-by: Mike Rapoport <rppt@linux.ibm.com>
 
> Thanks
> -- 
> Florian
> 

-- 
Sincerely yours,
Mike.

