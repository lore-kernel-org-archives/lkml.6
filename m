Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4D5C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 06:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5837725218
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 06:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5837725218
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752062AbeGAGY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 02:24:58 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:53472 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751539AbeGAGY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 02:24:56 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fZVmi-0006S2-Bg; Sun, 01 Jul 2018 14:24:32 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fZVmV-0007oa-HJ; Sun, 01 Jul 2018 14:24:19 +0800
Date:   Sun, 1 Jul 2018 14:24:19 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, qat-linux@intel.com,
        dm-devel@redhat.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 11/11] crypto: skcipher: Remove VLA usage for
 SKCIPHER_REQUEST_ON_STACK
Message-ID: <20180701062419.3opt7mnljf76hi4k@gondor.apana.org.au>
References: <20180625211026.15819-1-keescook@chromium.org>
 <20180625211026.15819-12-keescook@chromium.org>
 <20180626092041.mxfg4lxcvxfivzc2@gondor.apana.org.au>
 <CAGXu5jKYb-0NNvOcN79hzqU7O6vCFhMTBDGBL8Knuoc-YHamPg@mail.gmail.com>
 <20180627143622.ntksjxsymo4yw6dz@gondor.apana.org.au>
 <CAGXu5jJ2Z=YP+fNsvy+6a_BpC1ibZf6tOzZuPHk=Qx1qNVvOZw@mail.gmail.com>
 <20180627222749.xa5333caq5vaa7st@gondor.apana.org.au>
 <CAGXu5jKas=OyJPsrMthxjEykG=FkHDW84dO4bKGpj-50JjUYwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jKas=OyJPsrMthxjEykG=FkHDW84dO4bKGpj-50JjUYwQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 05:10:05PM -0700, Kees Cook wrote:
>
> In both cases here, what is "cipher"? i.e. what ciphers could lrw be
> wrapping, and what ciphers could cts be wrapping, so that I can
> examine the blocksizes, etc?

A cipher is a simple cipher like aes that operates on a single
block.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
