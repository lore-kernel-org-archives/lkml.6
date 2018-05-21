Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752740AbeEUKDs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 06:03:48 -0400
Received: from ozlabs.org ([203.11.71.1]:38101 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751145AbeEUKDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 06:03:07 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 20acf7fc9409e48cfbfb38262aa53466dfbc22bb
In-Reply-To: <a93c26abed5911cd92cf51b50bc4a0ca278188de.1526602763.git.fthain@telegraphics.com.au>
To: Finn Thain <fthain@telegraphics.com.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND] powerpc/lib: Fix "integer constant is too large" build failure
Message-Id: <40qDnk15vJz9s4V@ozlabs.org>
Date: Mon, 21 May 2018 20:01:29 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-05-18 at 01:18:33 UTC, Finn Thain wrote:
> My powerpc-linux-gnu-gcc v4.4.5 compiler can't build a 32-bit kernel
> any more:
> 
> arch/powerpc/lib/sstep.c: In function 'do_popcnt':
> arch/powerpc/lib/sstep.c:1068: error: integer constant is too large for 'long' type
> arch/powerpc/lib/sstep.c:1069: error: integer constant is too large for 'long' type
> arch/powerpc/lib/sstep.c:1069: error: integer constant is too large for 'long' type
> arch/powerpc/lib/sstep.c:1070: error: integer constant is too large for 'long' type
> arch/powerpc/lib/sstep.c:1079: error: integer constant is too large for 'long' type
> arch/powerpc/lib/sstep.c: In function 'do_prty':
> arch/powerpc/lib/sstep.c:1117: error: integer constant is too large for 'long' type
> 
> This file gets compiled with -std=gnu89 which means a constant can be
> given the type 'long' even if it won't fit. Fix the errors with a 'ULL'
> suffix on the relevant constants.
> 
> Fixes: 2c979c489fee ("powerpc/lib/sstep: Add prty instruction emulation")
> Fixes: dcbd19b48d31 ("powerpc/lib/sstep: Add popcnt instruction emulation")
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/20acf7fc9409e48cfbfb38262aa534

cheers
