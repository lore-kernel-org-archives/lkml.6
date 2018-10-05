Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF96C64EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 02:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624D020854
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 02:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 624D020854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbeJEJFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 05:05:16 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:55648 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbeJEJFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 05:05:15 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1g8FXi-00074D-Vh; Fri, 05 Oct 2018 10:08:39 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1g8FXa-00067k-Vy; Fri, 05 Oct 2018 10:08:31 +0800
Date:   Fri, 5 Oct 2018 10:08:30 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Crypto Fixes for 4.19
Message-ID: <20181005020830.sy6xjsbdvtdqrtxr@gondor.apana.org.au>
References: <20170714141855.GA29426@gondor.apana.org.au>
 <20170922084401.GA15541@gondor.apana.org.au>
 <20171128230929.GA17783@gondor.apana.org.au>
 <20171222064931.GA27068@gondor.apana.org.au>
 <20180105073808.GA14405@gondor.apana.org.au>
 <20180212031702.GA26153@gondor.apana.org.au>
 <20180428080517.haxgpvqrwgotakyo@gondor.apana.org.au>
 <20180622145403.6ltjip7che227fuo@gondor.apana.org.au>
 <20180829033353.agnzxra3jk2r2mzg@gondor.apana.org.au>
 <20180919062201.ov5o4vljvholgsed@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180919062201.ov5o4vljvholgsed@gondor.apana.org.au>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg: 

This push fixes the following issues:

- Out-of-bound stack access in qat.
- Illegal schedule in mxs-dcp.
- Memory corruption in chelsio.
- Incorrect pointer computation in caam.


Please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus


Harsh Jain (1):
      crypto: chelsio - Fix memory corruption in DMA Mapped buffers.

Horia Geantă (1):
      crypto: caam/jr - fix ablkcipher_edesc pointer arithmetic

Leonard Crestez (1):
      crypto: mxs-dcp - Fix wait logic on chan threads

Waiman Long (1):
      crypto: qat - Fix KASAN stack-out-of-bounds bug in adf_probe()

 drivers/crypto/caam/caamalg.c               |  8 ++---
 drivers/crypto/chelsio/chcr_algo.c          | 32 +++++++++++------
 drivers/crypto/chelsio/chcr_crypto.h        |  2 ++
 drivers/crypto/mxs-dcp.c                    | 53 ++++++++++++++++-------------
 drivers/crypto/qat/qat_c3xxx/adf_drv.c      |  6 ++--
 drivers/crypto/qat/qat_c3xxxvf/adf_drv.c    |  6 ++--
 drivers/crypto/qat/qat_c62x/adf_drv.c       |  6 ++--
 drivers/crypto/qat/qat_c62xvf/adf_drv.c     |  6 ++--
 drivers/crypto/qat/qat_dh895xcc/adf_drv.c   |  6 ++--
 drivers/crypto/qat/qat_dh895xccvf/adf_drv.c |  6 ++--
 10 files changed, 76 insertions(+), 55 deletions(-)

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
