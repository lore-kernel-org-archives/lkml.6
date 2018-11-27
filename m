Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0EAC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3092A2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:22:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3092A2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbeK0UTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:19:38 -0500
Received: from ozlabs.org ([203.11.71.1]:50677 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729950AbeK0UTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:19:37 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 433ywq3bcFz9s6w; Tue, 27 Nov 2018 20:22:19 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: beba24ac59133cb36ecd03f9af9ccb11971ee20e
In-Reply-To: <20181031123157.24947-1-malat@debian.org>
To:     Mathieu Malaterre <malat@debian.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/32: Add .data..Lubsan_data*/.data..Lubsan_type* sections explicitly
Message-Id: <433ywq3bcFz9s6w@ozlabs.org>
Date:   Tue, 27 Nov 2018 20:22:19 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-31 at 12:31:56 UTC, Mathieu Malaterre wrote:
> When both `CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y` and `CONFIG_UBSAN=y`
> are set, link step typically produce numberous warnings about orphan
> section:
> 
>   + powerpc-linux-gnu-ld -EB -m elf32ppc -Bstatic --orphan-handling=warn --build-id --gc-sections -X -o .tmp_vmlinux1 -T ./arch/powerpc/kernel/vmlinux.lds --who
>   le-archive built-in.a --no-whole-archive --start-group lib/lib.a --end-group
>   powerpc-linux-gnu-ld: warning: orphan section `.data..Lubsan_data393' from `init/main.o' being placed in section `.data..Lubsan_data393'.
>   powerpc-linux-gnu-ld: warning: orphan section `.data..Lubsan_data394' from `init/main.o' being placed in section `.data..Lubsan_data394'.
>   ...
>   powerpc-linux-gnu-ld: warning: orphan section `.data..Lubsan_type11' from `init/main.o' being placed in section `.data..Lubsan_type11'.
>   powerpc-linux-gnu-ld: warning: orphan section `.data..Lubsan_type12' from `init/main.o' being placed in section `.data..Lubsan_type12'.
>   ...
> 
> This commit remove those warnings produced at W=1.
> 
> Link: https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg135407.html
> Suggested-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/beba24ac59133cb36ecd03f9af9ccb

cheers
