Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71739C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29BB4204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29BB4204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbeKAUss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 16:48:48 -0400
Received: from foss.arm.com ([217.140.101.70]:55480 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727507AbeKAUsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 16:48:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53224A78;
        Thu,  1 Nov 2018 04:46:11 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75B343F71D;
        Thu,  1 Nov 2018 04:46:09 -0700 (PDT)
Date:   Thu, 1 Nov 2018 11:46:06 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     robh+dt@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        andy@infradead.org, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        hutao@cn.fujitsu.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH V5 8/8]  dt-bindings/misc/pvpanic :add document for
 pvpanic-mmio
Message-ID: <20181101114606.ehiis3adjchjvr34@lakrids.cambridge.arm.com>
References: <1541085002-42993-1-git-send-email-peng.hao2@zte.com.cn>
 <1541085002-42993-8-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541085002-42993-8-git-send-email-peng.hao2@zte.com.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix the spacing in the commit title. It should be formatted:

  dt-bindings: misc/pvpanic: add document for pvpanic-mmio

On Thu, Nov 01, 2018 at 11:10:02PM +0800, Peng Hao wrote:
> Add dt-bindings document for "qemu:pvpanic-mmio".
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>

With the title fixed:

Acked-by: Mark Rutland <mark.rutland@arm.com>

When sending DT bindings in future, please follow the process in:

  Documentation/devicetree/bindings/submitting-patches.txt

... e.g., send the binding before the code using the binding.

Thanks,
Mark.

> ---
>  .../devicetree/bindings/misc/pvpanic-mmio.txt      | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/pvpanic-mmio.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/pvpanic-mmio.txt b/Documentation/devicetree/bindings/misc/pvpanic-mmio.txt
> new file mode 100644
> index 0000000..985e907
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/pvpanic-mmio.txt
> @@ -0,0 +1,29 @@
> +* QEMU PVPANIC MMIO Configuration bindings
> +
> +QEMU's emulation / virtualization targets provide the following PVPANIC
> +MMIO Configuration interface on the "virt" machine.
> +type:
> +
> +- a read-write, 16-bit wide data register.
> +
> +QEMU exposes the data register to guests as memory mapped registers.
> +
> +Required properties:
> +
> +- compatible: "qemu,pvpanic-mmio".
> +- reg: the MMIO region used by the device.
> +  * Bytes 0x0  Write panic event to the reg when guest OS panics.
> +  * Bytes 0x1  Reserved.
> +
> +Example:
> +
> +/ {
> +        #size-cells = <0x2>;
> +        #address-cells = <0x2>;
> +
> +        pvpanic-mmio@9060000 {
> +                compatible = "qemu,pvpanic-mmio";
> +                reg = <0x0 0x9060000 0x0 0x2>;
> +        };
> +};
> +
> -- 
> 1.8.3.1
> 
