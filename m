Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E020FC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B17921738
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B17921738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731909AbeHNMPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 08:15:13 -0400
Received: from ozlabs.org ([203.11.71.1]:55743 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728314AbeHNMPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 08:15:13 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41qS2l1wCwz9s0n;
        Tue, 14 Aug 2018 19:28:47 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     zhong jiang <zhongjiang@huawei.com>, tony.luck@intel.com,
        fenghua.yu@intel.com, benh@kernel.crashing.org, paulus@samba.org,
        oleg@redhat.com, rppt@linux.vnet.ibm.com, dhowells@redhat.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc: Use ARRAY_SIZE to replace its implementation
In-Reply-To: <1534214814-9043-3-git-send-email-zhongjiang@huawei.com>
References: <1534214814-9043-1-git-send-email-zhongjiang@huawei.com> <1534214814-9043-3-git-send-email-zhongjiang@huawei.com>
Date:   Tue, 14 Aug 2018 19:28:46 +1000
Message-ID: <874lfxjnzl.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zhong jiang <zhongjiang@huawei.com> writes:
> Use ARRAY_SIZE instead of dividing sizeof array with sizeof an element.
> So just replace it.
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  arch/powerpc/xmon/ppc-opc.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

This code is copied from binutils and we don't want to needlessly cause
it to diverge from the binutils copy.

So thanks but no thanks.

cheers

> diff --git a/arch/powerpc/xmon/ppc-opc.c b/arch/powerpc/xmon/ppc-opc.c
> index ac2b55b..f3f57a1 100644
> --- a/arch/powerpc/xmon/ppc-opc.c
> +++ b/arch/powerpc/xmon/ppc-opc.c
> @@ -966,8 +966,7 @@
>    { 0xff, 11, NULL, NULL, PPC_OPERAND_SIGNOPT },
>  };
>  
> -const unsigned int num_powerpc_operands = (sizeof (powerpc_operands)
> -					   / sizeof (powerpc_operands[0]));
> +const unsigned int num_powerpc_operands = ARRAY_SIZE(powerpc_operands);
>  
>  /* The functions used to insert and extract complicated operands.  */
>  
> @@ -6980,8 +6979,7 @@
>  {"fcfidu.",	XRC(63,974,1),	XRA_MASK, POWER7|PPCA2,	PPCVLE,		{FRT, FRB}},
>  };
>  
> -const int powerpc_num_opcodes =
> -  sizeof (powerpc_opcodes) / sizeof (powerpc_opcodes[0]);
> +const int powerpc_num_opcodes = ARRAY_SIZE(powerpc_opcodes);
>  
>  /* The VLE opcode table.
>  
> @@ -7219,8 +7217,7 @@
>  {"se_bl",	BD8(58,0,1),	BD8_MASK,	PPCVLE,	0,		{B8}},
>  };
>  
> -const int vle_num_opcodes =
> -  sizeof (vle_opcodes) / sizeof (vle_opcodes[0]);
> +const int vle_num_opcodes = ARRAY_SIZE(vle_opcodes);
>  
>  /* The macro table.  This is only used by the assembler.  */
>  
> @@ -7288,5 +7285,4 @@
>  {"e_clrlslwi",4, PPCVLE, "e_rlwinm %0,%1,%3,(%2)-(%3),31-(%3)"},
>  };
>  
> -const int powerpc_num_macros =
> -  sizeof (powerpc_macros) / sizeof (powerpc_macros[0]);
> +const int powerpc_num_macros = ARRAY_SIZE(powerpc_macros);
> -- 
> 1.7.12.4
