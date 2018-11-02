Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F31C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 262272081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 262272081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbeKCC3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 22:29:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44288 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbeKCC3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 22:29:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD07AA78;
        Fri,  2 Nov 2018 10:21:46 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CF7D3F71E;
        Fri,  2 Nov 2018 10:21:45 -0700 (PDT)
Date:   Fri, 2 Nov 2018 17:21:41 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Paul Sorensen <paulsorensen5@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Correct comparison statements in documentation
Message-ID: <20181102172140.ntuj66zscmoe572w@lakrids.cambridge.arm.com>
References: <20181102170952.46303-1-paulsorensen5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102170952.46303-1-paulsorensen5@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 10:09:52AM -0700, Paul Sorensen wrote:
> Instances of "less then" or "greater then" are corrected to "less than" or
> "greater than", respectively.
> 
> Signed-off-by: Paul Sorensen <paulsorensen5@gmail.com>
> ---

[...]

> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 7eb8dc136c1c..5e5aaee89e10 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -270,7 +270,7 @@ static unsigned int calculate_alignment(slab_flags_t flags,
>  	 * suggestion if the object is sufficiently large.
>  	 *
>  	 * The hardware cache alignment cannot override the specified
> -	 * alignment though. If that is greater then use it.
> +	 * alignment though. If that is greater than use it.
>  	 */

The original was correct.

To aid comprehension, perhaps:

	The hardware cache alignment cannot override the specified
	alignment, so use whichever is greater.

Thanks,
Mark.
