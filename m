Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C39FC282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88852146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfBHNCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:02:50 -0500
Received: from ozlabs.org ([203.11.71.1]:56315 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727675AbfBHNCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:02:48 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43wwMT34bmz9sPP; Sat,  9 Feb 2019 00:02:44 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 26b523356f49a0117c8f9e32ca98aa6d6e496e1a
X-Patchwork-Hint: ignore
In-Reply-To: <a14aac5408f98cf8ad8723ffa874764ccb42d4d4.1548978750.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v2] powerpc: drop page_is_ram() and walk_system_ram_range()
Message-Id: <43wwMT34bmz9sPP@ozlabs.org>
Date:   Sat,  9 Feb 2019 00:02:44 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-02-01 at 10:46:52 UTC, Christophe Leroy wrote:
> Since commit c40dd2f76644 ("powerpc: Add System RAM to /proc/iomem")
> it is possible to use the generic walk_system_ram_range() and
> the generic page_is_ram().
> 
> To enable the use of walk_system_ram_range() by the IBM EHEA
> ethernet driver, the generic function has to be exported.
> 
> As powerpc was the only (last?) user of CONFIG_ARCH_HAS_WALK_MEMORY,
> the #ifdef around the generic walk_system_ram_range() has become
> useless and can be dropped.
> 
> Fixes: c40dd2f76644 ("powerpc: Add System RAM to /proc/iomem")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/26b523356f49a0117c8f9e32ca98aa6d

cheers
