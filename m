Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A14C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1039021780
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="l2Hi+X8F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1039021780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732023AbeKND3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:29:14 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:58166 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731528AbeKND3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:29:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jwyloY7sSYqbg3BFk2woSZWarwKxx9kL8rIppy89gcw=; b=l2Hi+X8FD6fEETsismlu4OC0y
        Ti/Go8bFvFYpUh2G1edFbINl2ak1F7VOZJcld/7Vsq4Nqm4nkNCHnCmFPDKUp3I0hJXwVz7sXefe4
        7MmuXQw1hJ4XkE0GlOtAfI5aNMQtqLSq75NVYaXUwrsD7rhQpxyo2sjcHj5TIbGNWd/l0=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:45525)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gMcVf-0000q9-5c; Tue, 13 Nov 2018 17:29:55 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gMcVb-0004P4-RT; Tue, 13 Nov 2018 17:29:51 +0000
Date:   Tue, 13 Nov 2018 17:29:50 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Emmanuel Vadot <manu@freebsd.org>
Cc:     jason@lakedaemon.net, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: marvell: armada_8k: reserve memory for ATF
Message-ID: <20181113172950.GL30658@n2100.armlinux.org.uk>
References: <20181113134807.53292-1-manu@freebsd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113134807.53292-1-manu@freebsd.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 02:48:07PM +0100, Emmanuel Vadot wrote:
> Like 4436a371 for 37xx, reserve the PSCI area memory region so kernels
> can call the code there.
> Region address is taken from the ATF code [1] and is 2MiB aligned.
> 
> [1] plat/marvell/a8k/common/include/platform_def.h
> 
> Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
> ---
>  arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> index 073610ac0a53..d8a79bb69de1 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> @@ -23,6 +23,21 @@
>  		spi0 = &spi0;
>  	};
>  
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		/*
> +		 * The PSCI firmware region depicted below is the default one
> +		 * and should be updated by the bootloader.
> +		 */
> +		psci-area@4000000 {
> +			reg = <0 0x4000000 0 0x200000>;
> +			no-map;
> +		};
> +	};

Does this really apply to everything?  I'm not sure it does.
If I look at a memory dump from the Macchiatobin, I see:

 04000000  00000000 00000007 00000005 00000040
 04000010  00000001 00001000 00000007 00000001
 04000020  00000008 00000000 00000009 00000000
 04000030  0000000a 00000000 fff7ffff ffffffff
 04000040  fbf7dfc7 fffffdff f2fffffe fbfdfffb
 04000050  af7ffefb fbfff7ff efbfffe3 5efdbf4d
 04000060  ff7effff fdffedff ff9f8fff ef9ffffd
 04000070  bffcffff ff7fff7a eff7ff7d 7fffbfff
 04000080  ffefefff fedfff7f ffdfffff ffbdff7f
 04000090  f3ff7fdb ffff76ff ffeffefe ffffff7f
 040000a0  9fffffff fff7ffdf edffffff fcffdfff
 040000b0  fffbefff fefffffb ffeffff7 6fffffff
 040000c0  ffdffdfb fd7fff9e fbefefbf eeefdfeb
 040000d0  bbdfbda3 9dfdef92 7b6ffaee fffde3fc
 040000e0  ff9efffd ff79ffdb ffaef57f ffaec1fe
 040000f0  bff7ffff fffeffdb effffb3f eaedffee
 04000100  fffffffb ffffffdf ffdffebf bfefbff3
 04000110  ffffffff fffffeff f7ffffff ffeeefff
 04000120  f7ffff7f fedfffff fffffffe fffefefe
 04000130  fbffff7d fffdffff fdffffff b7ffffff
 04000140  6fffffff ffee7fed fffffeff fffbfe6d
 04000150  fd5ff7ff f7bfffdc fdfff3c7 f7ff6f1d

Doesn't look like firmware to me.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
