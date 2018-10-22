Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB02C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C97E20652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXIVE5Av"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C97E20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbeJWCCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 22:02:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728629AbeJWCCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 22:02:03 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F83220663;
        Mon, 22 Oct 2018 17:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540230156;
        bh=VeEaZ2QwpQxpAy+OYIk/bbghGJA/tfkbQQRRgScuj0E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TXIVE5AvSHfFxTsLMHKIGRsixVXxj2P3Lru7w434QVtE69mnF13GJdrRI+vOIuo2Y
         Td2foZzOYVMdhOPsLp6J3YoYVddPtxdhASZdXoacQffB5kTpf5DTl3HHPR8n0ugOPY
         hcVg5JPFQcmLtaHh7LML0tWZ9V/M35GF8yEKRdIs=
Received: by mail-ed1-f47.google.com with SMTP id c15-v6so5751373eds.4;
        Mon, 22 Oct 2018 10:42:35 -0700 (PDT)
X-Gm-Message-State: ABuFfojTyZ796NqOqelFOcI8SwPWAI35PfbSJLSjXoBlpi2ZbtQZPeeM
        By0qi4YbKB5nS6wOGcw56ugPASepTUMfa1VKHrs=
X-Google-Smtp-Source: ACcGV61w6WwrJwSXK3NZdUBp5pj64L0LLWcAlxK6Dx82CEBhcNhyvAvt78jaBGuNW/B4RM4hqEl0p8AoE3ibQk0clpg=
X-Received: by 2002:a50:adca:: with SMTP id b10-v6mr14396600edd.184.1540230153556;
 Mon, 22 Oct 2018 10:42:33 -0700 (PDT)
MIME-Version: 1.0
References: <20181020084805.29103-1-nava.manne@xilinx.com> <20181020084805.29103-3-nava.manne@xilinx.com>
In-Reply-To: <20181020084805.29103-3-nava.manne@xilinx.com>
From:   Alan Tull <atull@kernel.org>
Date:   Mon, 22 Oct 2018 12:41:56 -0500
X-Gmail-Original-Message-ID: <CANk1AXQ_AFGX9_80YM7-GYncfZ8pOhaYdSb=O-ZpYCWuHx71vA@mail.gmail.com>
Message-ID: <CANk1AXQ_AFGX9_80YM7-GYncfZ8pOhaYdSb=O-ZpYCWuHx71vA@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: fpga: Add bindings for ZynqMP fpga driver
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

Just some nits, below.

>
> Add documentation to describe Xilinx ZynqMP fpga driver
> bindings.
>
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v1:
>                 Created a Seperate(New) DT binding file as
>                 suggested by Rob.
>
> Changes for RFC-V2:
>                 -Moved pcap node as a child to firwmare
>                  node as suggested by Rob.
>
>  .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt     | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
>
> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> new file mode 100644
> index 000000000000..248ff0ee60a8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> @@ -0,0 +1,17 @@
> +--------------------------------------------------------------------------

Please get rid of all these '----' separators (in 4 places).

> +Device Tree zynqmp-fpga bindings for the Zynq Ultrascale+ MPSoC controlled
> +using ZynqMP SoC firmware interface
> +--------------------------------------------------------------------------
> +For Bitstream configuration on ZynqMp Soc uses processor configuration
> +port(PCAP) to configure the programmable logic(PL) through PS by using
> +FW interface.
> +
> +Required properties:
> +- compatible: should contain "xlnx,zynqmp-pcap-fpga"
> +
> +-------
> +Example

Nit: please add a colon so 'Example:'
> +-------
> +       zynqmp_pcap: pcap {
> +               compatible = "xlnx,zynqmp-pcap-fpga";
> +       };
> --
> 2.18.0
>

Thanks,
Alan
