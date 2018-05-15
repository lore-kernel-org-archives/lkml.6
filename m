Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1837638-1526353526-2-16232720703758427902
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526353526; b=F5NfK9/NlZhZ37pt2kxR5h/t4i7zA/9b/FxA7TH3IRXzKjFnpb
    2TwW8TiCbdRKgtstEoT/zKOGvhwZCRluQnfYCBZPs3BpgniHxT2M/YcqcZPseBa8
    nkobqb/tFU8WoAFlVgbr3J8xygTLsE1kQMv2UfJi/iQDq/TXm9FatP7JBDHt2Xau
    6vJ2NXBf6pa/BAYAddK2AiFgoHZHbjekTyOi7CJ+u4eipWZeSJeHKfPvob9Cz0PB
    i1pWkzaDhZ4NGKS4yySh9ibJXqoBMC31uimplllUkuBOswQfGuoN2lFQetQHCXFM
    8a+FWIwoMLz8Lhf4KbwDdtySgtRY0QGOsuiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    fm2; t=1526353526; bh=l7d1dN7lI8NgnZLVwd5KDA6w31rzzywI1XJtrsCjNe
    I=; b=QXJqWw8W5WqWU0UYnSZJKwwNX/8zvBSBC2qBIQ7zl/Hf5SXJOEMsWm+g0x
    q9lt+KhEFBHUpuaI7WG8Ln6/masYQF7qlXOBKCjmxND9r+sE08EgRFxsk8uDX7HR
    vpgnJooOpLjUkxg/GvvUdJy2EVCHzoJzNDnUv1eDrIZrX38WIM7lN1+AeUu2o9wK
    dG1X91ochArhE6CfCnBDo/GM8c2a/r5pCdjKfvQXq+6vjMA7Opt2DOe/+cDiC1Ho
    2FHsbCdViRZT26o9olISyCSUeQtoeGQBt+tnvUxLPde2qWKxVMgMrTBkIWxFa7fR
    vez1Vl7JFr7fJ84u5Bi3Ldge0/Mw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ellerman.id.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=ellerman.id.au header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ellerman.id.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=ellerman.id.au header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN2Gzwmpl48PDdJzNuKiimzjLNOdtBgMxdOoIfC3HPqea5VmQj1mSlTplJGn84r3TbZUDblRAuFGT6bT/No9Pf8+Vvl3M9aCt5ZTrhPsxf+nWJrvB80c
    VDXvywjV120yysrP5H5rxwlb7rGhbSKqWDxsJ9Y2uxO3JvKDXlx1n9Lc0diMyiZzZVtlhclXVKPmTbYBIF/LDQj3ym61QmmiU+CwvxHZlKGBZVc6dBqBnVZB
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=7CQSdrXTAAAA:8
    a=wMNdZWldAAAA:8 a=hGzw-44bAAAA:8 a=PCr46jiiVugRpmzwUMoA:9
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=FUarYpL4UH3yWsho8X8J:22 a=HvKuF1_PTVFglORKqfwH:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeEODFX (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 23:05:23 -0400
Received: from ozlabs.org ([203.11.71.1]:35645 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752009AbeEODFW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 May 2018 23:05:22 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC PATCH 06/11] powerpc: Remove unused task argument from prctl functions
In-Reply-To: <1526318067-4964-7-git-send-email-Dave.Martin@arm.com>
References: <1526318067-4964-1-git-send-email-Dave.Martin@arm.com> <1526318067-4964-7-git-send-email-Dave.Martin@arm.com>
Date: Tue, 15 May 2018 13:05:21 +1000
Message-ID: <87in7ppqj2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Dave Martin <Dave.Martin@arm.com> writes:

> Some powerpc-specific prctl backends take a task argument that is
> redundant, since the only thing ever passed is "current".
>
> This patch gets rid of the redundant arguments.
>
> No functional change.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/processor.h | 16 ++++++++--------
>  arch/powerpc/kernel/process.c        | 30 +++++++++++++++---------------
>  kernel/sys.c                         | 12 ++++++------
>  3 files changed, 29 insertions(+), 29 deletions(-)

This looks fine. I'm happy for it to get tested in linux-next to shake
out anything subtle.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
