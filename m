Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B535CC64EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 02:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830C22084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 02:30:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830C22084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeJEJ0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 05:26:31 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:55732 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbeJEJ0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 05:26:31 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1g8FsK-0007I9-Cj; Fri, 05 Oct 2018 10:29:56 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1g8FsJ-00016A-NZ; Fri, 05 Oct 2018 10:29:55 +0800
Date:   Fri, 5 Oct 2018 10:29:55 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     valdis.kletnieks@vt.edu
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto/morus(640,1280) - make crypto_...-algs static
Message-ID: <20181005022955.r4osquwg2p3yns4k@gondor.apana.org.au>
References: <113445.1538002178@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <113445.1538002178@turing-police.cc.vt.edu>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 06:49:38PM -0400, valdis.kletnieks@vt.edu wrote:
> sparse complains thusly:
> 
>   CHECK   arch/x86/crypto/morus640-sse2-glue.c
> arch/x86/crypto/morus640-sse2-glue.c:38:1: warning: symbol 'crypto_morus640_sse2_algs' was not declared. Should it be static?
>   CHECK   arch/x86/crypto/morus1280-sse2-glue.c
> arch/x86/crypto/morus1280-sse2-glue.c:38:1: warning: symbol 'crypto_morus1280_sse2_algs' was not declared. Should it be static?
>   CHECK   arch/x86/crypto/morus1280-avx2-glue.c
> arch/x86/crypto/morus1280-avx2-glue.c:38:1: warning: symbol 'crypto_morus1280_avx2_algs' was not declared. Should it be static?
> 
> and sparse is correct - these don't need to be global and polluting the namespace.
> 
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
