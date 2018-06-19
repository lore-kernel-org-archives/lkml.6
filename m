Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EB5C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113F22083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:24:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 113F22083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751579AbeFSXYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 19:24:50 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:56065 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbeFSXYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 19:24:46 -0400
Received: from mipsdag03.mipstec.com (mail3.mips.com [12.201.5.33]) by mx1413.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Tue, 19 Jun 2018 23:24:38 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag03.mipstec.com
 (10.20.40.48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Tue, 19
 Jun 2018 16:24:37 -0700
Received: from localhost (10.20.2.29) by mipsdag02.mipstec.com (10.20.40.47)
 with Microsoft SMTP Server id 15.1.1415.2 via Frontend Transport; Tue, 19 Jun
 2018 16:24:37 -0700
Date:   Tue, 19 Jun 2018 16:24:38 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] Make elf2ecoff work on 64bit host machines
Message-ID: <20180619232438.t3xbd4dkqr6t5oo5@pburton-laptop>
References: <20180605100021.14673-1-tbogendoerfer@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180605100021.14673-1-tbogendoerfer@suse.de>
User-Agent: NeoMutt/20180512
X-BESS-ID: 1529450678-531715-22544-16457-1
X-BESS-VER: 2018.7-r1806151722
X-BESS-Apparent-Source-IP: 12.201.5.33
X-BESS-Envelope-From: Paul.Burton@mips.com
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.194207
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-Orig-Rcpt: tbogendoerfer@suse.de,ralf@linux-mips.org,jhogan@kernel.org,linux-mips@linux-mips.org,linux-kernel@vger.kernel.org
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Tue, Jun 05, 2018 at 12:00:20PM +0200, Thomas Bogendoerfer wrote:
> Use fixed width integer types for ecoff structs to make elf2ecoff work
> on 64bit host machines
> 
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> Reviewed-by: Paul Burton <paul.burton@mips.com>
> ---
> 
> v3: include stdint.h in ecoff.h
>     missed one printf format
> 
> v2: include stdint.h and use inttypes.h for printf formats
> 
>  arch/mips/boot/ecoff.h     | 61 ++++++++++++++++++++++++----------------------
>  arch/mips/boot/elf2ecoff.c | 31 +++++++++++------------
>  2 files changed, 48 insertions(+), 44 deletions(-)

Thanks - applied to mips-next for 4.19.

Paul
