Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776EAC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376B2204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 376B2204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbeLJTAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:00:45 -0500
Received: from foss.arm.com ([217.140.101.70]:60934 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727348AbeLJTAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:00:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CCB1EBD;
        Mon, 10 Dec 2018 11:00:45 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D07F93F6A8;
        Mon, 10 Dec 2018 11:00:44 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 7015C1AE0B8F; Mon, 10 Dec 2018 19:01:07 +0000 (GMT)
Date:   Mon, 10 Dec 2018 19:01:07 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, anders.roxell@linaro.org,
        boqun.feng@gmail.com, naresh.kamboju@linaro.org,
        peterz@infradead.org
Subject: Re: [PATCH 1/2] locking/atomics: Change 'fold' to 'grep'
Message-ID: <20181210190107.GA28127@edgewater-inn.cambridge.arm.com>
References: <20181210175035.45096-1-mark.rutland@arm.com>
 <20181210175035.45096-2-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210175035.45096-2-mark.rutland@arm.com>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 05:50:34PM +0000, Mark Rutland wrote:
> From: Anders Roxell <anders.roxell@linaro.org>
> 
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
> [Mark: rework commit message]
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
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
>  }

Acked-by: Will Deacon <will.deacon@arm.com>

Will
