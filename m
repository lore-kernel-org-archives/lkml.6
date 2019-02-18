Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F8DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E41AD21916
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390364AbfBROGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:06:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56630 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390313AbfBROGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:06:09 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1IE5sP4023723
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 09:06:08 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qqves5hb5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 09:06:00 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 18 Feb 2019 14:05:23 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 18 Feb 2019 14:05:20 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1IE5JPa11468970
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Feb 2019 14:05:19 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED46352057;
        Mon, 18 Feb 2019 14:05:18 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.207.239])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id CFC495204E;
        Mon, 18 Feb 2019 14:05:17 +0000 (GMT)
Date:   Mon, 18 Feb 2019 16:05:15 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Rong Chen <rong.a.chen@intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>, LKP <lkp@01.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [LKP] efad4e475c [ 40.308255] Oops: 0000 [#1] PREEMPT SMP PTI
References: <20190218052823.GH29177@shao2-debian>
 <20190218070844.GC4525@dhcp22.suse.cz>
 <20190218085510.GC7251@dhcp22.suse.cz>
 <4c75d424-2c51-0d7d-5c28-78c15600e93c@intel.com>
 <20190218103013.GK4525@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218103013.GK4525@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19021814-0016-0000-0000-00000257CD78
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021814-0017-0000-0000-000032B20D41
Message-Id: <20190218140515.GF25446@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-18_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902180106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 11:30:13AM +0100, Michal Hocko wrote:
> On Mon 18-02-19 18:01:39, Rong Chen wrote:
> > 
> > On 2/18/19 4:55 PM, Michal Hocko wrote:
> > > [Sorry for an excessive quoting in the previous email]
> > > [Cc Pavel - the full report is http://lkml.kernel.org/r/20190218052823.GH29177@shao2-debian[]
> > > 
> > > On Mon 18-02-19 08:08:44, Michal Hocko wrote:
> > > > On Mon 18-02-19 13:28:23, kernel test robot wrote:
> > > [...]
> > > > > [   40.305212] PGD 0 P4D 0
> > > > > [   40.308255] Oops: 0000 [#1] PREEMPT SMP PTI
> > > > > [   40.313055] CPU: 1 PID: 239 Comm: udevd Not tainted 5.0.0-rc4-00149-gefad4e4 #1
> > > > > [   40.321348] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> > > > > [   40.330813] RIP: 0010:page_mapping+0x12/0x80
> > > > > [   40.335709] Code: 5d c3 48 89 df e8 0e ad 02 00 85 c0 75 da 89 e8 5b 5d c3 0f 1f 44 00 00 53 48 89 fb 48 8b 43 08 48 8d 50 ff a8 01 48 0f 45 da <48> 8b 53 08 48 8d 42 ff 83 e2 01 48 0f 44 c3 48 83 38 ff 74 2f 48
> > > > > [   40.356704] RSP: 0018:ffff88801fa87cd8 EFLAGS: 00010202
> > > > > [   40.362714] RAX: ffffffffffffffff RBX: fffffffffffffffe RCX: 000000000000000a
> > > > > [   40.370798] RDX: fffffffffffffffe RSI: ffffffff820b9a20 RDI: ffff88801e5c0000
> > > > > [   40.378830] RBP: 6db6db6db6db6db7 R08: ffff88801e8bb000 R09: 0000000001b64d13
> > > > > [   40.386902] R10: ffff88801fa87cf8 R11: 0000000000000001 R12: ffff88801e640000
> > > > > [   40.395033] R13: ffffffff820b9a20 R14: ffff88801f145258 R15: 0000000000000001
> > > > > [   40.403138] FS:  00007fb2079817c0(0000) GS:ffff88801dd00000(0000) knlGS:0000000000000000
> > > > > [   40.412243] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > [   40.418846] CR2: 0000000000000006 CR3: 000000001fa82000 CR4: 00000000000006a0
> > > > > [   40.426951] Call Trace:
> > > > > [   40.429843]  __dump_page+0x14/0x2c0
> > > > > [   40.433947]  is_mem_section_removable+0x24c/0x2c0
> > > > This looks like we are stumbling over an unitialized struct page again.
> > > > Something this patch should prevent from. Could you try to apply [1]
> > > > which will make __dump_page more robust so that we do not blow up there
> > > > and give some more details in return.
> > > > 
> > > > Btw. is this reproducible all the time?
> > > And forgot to ask whether this is reproducible with pending mmotm
> > > patches in linux-next.
> > 
> > 
> > Do you mean the below patch? I can reproduce the problem too.
> 
> Yes, thanks for the swift response. The patch has just added a debugging
> output
> [    0.013697] Early memory node ranges
> [    0.013701]   node   0: [mem 0x0000000000001000-0x000000000009efff]
> [    0.013706]   node   0: [mem 0x0000000000100000-0x000000001ffdffff]
> [    0.013711] zeroying 0-1
> 
> This is the first pfn.
> 
> [    0.013715] zeroying 9f-100
> 
> this is [mem 0x9f000, 0xfffff] so it fills up the whole hole between the
> above two ranges. This is definitely good.
> 
> [    0.013722] zeroying 1ffe0-1ffe0
> 
> this is a single page at 0x1ffe0000 right after the zone end.
> 
> [    0.013727] Zeroed struct page in unavailable ranges: 98 pages
> 
> Hmm, so this is getting really interesting. The whole zone range should
> be covered. So this is either some off-by-one or I something that I am
> missing right now. Could you apply the following on top please? We
> definitely need to see what pfn this is.
> 
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 124e794867c5..59bcfd934e37 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1232,12 +1232,14 @@ static bool is_pageblock_removable_nolock(struct page *page)
>  /* Checks if this range of memory is likely to be hot-removable. */
>  bool is_mem_section_removable(unsigned long start_pfn, unsigned long nr_pages)
>  {
> -	struct page *page = pfn_to_page(start_pfn);
> +	struct page *page = pfn_to_page(start_pfn), *first_page;
>  	unsigned long end_pfn = min(start_pfn + nr_pages, zone_end_pfn(page_zone(page)));
>  	struct page *end_page = pfn_to_page(end_pfn);
> 
>  	/* Check the starting page of each pageblock within the range */
> -	for (; page < end_page; page = next_active_pageblock(page)) {
> +	for (first_page = page; page < end_page; page = next_active_pageblock(page)) {
> +		if (PagePoisoned(page))
> +			pr_info("Unexpected poisoned page %px pfn:%lx\n", page, start_pfn + page-first_page);
>  		if (!is_pageblock_removable_nolock(page))
>  			return false;
>  		cond_resched();

I've added more prints and somehow end_page gets too big (in brackets is
the pfn):

[   11.183835] ===> start: ffff88801e240000(0), end: ffff88801e400000(8000)
[   11.188457] ===> start: ffff88801e400000(8000), end: ffff88801e640000(10000)
[   11.193266] ===> start: ffff88801e640000(10000), end: ffff88801e060000(18000)

                                                 should be ffff88801e5c0000

[   11.197363] ===> start: ffff88801e060000(18000), end: ffff88801e21f900(1ffe0)
[   11.207547] Unexpected poisoned page ffff88801e5c0000 pfn:10000


With the patch below the problem seem to disappear, although I have no idea
why...

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 91e6fef..53d15ff 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1234,7 +1234,7 @@ bool is_mem_section_removable(unsigned long start_pfn, unsigned long nr_pages)
 {
 	struct page *page = pfn_to_page(start_pfn);
 	unsigned long end_pfn = min(start_pfn + nr_pages, zone_end_pfn(page_zone(page)));
-	struct page *end_page = pfn_to_page(end_pfn);
+	struct page *end_page = page + (end_pfn - start_pfn);
 
 	/* Check the starting page of each pageblock within the range */
 	for (; page < end_page; page = next_active_pageblock(page)) {


> -- 
> Michal Hocko
> SUSE Labs
> 

-- 
Sincerely yours,
Mike.

