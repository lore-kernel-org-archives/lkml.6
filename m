Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B125AC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 05:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5165820869
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 05:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5165820869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbeIDJpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 05:45:17 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:38902 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbeIDJpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 05:45:17 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fx3mT-0000Er-Ko; Tue, 04 Sep 2018 13:21:37 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fx3mQ-0003LR-Iz; Tue, 04 Sep 2018 13:21:34 +0800
Date:   Tue, 4 Sep 2018 13:21:34 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, jeff.lien@wdc.com
Subject: Re: [PATCH 0/2] crypto: arm64/crct10dif - refactor and implement
 non-Crypto Extension version
Message-ID: <20180904052134.5ax5j374gubxpo4s@gondor.apana.org.au>
References: <20180827153812.6763-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827153812.6763-1-ard.biesheuvel@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 05:38:10PM +0200, Ard Biesheuvel wrote:
> The current arm64 CRC-T10DIF code only runs on cores that implement the
> 64x64 bit PMULL instructions that are part of the optional Crypto
> Extensions, and falls back to the highly inefficient C code otherwise.
> 
> Let's provide a SIMD version that is twice as fast as the C code even on
> a low end core like the Cortex-A53, and is time invariant and much easier
> on the D-cache.
> 
> Some performance numbers at the bottom.
> 
> Ard Biesheuvel (2):
>   crypto: arm64/crct10dif - preparatory refactor for 8x8 PMULL version
>   crypto: arm64/crct10dif - implement non-Crypto Extensions alternative
> 
>  arch/arm64/crypto/crct10dif-ce-core.S | 314 +++++++++++++++-----
>  arch/arm64/crypto/crct10dif-ce-glue.c |  14 +-
>  2 files changed, 251 insertions(+), 77 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
