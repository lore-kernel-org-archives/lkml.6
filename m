Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40409C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E7D208E8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ppAvu+27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9E7D208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966431AbeFOTuZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 15:50:25 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:42844 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965768AbeFOTuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 15:50:23 -0400
Received: by mail-lf0-f66.google.com with SMTP id v135-v6so16236883lfa.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 12:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w1CdjnphkZpTq8rLRemD5itPBV0qo8DLvweSHwEutd4=;
        b=ppAvu+271nXjWaT1GzYwSs92qXNpbuJhqj3VwpD/rEKZldWPGNNAqr9Hc0vShPqPak
         kPhaS8HBBP68RDvzLq/wWK0/MOnXrvz/gAlyL/EbCuDvbGYua3/xTrlLXO0OAph8Tamj
         5tBOS3K97GJHQUI4A87HPJjua+umfsGKpXsSLu+M6zNGlsEhvlqPjJEG4ptkzf0mou2G
         SLuQW5+n9uWndOdJCJd4OUCUfp1LFPFtk4jb8SwYjD+hVEXVLMYmmGR0JJYBa1IDnBA6
         ZxHhzckcjUQwRofgWx1rRpEUIKtnyu8InVnaaAusMIV9A+MCaiJUjdiurpT8D2fIbsN3
         QzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w1CdjnphkZpTq8rLRemD5itPBV0qo8DLvweSHwEutd4=;
        b=CuMe1I18rEBkcggqWwAJcmmpZnvtrYYul/uqxrG3uxgNSoGGV6sRlGhvN5G8lWufJ9
         bBzIbEdAkFkByYiDOlSD6DGlzfC8ed2myvjcbsz1k4+lH6YI6yJ5g0FDC+gaUFX0/wXI
         7OZC7mhdoitklUKRTJL1hrLoUezBrJA5Ib4bgXLY7zxSLgew9Ij5FGkMsyBq6DoryaNk
         VIy2SZqSdMHMoawVRWY5etR0BWPRj3NFduZOBX/7yau8BXkoxVlhr/TZEUmG0hRj5oA1
         of1320dRCHVupxol2TIXMuoIJEqmTzXP1iMOVuGltcfr4nfP2/zIHp8NkM4SDWinm4qi
         rcZA==
X-Gm-Message-State: APt69E2XrGcMQxy6EMxwnzN6ZVWwfzwVLfeyDDbu2k3eSmq1CerrFlVs
        OxLpNSr8l2EYosYQYcYO15w=
X-Google-Smtp-Source: ADUXVKLLLH13DOX8uKNTkRZtnk1Iq04coJnRPImUXaPPsyO6XYbvoeuy87tw5kTCClEUBJsomw/MQQ==
X-Received: by 2002:a2e:428e:: with SMTP id h14-v6mr2271676ljf.136.1529092222494;
        Fri, 15 Jun 2018 12:50:22 -0700 (PDT)
Received: from mobilestation ([5.166.218.73])
        by smtp.gmail.com with ESMTPSA id q5-v6sm1583908ljj.68.2018.06.15.12.50.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 12:50:21 -0700 (PDT)
Date:   Fri, 15 Jun 2018 22:50:30 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 6/8] NTB: perf: Fix support for hardware that doesn't
 have port numbers
Message-ID: <20180615195030.GA25303@mobilestation>
References: <20180609000819.13883-1-logang@deltatee.com>
 <20180609000819.13883-8-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180609000819.13883-8-logang@deltatee.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 06:08:17PM -0600, Logan Gunthorpe <logang@deltatee.com> wrote:
> Legacy drivers do not have port numbers (but is reliably only two ports)
> and was broken by the recent commit that added mult-port support to
> ntb_perf. This is especially important to support the cross link
> topology which is perfectly symmetric and cannot assign unique port
> numbers easily.
> 

Please, see the comment to the patch 3/8. I explained everything there
including the fact, that the Intel/AMD drivers do have unique port numbers
assigned.

Regards,
-Sergey

> Hardware that returns zero for both the local port and the peer should
> just always use gidx=0 for the only peer.
> 
> Fixes: 5648e56d03fa ("NTB: ntb_perf: Add full multi-port NTB API support")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/ntb/test/ntb_perf.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index fe27412ffe91..6285cb8515ac 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -1417,6 +1417,16 @@ static int perf_init_peers(struct perf_ctx *perf)
>  	if (perf->gidx == -1)
>  		perf->gidx = pidx;
>  
> +	/*
> +	 * Hardware with only two ports may not have unique port
> +	 * numbers. In this case, the gidxs should all be zero.
> +	 */
> +	if (perf->pcnt == 1 &&  ntb_port_number(perf->ntb) == 0 &&
> +	    ntb_peer_port_number(perf->ntb, 0) == 0) {
> +		perf->gidx = 0;
> +		perf->peers[0].gidx = 0;
> +	}
> +
>  	for (pidx = 0; pidx < perf->pcnt; pidx++) {
>  		ret = perf_setup_peer_mw(&perf->peers[pidx]);
>  		if (ret)
> -- 
> 2.11.0
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/20180609000819.13883-8-logang%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
