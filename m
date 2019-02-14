Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D74C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C359F21928
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502788AbfBNQ4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:56:51 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47524 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502775AbfBNQ4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:56:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4F6415AB;
        Thu, 14 Feb 2019 08:56:48 -0800 (PST)
Received: from C02TF0J2HF1T.local (unknown [10.37.12.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 684BC3F575;
        Thu, 14 Feb 2019 08:56:46 -0800 (PST)
Date:   Thu, 14 Feb 2019 16:56:43 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will.deacon@arm.com>,
        Guan Xuetao <gxt@pku.edu.cn>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] initramfs: move the legacy keepinitrd parameter to
 core code
Message-ID: <20190214165642.GB20349@C02TF0J2HF1T.local>
References: <20190213174621.29297-1-hch@lst.de>
 <20190213174621.29297-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213174621.29297-7-hch@lst.de>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 06:46:19PM +0100, Christoph Hellwig wrote:
> No need to handle the freeing disable in arch code when we already
> have a core hook (and a different name for the option) for it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/Kconfig             |  7 +++++++
>  arch/arm/Kconfig         |  1 +
>  arch/arm/mm/init.c       | 25 ++++++-------------------
>  arch/arm64/Kconfig       |  1 +
>  arch/arm64/mm/init.c     | 17 ++---------------
>  arch/unicore32/Kconfig   |  1 +
>  arch/unicore32/mm/init.c | 14 +-------------
>  init/initramfs.c         |  9 +++++++++
>  8 files changed, 28 insertions(+), 47 deletions(-)

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
