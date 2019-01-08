Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA691C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99DB92070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546971126;
	bh=BQpvuW78ktDWmktZXBnmTMkVllcIV2yFx7pGbDIBTm8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=btW4WMZY7qHBlkzI/H6L7wPi9jQN1+mnDRN/K6mCP5+cwdZmRxZFMVf5sZz5LNlaG
	 a5WIUktr9oRUtxmi+hm6BN6mdT+A53NuQeosMuRs7Fs6gwJFu0vd0vpKiYLZQVzIlu
	 eqRkcxwJogutCgnbQUMkkhEasH9N/MMx6j0jz7/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbfAHSMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:12:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:50816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728587AbfAHSMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:12:05 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD99F218A1;
        Tue,  8 Jan 2019 18:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546971124;
        bh=BQpvuW78ktDWmktZXBnmTMkVllcIV2yFx7pGbDIBTm8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d5WiCKII3/Pz/vHHryg0/nw2MkWWnXnfbUCHIRKu5porGyaVOE1kodRwQBGEZtA5X
         mNcALro/GkkxQqKpBxNB50ML6LEqzrUvX3XhKt9FgKANdp5LuPWAzjpCt2Oy3x0pcA
         xBToTGRt858ICTYYU0iy3ZQWjBpnYiFiWecrAcas=
Received: by mail-qt1-f172.google.com with SMTP id l12so5384723qtf.8;
        Tue, 08 Jan 2019 10:12:03 -0800 (PST)
X-Gm-Message-State: AJcUuke9Lv/kdgVMYyOz9l7/ma++KODvRzt9DVA5/gRPRgECEE5CISa7
        UEShRSYsMhT9pLFGo5g8VAd6FRe7xe02EseaDg==
X-Google-Smtp-Source: ALg8bN6YNs9GINgxVL8lT6K2vS60Wb+xmgG/nWRtLVvJ3yvE9h/SiwmhRz5HmClmDwi/LtIiv0hjybsvIRF4K7sNMvE=
X-Received: by 2002:ac8:2d2b:: with SMTP id n40mr2608181qta.38.1546971122996;
 Tue, 08 Jan 2019 10:12:02 -0800 (PST)
MIME-Version: 1.0
References: <1545144107-88378-1-git-send-email-michal.vokac@ysoft.com>
 <20181228232556.GA14277@bogus> <49371bd4-6ab9-31c3-dd48-800becac17e3@ysoft.com>
 <CAL_JsqJyZt=VCv2bX1YYFQt91BcFqDWfeAqkJVcF7eFD0_JM1g@mail.gmail.com>
 <6fd5ac6a-edb5-a600-3c10-b46a1c1d9906@ysoft.com> <f96952b2-7b19-5397-00a1-0fe9b5800dab@ysoft.com>
In-Reply-To: <f96952b2-7b19-5397-00a1-0fe9b5800dab@ysoft.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 8 Jan 2019 12:11:50 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLRX2g1t-8YCqpZ5fd=-MyLPkgy88Gb=6ohEZbxWfS+LA@mail.gmail.com>
Message-ID: <CAL_JsqLRX2g1t-8YCqpZ5fd=-MyLPkgy88Gb=6ohEZbxWfS+LA@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: imx: Add Y Soft IOTA Draco, Hydra and Ursa boards
To:     =?UTF-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 10:09 AM Vok=C3=A1=C4=8D Michal <Michal.Vokac@ysoft.=
com> wrote:
>
> On 8.1.2019 16:00, Vok=C3=A1=C4=8D Michal wrote:
> > On 8.1.2019 15:56, Rob Herring wrote:
> >> On Tue, Jan 8, 2019 at 5:43 AM Vok=C3=A1=C4=8D Michal <Michal.Vokac@ys=
oft.com> wrote:
> >>>
> >>> On 29.12.2018 00:25, Rob Herring wrote:
> >>>> On Tue, Dec 18, 2018 at 02:42:11PM +0000, Vok=C3=A1=C4=8D Michal wro=
te:
> >>>>> These are i.MX6S/DL based SBCs embedded in various Y Soft products.
> >>>>> All share the same board design but have slightly different HW
> >>>>> configuration.
> >>
> >> [...]
> >>
> >>>>> +/ {
> >>>>> +    model =3D "Y Soft IOTA Draco i.MX6Solo board";
> >>>>> +    compatible =3D "ysoft,imx6dl-yapp4-draco", "fsl,imx6dl";
> >>>>
> >>>> All compatible strings should be documented, not just SoC vendor boa=
rds.
> >>>
> >>> OK, I will add a Documentation/devicetree/bindings/arm/ysoft.yaml fil=
e for that.
> >>
> >> Actually, it should go in fsl.yaml. The file for every board vendor is
> >> gone. i.MX was pretty much the only platform doing that.
> >
> > OK, I will do so. Thank you.
>
> I am sorry for the noise Rob, but your "dt-bindings: arm: Convert FSL
> board/soc bindings to json-schema" patch is not in mainline yet. So
> there is no arm/fsl.yaml file to add my compatible strings into.
>
> Now I do not know how to respin. Should I send this updated dts/dtsi
> patch as usual and create another patch with the ysoft compatible
> strings against your yaml-bindings-v2 branch, where the fsl.yaml file
> exist? Or something else?

Humm, I thought Shawn had applied to his tree as there were some conflicts.

Shawn, do you need me to resend?

Rob
