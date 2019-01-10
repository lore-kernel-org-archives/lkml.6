Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1154BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46E8206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547138957;
	bh=xsnjqhuZJ9KzzhhGhsUf2Xx3JX61cB4FzMxRVnXI4Q0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=siYw7Gjjh7BPbdD5szqRp3olmzLw4I9jz457TMtKwtonAmGtDJiSzUkzSia7Q0We2
	 F7iBlD0EmclKQgnvA9eTD/arzVm0bYeWS1SusR1dfw6Pt3+KNyuWHv+XM2I00yooYI
	 X6NBIL3sYM5h/pLqsDt57wda7kQjc//WcaUEFHQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbfAJQtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:49:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:41850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728415AbfAJQtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 11:49:15 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B586214DA;
        Thu, 10 Jan 2019 16:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547138954;
        bh=xsnjqhuZJ9KzzhhGhsUf2Xx3JX61cB4FzMxRVnXI4Q0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BT6rikCiqNCJadXZUXNmRX9d9JHmB8U4rtNF35mSibn8cKNOMsQMHYN0lQiUGfWBQ
         FpSK7g8ID/fIDKfTrlMgAVzMuZ+Z/cPhLGUBTd7PZS+Yhu5/WQBUocFYIWxWI1ayMT
         lYtg3Ou8VzqG+PuAAadKI80t7HY3BDcPXqBuiMTs=
Received: by mail-qt1-f174.google.com with SMTP id t13so13890930qtn.3;
        Thu, 10 Jan 2019 08:49:14 -0800 (PST)
X-Gm-Message-State: AJcUukewCI8IDg2P5mYrSP0ihGUpqrt7i33Po6R2NYGg/0iBBIjTrEY5
        e1W226IOvU9AdFvPdjAI1XTQjGgYZBUODPtKrg==
X-Google-Smtp-Source: ALg8bN4xldI/Miwo9HXUJPBpA/jHxyoBCYOMMVvm/RezheoPqqQ3nHkH/EOX8PO/n16APDq3CYwv0m1/66kREwBpyb8=
X-Received: by 2002:a37:b646:: with SMTP id g67mr9959076qkf.326.1547138953214;
 Thu, 10 Jan 2019 08:49:13 -0800 (PST)
MIME-Version: 1.0
References: <20190110080821.30280-1-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190110080821.30280-1-manivannan.sadhasivam@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 10 Jan 2019 10:49:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJt3aKGBPCu49OxJx0_HDu5r1W9NhRfREowaBMQ047dSA@mail.gmail.com>
Message-ID: <CAL_JsqJt3aKGBPCu49OxJx0_HDu5r1W9NhRfREowaBMQ047dSA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add Oxalis board support
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>, Yang-Leo Li <leoyang.li@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        a.tropschug@ebs-systart.com, m.bittner@ebs-systart.com,
        Amit Kucheria <amit.kucheria@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 2:08 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Hello,
>
> This patchset adds Oxalis board support. This board is one of the
> 96Boards Enterprise Edition platform from EBS-SYSTART GmbH. Below are some
> of the key features of this board:
>
> * SoC: NXP Layerscape LS1012A
> * RAM: 1GB DDR3L
> * PMU: NXP VR5100
> * Storage: 64MByte SPI Flash for bootloader and RCW, MicroSD Card, SATA
> * Connectivity: 2x Ethernet
> * USB: 2x USB3.0
>
> More information about this board can be found in 96Boards product
> page: https://www.96boards.org/product/oxalis/
>
> Ethernet and SPI flash are not supported yet!
>
> Thanks,
> Mani
>
> Manivannan Sadhasivam (3):
>   dt-bindings: vendor-prefixes: Add EBS-SYSTART GmbH Vendor Prefix
>   dt-bindings: arm: fsl: Add devicetree binding for Oxalis
>   arm64: dts: freescale: Add devicetree for Oxalis
>
>  Documentation/devicetree/bindings/arm/fsl.txt |  4 +

This is converted to json-schema now (in Shawn's tree), so you'll need
to update to that.

Rob

>  .../devicetree/bindings/vendor-prefixes.txt   |  1 +
>  arch/arm64/boot/dts/freescale/Makefile        |  1 +
>  .../boot/dts/freescale/fsl-ls1012a-oxalis.dts | 96 +++++++++++++++++++
>  4 files changed, 102 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dts
>
> --
> 2.17.1
>
