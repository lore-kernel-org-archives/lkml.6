Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F40ECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 00:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA4020693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 00:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuNOI8kX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AA4020693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731442AbeGRAsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 20:48:06 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42947 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730043AbeGRAsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 20:48:06 -0400
Received: by mail-pf0-f195.google.com with SMTP id l9-v6so1278499pff.9;
        Tue, 17 Jul 2018 17:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6j+JJWCgwt0YY+WGidLSFwkh1MdLiA0MRoHIB/PcXgQ=;
        b=TuNOI8kX74StgmO9yL9hJiqcTDhaVoFOhOhsLcucbBFaiKz3J8/bbX+Vio/RY9f8kZ
         /uvSwbqvnTeThU5Ilr0+95Wr50EfmHpgtoBdxHCrfFJz125aNHcuiySnA63TkyYk8iHH
         QXk1XgjfOKOt5KEdVD1wuXfPn1YxIO0mLpWZYs/yavMt7A3fGlu6VE0wq9OXSIwrwKjI
         Hu/3gUFH3C5lQjDiCIXrN/HGBYTOLqJIRyGY997/KguXq08FhMzBZYtnSh/WwKpR6Hfz
         8ABCb58meeQ7KeX5X/WyXmb4rd73bfqf2cKsI3LBB4C/CWbwt5amKRs0WpQtX0iWmrjq
         ijkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6j+JJWCgwt0YY+WGidLSFwkh1MdLiA0MRoHIB/PcXgQ=;
        b=Rt4qqxijJXOqydJaAvuYzRwBSm+YikgR4PUoQ0fPPz+QSvL6eIF5pSckJLO3yeDEqH
         rduNSbCcgp713K6p7Sym1iNWes9N9MGmzynO2LI0DwprNwJj+HQmSbH0x174jwX03XpW
         I0tb21QNyDot0y34/fyW44s9hgyWpDkZ7xIJCAouk/SATUSH4jw+LHpbukpbSqMbuktw
         Wye8XzQwnK5/X3/3GHvBwYbZTeYuF4aaV9Qzkz5Eq0pxho4SPoLb87g0YXsCfgdeHgRI
         Vz8LRjThp9DvEjKOd7L0107LgRmIuG1xytZYdWkbwuOb+EYJcGGPFaXZR/Zzkabm96jT
         Z3OQ==
X-Gm-Message-State: AOUpUlGi7pTzjUtkGjD4trlqVV9YwzT+UjBBaxLwU5o3HeAwfKaKGyDQ
        rQAMKSkXJa6nMsZZgmiHHmc=
X-Google-Smtp-Source: AAOMgpfYRLupfcVureeYtHMEB7DSLzlP9gzlg+uvbYRGT4z0UNlOfYQ3lrP9yzrMcnzMaEd/iDFT5w==
X-Received: by 2002:a63:8648:: with SMTP id x69-v6mr3586610pgd.172.1531872781203;
        Tue, 17 Jul 2018 17:13:01 -0700 (PDT)
Received: from gmail.com ([2620:15c:17:3:dc28:5c82:b905:e8a8])
        by smtp.gmail.com with ESMTPSA id 10-v6sm3447576pfs.111.2018.07.17.17.13.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 17:13:00 -0700 (PDT)
Date:   Tue, 17 Jul 2018 17:12:58 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
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
Message-ID: <20180718001258.GA210746@gmail.com>
References: <20180717160541.3843-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717160541.3843-1-krzk@kernel.org>
User-Agent: Mutt/1.10+35 (c786a508) (2018-06-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

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
> 

Did you check whether any of these users can be converted to use the CRC
implementations in lib/, so they wouldn't need the polynomial definition
themselves?

- Eric
