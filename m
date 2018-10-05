Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA397C64EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 02:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C7C2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 02:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1C7C2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbeJEJ00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 05:26:26 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:55724 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbeJEJ00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 05:26:26 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1g8Fs8-0007I1-Kf; Fri, 05 Oct 2018 10:29:44 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1g8Fs6-00015s-IU; Fri, 05 Oct 2018 10:29:42 +0800
Date:   Fri, 5 Oct 2018 10:29:42 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: caam/qi2 - add CONFIG_NETDEVICES dependency
Message-ID: <20181005022942.gs7shzuagy5ycfct@gondor.apana.org.au>
References: <20180926130045.2295764-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926130045.2295764-1-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 03:00:34PM +0200, Arnd Bergmann wrote:
> This driver implements a (part of a) network driver, and fails to
> build if we have turned off networking support:
> 
> drivers/crypto/caam/caamalg_qi2.o: In function `dpaa2_caam_fqdan_cb':
> caamalg_qi2.c:(.text+0x577c): undefined reference to `napi_schedule_prep'
> caamalg_qi2.c:(.text+0x578c): undefined reference to `__napi_schedule_irqoff'
> drivers/crypto/caam/caamalg_qi2.o: In function `dpaa2_dpseci_poll':
> caamalg_qi2.c:(.text+0x59b8): undefined reference to `napi_complete_done'
> drivers/crypto/caam/caamalg_qi2.o: In function `dpaa2_caam_remove':
> caamalg_qi2.c:(.text.unlikely+0x4e0): undefined reference to `napi_disable'
> caamalg_qi2.c:(.text.unlikely+0x4e8): undefined reference to `netif_napi_del'
> drivers/crypto/caam/caamalg_qi2.o: In function `dpaa2_dpseci_setup':
> caamalg_qi2.c:(.text.unlikely+0xc98): undefined reference to `netif_napi_add'
> 
> >From what I can tell, CONFIG_NETDEVICES is the correct dependency here,
> and adding it fixes the randconfig failures.
> 
> Fixes: 8d818c105501 ("crypto: caam/qi2 - add DPAA2-CAAM driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
