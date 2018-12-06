Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81B4C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40BA208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B40BA208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbeLFPwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:52:24 -0500
Received: from foss.arm.com ([217.140.101.70]:53972 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbeLFPwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:52:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B76F580D;
        Thu,  6 Dec 2018 07:52:23 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 880333F59C;
        Thu,  6 Dec 2018 07:52:23 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id A3A141AE0BD1; Thu,  6 Dec 2018 15:52:44 +0000 (GMT)
Date:   Thu, 6 Dec 2018 15:52:44 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Anders Roxell <anders.roxell@linaro.org>, mingo@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCH] scripts/atomic: change 'fold' to 'grep'
Message-ID: <20181206155244.GA4389@arm.com>
References: <20181204214713.5812-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204214713.5812-1-anders.roxell@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+ Ingo and Mark]

On Tue, Dec 04, 2018 at 10:47:13PM +0100, Anders Roxell wrote:
> Some distibutions and build systems doesn't include 'fold' from
> coreutils default.
> 
> .../scripts/atomic/atomic-tbl.sh: line 183: fold: command not found
> 
> Rework to use 'grep' instead of 'fold' to use a dependency that is
> already used a lot in the kernel.
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Suggested-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  scripts/atomic/atomic-tbl.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/atomic/atomic-tbl.sh b/scripts/atomic/atomic-tbl.sh
> index 9d6be538a987..81d5c32039dd 100755
> --- a/scripts/atomic/atomic-tbl.sh
> +++ b/scripts/atomic/atomic-tbl.sh
> @@ -180,7 +180,7 @@ gen_proto_variants()
>  #gen_proto(meta, ...)
>  gen_proto() {
>  	local meta="$1"; shift
> -	for m in $(echo "${meta}" | fold -w1); do
> +	for m in $(echo "${meta}" | grep -o .); do
>  		gen_proto_variants "${m}" "$@"
>  	done

Acked-by: Will Deacon <will.deacon@arm.com>

Ingo -- please can you take this one via -tip?

Cheers,

Will
