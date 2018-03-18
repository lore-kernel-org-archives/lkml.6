Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754372AbeCRMuf (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 08:50:35 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:46560 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754240AbeCRMtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 08:49:49 -0400
X-Google-Smtp-Source: AG47ELuMRUR4iI3Lf8Cibf8F1wdmKx8ZFDjmk6QpWq0PC3sBWIVXphhfPpuhZisME0Ru4rstoKGalg==
Date: Sun, 18 Mar 2018 07:49:45 -0500
From: Rob Herring <robh@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: mfd: bd9571mwv: Document DDR Backup
 Mode properties
Message-ID: <20180318124945.s73c7lbtmih7ecrz@rob-hp-laptop>
References: <1521025722-24205-1-git-send-email-geert+renesas@glider.be>
 <1521025722-24205-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521025722-24205-2-git-send-email-geert+renesas@glider.be>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 12:08:39PM +0100, Geert Uytterhoeven wrote:
> Document the new optional properties related to DDR Backup Mode and
> toggle/momentary power switches.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Improve property description,
>   - Add properties for power switch type.
> ---
>  Documentation/devicetree/bindings/mfd/bd9571mwv.txt | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/bd9571mwv.txt b/Documentation/devicetree/bindings/mfd/bd9571mwv.txt
> index 9ab216a851d5619b..8804a214759845c5 100644
> --- a/Documentation/devicetree/bindings/mfd/bd9571mwv.txt
> +++ b/Documentation/devicetree/bindings/mfd/bd9571mwv.txt
> @@ -25,6 +25,25 @@ Required properties:
>  			    Each child node is defined using the standard
>  			    binding for regulators.
>  
> +Optional properties:
> +  - rohm,ddr-backup-power : Value to use for DDR-Backup Power (default 0).
> +			    This is a bitmask that specifies which DDR power
> +			    rails need to be kept powered when backup mode is
> +			    entered, for system suspend:
> +			      - bit 0: DDR0
> +			      - bit 1: DDR1
> +			      - bit 2: DDR0C
> +			      - bit 3: DDR1C
> +			    These bits match the KEEPON_DDR* bits in the
> +			    documentation for the "BKUP Mode Cnt" register.
> +  - rohm,rstbmode-level: The RSTB signal is configured for level mode, to
> +			 accommodate a toggle power switch (the RSTBMODE pin is
> +			 strapped low).
> +  - rohm,rstbmode-pulse: The RSTB signal is configured for pulse mode, to
> +			 accommodate a momentary power switch (the RSTBMODE pin
> +			 is strapped high).
> +			 The two properties above are mutually exclusive.
> +
>  Example:
>  
>  	pmic: pmic@30 {
> @@ -36,6 +55,8 @@ Example:
>  		#interrupt-cells = <2>;
>  		gpio-controller;
>  		#gpio-cells = <2>;
> +		rohm,ddr-backup-power = <15>;

Would be better to use hex for a bit mask. Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>


> +		rohm,rstbmode-pulse;
>  
>  		regulators {
>  			dvfs: dvfs {
> -- 
> 2.7.4
> 
