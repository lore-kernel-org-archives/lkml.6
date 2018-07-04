Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE410C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7987A219E7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjaCNn/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7987A219E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752899AbeGDQQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:16:10 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36158 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752401AbeGDQQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:16:08 -0400
Received: by mail-oi0-f65.google.com with SMTP id r16-v6so11678147oie.3;
        Wed, 04 Jul 2018 09:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WkSvtSS5ZPAfUXdDcnG5wR1nnuWO8kkZpSKNQApVx74=;
        b=TjaCNn/xOyGoJSLYi/pinnjXp3byhMY+0itrLDcp0OPbrnYgxU87BjoFDNL3q7CUyo
         VvnINubISDCfwBBIrO3XokKHMIr/jkicYwEQtiqpehB63EBazdFjNB4CX69RWUENmNPY
         2N7BzPuF9fh6STzl25FBRRUO6iUwUyHakbt8frygtQrsNssMmRJ6VxtiH7PWh8qBVVhd
         9V5ivOrBniui2b7Z46nDOvsteg+2kx38VB5cveMHY+SjQz2Mu/C5gcAnZPM2DvXB54SV
         lwe5iiW778hQvzxAHZLwml52KnDpBW4hYkOqETkfIO2wI32l3ZsZ5gD6z7lo/Hw36XvC
         HeVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WkSvtSS5ZPAfUXdDcnG5wR1nnuWO8kkZpSKNQApVx74=;
        b=WKYKGnZLq8Xew6mC2qRyV5a8UfgSOZz9vZ/gSkSdsoIAmzOk7C+lcwA+nwA0nB+Iea
         U8cXezzHQss9kf5pbPiGirqdpC+0NR4yBeoV0dMxx0wFvpmWu3VD6ozxsHuqnXFG2Vep
         FENqjYYqPjKZTGbyAFhTRUMIIOlHNkmNr90HG64Bb8U+rb0O69p3z5pesyFqXftHobwP
         F+rQPGPzyhNGjzmEoFnm+tCnXFmx+6wom5j6q28eQ9bwiyPdEySIqoiHTbpDI+WHUyRi
         CxUh4G6jiYlkRkgNkfHIPcwM9wtRXbTejpYjwNQ8IHoNU14PI/eXftsu0VqbwDA/fRyD
         T3sA==
X-Gm-Message-State: APt69E2pFEBT9uQJhOuvW1ExUvcBwoEQRgjPzGIgEAB6a6Xqn7wcywf0
        nY0X063enqQu/pLmE3PebcJ/fOZC/mcbp2BjT3A=
X-Google-Smtp-Source: AAOMgpfJv3SVpnfSrxhLl3Tvl6m+Aw30oWY3iLHxqJr9Jhg7xzkwzHs/tpBab3Ku0Vli0+iIjdgjteUi+kQbl8DXx+c=
X-Received: by 2002:aca:3ac6:: with SMTP id h189-v6mr3055185oia.336.1530720967588;
 Wed, 04 Jul 2018 09:16:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:ea3:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 09:16:07 -0700 (PDT)
In-Reply-To: <VI1PR0402MB3485AB652FBD61CE27965D3798410@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <20180622194752.11221-1-logang@deltatee.com> <20180622194752.11221-7-logang@deltatee.com>
 <CAOMZO5DpwPsidKQ9wfe8mNTgdOpkdHHgqHMa4yQBx9uRrfFmww@mail.gmail.com>
 <CAHp75VcCNsx2sHcYG2aNiw354exTvO=NUOS9P_BTmcM3siAepg@mail.gmail.com>
 <13ea3f97-4a33-3a24-1b7e-b819be73d867@deltatee.com> <CAOMZO5CfUfNZd0kG=VVnH4BjP+XMpGh3bPCUrTwi_4w6YEGX7g@mail.gmail.com>
 <CAHp75VcDudrwV4kRnVR+vtddFhxHsU672YqOJgPPchuLvPV3nA@mail.gmail.com>
 <CAOMZO5A4bsu9dXCPb4QeSbnnLi=pr1=WYWn8p2AfU3rEG=RWXg@mail.gmail.com>
 <6e5224b9-343f-990c-19bd-fe37c6fbdc9b@deltatee.com> <CAOMZO5CJ_iG=p_+xL=Q_Rv3F5vtGggsgatar4XVTL+UFVnHBTA@mail.gmail.com>
 <7ddda181-6337-32cc-7a0d-43fc6a7ba78b@deltatee.com> <CAHp75VcN=pUkFK6=_7yErMRGNS3WsgBhkWMSwP0Cw_ZmGR=RJg@mail.gmail.com>
 <991b2298-bb3f-dad3-c93b-b43ee5f372de@deltatee.com> <VI1PR0402MB3485F76DD56D221EB256B4F698410@VI1PR0402MB3485.eurprd04.prod.outlook.com>
 <CAOMZO5C7V4_SpXOcAz0KbGYScpos0HRD-aa-Zh_6M3p9EqLsLQ@mail.gmail.com> <VI1PR0402MB3485AB652FBD61CE27965D3798410@VI1PR0402MB3485.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 4 Jul 2018 13:16:07 -0300
Message-ID: <CAOMZO5BJXtpy+fmWxHqQWf_GwzoeQ=nTD8wWFAfw3vs6e0eV0g@mail.gmail.com>
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

On Wed, Jul 4, 2018 at 12:59 PM, Horia Geanta <horia.geanta@nxp.com> wrote:

> I guess it would be better this way.

Sounds good. I will submit the revert patch then.

Thanks
