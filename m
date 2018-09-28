Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484E6C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 05:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5812159D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 05:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B5812159D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbeI1L3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 07:29:51 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:42510 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbeI1L3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 07:29:51 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1g5l0G-0008U7-RQ; Fri, 28 Sep 2018 13:07:48 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1g5l0B-0005ua-AR; Fri, 28 Sep 2018 13:07:43 +0800
Date:   Fri, 28 Sep 2018 13:07:43 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Christoph Manszewski <c.manszewski@samsung.com>
Cc:     linux-crypto@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kamil Konieczny <k.konieczny@partner.samsung.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2 0/4] crypto: s5p-sss: Fix and add aes-ctr support
Message-ID: <20180928050743.7mqgbs2femmacq5o@gondor.apana.org.au>
References: <CGME20180917151002eucas1p27689f043367e1bc64bf63bc402dffcdd@eucas1p2.samsung.com>
 <20180917151002eucas1p27689f043367e1bc64bf63bc402dffcdd~VOId3-CTL2961529615eucas1p2I@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917151002eucas1p27689f043367e1bc64bf63bc402dffcdd~VOId3-CTL2961529615eucas1p2I@eucas1p2.samsung.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 05:09:26PM +0200, Christoph Manszewski wrote:
> Hello,
> 
> This patch series adds aes-ctr support in s5p-sss.c driver. Additionally it
> it provides a fix, and a minor code cleanup.
> 
> Patch 1 contains a simple fix, of a possible race condition.
> Patches 2-3 are code cleanup patches.
> Patch 4 adds support for aes-ctr block cipher mode of operation.
> 
> Regards,
> Chris
> 
> Changes in v2:
> - pass dev->req directly to s5p_aes_complete in s5p_aes_interrupt
> non-error path,
> - move req asignment in s5p_aes_interrupt before if statement,
> - change commit message and subject for patch 2/4,
> - remove empty lines and add rationale in commit message for 
> patch 3/4,
> 
> Christoph Manszewski (4):
>   crypto: s5p-sss: Fix race in error handling
>   crypto: s5p-sss: Fix Fix argument list alignment
>   crypto: s5p-sss: Minor code cleanup
>   crypto: s5p-sss: Add aes-ctr support
> 
>  drivers/crypto/s5p-sss.c | 113 +++++++++++++++++++++++++++--------------------
>  1 file changed, 65 insertions(+), 48 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
