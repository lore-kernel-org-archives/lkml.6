Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DATE_IN_FUTURE_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E56C65BAF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 04:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C96C72081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 04:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="T+wh7I9D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C96C72081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mobiveil.co.in
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbeLJEiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 23:38:50 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38951 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbeLJEiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 23:38:50 -0500
Received: by mail-wm1-f68.google.com with SMTP id f81so9684869wmd.4
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 20:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobiveil.co.in; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QQeTPStWdQffsRdjgIQ5kUxjgC0AbP5Kz14R+R3dPic=;
        b=T+wh7I9DNmSNRX3WgITI5B09E9p3OBneiKE7VgJYm9K98VAJD4R2VdKNzmtADj6ZDs
         8HjKPnJrpNJdS5JiaFKUiyybIQIwAwlDremNtS1zD2aU+MrTr93PFCRJsI9RaRqnYUmr
         qIW4XGzqLYH4dQme2iG9ZbpPbYi41KVsdIfWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QQeTPStWdQffsRdjgIQ5kUxjgC0AbP5Kz14R+R3dPic=;
        b=HgG/indFesqZKfPczPJGxIdGzsM1TcpbKTwTZrMPa2oUInLdb+eeSmycH3okuiPQIn
         FLg7Xl6z4Om/O2zlcEV+1EXnBpZdADSLN5AoXpkxcdOC6sYsukYdhnz/cxVu2icuD32S
         CteUr2NHpu9VYrDr42RCX1NLfLAW/p8dcUf6W8OZbNs+O0BfJGHf3SQ8ALUvPZzYWmd+
         ItJmmgAx+Zlk/7fIRnECdRvjPn7ClhbhvAQe50AInLJ7C3m+zQ/pjZUH5g5h/x2faj9X
         /yn5Q4kTSB6K1gjw/HgnNCCkRSDZLqUfrOCeNWM7cyIbpF0xsuLcQO7vEP3lXhY61EbU
         A0gQ==
X-Gm-Message-State: AA+aEWa7BJF8WzmCos6yLNcmuWkXQwnDmANlrQsaDypUo9nq9HSlWGvc
        NDJBehT2J2h+TqpsYC3KiPlQgmk14PG0pua7ZKgKbQ==
X-Google-Smtp-Source: AFSGD/WSKQNt6trakD0WZgJFVEZ/HFHbKPf61xg/m2kFM3J3PNhSIJHQGgCKPvIfpbKWxkb5tQP1z95XAd9yAvK9YE4=
X-Received: by 2002:a1c:a84f:: with SMTP id r76mr9216138wme.16.1544416727742;
 Sun, 09 Dec 2018 20:38:47 -0800 (PST)
MIME-Version: 1.0
References: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com> <20181203115850.GB8040@e107981-ln.cambridge.arm.com>
In-Reply-To: <20181203115850.GB8040@e107981-ln.cambridge.arm.com>
From:   Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date:   Mon, 10 Dec 2018 07:16:17 -0300
Message-ID: <CAFZiPx1cXVWi0vLA4ZtOTeObXg8RtvFX+m31NM2Ezqzq7ymPaA@mail.gmail.com>
Subject: Re: [PATCH 00/23] PCI: refactor the Mobiveil driver and add PCIe
 support for NXP LX SoCs
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     "Z.q. Hou" <zhiqiang.hou@nxp.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        Leo Li <leoyang.li@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>, xiaowei.bao@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lorenzo,
You are right, I reviewed few DT files, will need some time to review
this train.
I will start doing it in a while.

Thanks for pitching in.

Thanks.

On Mon, Dec 3, 2018 at 8:58 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Tue, Nov 06, 2018 at 01:19:03PM +0000, Z.q. Hou wrote:
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >
> > This patch set is aim to refactor the Mobiveil driver and add
> > PCIe support for NXP LX series SoCs.
> >
> > Hou Zhiqiang (23):
> >   PCI: mobiveil: uniform the register accessors
> >   PCI: mobiveil: format the code without function change
> >   PCI: mobiveil: correct the returned error number
> >   PCI: mobiveil: remove flag MSI_FLAG_MULTI_PCI_MSI
> >   PCI: mobiveil: correct PCI base address in MEM/IO outbound windows
> >   PCI: mobiveil: replace the resource list iteration function
> >   PCI: mobiveil: use WIN_NUM_0 explicitly for CFG outbound window
> >   PCI: mobiveil: use the 1st inbound window for MEM inbound transactions
> >   PCI: mobiveil: correct the inbound/outbound window setup routine
> >   PCI: mobiveil: fix the INTx process error
> >   PCI: mobiveil: only fixup the Class Code field
> >   PCI: mobiveil: move out the link up waiting from mobiveil_host_init
> >   PCI: mobiveil: move irq chained handler setup out of DT parse
> >   PCI: mobiveil: initialize Primary/Secondary/Subordinate bus number
> >   dt-bindings: pci: mobiveil: change gpio_slave and apb_csr to optional
> >   PCI: mobiveil: refactor the Mobiveil driver
> >   PCI: mobiveil: continue to initialize the host upon no PCIe link
> >   PCI: mobiveil: disabled IB and OB windows set by bootloader
> >   PCI: mobiveil: add Byte and Half-Word width register accessors
> >   PCI: mobiveil: change prototype of function mobiveil_host_init
> >   dt-bindings: pci: Add NXP LX SoCs PCIe controller
> >   PCI: mobiveil: add PCIe RC driver for NXP LX series SoCs
> >   arm64: dts: freescale: lx2160a: add pcie DT nodes
> >
> >  .../devicetree/bindings/pci/lx-pci.txt        |  52 ++
> >  .../devicetree/bindings/pci/mobiveil-pcie.txt |   2 +
> >  MAINTAINERS                                   |  10 +-
> >  .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 157 ++++
> >  drivers/pci/controller/Kconfig                |  11 +-
> >  drivers/pci/controller/Makefile               |   2 +-
> >  drivers/pci/controller/mobiveil/Kconfig       |  34 +
> >  drivers/pci/controller/mobiveil/Makefile      |   5 +
> >  drivers/pci/controller/mobiveil/pci-lx.c      | 222 +++++
> >  .../controller/mobiveil/pcie-mobiveil-host.c  | 622 +++++++++++++
> >  .../controller/mobiveil/pcie-mobiveil-plat.c  |  54 ++
> >  .../pci/controller/mobiveil/pcie-mobiveil.c   | 245 +++++
> >  .../pci/controller/mobiveil/pcie-mobiveil.h   | 221 +++++
> >  drivers/pci/controller/pcie-mobiveil.c        | 861 ------------------
> >  14 files changed, 1625 insertions(+), 873 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/pci/lx-pci.txt
> >  create mode 100644 drivers/pci/controller/mobiveil/Kconfig
> >  create mode 100644 drivers/pci/controller/mobiveil/Makefile
> >  create mode 100644 drivers/pci/controller/mobiveil/pci-lx.c
> >  create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> >  create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
> >  create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil.c
> >  create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil.h
> >  delete mode 100644 drivers/pci/controller/pcie-mobiveil.c
>
> Subrahmanya,
>
> for the records, this is the driver *you* are maintaining, aren't you ?
>
> We ask developers to be added to the MAINTAINERS list in order to hold
> them accountable, merging a driver upstream means that you need to
> actively maintain it, which in turn means reviewing series affecting
> its code, like this one.
>
> I will have a look too but it is your responsibility to review these
> patches and ACK them accordingly.
>
> So I strongly suggest you start doing it please.
>
> Thanks,
> Lorenzo
