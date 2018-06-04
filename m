Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753714AbeFDOLE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:11:04 -0400
Received: from ozlabs.org ([203.11.71.1]:52609 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753349AbeFDOLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:11:02 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 1128bb7813a896bd608fb622eee3c26aaf33b473
In-Reply-To: <20180518130116.A1A3B6F937@po14934vm.idsi0.si.c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v2] powerpc/lib: Adjust .balign inside string functions for PPC32
Message-Id: <40zxg75qFJz9s5b@ozlabs.org>
Date: Tue,  5 Jun 2018 00:10:58 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-05-18 at 13:01:16 UTC, Christophe Leroy wrote:
> commit 87a156fb18fe1 ("Align hot loops of some string functions")
> degraded the performance of string functions by adding useless
> nops
> 
> A simple benchmark on an 8xx calling 100000x a memchr() that
> matches the first byte runs in 41668 TB ticks before this patch
> and in 35986 TB ticks after this patch. So this gives an
> improvement of approx 10%
> 
> Another benchmark doing the same with a memchr() matching the 128th
> byte runs in 1011365 TB ticks before this patch and 1005682 TB ticks
> after this patch, so regardless on the number of loops, removing
> those useless nops improves the test by 5683 TB ticks.
> 
> Fixes: 87a156fb18fe1 ("Align hot loops of some string functions")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1128bb7813a896bd608fb622eee3c2

cheers
