Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63DBC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3A320658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F3A320658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbeJVRwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 13:52:49 -0400
Received: from ozlabs.org ([203.11.71.1]:50711 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727045AbeJVRwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 13:52:49 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 42drw739fGz9sDL; Mon, 22 Oct 2018 20:35:03 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: aa5456abdc20568f5da348209148a9c75a32468a
In-Reply-To: <f3a64e8451cd539f8a2e864045576ad99598160d.1529589663.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, malat@debian.org,
        aneesh.kumar@linux.vnet.ibm.com
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/mm: fix missing prototypes in slice.c
Message-Id: <42drw739fGz9sDL@ozlabs.org>
Date:   Mon, 22 Oct 2018 20:35:02 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-22 at 13:49:48 UTC, Christophe Leroy wrote:
> This patch fixes the following warnings (obtained with make W=1).
> 
> arch/powerpc/mm/slice.c: At top level:
> arch/powerpc/mm/slice.c:682:15: error: no previous prototype for 'arch_get_unmapped_area' [-Werror=missing-prototypes]
>  unsigned long arch_get_unmapped_area(struct file *filp,
>                ^
> arch/powerpc/mm/slice.c:692:15: error: no previous prototype for 'arch_get_unmapped_area_topdown' [-Werror=missing-prototypes]
>  unsigned long arch_get_unmapped_area_topdown(struct file *filp,
>                ^
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/aa5456abdc20568f5da348209148a9

cheers
