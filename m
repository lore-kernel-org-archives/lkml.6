Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EBEC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 16:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF2DB208CA
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 16:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF2DB208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754281AbeGHQqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 12:46:42 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:40390 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752891AbeGHQqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 12:46:40 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fcCpZ-00013h-EK; Mon, 09 Jul 2018 00:46:37 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fcCpW-0007CK-Fa; Mon, 09 Jul 2018 00:46:34 +0800
Date:   Mon, 9 Jul 2018 00:46:34 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>, Hadar Gat <hadar.gat@arm.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] crypto: fixes and cleanups
Message-ID: <20180708164634.x5uubnls2arlrqsv@gondor.apana.org.au>
References: <1530428560-4440-1-git-send-email-gilad@benyossef.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530428560-4440-1-git-send-email-gilad@benyossef.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 01, 2018 at 08:02:33AM +0100, Gilad Ben-Yossef wrote:
> The patch set fixes ccree IV handling, finup() operation (provided           
> by Hadar Gat) and CTS-AES mode of operation along a code cleanup.                                             
>                                                                                 
> Since our finup() method was obviously broken but was not detected              
> by testmgr, I've added finup() test to testmgr to catch it next                 
> time it happened.
> 
> Changes from v1:
> - Add missing "static" qualifier reported by kbuild bot
> - Add CTS-AES fix and some more cleanups
> 
> 
> Gilad Ben-Yossef (5):
>   crypto: testmgr: add hash finup tests
>   crypto: ccree: fix iv handling
>   crypto: ccree: remove dead legacy code
>   crypto: ccree: use CBC-CS3 CTS mode
>   crypto: ccree: rate limit debug print
> 
> Hadar Gat (1):
>   crypto: ccree: fix finup
> 
>  crypto/testmgr.c                 |  55 +++++++++++++---
>  drivers/crypto/ccree/cc_cipher.c | 137 +++++++++++++++++++++++++--------------
>  drivers/crypto/ccree/cc_driver.c |   4 +-
>  drivers/crypto/ccree/cc_hash.c   |  81 +++++------------------
>  4 files changed, 153 insertions(+), 124 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
