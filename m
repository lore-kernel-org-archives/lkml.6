Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752734AbeENMKZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:10:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34932 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752209AbeENMKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:10:23 -0400
Date: Mon, 14 May 2018 05:10:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, dave.martin@arm.com, james.morse@arm.com,
        linux@dominikbrodowski.net, linux-fsdevel@vger.kernel.org,
        marc.zyngier@arm.com, viro@zeniv.linux.org.uk, will.deacon@arm.com
Subject: Re: [PATCH 17/18] arm64: convert compat wrappers to C
Message-ID: <20180514121022.GB11638@infradead.org>
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-18-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514094640.27569-18-mark.rutland@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +COMPAT_SYSCALL_DEFINE3(aarch32_statfs64, const char __user *, pathname,
> +		       compat_size_t, sz, struct compat_statfs64 __user *, buf)
> +{
> +	if (sz == 88)
> +		sz = 84;
> +
> +	return kcompat_sys_statfs64(pathname, sz, buf);

This really needs a comment, and it looks very obviously bogus.
In case it isn't it needs a very good explanation.
