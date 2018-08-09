Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABA2C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312C921AA7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312C921AA7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbeHIIKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 04:10:24 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:46398 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbeHIIKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 04:10:24 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fndmz-00053a-Mh; Thu, 09 Aug 2018 13:47:13 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fndmv-0006xV-Vp; Thu, 09 Aug 2018 13:47:10 +0800
Date:   Thu, 9 Aug 2018 13:47:09 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Crypto Fixes for 4.18
Message-ID: <20180809054709.gd5whukrd3vf6j3m@gondor.apana.org.au>
References: <20170714141855.GA29426@gondor.apana.org.au>
 <20170922084401.GA15541@gondor.apana.org.au>
 <20171128230929.GA17783@gondor.apana.org.au>
 <20171222064931.GA27068@gondor.apana.org.au>
 <20180105073808.GA14405@gondor.apana.org.au>
 <20180212031702.GA26153@gondor.apana.org.au>
 <20180428080517.haxgpvqrwgotakyo@gondor.apana.org.au>
 <20180622145403.6ltjip7che227fuo@gondor.apana.org.au>
 <20180719073931.q5ny7tqgwws27lnq@gondor.apana.org.au>
 <20180803054420.4eehj2uneqimcf7g@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803054420.4eehj2uneqimcf7g@gondor.apana.org.au>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus: 

This push fixes a performance regression in arm64 NEON crypto as
well as a crash in x86 aegis/morus on unsupported CPUs.


Please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus


Ard Biesheuvel (1):
      crypto: arm64 - revert NEON yield for fast AEAD implementations

Ondrej Mosnacek (1):
      crypto: x86/aegis,morus - Fix and simplify CPUID checks

 arch/arm64/crypto/aes-ce-ccm-core.S    |  150 ++++++++++++--------------------
 arch/arm64/crypto/ghash-ce-core.S      |   76 ++++++----------
 arch/x86/crypto/aegis128-aesni-glue.c  |   12 +--
 arch/x86/crypto/aegis128l-aesni-glue.c |   12 +--
 arch/x86/crypto/aegis256-aesni-glue.c  |   12 +--
 arch/x86/crypto/morus1280-avx2-glue.c  |   10 +--
 arch/x86/crypto/morus1280-sse2-glue.c  |   10 +--
 arch/x86/crypto/morus640-sse2-glue.c   |   10 +--
 8 files changed, 101 insertions(+), 191 deletions(-)

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
