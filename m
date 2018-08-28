Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2166EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B4E20850
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:39:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B4E20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbeH1VcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:32:23 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43160 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbeH1VcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:32:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A631E18A;
        Tue, 28 Aug 2018 10:39:40 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 77A0E3F5BD;
        Tue, 28 Aug 2018 10:39:40 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 0F6F91AE3413; Tue, 28 Aug 2018 18:39:52 +0100 (BST)
Date:   Tue, 28 Aug 2018 18:39:52 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/ww_mutex: fix spelling mistake "cylic" ->
 "cyclic"
Message-ID: <20180828173951.GB20375@arm.com>
References: <20180824112235.8842-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824112235.8842-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 12:22:35PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in pr_err error message
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  kernel/locking/test-ww_mutex.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Given that this is part of an error message, I agree it's worth fixing.

Will

> diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
> index 5b915b370d5a..0be047dbd897 100644
> --- a/kernel/locking/test-ww_mutex.c
> +++ b/kernel/locking/test-ww_mutex.c
> @@ -324,7 +324,7 @@ static int __test_cycle(unsigned int nthreads)
>  		if (!cycle->result)
>  			continue;
>  
> -		pr_err("cylic deadlock not resolved, ret[%d/%d] = %d\n",
> +		pr_err("cyclic deadlock not resolved, ret[%d/%d] = %d\n",
>  		       n, nthreads, cycle->result);
>  		ret = -EINVAL;
>  		break;
> -- 
> 2.17.1
> 
