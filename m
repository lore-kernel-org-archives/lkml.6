Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C12FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F54120675
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbfAQA1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 19:27:31 -0500
Received: from ozlabs.org ([203.11.71.1]:46249 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728247AbfAQA1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 19:27:31 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43g4f9229qz9sD9; Thu, 17 Jan 2019 11:27:29 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: da727097a482a93645ba5beea8d389ebab11fc64
X-Patchwork-Hint: ignore
In-Reply-To: <20190115004745.9996-1-Jason@zx2c4.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>, benh@kernel.crashing.org,
        paulus@samba.org, aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: powerpc: PCI does not require PowerNV
Message-Id: <43g4f9229qz9sD9@ozlabs.org>
Date:   Thu, 17 Jan 2019 11:27:29 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-15 at 00:47:45 UTC, "Jason A. Donenfeld" wrote:
> Commit 0e759bd75285 moved around the declaration of pnv_npu2_init, but
> did not conditionalize it inside of the PCI pSeries driver. This meant
> that CONFIG_PCI && CONFIG_PPC_PSERIES && !CONFIG_PPC_POWERNV resulted
> in:
> 
> powerpc64le-pc-linux-gnu-ld: arch/powerpc/platforms/pseries/pci.o: in function `pSeries_final_fixup':
> pci.c:(.init.text+0x1b0): undefined reference to `pnv_npu2_init'
> 
> This commit therefore wraps that line in an ifdef, so that PCI works
> without PowerNV.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Fixes: 0e759bd75285 ("powerpc/powernv/npu: Move OPAL calls away from context manipulation")
> Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/da727097a482a93645ba5beea8d389eb

cheers
