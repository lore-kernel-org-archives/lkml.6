Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387ACC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097D92082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 097D92082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbeJ2TRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 15:17:16 -0400
Received: from foss.arm.com ([217.140.101.70]:38424 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729487AbeJ2TRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 15:17:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D10C11682;
        Mon, 29 Oct 2018 03:29:12 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A1CEE3F6A8;
        Mon, 29 Oct 2018 03:29:12 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 990E61AE0757; Mon, 29 Oct 2018 10:29:19 +0000 (GMT)
Date:   Mon, 29 Oct 2018 10:29:19 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kyeongdon Kim <kyeongdon.kim@lge.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 1/3] linkage.h: Align weak symbols.
Message-ID: <20181029102919.GB14127@arm.com>
References: <20180914152800.GB6236@arm.com>
 <20180920135631.23833-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920135631.23833-1-aryabinin@virtuozzo.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 04:56:29PM +0300, Andrey Ryabinin wrote:
> Since WEAK() supposed to be used instead of ENTRY() to define weak
> symbols, but unlike ENTRY() it doesn't have ALIGN directive.
> It seems there is no actual reason to not have, so let's add
> ALIGN to WEAK() too.
> 
> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> ---
>  include/linux/linkage.h | 1 +
>  1 file changed, 1 insertion(+)

Looks sensible to me:

Acked-by: Will Deacon <will.deacon@arm.com>

Will

> diff --git a/include/linux/linkage.h b/include/linux/linkage.h
> index d7618c41f74c..7c47b1a471d4 100644
> --- a/include/linux/linkage.h
> +++ b/include/linux/linkage.h
> @@ -90,6 +90,7 @@
>  #ifndef WEAK
>  #define WEAK(name)	   \
>  	.weak name ASM_NL   \
> +	ALIGN ASM_NL \
>  	name:
>  #endif
>  
> -- 
> 2.16.4
> 
