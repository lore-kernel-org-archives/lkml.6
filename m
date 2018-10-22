Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCABC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9631120664
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NU5KCvdJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9631120664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbeJWAS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 20:18:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727820AbeJWAS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 20:18:26 -0400
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87E4520674;
        Mon, 22 Oct 2018 15:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540223960;
        bh=2X572wAnhxyRe8B89ooSC2FuUAqzgppRW2gSbmFfy0c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NU5KCvdJLJIoS1NED8rCcmrvMciDZRxpKQAB9A8I+raTRk9CtePArdxXAQpoV0m8s
         Rn/Mrcgw7rD4Pyq0ZkhkJgpgPA2DG1bQxx8WB67pw4HSvLWsgz10RbowFbAOk204iy
         GpaeSRbi3c+wtUYa8Xs53O7TH6hmaTEG6bOPGXQ0=
Received: by mail-ed1-f52.google.com with SMTP id v22-v6so1958432edq.13;
        Mon, 22 Oct 2018 08:59:20 -0700 (PDT)
X-Gm-Message-State: AGRZ1gJfncGhj1GgiiFOFaDw9+B7f9Y31XjXcHgVehCWdUZdF+bvXsxN
        CXtiVcY1ThUtFpkvMilqQaJUmFBLWDn64aUlwpU=
X-Google-Smtp-Source: AJdET5eGeexztxXLmfjFTEAhl8R12iYf1RYkTvK3cEZK8ZozXdipIIsz9DwKhxpKzumxU32wQI3qnP6nkUBh087LHM8=
X-Received: by 2002:a50:cd4b:: with SMTP id d11-v6mr3637763edj.60.1540223958470;
 Mon, 22 Oct 2018 08:59:18 -0700 (PDT)
MIME-Version: 1.0
References: <20181020084805.29103-1-nava.manne@xilinx.com>
In-Reply-To: <20181020084805.29103-1-nava.manne@xilinx.com>
From:   Alan Tull <atull@kernel.org>
Date:   Mon, 22 Oct 2018 10:58:42 -0500
X-Gmail-Original-Message-ID: <CANk1AXTUu=qiko9_sLrxrNxBmX7p0OXVxNN13p1uBirNh+Ymtw@mail.gmail.com>
Message-ID: <CANk1AXTUu=qiko9_sLrxrNxBmX7p0OXVxNN13p1uBirNh+Ymtw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add Bitstream configuration support for ZynqMP
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>, rajanv@xilinx.com,
        jollys@xilinx.com, linux-fpga@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kishore m <chinnikishore369@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 3:49 AM Nava kishore Manne
<nava.manne@xilinx.com> wrote:

Hi Nava,

>
> This series of patches are created On top of the
> below repo.
> //git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
> BRANCH: next/drivers.

IIUC this is dependent on some patches that aren't released yet.
Please make this explicit by specifying which patches this is
dependent on in each future submission of new versions.  It will help
so that I don't send these upstream prematurely and introduce build
breaks.  Of course, we can keep reviewing!

Thanks for submitting!
Alan

>
> Nava kishore Manne (3):
>   firmware: xilinx: Add fpga API's
>   dt-bindings: fpga: Add bindings for ZynqMP fpga driver
>   fpga manager: Adding FPGA Manager support for Xilinx zynqmp
>
>  .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt   |  17 ++
>  drivers/firmware/xilinx/zynqmp.c              |  46 +++++
>  drivers/fpga/Kconfig                          |   9 +
>  drivers/fpga/Makefile                         |   1 +
>  drivers/fpga/zynqmp-fpga.c                    | 159 ++++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h          |   4 +
>  6 files changed, 236 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
>  create mode 100644 drivers/fpga/zynqmp-fpga.c
>
> --
> 2.18.0
>
