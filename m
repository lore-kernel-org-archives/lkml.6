Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0ECC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989592086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfARKkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:40:11 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:48442 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfARKkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:40:10 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gkRZH-0004fI-Hk; Fri, 18 Jan 2019 18:40:07 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gkRZG-0001AT-Bg; Fri, 18 Jan 2019 18:40:06 +0800
Date:   Fri, 18 Jan 2019 18:40:06 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Crypto Fixes for 5.0
Message-ID: <20190118104006.ye5amhxkgd4xrbmc@gondor.apana.org.au>
References: <20170922084401.GA15541@gondor.apana.org.au>
 <20171128230929.GA17783@gondor.apana.org.au>
 <20171222064931.GA27068@gondor.apana.org.au>
 <20180105073808.GA14405@gondor.apana.org.au>
 <20180212031702.GA26153@gondor.apana.org.au>
 <20180428080517.haxgpvqrwgotakyo@gondor.apana.org.au>
 <20180622145403.6ltjip7che227fuo@gondor.apana.org.au>
 <20180829033353.agnzxra3jk2r2mzg@gondor.apana.org.au>
 <20181116063146.e7a3mep3ghnfltxe@gondor.apana.org.au>
 <20181207061409.xflg423nknleuddw@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181207061409.xflg423nknleuddw@gondor.apana.org.au>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus: 

This push fixes the following issues:

- Zero-length DMA mapping in caam.
- Illegalling mapping stack memory for DMA in talitos.
- Use after free in cavium/nitrox.
- Key parsing in authenc.
- Undefined shift in sm3.
- Bogus completion call in authencesn.
- SHA support detection in caam.


Please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus


Aymen Sghaier (1):
      crypto: caam - fix zero-length buffer DMA mapping

Christophe Leroy (2):
      crypto: talitos - reorder code in talitos_edesc_alloc()
      crypto: talitos - fix ablkcipher for CONFIG_VMAP_STACK

Dan Carpenter (1):
      crypto: cavium/nitrox - Use after free in process_response_list()

Eric Biggers (5):
      crypto: authenc - fix parsing key with misaligned rta_len
      crypto: bcm - convert to use crypto_authenc_extractkeys()
      crypto: ccree - convert to use crypto_authenc_extractkeys()
      crypto: adiantum - initialize crypto_spawn::inst
      crypto: sm3 - fix undefined shift by >= width of value

Harsh Jain (1):
      crypto: authencesn - Avoid twice completion call in decrypt path

Horia Geantă (1):
      crypto: caam - fix SHA support detection

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
