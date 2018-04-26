Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3121895-1524773031-2-5144673794758658668
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524773029; b=wTHk/GK1szEJ4z6x374lBKG69ni4yzOK4LrFAtT9mktWc76aCi
    j+fxSioYKfli/2y7tD4r0txFGdZX+ytwo1XbdUDBVZsm88B64QairpAvUN2eAKXU
    WLxGVcUjU5wpvAZ9SP+I+9OKCTsdanR7IUB07MFsXPQxa0IWxy9PZNHs0NKQk86h
    3VI4aEKBQ/o/eP4glr8F7goqg+YnuwUsEW33e7qdkpE9xDyNIYeguPZlkIS2Ik4C
    UNF0NH1gtIYl7fKx/P6X78d4/xJsElBvjfHsgnzF8RWzJ8zgJv9fhFIReTXQp4tG
    pz0sdT2hvi5MRe3w7OSrlEXLQq69P68CwROA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524773029; bh=FYmyfDbHiJ3vcasR1coomV+caX6tdU
    Ax8vaQQ5XspBo=; b=QuV4r57ntkik6n6dOybC489u8OitzSCnaZqaz8YqggDByp
    uS/TluJjiKN+4q+c5HTS8T40vGxGFdaYjt0X+SXDUyCIwl7OAHXQufZxsDtAz8ya
    k2cgPBBWS2fDzFFAKxCiHKMqZSIQwys0L7xyVOJp7wSSZ9cqFuEkVH9Q2VQNF6mX
    mYVAMBZYKDcv6CPPV7GQeImjAIUVSQt4wpZcxNtCEfoVviK5DEhIpPqut/3VZimY
    /6q8mwqIbrRXkWo9E0O8xNJuzTAMpU85S24SuzpTGkRhJoC2OKlbumGiWOzPcT4Z
    HZ3+PzEvVyrt0tSTAfZDY5EfKdT0+zIQimuiHIwQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAaQAagcQOXZDGtsqUfxCxKypmVt5gScyISaBY/Ck4mMO79Hd+wLwAF+y2StrttbD9scL5/aRgYauJR2ykpYih0Y0P3+wbNPgDmhl/8edLLKCt/YiuOn
    3ATF2FssKiGO4Y/AM7tZL5CICwB5YQc3OrFGZKajSsBy8qQbusARKNJ6Bq1BJQbu643YvoZmJUOMdoOCmut7TAT1cLXirBX1MJhtWxFtqteLOXkdwqtr2A1b
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=FOH2dFAWAAAA:8 a=JfrnYn6hAAAA:8 a=Z4Rwk6OoAAAA:8 a=drOt6m5kAAAA:8
    a=iox4zFpeAAAA:8 a=ufHFDILaAAAA:8 a=VwQbUJbxAAAA:8 a=HlR1BP9YCU_Ax4rQYlQA:9
    a=9_sauB0ltD2lJV1Y:21 a=QBAYB7Gwgt-Oyznt:21 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=i3VuKzQdj-NEYjvDI-p3:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=HkZW87K1Qel5hWWM3VKY:22 a=RMMjzBEyIzXRtoq5n5K6:22 a=WzC6qhA0u3u7Ye7llzcV:22
    a=ZmIg1sZ3JBWsdXgziEIF:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757101AbeDZUDf (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 16:03:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:45728 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756685AbeDZUDd (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 26 Apr 2018 16:03:33 -0400
Date: Thu, 26 Apr 2018 22:03:31 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Roman Gushchin <guro@fb.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, kernel-team@fb.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm: don't show nr_indirectly_reclaimable in /proc/vmstat
Message-ID: <20180426200331.GZ17484@dhcp22.suse.cz>
References: <20180425191422.9159-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425191422.9159-1-guro@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed 25-04-18 20:14:22, Roman Gushchin wrote:
> Don't show nr_indirectly_reclaimable in /proc/vmstat,
> because there is no need in exporting this vm counter
> to the userspace, and some changes are expected
> in reclaimable object accounting, which can alter
> this counter.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>

This is quite a hack. I would much rather revert the counter and fixed
it the way Vlastimil has proposed. But if there is a strong opposition
to the revert then this is probably the simples thing to do. Therefore

Unhappy-Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/vmstat.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 536332e988b8..a2b9518980ce 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1161,7 +1161,7 @@ const char * const vmstat_text[] = {
>  	"nr_vmscan_immediate_reclaim",
>  	"nr_dirtied",
>  	"nr_written",
> -	"nr_indirectly_reclaimable",
> +	"", /* nr_indirectly_reclaimable */
>  
>  	/* enum writeback_stat_item counters */
>  	"nr_dirty_threshold",
> @@ -1740,6 +1740,10 @@ static int vmstat_show(struct seq_file *m, void *arg)
>  	unsigned long *l = arg;
>  	unsigned long off = l - (unsigned long *)m->private;
>  
> +	/* Skip hidden vmstat items. */
> +	if (*vmstat_text[off] == '\0')
> +		return 0;
> +
>  	seq_puts(m, vmstat_text[off]);
>  	seq_put_decimal_ull(m, " ", *l);
>  	seq_putc(m, '\n');
> -- 
> 2.14.3

-- 
Michal Hocko
SUSE Labs
