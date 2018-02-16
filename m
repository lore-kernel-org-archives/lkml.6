Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1017188-1518813842-2-10833252367793415855
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518813841; b=M4MiO+vx7tdyM0tXJzetxFjfIw2o/1W1FeSHf1wmqnoQ99f
    pZcymLrTTjXsAhl0QIsTSvON1RbwhVW1Bb0cOaOgh/YGqOLCdCkvO0bguxVEETxz
    5YpDlg+VYMlGEt5i7ATPuGA4WPvdS1rJLqtTsls5j/Lx6iMNhNyQxMC4kIQ2mlx5
    Wk73rrGOabm91nPwt5WdxUpUzgZVHj1cQQ4JjtEJxIxGN4L8dfkMQxxpESVw30nY
    ImCCXEoAcloVieXlSwMax6yn1g5sBMHMN3gRPrrdmiWYO95NuORwQn6KMHZWjlo1
    dDRZDSe+OHDwSeUtnqVKxgQADT3QhTrK9NBda2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518813841; bh=MDP8ryjW3OrClKTyKeVV277tn4gaMMWXFjZ9LVMfccg=; b=R
    ETZUR2/7poUkjiusyOo66fkA5SEJz5f9HupslKE9pyPMtlHnSk9Zt6JejlvfLqR3
    28/xKpbnFYV/FeA2PZyaNwmk03makL46DzfK/kRv4TtpoCFuxGH1G/K6ybffAGlM
    4dVSw9zraayPLaJs14yzLbNkqSzPccBN5XHByvJRiB0IJpuAb2aZ0+Zu63ghYWQC
    w2YMHmSN6pJZw/OR4WpIZncjlaSEmFuGO9E1jDU3MPkkTN5Xv6Wv+gMMqvR8Vocd
    YqVBCaiOWdjkUostuu2vwPVxul9aNa2lWvutt7qU3Wq/bFD4us4BB2oJ3kyVkLmv
    BQOUxNIVAa7dC4rurR8oQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750858AbeBPUn7 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 15:43:59 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49808 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbeBPUn6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Feb 2018 15:43:58 -0500
Date: Fri, 16 Feb 2018 12:43:57 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, mhocko@suse.com,
        stable@vger.kernel.org
Subject: Re: [RESEND v2] mm: don't defer struct page initialization for Xen
 pv guests
Message-Id: <20180216124357.de2cb8fe96c07dea51556adb@linux-foundation.org>
In-Reply-To: <20180216154101.22865-1-jgross@suse.com>
References: <20180216154101.22865-1-jgross@suse.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 16 Feb 2018 16:41:01 +0100 Juergen Gross <jgross@suse.com> wrote:

> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -347,6 +347,9 @@ static inline bool update_defer_init(pg_data_t *pgdat,
>  	/* Always populate low zones for address-constrained allocations */
>  	if (zone_end < pgdat_end_pfn(pgdat))
>  		return true;
> +	/* Xen PV domains need page structures early */
> +	if (xen_pv_domain())
> +		return true;

I'll do this:

--- a/mm/page_alloc.c~mm-dont-defer-struct-page-initialization-for-xen-pv-guests-fix
+++ a/mm/page_alloc.c
@@ -46,6 +46,7 @@
 #include <linux/stop_machine.h>
 #include <linux/sort.h>
 #include <linux/pfn.h>
+#include <xen/xen.h>
 #include <linux/backing-dev.h>
 #include <linux/fault-inject.h>
 #include <linux/page-isolation.h>

So we're not relying on dumb luck ;)
