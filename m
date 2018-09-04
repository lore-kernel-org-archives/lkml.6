Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD19C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 05:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF1020869
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 05:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF1020869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbeIDJou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 05:44:50 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:38890 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbeIDJot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 05:44:49 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fx3m2-0000Ef-13; Tue, 04 Sep 2018 13:21:10 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fx3m1-0003Kd-A2; Tue, 04 Sep 2018 13:21:09 +0800
Date:   Tue, 4 Sep 2018 13:21:09 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        will.deacon@arm.com, catalin.marinas@arm.com, ebiggers@google.com,
        suzuki.poulose@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] crypto: arm64/crc32 - remove PMULL based CRC32 driver
Message-ID: <20180904052109.bprmzgstknh6yecz@gondor.apana.org.au>
References: <20180827110245.14812-1-ard.biesheuvel@linaro.org>
 <20180827110245.14812-5-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827110245.14812-5-ard.biesheuvel@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 01:02:45PM +0200, Ard Biesheuvel wrote:
> Now that the scalar fallbacks have been moved out of this driver into
> the core crc32()/crc32c() routines, we are left with a CRC32 crypto API
> driver for arm64 that is based only on 64x64 polynomial multiplication,
> which is an optional instruction in the ARMv8 architecture, and is less
> and less likely to be available on cores that do not also implement the
> CRC32 instructions, given that those are mandatory in the architecture
> as of ARMv8.1.
> 
> Since the scalar instructions do not require the special handling that
> SIMD instructions do, and since they turn out to be considerably faster
> on some cores (Cortex-A53) as well, there is really no point in keeping
> this code around so let's just remove it.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
