Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73F8C282CD
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 04:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5E420881
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 04:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVYtttwI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbfA3Ete (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 23:49:34 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:47024 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbfA3Ete (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 23:49:34 -0500
Received: by mail-lf1-f66.google.com with SMTP id f5so16346090lfc.13;
        Tue, 29 Jan 2019 20:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JO6H46CTHBzFm/XOD+n/nEDz7rrFEwNgn/lOiGCKwNA=;
        b=cVYtttwIJcE6AN1NAHWJQVq3d6iGonpk3fWhj6C384+JDzPSYlIpOl8T/Ujt1PK2r+
         5EIZI+7pOFFp3lBAgO5D2SEY5oxaMAme9DaS+eBO2cgp6y0A21X5OC7n4tsFnL6laqlA
         PrrXrASoeAbQclMGyWGDK1W5jReFnRBmrSJPUlV4JGF5mEo3GqUCCoGgWtmgGsGE+nnb
         uMfBwTvSUUhTSAqzxzwduAYYrBAFo8Z6gOV2r7QmdXhl5vYqGXBkrEVzAa6pVYoxf/Tg
         A/I6b1Cf3BQ197TwPsbircYHK9FGQfq2820PFwo4MqcDkgbOv1YMWlizrdPz4Kziv8L/
         A2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JO6H46CTHBzFm/XOD+n/nEDz7rrFEwNgn/lOiGCKwNA=;
        b=inaZxrBul2YQa5wnN368UtmRsto+tsH7xBeOB5TkVLNz+UldL4DHOcTMRkTO+jh3SX
         LCMZOinLyruE8PsbHdWk1ELCHf3sV5P7Da3ez7drbK81G0AOEcQw8BdjnDYvA8JgrKIo
         pIFt5bEN8qDllcyUBuNS0d59cK7Sx3SR/uZdjZ5V6Z57YhwlO/A4AH4GAR4D5ASx6hxn
         zI81wh+C7oJHSvZmuO+nQNtJRE0dADmwr4xl03s1aW80rLAtCGHSRsZsMsMAPNBDtjnG
         XiXD33z3MYzgCpTlQJ8TTnWKO4/x/ePuJW/iwIOcERINmpGuKw+JqMlJGrNVfCYh9xFH
         sdeg==
X-Gm-Message-State: AJcUukeJYmqya+d4KtnrX5JO2Ia7Qy2Kkbym+3JVqiufWz3lCnAVtUol
        GsfbYkjWqWHwTvqGUQpnHso=
X-Google-Smtp-Source: ALg8bN4kAKNhpttgpjMrcdB15QUCqPImEIiiOnHwdGyuGEJf8VNuyVtepLPU6g7DAKJHL7ps1P77jw==
X-Received: by 2002:a19:980f:: with SMTP id a15mr22150227lfe.103.1548823771621;
        Tue, 29 Jan 2019 20:49:31 -0800 (PST)
Received: from dimatab (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id j138sm74825lfg.64.2019.01.29.20.49.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 20:49:31 -0800 (PST)
Date:   Wed, 30 Jan 2019 07:49:51 +0300
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        "Shardar Mohammed" <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH V5 3/5] i2c: tegra: Add DMA Support
Message-ID: <20190130074951.154cf037@dimatab>
In-Reply-To: <BYAPR12MB3398502D8F00D4F7BFF25D27C2900@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1548803771-13424-1-git-send-email-skomatineni@nvidia.com>
        <1548803771-13424-3-git-send-email-skomatineni@nvidia.com>
        <20190130044214.65991195@dimatab>
        <BYAPR12MB339850895826781B4E6AF028C2900@BYAPR12MB3398.namprd12.prod.outlook.com>
        <BYAPR12MB339812A2E876B76E95828EA1C2900@BYAPR12MB3398.namprd12.prod.outlook.com>
        <BYAPR12MB3398502D8F00D4F7BFF25D27C2900@BYAPR12MB3398.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=92 Wed, 30 Jan 2019 04:22:10 +0000
Sowjanya Komatineni <skomatineni@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> [Correction]
>=20
> > > Could you please tell whether you missed my comments to V3 [0] or
> > > chose to ignore them? If the former, then I'd want to get answers
> > > to those questions and comments. I'll stop here for now.
> > >=20
> > > [0] https://patchwork.ozlabs.org/patch/1031379/ =20
> >
> > Somehow missed those from multiple comments. Will go thru and
> > respond back. =20
>=20
> V6 includes feedback changes. Want to clarify on few feedback points
>=20
> - ALIGN is used for 4 byte boundary to use with DMA but extra bytes
> doesn=E2=80=99t get transferred over I2C as I2C controller transfer bytes
> based on size specified in the packet header. DMA length and memory
> address need to be 4 byte boundary.

Okay, I see now. Thanks.

> - RX channel releasing when TX init fails?
>   For I2C both TX and RX doesn=E2=80=99t happen in same transaction and no
> dependency. So if RX channel request & buffer allocation succeeds but
> TX channel request fails, then RX DMA can still be used for Msg reads
> and transmits can happen on PIO mode

That's not what my point is about. In a case of TX initing failure, the
RX channel and DMA buffer are not getting released in the probe
function. Please be more careful about managing allocated resources.

> - dma_burst < 8 negatively affects transfer efficiency? Performance
> stats for DMA Vs PIO mode. Tested with 256 bytes of transfer and DMA
> Vs PIO mode transfer rate is almost same. But the main reason for
> adding DMA mode is to address couple of cases mentioned earlier and
> not mainly from the transfer performance perspective.=20

Could you please add a clarifying comment to the code, saying that the
whole purpose of the DMA transfer is solely to avoid delaying of the
transactions?

Thanks for the replies! I'll take a look at V6 later today.
