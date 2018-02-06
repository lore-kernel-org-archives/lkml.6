Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1543687-1517933972-2-10742508187445201892
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517933972; b=EY6DEaov3QUKDPH/n2DoIHc5VTVoXaIdzqZf6rY9GZaO8V8
    La/SxPtH3Hvb7tBX1/NhrqvsCEpuHJ1gJm0TI1MNmazGRFjYQQ2uNwK2yTiAz8kw
    L+97rgHJohXgGFknaWkd7xUM80BTecjno8MrM4S4pR9efpNTpyMX1tg+e9oyjKiH
    BRvM1BRDoSyPjn5yvCnAHobmphq37mGkYWSaeu5YlWMzFTK91uD1j7Gq+X7tD/Gj
    95NgDs7xtACgfWfPfbBsDMg5Q28cseYjX8nimh95fyzX98HedI3n1BTdcQ1g6ryY
    C4zeVn1RxieXUBi0uy9CaHoOHwKTWse8x93oCiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517933972; bh=CDGH8WWRws13dniAUg9jkKjYHn
    s6igTxLPcmwnXOCig=; b=G6Xxp4lSr3dffFQ4jIXypLWBx0z+9HvATqGowa+e2B
    T4if52hb3wzqr+wrMgytkAnrPpBCS6RNB+d/Q+9iduGWXMdkl0M8YeQpa3mqS1fP
    FXbEtVt8KHHyqeTvYsB+8UsmwSuN/b9Py7wNY2mnjusXpYLOA8zNoRgAhQZ3SJGQ
    w+G+SzhMWe/lcMyxbM49InBoTicjYQKdvHlFtzgvGgHvvHlAU6aw3UV58BY0r5mN
    sn7hhC2myhIaP1etS+R6ywCTnxdgmmU8bf6rvmHCYJlX3tMTLXWjBzbyMAdY2XLr
    hXp1C9UrsgyI+uTIZ6ZK7MDHkUKKoE84tCGL6SOLg8+Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752699AbeBFQTa (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 11:19:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:37521 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752621AbeBFQTR (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 6 Feb 2018 11:19:17 -0500
Date: Tue, 6 Feb 2018 17:19:14 +0100
From: Jan Kara <jack@suse.cz>
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
        Joshua Miller <joshmiller@fb.com>, kernel-team@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] bdi: make sure congestion states are clear on free
Message-ID: <20180206161914.gi7xctcgkhh7v6iq@quack2.suse.cz>
References: <20180202175328.GL1121507@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180202175328.GL1121507@devbig577.frc2.facebook.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri 02-02-18 09:53:28, Tejun Heo wrote:
> FUSE has a bug where it fails to clear congestion states if a
> connection gets aborted while congested, which can leave
> nr_wb_congested[] stuck until reboot causing wait_iff_congested() to
> wait spuriously.
> 
> While the bdi owner, FUSE, is primarily responsible for clearing
> congestion states before destroying bdi_writebacks, bdi layer can
> ensure that congestion states are not leaked beyond bdi_writeback
> lifecycle.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Joshua Miller <joshmiller@fb.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: stable@vger.kernel.org

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/backing-dev.h |   14 +++++++++++++-
>  mm/backing-dev.c            |    2 +-
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> --- a/include/linux/backing-dev.h
> +++ b/include/linux/backing-dev.h
> @@ -220,6 +220,18 @@ static inline int bdi_sched_wait(void *w
>  	return 0;
>  }
>  
> +static inline void __wb_congested_free(struct bdi_writeback_congested *congested)
> +{
> +	/*
> +	 * Make sure congestion states are cleared before freeing to avoid
> +	 * nr_wb_congested() corruption which can lead to misbehaving
> +	 * wait_iff_congested().
> +	 */
> +	clear_wb_congested(congested, BLK_RW_SYNC);
> +	clear_wb_congested(congested, BLK_RW_ASYNC);
> +	kfree(congested);
> +}
> +
>  #ifdef CONFIG_CGROUP_WRITEBACK
>  
>  struct bdi_writeback_congested *
> @@ -409,7 +421,7 @@ wb_congested_get_create(struct backing_d
>  static inline void wb_congested_put(struct bdi_writeback_congested *congested)
>  {
>  	if (atomic_dec_and_test(&congested->refcnt))
> -		kfree(congested);
> +		__wb_congested_free(congested);
>  }
>  
>  static inline struct bdi_writeback *wb_find_current(struct backing_dev_info *bdi)
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -509,7 +509,7 @@ void wb_congested_put(struct bdi_writeba
>  	}
>  
>  	spin_unlock_irqrestore(&cgwb_lock, flags);
> -	kfree(congested);
> +	__wb_congested_free(congested);
>  }
>  
>  static void cgwb_release_workfn(struct work_struct *work)
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
