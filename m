Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77559C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87EF23D9E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87EF23D9E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751135AbeFVGxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 02:53:54 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:37864 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeFVGxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 02:53:52 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fWFx4-00011u-6H; Fri, 22 Jun 2018 14:53:46 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fWFwz-0003B6-Pp; Fri, 22 Jun 2018 14:53:41 +0800
Date:   Fri, 22 Jun 2018 14:53:41 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Hadar Gat <hadar.gat@arm.com>, Ofir Drang <ofir.drang@arm.com>,
        stable@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: ccree: fix iv copying for small buffers
Message-ID: <20180622065341.yparmvx5tspj3zvy@gondor.apana.org.au>
References: <1528361927-4172-1-git-send-email-gilad@benyossef.com>
 <CAOtvUMcJfJDjnMoithRQ4ife09VC+G-w+__jV-JLwh7M=s7JNQ@mail.gmail.com>
 <20180613063030.bsrq3xmufcw4zi52@gondor.apana.org.au>
 <CAOtvUMdtafGwXJFD0Tm1tx1q+TxRsB4nwEKxumE7=--_PMCZrQ@mail.gmail.com>
 <20180619142713.dzipyarpb23a7qne@gondor.apana.org.au>
 <CAOtvUMcChKswKBCOkN7DGvK3DcotJBh0y=-Xi8232uYK26-xQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOtvUMcChKswKBCOkN7DGvK3DcotJBh0y=-Xi8232uYK26-xQA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 04:35:44PM +0300, Gilad Ben-Yossef wrote:
> 
> What about OFB? unless I've missed something there is no generic
> implementation... ?

In general we shouldn't add hardware drivers for algorithms that
do not have a generic implementation.  Sometimes they slip through
though.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
