Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1DAC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9DE4219EA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jq8wIbGC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9DE4219EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753107AbeGDRcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 13:32:24 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:34663 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752684AbeGDRcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 13:32:22 -0400
Received: by mail-ua0-f196.google.com with SMTP id r10-v6so3873351uao.1;
        Wed, 04 Jul 2018 10:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YS6NCJerDnz4/+i0efFzk+8fRKFtMRMDnT4uQVBWVLY=;
        b=jq8wIbGCS9M//9i5LdPY8k6mv1wvYrf3AtUA5Hf5S3RC1fdQUuUIqoJqTEqZbCxTAe
         v3RT1fZLFpp1dSsFXwJ2OcChKnSrkvsoSB7Ex0lHUO0wFJQVwEveBgq/+DL6uW/scvro
         ZGrQ8O8UrhEWsS8C+kPtczfQ3hHGDXKKD1aTWDzCp3+AwUhtCU1MGjoCbE7ct4SbEyjo
         noUcANDqaDIjZbbT+L7c1zacL2hgAjwIMadsme3f5yNn/IMxZpEAl/6PuOC6iqdzUM3b
         2intXF1MXsk246FFYp420WK9dAbMUG5YspPu49nrzdKVFg0FT51mJhywcA7YypJtvCAa
         zIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YS6NCJerDnz4/+i0efFzk+8fRKFtMRMDnT4uQVBWVLY=;
        b=YqrYGBNrzoIcEJNT3xqcgbjlFuE5jD7e694Elpo/ken5pCTooJWpYUY/238QTiZISK
         OHT8wB63xBqAcuZv1UqK8O6D+mou9MIQaIcg9vC9DARFjXqNC2LksprD9FywCM4PKqXd
         vEJ8SWPbOJkcqh7a1VaOZr7K1BxaisnweIBVLidykW+i6ZG7vnYAgJjoX7F3+FbcWCFW
         GXy/IST92iF58pYjhaAiLcuv3hAT4Zt5GTrD7VCxozgb3+zQZ82egoQZ8Vv46aAzue3F
         +g8F+KKT4rsIMpAxmFqn/TGvJPBSzxnYu5q2p8tJ/TC+gdB6klcaiu+B5igp4r+TfaOL
         Q0KQ==
X-Gm-Message-State: APt69E0nOT8/DnRFUlTtLwDKRLeiD4LnkMrb3xEP0b9cCGMA5vhIN2u2
        p15AYDEvK+oYSNRN8++ew00t/ZGMdF/cY524bVU=
X-Google-Smtp-Source: AAOMgpccC5ZwBWsTXLvp5gxmmfQ3abnJnKEA/ZjzvnwD2tuSYfRn7QBLIRMk9nQ0rznAMO2oakCycDkPwJrerNi280o=
X-Received: by 2002:ab0:4c24:: with SMTP id l36-v6mr1661047uaf.199.1530725541771;
 Wed, 04 Jul 2018 10:32:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 10:32:20 -0700 (PDT)
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
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Jul 2018 20:32:20 +0300
Message-ID: <CAHp75VdcPORzYzw+Q7EdnwEzWE3Adkqc-XcZVS6Z9W6ibNmhtQ@mail.gmail.com>
Subject: Re: [PATCH v18 6/7] crypto: caam: cleanup CONFIG_64BIT ifdefs when
 using io{read|write}64
To:     Horia Geanta <horia.geanta@nxp.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Fabio Estevam <festevam@gmail.com>,
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

On Wed, Jul 4, 2018 at 2:45 PM, Horia Geanta <horia.geanta@nxp.com> wrote:
> On 7/4/2018 2:58 AM, Logan Gunthorpe wrote:
>>
>>
>> On 03/07/18 04:21 PM, Andy Shevchenko wrote:
>>> It is an explicit call to BUG().
>>> That's why we see wrong instruction trap.
>>
>> Ok, I think I see the problem... the code is rather confusing:
>>
>> Prior to the patch, IOs were BE depending on caam_little_end but if
>> caam_imx was set, then it wrote two LE writes with the high one first.
>> After the patch, it writes two BE writes with the high one first.
>>
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

There is a ambiguity with the commit message.
Since it had implemented only LE IO accessors the address semantics is
the same as data flow.

As a driver writer intuitively I would expect data flow semantics.

It means it would be invariant to LE BE accessors, right?

lo-hi: LE (0x0 0x4) BE (0x4 0x0)
hi-lo: LE (0x4 0x0) BE (0x0 0x4)

-- 
With Best Regards,
Andy Shevchenko
