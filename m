Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025A0C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B456D21746
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B456D21746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbeHMOEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 10:04:49 -0400
Received: from ozlabs.org ([203.11.71.1]:44099 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728356AbeHMOEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 10:04:48 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 41ptcx3rGLz9sBZ; Mon, 13 Aug 2018 21:22:57 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 618a89d738fdd97f6fc58b7b666c7a84b2bb95e3
In-Reply-To: <20180328193935.1338-1-malat@debian.org>
To:     Mathieu Malaterre <malat@debian.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [v2,07/19] powerpc/powermac: Make some functions static
Message-Id: <41ptcx3rGLz9sBZ@ozlabs.org>
Date:   Mon, 13 Aug 2018 21:22:57 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-28 at 19:39:35 UTC, Mathieu Malaterre wrote:
> These functions can all be static, make it so. Fix warnings treated as
> errors with W=1:
> 
>   arch/powerpc/platforms/powermac/pci.c:1022:6: error: no previous prototype for ‘pmac_pci_fixup_ohci’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/powermac/pci.c:1057:6: error: no previous prototype for ‘pmac_pci_fixup_cardbus’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/powermac/pci.c:1094:6: error: no previous prototype for ‘pmac_pci_fixup_pciata’ [-Werror=missing-prototypes]
> 
> Remove has_address declaration and assignment since not used. Also add gcc
> attribute unused to fix a warning treated as error with W=1:
> 
>   arch/powerpc/platforms/powermac/pci.c:784:19: error: variable ‘has_address’ set but not used [-Werror=unused-but-set-variable]
>   arch/powerpc/platforms/powermac/pci.c:907:22: error: variable ‘ht’ set but not used [-Werror=unused-but-set-variable]
> 
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/618a89d738fdd97f6fc58b7b666c7a

cheers
