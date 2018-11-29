Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F82CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03CC12081B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:13:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03CC12081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbeK2VSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 16:18:33 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:54276 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbeK2VSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 16:18:33 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gSJKG-0002C5-VY; Thu, 29 Nov 2018 18:13:41 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gSJKG-0005dU-RW; Thu, 29 Nov 2018 18:13:40 +0800
Date:   Thu, 29 Nov 2018 18:13:40 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Srikanth, Jampala" <Jampala.Srikanth@cavium.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] crypto: cavium/nitrox - Enable interrups for PF in
 SR-IOV mode.
Message-ID: <20181129101340.tne6mlpop5kpmxaw@gondor.apana.org.au>
References: <20181121095200.6036-1-Jampala.Srikanth@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121095200.6036-1-Jampala.Srikanth@cavium.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 09:52:24AM +0000, Srikanth, Jampala wrote:
> Enable the available interrupt vectors for PF in SR-IOV Mode.
> Only single vector entry 192 is valid of PF. This is used to
> notify any hardware errors and mailbox messages from VF(s).
> 
> Signed-off-by: Srikanth Jampala <Jampala.Srikanth@cavium.com>
> ---
>  drivers/crypto/cavium/nitrox/nitrox_dev.h   | 15 +++-
>  drivers/crypto/cavium/nitrox/nitrox_isr.c   | 84 ++++++++++++++++++++-
>  drivers/crypto/cavium/nitrox/nitrox_isr.h   |  2 +
>  drivers/crypto/cavium/nitrox/nitrox_sriov.c | 51 +++++++++++--
>  4 files changed, 142 insertions(+), 10 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
