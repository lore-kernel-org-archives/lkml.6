Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91166C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477D423DAC
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vLmweKVb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 477D423DAC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752801AbeGDPGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 11:06:18 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38723 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752114AbeGDPGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 11:06:16 -0400
Received: by mail-oi0-f67.google.com with SMTP id v8-v6so11301075oie.5;
        Wed, 04 Jul 2018 08:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cjBhzgj9G95WpiuP36t1+BkZCOEDepTY0w64+3NcYuA=;
        b=vLmweKVbqSte7Ov4xzev20LBZRf31BswO7lN10+Cwe35bWb4lyObjpyd/n2eQx6Pv+
         WhKg8nPbA04g33qoSbM2rG31ATWFxsFcS1w3Ns0Oax8Y8p9vecERh+gdZwoH3BgyXUpz
         TrXzH04b5zVY/d+/LGPpL/wkOgAY2MWgQOHNsE5LD/Oq7+o41hSUxKPl/tFBZFMyPqdV
         qnM6VsEYQWvruju8YxoVjL9uEO1XL+abhxLwPkCbLgGbPMtxd55rkQTnQG8j8WWs+cur
         5ZeQSXaUv2FYZFSZg1U5ZK9P7R8Lt+FEq5qs/EvEneItI63UmSkAJU2c4yz2VTZtzN86
         XtcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cjBhzgj9G95WpiuP36t1+BkZCOEDepTY0w64+3NcYuA=;
        b=uZch517VTMx1vU9Pd0QbmT7anSg0T36hL9/vOtbmEUTdF8DzZiEZ3gYNoPFDQgm9IL
         9h8ReeNXcRvLimUp7PNGslVOWfWKqVzGMOVzwGakZ90K3oBaivK/L7biVpgaCmQIns7B
         thwvhYIWEo/LBwRje/pVZewcyiUPqmD7ouptWlXg2W/E21/a9QmjwsUa+fBFm5JBNKRQ
         K4nKd+sUCBe6qwEhSvFCwKLlN3aawnODapDbilavM8uEWbyIJT1URna1dVMQmoLqPPbT
         dlg2eP2EqsTRU7S7UHCDjGiKcMh9gH7DNbayGzo15I2BkeXyxVvRTohohUdIUMmB09ZU
         RA/g==
X-Gm-Message-State: APt69E2NDK06ZJn4ZatbDQPqphoP7Pn5/8et/RusWoLhAVBOtEzri59X
        A8FT6BsiLdQ82h+ExUX7yUWp0wmGPiLdtsw3S9o=
X-Google-Smtp-Source: AAOMgpdN8x/Ij/S/UOtuOZLqeZKpdaJK+aoNRZoFzxUoQKNNIUQKCzBAX0QCmzeBUEccWT2RyeIOppNo6ZH6NpiXrpI=
X-Received: by 2002:aca:4886:: with SMTP id v128-v6mr2844402oia.69.1530716775143;
 Wed, 04 Jul 2018 08:06:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:ea3:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 08:06:14 -0700 (PDT)
In-Reply-To: <VI1PR0402MB3485F76DD56D221EB256B4F698410@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <20180622194752.11221-1-logang@deltatee.com> <20180622194752.11221-7-logang@deltatee.com>
 <CAOMZO5DpwPsidKQ9wfe8mNTgdOpkdHHgqHMa4yQBx9uRrfFmww@mail.gmail.com>
 <CAHp75VcCNsx2sHcYG2aNiw354exTvO=NUOS9P_BTmcM3siAepg@mail.gmail.com>
 <13ea3f97-4a33-3a24-1b7e-b819be73d867@deltatee.com> <CAOMZO5CfUfNZd0kG=VVnH4BjP+XMpGh3bPCUrTwi_4w6YEGX7g@mail.gmail.com>
 <CAHp75VcDudrwV4kRnVR+vtddFhxHsU672YqOJgPPchuLvPV3nA@mail.gmail.com>
 <CAOMZO5A4bsu9dXCPb4QeSbnnLi=pr1=WYWn8p2AfU3rEG=RWXg@mail.gmail.com>
 <6e5224b9-343f-990c-19bd-fe37c6fbdc9b@deltatee.com> <CAOMZO5CJ_iG=p_+xL=Q_Rv3F5vtGggsgatar4XVTL+UFVnHBTA@mail.gmail.com>
 <7ddda181-6337-32cc-7a0d-43fc6a7ba78b@deltatee.com> <CAHp75VcN=pUkFK6=_7yErMRGNS3WsgBhkWMSwP0Cw_ZmGR=RJg@mail.gmail.com>
 <991b2298-bb3f-dad3-c93b-b43ee5f372de@deltatee.com> <VI1PR0402MB3485F76DD56D221EB256B4F698410@VI1PR0402MB3485.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 4 Jul 2018 12:06:14 -0300
Message-ID: <CAOMZO5C7V4_SpXOcAz0KbGYScpos0HRD-aa-Zh_6M3p9EqLsLQ@mail.gmail.com>
Subject: Re: [PATCH v18 6/7] crypto: caam: cleanup CONFIG_64BIT ifdefs when
 using io{read|write}64
To:     Horia Geanta <horia.geanta@nxp.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Douglass <dan.douglass@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Horia,

On Wed, Jul 4, 2018 at 8:45 AM, Horia Geanta <horia.geanta@nxp.com> wrote:

> I think there are two separate issues here:
>
> 1. Semantics of operations in io-64-nonatomic-lo-hi.h, io-64-nonatomic-hi-lo.h
>
> Logan, you mentioned the following (which unfortunately I somehow missed):
> https://lore.kernel.org/lkml/c3f2e061-5ed1-5c74-b955-3d2bfb0da074@deltatee.com
> The lo_hi/hi_lo functions seem to always refer to the data being written
> or read not to the address operated on.
>
> OTOH, initial commit that added asm-generic/io-64-nonatomic-lo-hi.h and
> asm-generic/io-64-nonatomic-hi-lo.h mentions:
> 797a796a13df6 ("asm-generic: architecture independent readq/writeq for 32bit
> environment")
> - <asm-generic/io-64-nonatomic-lo-hi.h> provides non-atomic readq/ writeq with
> the order of lower address -> higher address
> - <asm-generic/io-64-nonatomic-hi-lo.h> provides non-atomic readq/ writeq with
> reversed order
>
> I think we should keep the initial semantics when adding support for
> io{read|write}64, i.e. "lo" and "hi" to refer to address and not to value.
>
> Actually this is the semantics intended for the CAAM patch, see the note at the
> end of the commit message that refers to addresses, not values:
> To be consistent with CAAM engine HW spec: in case of 64-bit registers,
> irrespective of device endianness, the lower address should be read from
> / written to first, followed by the upper address.
>
>
> 2. CAAM driver I/O accessors for i.MX case
>
> CAAM block in some i.MX parts has broken endianness for 64b registers.
> For e.g. for i.MX6S/SL/D/Q even though CAAM is little endian, BARs for I/O rings
> have to be programmed as:
> I/O Ring BAR+0: unused
> I/O Ring BAR+4: IOVA (32-bit little endian)
> when the proper layout (for a 64b register) would have been to program IOVA at
> BAR+0.
>
> This explains why I/O accessors in CAAM driver handle things differently in case
> caam_imx=true.
>
> Since this quirk cannot be accommodated in generic fashion, code dealing with
> caam_imx has to stay.

Should I sent a revert of patch 46e4bf08f6388 for the boot regression for now?

Then the two issues you pointed out could be fixed later.
