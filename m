Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1251131-1524685123-3-4908578587791813059
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524685122; b=lAYnsKhsP0qbP+HNBIEJylbwsMBAfUrte7xLxVjywxi1jhKDce
    RRh0unuiYiqpHrPqkmkmLk75jQv+B1Pk5Vfc4t+fzt2IT/IrTyYq7bFdKZXKv9lB
    IWC/FGXE7qleHoyXmgfyS+keMaYrW7kcqayBgfIlWALKkDgdZaYzYzq+3Oi6hMiB
    ErjiV1zJmclCGenbk0edwk2ECO45KgJoJz1GbuCfbKwN4EM3uVkkcvqUCLafnT0s
    5GliVgaA+vW1ZZplLF8xo1Os5ylKViW0g7T9VL8qT+4QZprOsrbqeq1o234hMsry
    kOVY1kBifNuAQxUZ8ZkvC1NsUlg25UX/zpDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524685122;
    bh=vR7qqRn3N0KAJ/zJr23KV58aWRq+W8+E1ltySRhxx/Q=; b=cSmGJxE+YjDX
    Zg60PoYXp0i+0fyLk0xUyE5qepxKxFbSQBSixlLjC9vottTHV5zFrmtMbc1GriHp
    mVTAHHi7mY1zBY32ntC3PGKyB9Ok6ObSVqo3H0a/0WopoNqnzAapTHHLDgUMWt8g
    1Yw+yMGW+rkjgTjqzc5cOuNTZ3s0Thd/BH6LmAcduu65l2NR6xRQHZpiSbKJEj5k
    64le59lnChaOIGKk6gwupSu3IGguMfVXGqIMpdro3CGdnM84tPGBsfTJJctlzrwJ
    /1k+t8PSbtc2yPXzjfbMIr+67dVqNiHZ5XVQt6gke391RQvuKWJSkoavQmu4couf
    37co2SiDnw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLNT+katkuuFaiKg+jqGNGHyo42/Ksmmeh0Yk/9JYGXYK0S15RT0USdHsfwkcmMhTYkUigmoUnUY2rG0bM1pQDeSohD+Sluy5AMrEA5gf9J/O08Tex98
    NT0HcdpDSD3SbiioFy+7FKskjKdEp7bySQx+6v4F2twQ1Yp+1pgKEI4c7DHCAKpYXI5ukOazvxa7CUDbP7d3Kw2pjKQORtKQOoYVPw3XjgkVnyss8Y0nXEBV
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=FOH2dFAWAAAA:8 a=JfrnYn6hAAAA:8 a=Z4Rwk6OoAAAA:8 a=drOt6m5kAAAA:8
    a=iox4zFpeAAAA:8 a=ufHFDILaAAAA:8 a=VwQbUJbxAAAA:8 a=HlR1BP9YCU_Ax4rQYlQA:9
    a=GN6wUxVyeTAE2H7Z:21 a=XwIDdrwu_f9-grkl:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=i3VuKzQdj-NEYjvDI-p3:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=HkZW87K1Qel5hWWM3VKY:22 a=RMMjzBEyIzXRtoq5n5K6:22 a=WzC6qhA0u3u7Ye7llzcV:22
    a=ZmIg1sZ3JBWsdXgziEIF:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751255AbeDYTik (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 15:38:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:44683 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751084AbeDYTij (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 25 Apr 2018 15:38:39 -0400
Subject: Re: [PATCH] mm: don't show nr_indirectly_reclaimable in /proc/vmstat
To: Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        kernel-team@fb.com, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <20180425191422.9159-1-guro@fb.com>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <a2206b6a-1492-39dc-101f-118060083206@suse.cz>
Date: Wed, 25 Apr 2018 21:36:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425191422.9159-1-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/25/2018 09:14 PM, Roman Gushchin wrote:
> Don't show nr_indirectly_reclaimable in /proc/vmstat,
> because there is no need in exporting this vm counter
> to the userspace, and some changes are expected
> in reclaimable object accounting, which can alter
> this counter.

Oh, you beat me to it, thanks.

> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Andrew, can you send this to Linus before the current rc period ends,
please?

Thanks,
Vlastimil

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
> 

