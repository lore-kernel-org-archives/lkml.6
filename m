Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71020ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EAEE20854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIpSAXUJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EAEE20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbeGRHKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 03:10:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbeGRHKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 03:10:15 -0400
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B37620854;
        Wed, 18 Jul 2018 06:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531895638;
        bh=1TTkQS5KXrluy+hqUTBROw+Bk+RL0iu18s8yncnOMaQ=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=GIpSAXUJ/10ggbKu6jTEtXDm6KvojjNYs3pZL8v5J7c9XFr6rNuqG2k8yFxMJBis0
         0sCc3hcVtc0JVPxWiq3aba6KoXykF/aODmszXlaIwf3fGXoM16rUJEZxlKpx440BE6
         4gzbmtjTXtLP5OHq80hQQKsJJzv1ix7UCpp6NABE=
Received: by mail-wm0-f51.google.com with SMTP id v25-v6so1567745wmc.0;
        Tue, 17 Jul 2018 23:33:58 -0700 (PDT)
X-Gm-Message-State: AOUpUlGlG+qsnyN9gKevEeklhzznK6m3CVaENjfozpDUj5iYMysvgIOb
        wwkr4pgkLPaUeD8pW6R3m11wn8aEj6HWiYLWF4Y=
X-Google-Smtp-Source: AAOMgpfZaGvaILL8j8wX9qckJBaoXQ4BjZrKOfaPcGzQbW0Yy1/Dno23vyT7om/CR4L06dLhHpz7WORV+V8ukawAsn4=
X-Received: by 2002:a1c:3a8f:: with SMTP id h137-v6mr726242wma.72.1531895636732;
 Tue, 17 Jul 2018 23:33:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 23:33:56
 -0700 (PDT)
In-Reply-To: <20180718001258.GA210746@gmail.com>
References: <20180717160541.3843-1-krzk@kernel.org> <20180718001258.GA210746@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 18 Jul 2018 08:33:56 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdOrp07+YsEhsti6WLND6We2q_R=30cCWdaBgmEWkS5Ww@mail.gmail.com>
Message-ID: <CAJKOXPdOrp07+YsEhsti6WLND6We2q_R=30cCWdaBgmEWkS5Ww@mail.gmail.com>
Subject: Re: [PATCH 0/6] lib/crc32: treewide: Use existing define with polynomial
To:     Eric Biggers <ebiggers3@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 July 2018 at 02:12, Eric Biggers <ebiggers3@gmail.com> wrote:
> Hi Krzysztof,
>
> On Tue, Jul 17, 2018 at 06:05:35PM +0200, Krzysztof Kozlowski wrote:
>> Hi,
>>
>> Kernel defines same polynomial for CRC-32 in few places.
>> This is unnecessary duplication of the same value. Also this might
>> be error-prone for future code - every driver will define the
>> polynomial again.
>>
>> This is an attempt to unify definition of polynomial.  Few obvious
>> hard-coded locations are fixed with define.
>>
>> All series depend on each 1/6 and 2/6.
>>
>> This could be merged in two different merge windows (1st lib/crc and then
>> the rest) or taken through one tree.
>>
>> It would be nice to get some testing. Only generic lib/crc, bunzip, xz_crc32
>> and Freescale's Ethernet driver were tested on HW.  Rest got just different
>> builds.
>>
>> Best regards,
>> Krzysztof
>>
>> Krzysztof Kozlowski (6):
>>   lib/crc: Move polynomial definition to separate header
>>   lib/crc: Use consistent naming for CRC-32 polynomials
>>   crypto: stm32_crc32 - Use existing define with polynomial
>>   net: ethernet: Use existing define with polynomial
>>   staging: rtl: Use existing define with polynomial
>>   lib: Use existing define with polynomial
>>
>>  drivers/crypto/stm32/stm32_crc32.c               | 11 ++++-------
>>  drivers/net/ethernet/amd/xgbe/xgbe-dev.c         |  4 ++--
>>  drivers/net/ethernet/apple/bmac.c                |  8 ++------
>>  drivers/net/ethernet/broadcom/tg3.c              |  3 ++-
>>  drivers/net/ethernet/freescale/fec_main.c        |  4 ++--
>>  drivers/net/ethernet/freescale/fs_enet/fec.h     |  3 ---
>>  drivers/net/ethernet/freescale/fs_enet/mac-fec.c |  3 ++-
>>  drivers/net/ethernet/micrel/ks8851_mll.c         |  3 ++-
>>  drivers/net/ethernet/synopsys/dwc-xlgmac-hw.c    |  4 ++--
>>  drivers/staging/rtl8712/rtl871x_security.c       |  5 ++---
>>  drivers/staging/rtl8723bs/core/rtw_security.c    |  5 ++---
>>  include/linux/crc32poly.h                        | 20 ++++++++++++++++++++
>>  lib/crc32.c                                      | 11 ++++++-----
>>  lib/crc32defs.h                                  | 14 --------------
>>  lib/decompress_bunzip2.c                         |  3 ++-
>>  lib/gen_crc32table.c                             |  5 +++--
>>  lib/xz/xz_crc32.c                                |  3 ++-
>>  17 files changed, 55 insertions(+), 54 deletions(-)
>>  create mode 100644 include/linux/crc32poly.h
>>
>
> Did you check whether any of these users can be converted to use the CRC
> implementations in lib/, so they wouldn't need the polynomial definition
> themselves?

I did not check but that's interesting point... The Ethernet drivers
(xgbe, tg3, fec, ks8851, dwc-xlgmac) look like could be converted to
generic implementation. The apple/bmac looks weird. The rtl WiFi
drivers in long term can be converted to use generic lib80211 for
encryption (see commit 0d4876f4e977 ("staging:r8188eu: Use lib80211 to
encrypt (TKIP) tx frames")) but that is much bigger task. The
remaining use the polynomials in different aspect:
1. XZ and BUNZIP use it to create CRC tables - probably generic
gen_crc32table.c could be used,
2. stm32_crc32.c uses it to initialize HW CRC accelerator.

I can work on Freescale FEC, xz and bunzip code because these I can
test but I would prefer to do it as follow up.

Best regards,
Krzysztof
