Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A3FC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B7F20891
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B7F20891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbeGYRHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:07:35 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41302 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728568AbeGYRHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:07:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2092880D;
        Wed, 25 Jul 2018 08:55:18 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 560FE3F575;
        Wed, 25 Jul 2018 08:55:16 -0700 (PDT)
Date:   Wed, 25 Jul 2018 16:55:13 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, oleg@redhat.com,
        linux@dominikbrodowski.net, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, steve.mcintyre@arm.com,
        linux-arm-kernel@lists.infradead.org, ebiederm@xmission.com
Subject: Re: [PATCH 2/2] arm64: compat: Provide definition for
 COMPAT_SIGMINSTKSZ
Message-ID: <20180725155513.GS4240@e103592.cambridge.arm.com>
References: <1532526312-26993-1-git-send-email-will.deacon@arm.com>
 <1532526312-26993-3-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532526312-26993-3-git-send-email-will.deacon@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 02:45:12PM +0100, Will Deacon wrote:
> arch/arm/ defines a SIGMINSTKSZ of 2k, so we should use the same value
> for compat tasks.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Reported-by: Steve McIntyre <steve.mcintyre@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

> ---
>  arch/arm64/include/asm/compat.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
> index 1a037b94eba1..cee28a05ee98 100644
> --- a/arch/arm64/include/asm/compat.h
> +++ b/arch/arm64/include/asm/compat.h
> @@ -159,6 +159,7 @@ static inline compat_uptr_t ptr_to_compat(void __user *uptr)
>  }
>  
>  #define compat_user_stack_pointer() (user_stack_pointer(task_pt_regs(current)))
> +#define COMPAT_MINSIGSTKSZ	2048
>  
>  static inline void __user *arch_compat_alloc_user_space(long len)
>  {
> -- 
> 2.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
