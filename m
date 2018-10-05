Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E2FC64EBC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 01:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C475D20834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 01:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C475D20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbeJEIdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 04:33:31 -0400
Received: from ozlabs.org ([203.11.71.1]:33553 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbeJEIdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 04:33:31 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 42RC6W3bXgz9sB7; Fri,  5 Oct 2018 11:37:07 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 242cdad873a75652f97c35aad61270581e0f3a2e
In-Reply-To: <20180921025431.28366-1-joel@jms.id.au>
To:     Joel Stanley <joel@jms.id.au>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Meelis Roos <mroos@linux.ee>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: lib/xz: Put CRC32_POLY_LE in xz_private.h
Message-Id: <42RC6W3bXgz9sB7@ozlabs.org>
Date:   Fri,  5 Oct 2018 11:37:07 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-09-21 at 02:54:31 UTC, Joel Stanley wrote:
> This fixes a regression introduced by faa16bc404d72a5 ("lib: Use
> existing define with polynomial").
> 
> The cleanup added a dependency on include/linux, which broke the PowerPC
> boot wrapper/decompresser when KERNEL_XZ is enabled:
> 
>   BOOTCC  arch/powerpc/boot/decompress.o
>  In file included from arch/powerpc/boot/../../../lib/decompress_unxz.c:233,
>                  from arch/powerpc/boot/decompress.c:42:
>  arch/powerpc/boot/../../../lib/xz/xz_crc32.c:18:10: fatal error:
>  linux/crc32poly.h: No such file or directory
>   #include <linux/crc32poly.h>
>            ^~~~~~~~~~~~~~~~~~~
> 
> The powerpc decompresser is a hairy corner of the kernel. Even while building
> a 64-bit kernel it needs to build a 32-bit binary and therefore avoid including
> files from include/linux.
> 
> This allows users of the xz library to avoid including headers from
> 'include/linux/' while still achieving the cleanup of the magic number.
> 
> Fixes: faa16bc404d72a5 ("lib: Use existing define with polynomial")
> Reported-by: Meelis Roos <mroos@linux.ee>
> Reported-by: kbuild test robot <lkp@intel.com>
> Suggested-by: Christophe LEROY <christophe.leroy@c-s.fr>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Tested-by: Meelis Roos <mroos@linux.ee>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/242cdad873a75652f97c35aad61270

cheers
