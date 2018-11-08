Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CA2C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA7D20857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA7D20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbeKHRgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 12:36:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:32976 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726133AbeKHRgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 12:36:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 71C6EAD08;
        Thu,  8 Nov 2018 08:01:45 +0000 (UTC)
Date:   Thu, 8 Nov 2018 09:01:45 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Oscar Salvador <OSalvador@suse.com>,
        Baoquan He <bhe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 4/5] mm, memory_hotplug: print reason for the
 offlining failure
Message-ID: <20181108080145.GM27423@dhcp22.suse.cz>
References: <20181107101830.17405-1-mhocko@kernel.org>
 <20181107101830.17405-5-mhocko@kernel.org>
 <20181107140413.2c0061e440123be76bf419bf@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107140413.2c0061e440123be76bf419bf@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 07-11-18 14:04:13, Andrew Morton wrote:
[...]
> Fix:
> 
> --- a/mm/memory_hotplug.c~mm-memory_hotplug-print-reason-for-the-offlining-failure-fix
> +++ a/mm/memory_hotplug.c
> @@ -1576,7 +1576,7 @@ static int __ref __offline_pages(unsigne
>  				       MIGRATE_MOVABLE, true);
>  	if (ret) {
>  		mem_hotplug_done();
> -		reason = "failed to isolate range";
> +		reason = "failure to isolate range";
>  		goto failed_removal
>  	}
>  
> @@ -1587,7 +1587,7 @@ static int __ref __offline_pages(unsigne
>  	ret = memory_notify(MEM_GOING_OFFLINE, &arg);
>  	ret = notifier_to_errno(ret);
>  	if (ret) {
> -		reason = "notifiers failure";
> +		reason = "notifier failure";
>  		goto failed_removal_isolated;
>  	}
>  
> @@ -1616,7 +1616,7 @@ repeat:
>  	 */
>  	ret = dissolve_free_huge_pages(start_pfn, end_pfn);
>  	if (ret) {
> -		reason = "fails to disolve hugetlb pages";
> +		reason = "failure to dissolve huge pages";
>  		goto failed_removal_isolated;
>  	}
>  	/* check again */
> _
> 

LGTM, thanks!

-- 
Michal Hocko
SUSE Labs
