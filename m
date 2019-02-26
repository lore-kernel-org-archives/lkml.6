Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1AAC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30B62173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfBZMrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:47:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54802 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726454AbfBZMrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:47:01 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1QCjQgS041366
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 07:47:00 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qw3n4yfp4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 07:46:58 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 26 Feb 2019 12:46:56 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Feb 2019 12:46:53 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1QCkq1N52559976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Feb 2019 12:46:52 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 339AEAE045;
        Tue, 26 Feb 2019 12:46:52 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64DE2AE051;
        Tue, 26 Feb 2019 12:46:51 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.84])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 26 Feb 2019 12:46:51 +0000 (GMT)
Date:   Tue, 26 Feb 2019 14:46:49 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org
Subject: Re: [PATCH AUTOSEL 4.20 66/72] mm, memory_hotplug:
 is_mem_section_removable do not pass the end of a zone
References: <20190223210422.199966-1-sashal@kernel.org>
 <20190223210422.199966-66-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190223210422.199966-66-sashal@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19022612-0016-0000-0000-0000025B1407
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022612-0017-0000-0000-000032B57643
Message-Id: <20190226124649.GH11981@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-26_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1031 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902260094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2019 at 04:04:16PM -0500, Sasha Levin wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> [ Upstream commit efad4e475c312456edb3c789d0996d12ed744c13 ]
 
There is a fix for this fix [1].

It's  commit 891cb2a72d821f930a39d5900cb7a3aa752c1d5b ("mm, memory_hotplug:
fix off-by-one in is_pageblock_removable") in mainline.
    
[1] https://lore.kernel.org/lkml/20190218181544.14616-1-mhocko@kernel.org/


> Patch series "mm, memory_hotplug: fix uninitialized pages fallouts", v2.
> 
> Mikhail Zaslonko has posted fixes for the two bugs quite some time ago
> [1].  I have pushed back on those fixes because I believed that it is
> much better to plug the problem at the initialization time rather than
> play whack-a-mole all over the hotplug code and find all the places
> which expect the full memory section to be initialized.
> 
> We have ended up with commit 2830bf6f05fb ("mm, memory_hotplug:
> initialize struct pages for the full memory section") merged and cause a
> regression [2][3].  The reason is that there might be memory layouts
> when two NUMA nodes share the same memory section so the merged fix is
> simply incorrect.
> 
> In order to plug this hole we really have to be zone range aware in
> those handlers.  I have split up the original patch into two.  One is
> unchanged (patch 2) and I took a different approach for `removable'
> crash.
> 
> [1] http://lkml.kernel.org/r/20181105150401.97287-2-zaslonko@linux.ibm.com
> [2] https://bugzilla.redhat.com/show_bug.cgi?id=1666948
> [3] http://lkml.kernel.org/r/20190125163938.GA20411@dhcp22.suse.cz
> 
> This patch (of 2):
> 
> Mikhail has reported the following VM_BUG_ON triggered when reading sysfs
> removable state of a memory block:
> 
>  page:000003d08300c000 is uninitialized and poisoned
>  page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
>  Call Trace:
>    is_mem_section_removable+0xb4/0x190
>    show_mem_removable+0x9a/0xd8
>    dev_attr_show+0x34/0x70
>    sysfs_kf_seq_show+0xc8/0x148
>    seq_read+0x204/0x480
>    __vfs_read+0x32/0x178
>    vfs_read+0x82/0x138
>    ksys_read+0x5a/0xb0
>    system_call+0xdc/0x2d8
>  Last Breaking-Event-Address:
>    is_mem_section_removable+0xb4/0x190
>  Kernel panic - not syncing: Fatal exception: panic_on_oops
> 
> The reason is that the memory block spans the zone boundary and we are
> stumbling over an unitialized struct page.  Fix this by enforcing zone
> range in is_mem_section_removable so that we never run away from a zone.
> 
> Link: http://lkml.kernel.org/r/20190128144506.15603-2-mhocko@kernel.org
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> Reported-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> Debugged-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> Tested-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  mm/memory_hotplug.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 21d94b5677e81..5ce0d929ff482 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1234,7 +1234,8 @@ static bool is_pageblock_removable_nolock(struct page *page)
>  bool is_mem_section_removable(unsigned long start_pfn, unsigned long nr_pages)
>  {
>  	struct page *page = pfn_to_page(start_pfn);
> -	struct page *end_page = page + nr_pages;
> +	unsigned long end_pfn = min(start_pfn + nr_pages, zone_end_pfn(page_zone(page)));
> +	struct page *end_page = pfn_to_page(end_pfn);
> 
>  	/* Check the starting page of each pageblock within the range */
>  	for (; page < end_page; page = next_active_pageblock(page)) {
> -- 
> 2.19.1
> 

-- 
Sincerely yours,
Mike.

