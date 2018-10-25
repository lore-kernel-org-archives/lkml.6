Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F03ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A82A20831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z6XM8dy+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A82A20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbeJYInl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 04:43:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58872 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeJYInl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 04:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6Dz0CJy/5m7+uS7QA3MDg01ayJogASJH3CHbkaAtNKw=; b=Z6XM8dy+7o59O0wgwPXKr3rDT
        DRZveygxmqZfJVMU1fB2fXcFRnXnnwNw6XQ+16NUBI45rqW2WAJ7uFVNLbBywKJDN7f34fFWV111x
        aIWADb8CNuBUQzKdoQUOIGaFkWu8uI/LNy5qthqVrs2+Qz+xRShczF/QvuiL+QLrzvgqleLXWyWI8
        TXt9vxzH6nX1Q9/uA6AMyrVln5fGCdb+1UlzGhKlXnabWG4N4g/GkPIMQMLvkIXVIdG6k0QcBDxzd
        qQS+F4QOOfr3Urnswjx0BCx+6pip5ZLbmRnVdf9l2bnd2HmqalysQlKud1+0yP78ALXQBLRAzdSaM
        xFGbJDnFw==;
Received: from [167.98.65.38] (helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gFTH2-0001hf-Qq; Thu, 25 Oct 2018 00:13:17 +0000
Received: by worktop (Postfix, from userid 1000)
        id CC0816E0647; Thu, 25 Oct 2018 02:13:12 +0200 (CEST)
Date:   Thu, 25 Oct 2018 02:13:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, igor.stoppa@huawei.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/17] prmem: pratomic-long
Message-ID: <20181025001312.GA3159@worktop.c.hoisthospitality.com>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-17-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023213504.28905-17-igor.stoppa@huawei.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 12:35:03AM +0300, Igor Stoppa wrote:
> +static __always_inline
> +bool __pratomic_long_op(bool inc, struct pratomic_long_t *l)
> +{
> +	struct page *page;
> +	uintptr_t base;
> +	uintptr_t offset;
> +	unsigned long flags;
> +	size_t size = sizeof(*l);
> +	bool is_virt = __is_wr_after_init(l, size);
> +
> +	if (WARN(!(is_virt || likely(__is_wr_pool(l, size))),
> +		 WR_ERR_RANGE_MSG))
> +		return false;
> +	local_irq_save(flags);
> +	if (is_virt)
> +		page = virt_to_page(l);
> +	else
> +		vmalloc_to_page(l);
> +	offset = (~PAGE_MASK) & (uintptr_t)l;
> +	base = (uintptr_t)vmap(&page, 1, VM_MAP, PAGE_KERNEL);
> +	if (WARN(!base, WR_ERR_PAGE_MSG)) {
> +		local_irq_restore(flags);
> +		return false;
> +	}
> +	if (inc)
> +		atomic_long_inc((atomic_long_t *)(base + offset));
> +	else
> +		atomic_long_dec((atomic_long_t *)(base + offset));
> +	vunmap((void *)base);
> +	local_irq_restore(flags);
> +	return true;
> +
> +}

That's just hideously nasty.. and horribly broken.

We're not going to duplicate all these kernel interfaces wrapped in gunk
like that. Also, you _cannot_ call vunmap() with IRQs disabled. Clearly
you've never tested this with debug bits enabled.
