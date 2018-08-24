Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196FEC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52FA21564
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C52FA21564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeHXQcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 12:32:18 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56980 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbeHXQcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 12:32:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76C96ED1;
        Fri, 24 Aug 2018 05:57:44 -0700 (PDT)
Received: from armageddon.cambridge.arm.com (armageddon.emea.arm.com [10.4.13.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67B773F675;
        Fri, 24 Aug 2018 05:57:43 -0700 (PDT)
Date:   Fri, 24 Aug 2018 13:57:40 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Vincent Whitchurch <rabinv@axis.com>
Subject: Re: [PATCH] kmemleak: Add option to print warnings to dmesg
Message-ID: <20180824125740.wy3fmtowicglyqng@armageddon.cambridge.arm.com>
References: <20180824124011.22879-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824124011.22879-1-vincent.whitchurch@axis.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 02:40:11PM +0200, Vincent Whitchurch wrote:
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 9a085d525bbc..61ba47a357fc 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -311,6 +311,9 @@ static void hex_dump_object(struct seq_file *seq,
>  	const u8 *ptr = (const u8 *)object->pointer;
>  	size_t len;
>  
> +	if (!seq)
> +		return;
> +
>  	/* limit the number of lines to HEX_MAX_LINES */
>  	len = min_t(size_t, object->size, HEX_MAX_LINES * HEX_ROW_SIZE);
>  

We have a print_hex_dump() function you could use here instead of
skipping it. Sometimes such information is useful to capture part of the
object state.

-- 
Catalin
