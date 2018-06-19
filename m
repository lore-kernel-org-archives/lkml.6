Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C141C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35AC320020
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35AC320020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751587AbeFSX2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 19:28:51 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:43494 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbeFSX2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 19:28:50 -0400
Received: from mipsdag01.mipstec.com (mail1.mips.com [12.201.5.31]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Tue, 19 Jun 2018 23:28:28 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag01.mipstec.com
 (10.20.40.46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Tue, 19
 Jun 2018 16:28:27 -0700
Received: from localhost (10.20.2.29) by mipsdag02.mipstec.com (10.20.40.47)
 with Microsoft SMTP Server id 15.1.1415.2 via Frontend Transport; Tue, 19 Jun
 2018 16:28:27 -0700
Date:   Tue, 19 Jun 2018 16:28:28 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Nicholas Mc Guire <hofrat@osadl.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        David Daney <david.daney@cavium.com>,
        "Steven J. Hill" <Steven.Hill@cavium.com>,
        Joe Perches <joe@perches.com>,
        Colin Ian King <colin.king@canonical.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Octeon: assign bool true/false not 1/0
Message-ID: <20180619232828.icebwaaeb5zudnr2@pburton-laptop>
References: <1529133992-15360-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1529133992-15360-1-git-send-email-hofrat@osadl.org>
User-Agent: NeoMutt/20180512
X-BESS-ID: 1529450908-321459-12801-19000-1
X-BESS-VER: 2018.7-r1806151722
X-BESS-Apparent-Source-IP: 12.201.5.31
X-BESS-Envelope-From: Paul.Burton@mips.com
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.194207
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-Orig-Rcpt: hofrat@osadl.org,ralf@linux-mips.org,jhogan@kernel.org,david.daney@cavium.com,steven.hill@cavium.com,joe@perches.com,colin.king@canonical.com,linux-mips@linux-mips.org,linux-kernel@vger.kernel.org
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicholas,

On Sat, Jun 16, 2018 at 09:26:32AM +0200, Nicholas Mc Guire wrote:
> Booleans should be assigned true/false not 1/0 as comparison is not needed
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> ---
> 
> Problem located by scripts/coccinelle/misc/boolinit.cocci
>   ./arch/mips/cavium-octeon/octeon-irq.c:817:3-13:
>   WARNING: Assignment of bool to 0/1
> 
> Patch was compile tested with: cavium_octeon_defconfig
> (with a number of sparse warnings - not related to the proposed change)
> 
> Patch is against 4.17.0 (localversion-next is next-20180614)
> 
>  arch/mips/cavium-octeon/octeon-irq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to mips-next for 4.19.

Paul
