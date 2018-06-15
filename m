Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D148AC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 15:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32DC92088E
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 15:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32DC92088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965870AbeFOPNQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 11:13:16 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:57848 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935695AbeFOPNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 11:13:15 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fTqPU-0001FU-Ct; Fri, 15 Jun 2018 23:13:08 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fTqPP-0003DA-Sj; Fri, 15 Jun 2018 23:13:03 +0800
Date:   Fri, 15 Jun 2018 23:13:03 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Harsh Jain <harsh@chelsio.com>,
        Atul Gupta <atul.gupta@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Werner <werner@chelsio.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] crypto: chtls - use after free in chtls_pt_recvmsg()
Message-ID: <20180615151303.gvj3es3jfepfmycs@gondor.apana.org.au>
References: <20180601075852.fn5hongkasesi2ep@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601075852.fn5hongkasesi2ep@kili.mountain>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 10:59:25AM +0300, Dan Carpenter wrote:
> We call chtls_free_skb() but then we dereference it on the next lines.
> Also "skb" can't be NULL, we just dereferenced it on the line before.
> 
> I have moved the free down a couple lines to fix this issue.
> 
> Fixes: 17a7d24aa89d ("crypto: chtls - generic handling of data and hdr")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
