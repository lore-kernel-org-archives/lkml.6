Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1193642-1524685052-2-3651965336305492322
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524685052; b=G7OoTmqUMken2r7S9pWJk6CGiZolgrPb4WMiCxbiX1gUb+1IqH
    mO5vNRsWzSEObDauc0Hm1IbOj1eP1tKneh0b8ALYsr7YytyghSo6lsoKBv08CoZs
    3WFIAFkm7lGsxlOs7UKADHHIYV8+/diUE8DDWEadXrnNTrf0eW83rq8cES4SlNHG
    0GrDZA7cs85YNLGCeR/Mg1+zB8u0cvxzo6XCMQNP1CLMnfjGtKcgZ0zm3lh0p33a
    RF/lyBkUwRSlDcn/1F//IpYgGDHiI363DukmEQPIEEbxUeDHUbxgo++9LnRId5WZ
    DXs/M2cHJV9xWvaf5C730gY91EPMDIf9rKrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=fm2; t=1524685052; bh=SyivfOBjJuCsrGiW+dTTuxPpc6iXFJv9JKp+GSR
    9Ze4=; b=NRaaEvzScZAQGJAw8d7cAPi40QECKzeiFeULNiIES/xNC09JeShnZxl
    4fR2aTrvIXhT9EizYX3OXoUa/KZNJ1CvT4gp2I86rcy3VbkCejto59f7RZsl5ztN
    ISwR1VK6zS1pUYf5BcIg7Nh0zm5k3O29QaCvEAbWWK+zCCrpXdnqqI20lNqXM2jo
    UUpaeQthlufaejMFfnasaxMmKtTbxmmdDImo56gDXmI/zUKBUKps9+CWJMxf8PAo
    9rAYnLgiUSPPx+Z9z4Yf+z6EZo5JOu/POz4qZBnqoG8fnUYqNenaGbA4hNtaXuNs
    zZDvOWCDUJ5e63acTkb2iW4numT19lw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=hJuKqu5C x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=O8yvgPbU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=hJuKqu5C x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=O8yvgPbU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKIfzbhABDIu2TDcEY9S/yX0mSL4DKRdTHb6ICR4Vu/TYw0bPOIFAZ/9JKAupL0acs8vR7FhiNN/wE5rsmtVeOIonyXz0goVFxBwiXUqTaVGZr5ZoYGn
    sAh2jRkqCd9dyfkd2O/TsCpS5ZVDMYp9WtdmltsjI8qVoKj3di2HVb8/ZrSKGsntHcellHvsuRMSoua3Le93CEOiH//jhE8sS4WrPxrWAZGUQokqGCAPcULq
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=FOH2dFAWAAAA:8 a=JfrnYn6hAAAA:8 a=Z4Rwk6OoAAAA:8
    a=drOt6m5kAAAA:8 a=iox4zFpeAAAA:8 a=ufHFDILaAAAA:8 a=VwQbUJbxAAAA:8
    a=HlR1BP9YCU_Ax4rQYlQA:9 a=br0-oVX_ThkdIa5n:21 a=zOG6zEv3NkK1JDEy:21
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=i3VuKzQdj-NEYjvDI-p3:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=HkZW87K1Qel5hWWM3VKY:22 a=RMMjzBEyIzXRtoq5n5K6:22
    a=WzC6qhA0u3u7Ye7llzcV:22 a=ZmIg1sZ3JBWsdXgziEIF:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751453AbeDYTh3 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 15:37:29 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37135 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751165AbeDYTh2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 15:37:28 -0400
X-Google-Smtp-Source: AIpwx4987UbkOcY3W6qqBX3u+Rpf7XoVSNJpWnjB4v9s4yLKHy63oAYPNWnjgvbjwvoRYLq08n9YIA==
Date: Wed, 25 Apr 2018 12:37:26 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Roman Gushchin <guro@fb.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, kernel-team@fb.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm: don't show nr_indirectly_reclaimable in
 /proc/vmstat
In-Reply-To: <20180425191422.9159-1-guro@fb.com>
Message-ID: <alpine.DEB.2.21.1804251235330.151692@chino.kir.corp.google.com>
References: <20180425191422.9159-1-guro@fb.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 25 Apr 2018, Roman Gushchin wrote:

> Don't show nr_indirectly_reclaimable in /proc/vmstat,
> because there is no need in exporting this vm counter
> to the userspace, and some changes are expected
> in reclaimable object accounting, which can alter
> this counter.
> 

I don't think it should be a per-node vmstat, in this case.  It appears 
only to be used for the global context.  Shouldn't this be handled like 
totalram_pages, total_swap_pages, totalreserve_pages, etc?

> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
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
