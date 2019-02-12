Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE91C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD88320842
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ettus-com.20150623.gappssmtp.com header.i=@ettus-com.20150623.gappssmtp.com header.b="SEG2klxA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbfBLLCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 06:02:44 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:36853 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfBLLCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 06:02:44 -0500
Received: by mail-yb1-f193.google.com with SMTP id h40so863831ybj.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 03:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ettus-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1TQumLme3VslgLidIYqA5/lXkSqNK175qjGod6Gj/HI=;
        b=SEG2klxAVYy3ShSSvEnQjvAi5binY5sJpnF1brUGgZaRCWfmXlmt7tuHBEPUR/5GuP
         HTltwY1qZU+5O5IOCOpgkF1ssKDIH8RoggYP249RiUDzD0gqasf7MLm831mK9rtkIb9E
         cCz7sx1QKqWMrUgUtFyIrcFapMhGqjMAd7h8AsKIPXXJ8cj5wb6QrcJeCtmGVajnBEdW
         qgi+uk+zUIIzZdYfKUL/6XRLz8DVPovVDLhJvMlBFwRxrNjyMuAxZRh5tGz8AMXmrA8+
         N8HqOgiZ/dcx1gS7SLGw8eX18LKhMYIfIrqeJvWmMjUIRx8Yavfs9fExdYrZt3Dx00vv
         6flw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1TQumLme3VslgLidIYqA5/lXkSqNK175qjGod6Gj/HI=;
        b=gTiYwNOLA7FZxV10ah8uET4L2Tl3COlnRSCzfk3BpAmz7J8mCEGNITQU7vJWGARf/7
         QzsgqHXnvYTw0kYG03gitdY3VmR+LwrxzdGhd0HuoX3f7LisYqsyP03wLwx820GdPa1K
         e3M0u3TD2hcap2gVgriVu+CbxjF0FoF9egDOgiM67d6Kr3kFXOWbZ2SNbpO70pLNITzQ
         DPv04hFx+89MDcVAT12rrimtEhjCj+KNpvJH1Ew+1hZ9oRsDHHV6zgBzVcSM+sj8Jpz/
         DVGWvkh67x56xmDES9qo0uqgZBeNeybn5uLitGjfrESzsP6fZ7jrKoExMExsb2Wl1qbO
         wGVQ==
X-Gm-Message-State: AHQUAuYo+srL00loLZFNRzm1M6AwlRQBgdIDfeNyk7oNN8MHKFYEWGSH
        j3xhnzy+kPiIGhpHy+Eb3M/nrqSwc9rt0dqnkcDdZw==
X-Google-Smtp-Source: AHgI3IYLJ4YuJVUaAx71HhbJwIAKrL39Z8uLVKZBQFNWT3iT4yLnfRiX4jolQ2bFJgGBNlYCEw2qTDDFsngcCijK1+4=
X-Received: by 2002:a25:7d05:: with SMTP id y5mr2250739ybc.439.1549969363078;
 Tue, 12 Feb 2019 03:02:43 -0800 (PST)
MIME-Version: 1.0
References: <20190211161736.23844-1-nava.manne@xilinx.com>
In-Reply-To: <20190211161736.23844-1-nava.manne@xilinx.com>
From:   Moritz Fischer <moritz.fischer@ettus.com>
Date:   Tue, 12 Feb 2019 03:02:32 -0800
Message-ID: <CAAtXAHfUih0fWh6GhkRLKHb9epqhY_BnVzD-wBZ28rK+QY82LA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: fpga: Add bindings for ZynqMP fpga driver
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     Alan Tull <atull@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Rajan Vaja <rajanv@xilinx.com>, Jolly Shah <jollys@xilinx.com>,
        linux-fpga@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kishore m <chinnikishore369@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nava,

a couple of nits inline. otherwise looks fine to me.

On Sun, Feb 10, 2019 at 8:17 AM Nava kishore Manne
<nava.manne@xilinx.com> wrote:
>
> Add documentation to describe Xilinx ZynqMP fpga driver
> bindings.
>
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v3:
>                 -Created patches on top of 5.0-rc5.
>                  No functional changes.
> Changes for v2:
>                 -Removed "----" separators.
> Changes for v1:
>                 -Created a Seperate(New) DT binding file as
>                  suggested by Rob.
>
> Changes for RFC-V2:
>                 -Moved pcap node as a child to firwmare
>                  node as suggested by Rob.
>
>  .../devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt      | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
>
> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> new file mode 100644
> index 0000000..1f6f588
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> @@ -0,0 +1,13 @@
> +Device Tree zynqmp-fpga bindings for the Zynq Ultrascale+ MPSoC controlled
> +using ZynqMP SoC firmware interface

How about:
Devicetree bindings for Zynq Ultrascale MPSoC FPGA Manager.

> +For Bitstream configuration on ZynqMp Soc uses processor configuration
> +port(PCAP) to configure the programmable logic(PL) through PS by using
> +FW interface.
ZynqMP or ZynqMp, let's stay consistent here.

How about:
The ZynqMP SoC uses the PCAP (Processor configuration Port) to configure the
Programmable Logic (PL). The configuration uses  the firmware interface.
> +
> +Required properties:
> +- compatible: should contain "xlnx,zynqmp-pcap-fpga"
> +
> +Example:
> +       zynqmp_pcap: pcap {
> +               compatible = "xlnx,zynqmp-pcap-fpga";
> +       };
> --
> 2.7.4
>

Thanks,
Moritz
