Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A1BC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A21E217AC
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A21E217AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbeHMOEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 10:04:45 -0400
Received: from ozlabs.org ([203.11.71.1]:47043 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728356AbeHMOEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 10:04:45 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 41ptct30gwz9ryt; Mon, 13 Aug 2018 21:22:54 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 2fff0f07b8441a481eb5fc0bfcd0e46d6dbd90db
In-Reply-To: <20180322202007.23088-17-malat@debian.org>
To:     Mathieu Malaterre <malat@debian.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [16/19] powerpc/powermac: Add missing include of header pmac.h
Message-Id: <41ptct30gwz9ryt@ozlabs.org>
Date:   Mon, 13 Aug 2018 21:22:54 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-22 at 20:20:02 UTC, Mathieu Malaterre wrote:
> The header `pmac.h` was not included, leading to the following warnings,
> treated as error with W=1:
> 
>   arch/powerpc/platforms/powermac/time.c:69:13: error: no previous prototype for ‘pmac_time_init’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/powermac/time.c:207:15: error: no previous prototype for ‘pmac_get_boot_time’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/powermac/time.c:222:6: error: no previous prototype for ‘pmac_get_rtc_time’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/powermac/time.c:240:5: error: no previous prototype for ‘pmac_set_rtc_time’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/powermac/time.c:259:12: error: no previous prototype for ‘via_calibrate_decr’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/powermac/time.c:311:13: error: no previous prototype for ‘pmac_calibrate_decr’ [-Werror=missing-prototypes]
> 
> The function `via_calibrate_decr` was made static to silence a warning.
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2fff0f07b8441a481eb5fc0bfcd0e4

cheers
