Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7257C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 16:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2FF2208CA
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 16:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2FF2208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754239AbeGHQny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 12:43:54 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:40306 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753073AbeGHQnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 12:43:53 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fcCmr-0000xU-6k; Mon, 09 Jul 2018 00:43:49 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fcCmm-000791-RN; Mon, 09 Jul 2018 00:43:44 +0800
Date:   Mon, 9 Jul 2018 00:43:44 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, arnd@arndb.de,
        Eric Biggers <ebiggers3@gmail.com>,
        linux-crypto@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2 1/2] crypto: Fix -Wstringop-truncation warnings
Message-ID: <20180708164344.3lpe6q7m2yjeqcdl@gondor.apana.org.au>
References: <20180625124538.21051-1-shorne@gmail.com>
 <20180625124538.21051-2-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180625124538.21051-2-shorne@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 09:45:37PM +0900, Stafford Horne wrote:
> As of GCC 9.0.0 the build is reporting warnings like:
> 
>     crypto/ablkcipher.c: In function ‘crypto_ablkcipher_report’:
>     crypto/ablkcipher.c:374:2: warning: ‘strncpy’ specified bound 64 equals destination size [-Wstringop-truncation]
>       strncpy(rblkcipher.geniv, alg->cra_ablkcipher.geniv ?: "<default>",
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>        sizeof(rblkcipher.geniv));
>        ~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This means the strnycpy might create a non null terminated string.  Fix this by
> explicitly performing '\0' termination.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Eric Biggers <ebiggers3@gmail.com>
> Cc: Nick Desaulniers <nick.desaulniers@gmail.com>
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
