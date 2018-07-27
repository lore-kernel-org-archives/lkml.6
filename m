Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EF7C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ABA1208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ABA1208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388917AbeG0R2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 13:28:38 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:37000 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388156AbeG0R2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 13:28:38 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fj5F9-0002RA-AK; Sat, 28 Jul 2018 00:05:27 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fj5Ev-0007JH-Qz; Sat, 28 Jul 2018 00:05:13 +0800
Date:   Sat, 28 Jul 2018 00:05:13 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Siva Reddy Kallam <siva.kallam@broadcom.com>,
        Prashant Sreedharan <prashant@broadcom.com>,
        Michael Chan <mchan@broadcom.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Pantelis Antoniou <pantelis.antoniou@gmail.com>,
        Vitaly Bordug <vbordug@ru.mvista.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH 0/6] lib/crc32: treewide: Use existing define with
 polynomial
Message-ID: <20180727160513.fluthoaj24co2khr@gondor.apana.org.au>
References: <20180717160541.3843-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717160541.3843-1-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 06:05:35PM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> Kernel defines same polynomial for CRC-32 in few places.
> This is unnecessary duplication of the same value. Also this might
> be error-prone for future code - every driver will define the
> polynomial again.
> 
> This is an attempt to unify definition of polynomial.  Few obvious
> hard-coded locations are fixed with define.
> 
> All series depend on each 1/6 and 2/6.
> 
> This could be merged in two different merge windows (1st lib/crc and then
> the rest) or taken through one tree.
> 
> It would be nice to get some testing. Only generic lib/crc, bunzip, xz_crc32
> and Freescale's Ethernet driver were tested on HW.  Rest got just different
> builds.
> 
> Best regards,
> Krzysztof
> 
> 
> 
> 
> Krzysztof Kozlowski (6):
>   lib/crc: Move polynomial definition to separate header
>   lib/crc: Use consistent naming for CRC-32 polynomials
>   crypto: stm32_crc32 - Use existing define with polynomial
>   net: ethernet: Use existing define with polynomial
>   staging: rtl: Use existing define with polynomial
>   lib: Use existing define with polynomial
> 
>  drivers/crypto/stm32/stm32_crc32.c               | 11 ++++-------
>  drivers/net/ethernet/amd/xgbe/xgbe-dev.c         |  4 ++--
>  drivers/net/ethernet/apple/bmac.c                |  8 ++------
>  drivers/net/ethernet/broadcom/tg3.c              |  3 ++-
>  drivers/net/ethernet/freescale/fec_main.c        |  4 ++--
>  drivers/net/ethernet/freescale/fs_enet/fec.h     |  3 ---
>  drivers/net/ethernet/freescale/fs_enet/mac-fec.c |  3 ++-
>  drivers/net/ethernet/micrel/ks8851_mll.c         |  3 ++-
>  drivers/net/ethernet/synopsys/dwc-xlgmac-hw.c    |  4 ++--
>  drivers/staging/rtl8712/rtl871x_security.c       |  5 ++---
>  drivers/staging/rtl8723bs/core/rtw_security.c    |  5 ++---
>  include/linux/crc32poly.h                        | 20 ++++++++++++++++++++
>  lib/crc32.c                                      | 11 ++++++-----
>  lib/crc32defs.h                                  | 14 --------------
>  lib/decompress_bunzip2.c                         |  3 ++-
>  lib/gen_crc32table.c                             |  5 +++--
>  lib/xz/xz_crc32.c                                |  3 ++-
>  17 files changed, 55 insertions(+), 54 deletions(-)
>  create mode 100644 include/linux/crc32poly.h

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
