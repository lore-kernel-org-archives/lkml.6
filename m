Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3576C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CFDB208E8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DI9YAVj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CFDB208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966372AbeFOTvR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 15:51:17 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:39406 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966065AbeFOTvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 15:51:16 -0400
Received: by mail-lf0-f68.google.com with SMTP id t2-v6so9853504lfd.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 12:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6fmmyY8t0e9Rh1Wnkxc3Z3+JuTtxw68OUcSqX6zs+RE=;
        b=DI9YAVj1TfTAKogvm+Wua2jAX48qdiquscksQq7zlwRUKYqmKHvNuONOYI4nlEqJW4
         kDUHhFQZ9kIId7lFTE4DZtbrAKxvSRrJBlz8gwRUKYrq9iuWbqSQ3iKu59Vn/2nMtoU5
         52aTFgpj+g1qecsAtwq41go2fcV7Nki2cWkv+TqVboLyk5weFrO/WheLdZd+j909ufWy
         CBEeb/PGJx52J5+56uC22wVHhk/XgmKj0YTJviHURKn5v3cDLL2p4um4I/MHVERCkaFI
         sElKxLa/GDtDFfH75oufHkbRgOx9iaGqQnPw8Z+t8qFAd33nOOsHCEtQjNlkCDoCIfaX
         U7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6fmmyY8t0e9Rh1Wnkxc3Z3+JuTtxw68OUcSqX6zs+RE=;
        b=Rnpl9ghmlSA3GD3KMJaZv8P+J4MjT5JQmWlyiXz0hnQGKvf8tMV7h8OFCKYcMeeuAD
         198i5zWd69YIePIOLjx5nYARfpLvgwzh2v1TyRIBBhlnyzXCZwrTVa7hB8AR9Ovz9Q12
         2nlJ1x8nymWuJesz04NKS0+/EWdPVRsMpCilA6iCowJIta5qWAxqYbDULXoc6Lef1MJT
         ZIFC7pXj7waCdfCk5Kf7U4mxSTe/mGp7psq/f2bE7HE5DHxP70YsMbtFYGZdXj+9Pdh9
         XOOLG5vuZah0mbC/v+QwWVlvkvOmBLiRt5yJX1H7jiOy3GJa8lSWGdjvFiure3aEvQCB
         konw==
X-Gm-Message-State: APt69E2vSJMAs0bEcfJsKEswkeXoRq9Ev/cAloq/Jwe+95+ofgFetd5Z
        75hn9cSNn7jXZQqjY0Qgr+g=
X-Google-Smtp-Source: ADUXVKKEqnpmAx/AcEe7Nqoep85LhCXE9ygc/7iYvqPIcioYtw0olfxxbfX0HG6csQwK5gYch8ANzA==
X-Received: by 2002:a19:148d:: with SMTP id 13-v6mr1911929lfu.84.1529092274530;
        Fri, 15 Jun 2018 12:51:14 -0700 (PDT)
Received: from mobilestation ([5.166.218.73])
        by smtp.gmail.com with ESMTPSA id g62-v6sm1624563lfk.54.2018.06.15.12.51.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 12:51:13 -0700 (PDT)
Date:   Fri, 15 Jun 2018 22:51:22 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 7/8] NTB: perf: Fix race condition when run with ntb_test
Message-ID: <20180615195122.GA25387@mobilestation>
References: <20180609000819.13883-1-logang@deltatee.com>
 <20180609000819.13883-9-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180609000819.13883-9-logang@deltatee.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 06:08:18PM -0600, Logan Gunthorpe <logang@deltatee.com> wrote:
> When running ntb_test, the script tries to run the ntb_perf test
> immediately after probing the modules. Since adding multi-port support,
> this fails seeing the new initialization procedure in ntb_perf
> can not complete instantly.
> 
> To fix this we add a completion which is waited on when a test is
> started. In this way, run can be written any time after the module is
> loaded and it will wait for the initialization to complete instead of
> sending an error.
> 

Hmm, this behavior is the feature of the driver and isn't a bug or race to be
fixed. ntb_perf driver returns -ENOLINK until the link is actually established,
when the memory windows are properly initialized so the test can be performed.
What do you think of leaving the algorithm as is, but instead to develop
the polling scheme in the ntb_test.sh script and break the script execution if
the link isn't established after sometime? At least we won't need to wait forever
in case if the peer hanged up or crashed while the NTB link negotiation algorithm
was in-progress.

Regards,
-Sergey

> Fixes: 5648e56d03fa ("NTB: ntb_perf: Add full multi-port NTB API support")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/ntb/test/ntb_perf.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index 6285cb8515ac..8e2b7630ecc9 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -158,6 +158,8 @@ struct perf_peer {
>  	/* NTB connection setup service */
>  	struct work_struct	service;
>  	unsigned long		sts;
> +
> +	struct completion init_comp;
>  };
>  #define to_peer_service(__work) \
>  	container_of(__work, struct perf_peer, service)
> @@ -549,6 +551,7 @@ static int perf_setup_outbuf(struct perf_peer *peer)
>  
>  	/* Initialization is finally done */
>  	set_bit(PERF_STS_DONE, &peer->sts);
> +	complete_all(&peer->init_comp);
>  
>  	return 0;
>  }
> @@ -639,6 +642,7 @@ static void perf_service_work(struct work_struct *work)
>  		perf_setup_outbuf(peer);
>  
>  	if (test_and_clear_bit(PERF_CMD_CLEAR, &peer->sts)) {
> +		init_completion(&peer->init_comp);
>  		clear_bit(PERF_STS_DONE, &peer->sts);
>  		if (test_bit(0, &peer->perf->busy_flag) &&
>  		    peer == peer->perf->test_peer) {
> @@ -1046,8 +1050,9 @@ static int perf_submit_test(struct perf_peer *peer)
>  	struct perf_thread *pthr;
>  	int tidx, ret;
>  
> -	if (!test_bit(PERF_STS_DONE, &peer->sts))
> -		return -ENOLINK;
> +	ret = wait_for_completion_interruptible(&peer->init_comp);
> +	if (ret < 0)
> +		return ret;
>  
>  	if (test_and_set_bit_lock(0, &perf->busy_flag))
>  		return -EBUSY;
> @@ -1413,6 +1418,7 @@ static int perf_init_peers(struct perf_ctx *perf)
>  			peer->gidx = pidx;
>  		}
>  		INIT_WORK(&peer->service, perf_service_work);
> +		init_completion(&peer->init_comp);
>  	}
>  	if (perf->gidx == -1)
>  		perf->gidx = pidx;
> -- 
> 2.11.0
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/20180609000819.13883-9-logang%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
