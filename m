Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428E0C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEDC7207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEDC7207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbeJWTEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 15:04:35 -0400
Received: from foss.arm.com ([217.140.101.70]:56820 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727439AbeJWTEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 15:04:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1358E341;
        Tue, 23 Oct 2018 03:41:43 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B4F53F6A8;
        Tue, 23 Oct 2018 03:41:41 -0700 (PDT)
Date:   Tue, 23 Oct 2018 11:41:38 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     robh+dt@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        andy@infradead.org, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        hutao@cn.fujitsu.com
Subject: Re: [PATCH 4/4]  pvpanic: add document for pvpanic-mmio DT
Message-ID: <20181023104138.5yqjgul7mrpodjhe@lakrids.cambridge.arm.com>
References: <1540315537-70007-1-git-send-email-peng.hao2@zte.com.cn>
 <1540315537-70007-4-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540315537-70007-4-git-send-email-peng.hao2@zte.com.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 01:25:37AM +0800, Peng Hao wrote:
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  .../devicetree/bindings/arm/pvpanic-mmio.txt       | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/pvpanic-mmio.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/pvpanic-mmio.txt b/Documentation/devicetree/bindings/arm/pvpanic-mmio.txt
> new file mode 100644
> index 0000000..96c84e15
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/pvpanic-mmio.txt
> @@ -0,0 +1,26 @@
> +* QEMU PVPANIC MMIO Configuration bindings for ARM
> +
> +QEMU's aarch64-softmmu emulation / virtualization targets provide the
> +following PVPANIC MMIO Configuration interface on the "virt" machine
> +type:
> +
> +- a read-write, 16-bit wide data register.
> +
> +QEMU exposes the data register to ARM guests as memory mapped registers.

Please drop references to arm/arm64 in the commit message. I'm sure
other architectures will pick this up, and we only need to describe that
it's an MMIO device that QEMU can provide.

> +
> +Required properties:
> +
> +- compatible: "qemu,pvpanic-mmio".

The reg property should also be described.

Otherwise, this looks good to me.

Thanks,
Mark.

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
