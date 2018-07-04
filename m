Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C015C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05CA3208B9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XncA4EU2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05CA3208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752826AbeGDRKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 13:10:30 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:38326 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752173AbeGDRK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 13:10:27 -0400
Received: by mail-vk0-f67.google.com with SMTP id b77-v6so3445418vkb.5;
        Wed, 04 Jul 2018 10:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3wrNX1e5zhFeVO/U7zih+xML/8/TNWt8iAN0kSsXRMY=;
        b=XncA4EU2aWZJvC4tsP7yH2zVD9Tj2sIxJm4IVITzlIZxrXFkP/GmHzLElDQxafzYw8
         6fcq5yTqAjvR+jtTagy0mK4GVJAZHZVI2DAJE1q9JE65YJZb6Hui2lhR4W4fHg/PHvmv
         Qt++CY+9M03SOr8v13NNnCMF0VTpe/5Cb2D+1CNOy+zaPViNeVENTUzS6ZW/y+Sbmbs1
         Shmtox22BAmrrxs45XbWrvOOxNZjGY4/ZFMtjjTyNU+rMQVH7mwBnyFLkC/YMj1OogMT
         6xMzJOLc7c2k3zsKpHGJFeazRIgHMb8S7XomsvnuyZZaMScCbxAuz+6ZcH8/UOxzEWW/
         AN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3wrNX1e5zhFeVO/U7zih+xML/8/TNWt8iAN0kSsXRMY=;
        b=LQG6kBbKLpip1LKEFW5ox2bQ27MalYI9TIdPkHavz4qSRcuFpdvYfHhBclZjOFr7Va
         OlG9pVoOsiQG73qTxnoiUspBd6sPmmjsUf+Prv/varwn9mtf4gzXdxsjZl/caHpsKhBt
         pNKo9MUXiTlXMfFK29ZewPz42QUI2SETixrKoG1KJ4ALcBwkPrcpfNOyUN43bjhc3vnE
         fbbyX3ltP0pTvRyxJXne73qxi78e7wnDqcre+atGWwu6KhDsQ23haxcJ0vnR0vduGkBK
         0m+Pz/O5CSKVsR1QzDQ2aokRRSq2OtpdcMYISQSm+hwuziv0mf0CjgS0GECmzLz5Rt3H
         OVBw==
X-Gm-Message-State: APt69E1STJB/ZjoMMvO9gF7NKaoa3VasVQynD6PGumiCEL6yKQwhSPXC
        VlfEj+lO0tEOBJJdGm6c890jqqapmsj+nWQ6JLM=
X-Google-Smtp-Source: AAOMgpc7Y1vB9bx8EUve86aAIBz1NDFvcZXO1Du1SlfexPt/T8Ov4/LAZa3mPfoQlmVtPJOIkWuexG8xs7TtiFwwavY=
X-Received: by 2002:a1f:6dc4:: with SMTP id i187-v6mr1560497vkc.131.1530724226639;
 Wed, 04 Jul 2018 10:10:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 10:10:25 -0700 (PDT)
In-Reply-To: <55236e2b-a2a5-493a-5696-19c5926885b3@deltatee.com>
References: <20180622194752.11221-1-logang@deltatee.com> <20180622194752.11221-7-logang@deltatee.com>
 <CAOMZO5DpwPsidKQ9wfe8mNTgdOpkdHHgqHMa4yQBx9uRrfFmww@mail.gmail.com>
 <CAHp75VcCNsx2sHcYG2aNiw354exTvO=NUOS9P_BTmcM3siAepg@mail.gmail.com>
 <13ea3f97-4a33-3a24-1b7e-b819be73d867@deltatee.com> <CAOMZO5CfUfNZd0kG=VVnH4BjP+XMpGh3bPCUrTwi_4w6YEGX7g@mail.gmail.com>
 <CAHp75VcDudrwV4kRnVR+vtddFhxHsU672YqOJgPPchuLvPV3nA@mail.gmail.com>
 <CAOMZO5A4bsu9dXCPb4QeSbnnLi=pr1=WYWn8p2AfU3rEG=RWXg@mail.gmail.com>
 <6e5224b9-343f-990c-19bd-fe37c6fbdc9b@deltatee.com> <CAOMZO5CJ_iG=p_+xL=Q_Rv3F5vtGggsgatar4XVTL+UFVnHBTA@mail.gmail.com>
 <7ddda181-6337-32cc-7a0d-43fc6a7ba78b@deltatee.com> <CAHp75VcN=pUkFK6=_7yErMRGNS3WsgBhkWMSwP0Cw_ZmGR=RJg@mail.gmail.com>
 <991b2298-bb3f-dad3-c93b-b43ee5f372de@deltatee.com> <VI1PR0402MB3485F76DD56D221EB256B4F698410@VI1PR0402MB3485.eurprd04.prod.outlook.com>
 <CAOMZO5C7V4_SpXOcAz0KbGYScpos0HRD-aa-Zh_6M3p9EqLsLQ@mail.gmail.com> <55236e2b-a2a5-493a-5696-19c5926885b3@deltatee.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Jul 2018 20:10:25 +0300
Message-ID: <CAHp75VfCFdFh3eMpdpNYdNtbuVKG60PbUnYVsEbCrxP5pUZwMQ@mail.gmail.com>
Subject: Re: [PATCH v18 6/7] crypto: caam: cleanup CONFIG_64BIT ifdefs when
 using io{read|write}64
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Horia Geanta <horia.geanta@nxp.com>,
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

On Wed, Jul 4, 2018 at 8:01 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
> On 7/4/2018 9:06 AM, Fabio Estevam wrote:

> Hmm, well in fairness that commit didn't add any BE operations so
> lower/higher address is the same as lower/higher data being written.
> hi-lo/lo-hi is a bit ambiguous in that sense and designing it to match
> the semantics of the only user seemed to make sense at the time. I
> didn't even check the rough comments in an old commit message which I
> wouldn't really take as canonical. Also, it seems to me, most hardware
> would expect you to write in order of the address (if it cares at all)
> not in the order of the higher/lower data word. Though, I have no
> explicit examples only a gut feeling.

We have an iDMA 32-bit hardware (see drivers/dma/dw/) which has an
extension 64-bit registers where only one of them has a specific bit
to "commit" the changes written to all of them. And by some very
unknown reason that bit is in lo part which automatically means we
must to write it last.

-- 
With Best Regards,
Andy Shevchenko
