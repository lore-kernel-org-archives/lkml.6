Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41602C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B2D20849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B2D20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbeLMKbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:31:39 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:50490 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbeLMKbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:31:38 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gXOHG-0003Nm-SR; Thu, 13 Dec 2018 18:31:34 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gXOHE-0007Qq-UP; Thu, 13 Dec 2018 18:31:33 +0800
Date:   Thu, 13 Dec 2018 18:31:32 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Srikanth, Jampala" <Jampala.Srikanth@cavium.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: cavium/nitrox - Enabled Mailbox support
Message-ID: <20181213103132.ux5z3yszsgbxv57d@gondor.apana.org.au>
References: <20181204125521.4714-1-Jampala.Srikanth@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204125521.4714-1-Jampala.Srikanth@cavium.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 12:55:54PM +0000, Srikanth, Jampala wrote:
> Enabled the PF->VF Mailbox support. Mailbox message are interpreted
> as {type, opcode, data}. Supported message types are REQ, ACK and NACK.
> 
> Signed-off-by: Srikanth Jampala <Jampala.Srikanth@cavium.com>
> ---
>  drivers/crypto/cavium/nitrox/Makefile         |   3 +-
>  drivers/crypto/cavium/nitrox/nitrox_csr.h     |  12 +-
>  drivers/crypto/cavium/nitrox/nitrox_debugfs.h |  22 ++
>  drivers/crypto/cavium/nitrox/nitrox_dev.h     |  61 +++++-
>  drivers/crypto/cavium/nitrox/nitrox_hal.c     | 114 +++++++---
>  drivers/crypto/cavium/nitrox/nitrox_hal.h     |   2 +
>  drivers/crypto/cavium/nitrox/nitrox_isr.c     |   8 +-
>  drivers/crypto/cavium/nitrox/nitrox_main.c    |   3 +-
>  drivers/crypto/cavium/nitrox/nitrox_mbx.c     | 204 ++++++++++++++++++
>  drivers/crypto/cavium/nitrox/nitrox_mbx.h     |   9 +
>  drivers/crypto/cavium/nitrox/nitrox_sriov.c   |  57 ++++-
>  11 files changed, 441 insertions(+), 54 deletions(-)
>  create mode 100644 drivers/crypto/cavium/nitrox/nitrox_debugfs.h
>  create mode 100644 drivers/crypto/cavium/nitrox/nitrox_mbx.c
>  create mode 100644 drivers/crypto/cavium/nitrox/nitrox_mbx.h

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
