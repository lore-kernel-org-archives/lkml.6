Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D533C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 06:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBCA7208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 06:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q+5ll7qw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBCA7208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932939AbeFUGnb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 02:43:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36592 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932883AbeFUGnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 02:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6JKGCagtb+ioQ5uE0jW9Tka9XBnC7KqDUk1no8bR0rU=; b=q+5ll7qwib2bMLNzCvHsvDuIq
        u2fgQ40K29wRrez/wps+SLqJ7QXvtPeaoE4MidMlS63W/W1tDYGlN/XN9q29+Ity+MXJbTBzbrzx4
        vR60qu/fuCYeBMCZm/8EVGwFiSLX61CknoRHn0JZl9V/tift4RupsbEJBZKYzGbDpJzHjzhoryqWp
        UFuoTVZkBy/S45WS/jGYxCanAaCrEMybrOQN6Ze+1VIgD0Qtlu8KlIJSbWIZTr2XrthGCnzjcJnaU
        EWF0hUds+eDAo/p6WiaPj/F3O01UaxiQdXH2jkzYGg8SF3shAk3nSgxAoUo7xpJJALhyL3vAaOuxX
        rIaMm3SSQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVtJS-0004Hi-FW; Thu, 21 Jun 2018 06:43:22 +0000
Date:   Wed, 20 Jun 2018 23:43:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Zong Li <zong@andestech.com>
Cc:     palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        greentime@adnestech.com
Subject: Re: [PATCH 5/5] RISC-V: Use fixed width integer types for 32-bit
 compatible
Message-ID: <20180621064322.GE19319@infradead.org>
References: <cover.1529506497.git.zong@andestech.com>
 <37a6523947397cd72320676030b96926e373d05a.1529506497.git.zong@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37a6523947397cd72320676030b96926e373d05a.1529506497.git.zong@andestech.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 09:41:46AM +0800, Zong Li wrote:
> Use fixed width integer types for print format on 32/64 bit
> to fix warning about format compatible.
> 
> Like inttypes.h, but more simpler for RISC-V usage.
> 
> Signed-off-by: Zong Li <zong@andestech.com>
> ---
>  arch/riscv/include/asm/format.h | 20 ++++++++++++++++++++
>  arch/riscv/kernel/module.c      | 13 +++++++------
>  2 files changed, 27 insertions(+), 6 deletions(-)
>  create mode 100644 arch/riscv/include/asm/format.h
> 
> diff --git a/arch/riscv/include/asm/format.h b/arch/riscv/include/asm/format.h
> new file mode 100644
> index 000000000000..9b68ca7fac46
> --- /dev/null
> +++ b/arch/riscv/include/asm/format.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2018 Andes Technology Corporation */
> +
> +#ifndef _ASM_RISCV_FORMAT_H
> +#define _ASM_RISCV_FORMAT_H
> +
> +#if __riscv_xlen == 64
> +#define __PRI_PREFIX	"ll"
> +#else
> +#define __PRI_PREFIX
> +#endif
> +
> +#define PRIdX	__PRI_PREFIX "d"
> +#define PRIiX	__PRI_PREFIX "i"
> +#define PRIuX	__PRI_PREFIX "u"
> +#define PRIoX	__PRI_PREFIX "o"
> +#define PRIxX	__PRI_PREFIX "x"
> +#define PRIXX	__PRI_PREFIX "X"
> +
> +#endif /* _ASM_RISCV_FORMAT_H */

If you want these prefixed submit them to the core kernel, not
under asm/ for RISC-V.

>  
>  static int apply_r_riscv_32_rela(struct module *me, u32 *location, Elf_Addr v)
>  {
>  	if (v != (u32)v) {
> -		pr_err("%s: value %016llx out of range for 32-bit field\n",
> +		pr_err("%s: value %016" PRIxX "out of range for 32-bit field\n",
>  		       me->name, v);
>  		return -EINVAL;

But in general Linux uXX and sXX values are always the same underlying
fundamental C type.  What is the mismatch here?
