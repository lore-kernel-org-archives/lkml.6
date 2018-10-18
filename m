Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E387FC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB7C2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB7C2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbeJRW2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 18:28:00 -0400
Received: from foss.arm.com ([217.140.101.70]:38894 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727334AbeJRW2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 18:28:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56E1EA78;
        Thu, 18 Oct 2018 07:26:44 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A63043F71A;
        Thu, 18 Oct 2018 07:26:40 -0700 (PDT)
Date:   Thu, 18 Oct 2018 15:26:31 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Nickhu <nickhu@andestech.com>
Cc:     greentime@andestech.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, deanbo422@gmail.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, arnd@arndb.de, sboyd@codeaurora.org,
        geert@linux-m68k.org, zong@andestech.com, ebiederm@xmission.com,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, tglx@linutronix.de,
        kstewart@linuxfoundation.org, devicetree@vger.kernel.org,
        green.hu@gmail.com
Subject: Re: [PATCH 2/5] nds32: Fix bug in bitfield.h
Message-ID: <20181018142622.p3hrrymexubkkuf5@lakrids.cambridge.arm.com>
References: <cover.1539745993.git.nickhu@andestech.com>
 <6702edd2853db9a475853a9b8d00b5aacf546bb2.1539745993.git.nickhu@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6702edd2853db9a475853a9b8d00b5aacf546bb2.1539745993.git.nickhu@andestech.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 04:43:14PM +0800, Nickhu wrote:
> There two bitfield bug for perfomance counter
> in bitfield.h:
> 
> 	PFM_CTL_offSEL1		21 --> 16
> 	PFM_CTL_offSEL2		27 --> 22
> 
> This commit fix it.
> 
> Signed-off-by: Nickhu <nickhu@andestech.com>

This patch should probably be move before the patch adding perf support.
That way, perf support isn't broken at the point it is added.

Thanks,
Mark.

> ---
>  arch/nds32/include/asm/bitfield.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/nds32/include/asm/bitfield.h b/arch/nds32/include/asm/bitfield.h
> index 8e84fc385b94..19b2841219ad 100644
> --- a/arch/nds32/include/asm/bitfield.h
> +++ b/arch/nds32/include/asm/bitfield.h
> @@ -692,8 +692,8 @@
>  #define PFM_CTL_offKU1		13	/* Enable user mode event counting for PFMC1 */
>  #define PFM_CTL_offKU2		14	/* Enable user mode event counting for PFMC2 */
>  #define PFM_CTL_offSEL0		15	/* The event selection for PFMC0 */
> -#define PFM_CTL_offSEL1		21	/* The event selection for PFMC1 */
> -#define PFM_CTL_offSEL2		27	/* The event selection for PFMC2 */
> +#define PFM_CTL_offSEL1		16	/* The event selection for PFMC1 */
> +#define PFM_CTL_offSEL2		22	/* The event selection for PFMC2 */
>  /* bit 28:31 reserved */
>  
>  #define PFM_CTL_mskEN0		( 0x01  << PFM_CTL_offEN0 )
> -- 
> 2.17.0
> 
