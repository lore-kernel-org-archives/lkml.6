Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD92C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8EF21A2E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ettus-com.20150623.gappssmtp.com header.i=@ettus-com.20150623.gappssmtp.com header.b="cTV3QAfZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB8EF21A2E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ettus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbeHQTf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 15:35:58 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:38204 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbeHQTf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 15:35:57 -0400
Received: by mail-yb0-f194.google.com with SMTP id c1-v6so482625ybq.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 09:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ettus-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fZw2X/38ghpsGK069mXTDTlh8k6bvpsaz6gPRmD2hm8=;
        b=cTV3QAfZreykf6FPe9iXvfG/yGk05Q5TgLO2mPrSle/XsEjj8IRuYpt6YHc3C7kNTS
         dr2kCcPqztl20uP2JlEblsSce/is9J8e5or0n0cASBEFa/DMK5/mASx0aS15y1UH6W4S
         pUUdoQaIWcmTg9Mb5Fh4eXXVUoZ6l2VvTH7L87f3Q+tPJohbRUJoRhKnXahi0twY3V+t
         XlzRD6z76FUmBgA/CXjPX3b0b6pC3LXOQDI6cS9zwasgyEk3da48PjY75CtAml8FsAvk
         CKRiX6poqOMtW2fNroHpXgEfwdDmU08F/aTEoQYlmo0jbmcRmliheE1PbiZsZnTUHgty
         j0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fZw2X/38ghpsGK069mXTDTlh8k6bvpsaz6gPRmD2hm8=;
        b=S+TjL9ySp09aeUXLcEvHTBLSuNoHgTNtAJRjBobue9M/fzjJxtwbdDf7MINVHZxM7w
         et+EuA2ijNTQSZ3BfNiKxCldhinhKzunhdcRyI9mys4CWtYMK0D/zpo7kjr7MHP5Ac91
         cO3ZrZkiiiLX5NaOSqJ2e181Kiv9lda4xqymTJf9EMs/FLkwA4FJY7pLGQjotEDUUxLb
         b0WNlMS9VD+PNirqYKnj2oDLrbveGh0jBc62/OJo8mybVmcgkZI2Rg7cDO8NOw2As5mi
         vIUetoet9FXqBaO+qClw/rpeAwlY8OorsrVS3Q8GJhF7guu2gVXJCTbqE1mJADrE8VuR
         /RMA==
X-Gm-Message-State: AOUpUlFWs5zR6yFNEZYcIcoNhUXcx462fK81RdoR8H8PPgzIvzzaBTlu
        i4zWqz3FJUMIljnlq67mXtCXGHGwh4tHMdR/pPJM9w==
X-Google-Smtp-Source: AA+uWPwpw8UYLlDC6kLG2sgVIaaQJ8ccq6Gr1+L8a+30c7OpP2sKTeTc+4hE5eI6NajATtM2PJkyOtBhsyuLz2UNPKQ=
X-Received: by 2002:a25:2548:: with SMTP id l69-v6mr19296572ybl.230.1534523515821;
 Fri, 17 Aug 2018 09:31:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:3c0a:0:0:0:0:0 with HTTP; Fri, 17 Aug 2018 09:31:55
 -0700 (PDT)
In-Reply-To: <1534403190-28523-8-git-send-email-jliang@xilinx.com>
References: <1534403190-28523-1-git-send-email-jliang@xilinx.com> <1534403190-28523-8-git-send-email-jliang@xilinx.com>
From:   Moritz Fischer <moritz.fischer@ettus.com>
Date:   Fri, 17 Aug 2018 09:31:55 -0700
Message-ID: <CAAtXAHd0jmV32bSyxCyMSh9fcP63sM+6-SkTMS=gA1fJKGKtig@mail.gmail.com>
Subject: Re: [PATCH 7/7] Documentation: devicetree: Add Xilinx R5 rproc binding
To:     Wendy Liang <wendy.liang@xilinx.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, rajan.vaja@xilinx.com,
        jollys@xilinx.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wendy Liang <jliang@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wendy,

couple of minor stuff inline.

On Thu, Aug 16, 2018 at 12:06 AM, Wendy Liang <wendy.liang@xilinx.com> wrote:
> Add device tree binding for Xilinx Cortex-r5 remoteproc.
>
> Signed-off-by: Wendy Liang <jliang@xilinx.com>
> ---
>  .../remoteproc/xlnx,zynqmp-r5-remoteproc.txt       | 81 ++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5-remoteproc.txt
>
> diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5-remoteproc.txt b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5-remoteproc.txt
> new file mode 100644
> index 0000000..3940019
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5-remoteproc.txt
> @@ -0,0 +1,81 @@
> +Xilinx ARM Cortex A53-R5 remoteproc driver
> +==========================================
> +
> +ZynqMP family of devices use two Cortex R5 processors to help with various
> +low power / real time tasks.

The ZynqMP family [..] uses [..]
> +
> +This driver requires specific ZynqMP hardware design.

*a* specific ZynqMP hardware design. What does that mean?
> +
> +ZynqMP R5 RemoteProc Device Node:
> +=================================
> +A zynqmp_r5_remoteproc device node is used to represent a R5 IP instance
> +within ZynqMP SoC.
> +
> +Required properties:
> +--------------------
> + - compatible : Should be "xlnx,zynqmp-r5-remoteproc-1.0"
> + - reg : Address and length of the register set for the device. It
> +        contains in the same order as described reg-names

?
> + - reg-names: Contain the register set names.

Contains

> +              "tcm_a" and "tcm_b" for TCM memories.
> +              If the user uses the remoteproc driver with the RPMsg kernel
> +              driver,"ipi" for the IPI register used to communicate with RPU
> +              is also required.
> +              Otherwise, if user only uses the remoteproc driver to boot RPU
> +              firmware, "ipi" is not required.
> + - tcm-pnode-id: TCM resources power nodes IDs which are used to request TCM
> +                 resources for the remoteproc driver to access.
> + - rpu-pnode-id : RPU power node id which is used by the remoteproc driver
> +                  to start RPU or shut it down.
> +
> +Optional properties:
> +--------------------
> + - core_conf : R5 core configuration (valid string - split0 or split1 or
> +               lock-step), default is lock-step.
> + - memory-region: memories regions for RPU executable and DMA memory.
> + - interrupts : Interrupt mapping for remoteproc IPI. It is required if the
> +                user uses the remoteproc driver with the RPMsg kernel driver.
> + - interrupt-parent : Phandle for the interrupt controller. It is required if
> +                      the user uses the remoteproc driver with the RPMsg kernel
> +                      kernel driver.
> +
> +Example:
> +--------
> +       reserved-memory {
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               ranges;
> +               rproc_0_fw_reserved: rproc@3ed000000 {
> +                       compatible = "rproc-prog-memory";
> +                       no-map;
> +                       reg = <0x0 0x3ed00000 0x0 0x40000>;
> +               };
> +               rproc_0_dma_reserved: rproc@3ed400000 {
> +                       compatible = "shared-dma-pool";
> +                       no-map;
> +                       reg = <0x0 0x3ed40000 0x0 0x80000>;
> +               };
> +       };
> +
> +       firmware {
> +               zynqmp_firmware: zynqmp-firmware {
> +                       compatible = "xlnx,zynqmp-firmware";
> +                       method = "smc";
> +               };
> +       };
> +
> +       zynqmp-r5-remoteproc@0 {
> +               compatible = "xlnx,zynqmp-r5-remoteproc-1.0";
> +               reg = <0x0 0xFFE00000 0x0 0x10000>,
> +                       <0x0 0xFFE20000 0x0 0x10000>,
> +                       <0x0 0xff340000 0x0 0x100>;
> +               reg-names = "tcm_a", "tcm_b", "ipi";
> +               dma-ranges;
> +               core_conf = "split0";
> +               memory-region = <&rproc_0_fw_reserved>,
> +                               <&rproc_0_dma_reserved>;
> +               tcm-pnode-id = <0xf>, <0x10>;
> +               rpu-pnode-id = <0x7>;
> +               interrupt-parent = <&gic>;
> +               interrupts = <0 29 4>;
> +       } ;
> --
> 2.7.4
>

Cheers,
Moritz
