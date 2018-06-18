Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B262C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B8120693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rc0XwAe+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B8120693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936985AbeFRU5m (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 16:57:42 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:42241 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935708AbeFRU5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 16:57:40 -0400
Received: by mail-lf0-f67.google.com with SMTP id z207-v6so5398151lff.9;
        Mon, 18 Jun 2018 13:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sPVgCXb4ZY8xg/zNvqWZonRN7shcaye+HKwhvc/K1S4=;
        b=Rc0XwAe+pQlmVKTk6USl/gxaAOw1hShjyiLhAqMmpMKsUDuGFHM16oEHAEbwt5HjzD
         9fMzTh86+XaLXqB2RgHiDnVhgvGanmhQ4a2mlzHJ7Z++KTbOa1LYAgEWwHqekA9K/kWg
         FAtpyImIMgKDkTIAgVOjaHqTIvhPNTnM0Rvu311J6Vqw0hvWDeFHtAkB09BE1xaTpvuB
         TrQU9tiEyWRJ8DgKDI0qzb33RCVn2HQKJVrsCA5RpXz763HfV+aD0lXwNK0pcpBPw/zV
         uCALLEW9yUj9A2p40Nfx/sQsSL92yhV67vC7/zoKTmKlmQuXQ0/EcH58nxXKVDtvU/lg
         5v2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sPVgCXb4ZY8xg/zNvqWZonRN7shcaye+HKwhvc/K1S4=;
        b=GQ2T5cnyvI69rZVoyLuGr5eO/SHVXuKUJEtxli1m+7iTT8UK8++cF/1o/vHiHCo17Z
         kV6tYTin04HjaWYSmsy4cBSC24gsEjrF/rf41xd51fuyh0jachJ3kOgMau9PrFMeeGv7
         yXFrS9oUtLppPzgrXoVj7rfLNKS5Vhy+x/cgcxz3uvHkUSSLFXeLTeGjt4wER6TJdYXQ
         c5IoT4b5vr3NcT6sYcbU0+zwh9xtcD6ud+ovoYhK7oDUQrxCPpHFiLHXOGz9A9/mcRXt
         ariE9UnFUxqsccPkgi+4iVfUcvFHiUpokfFpr8jkGvMDlsQQ2wXdbRUpGE4NzSQOcuBq
         0GRA==
X-Gm-Message-State: APt69E3xFg6JK++8ilXTnfrwHlQP3d22fxOoITkHtEOEmOBrThKyNiEZ
        CcwdBHS+RnMIvPmyP7H5XOWusQXPiGhiAADLnmBm3b8k
X-Google-Smtp-Source: ADUXVKLbwd3xpJB+fi9w2VuR8cuBI//hKk0I0oZ1VcAtPANzWur4j60Cx/JOpj5taFgWo9ioz3UasWFSSi9P6N5tiBY=
X-Received: by 2002:a19:ce87:: with SMTP id e129-v6mr8842778lfg.57.1529355458317;
 Mon, 18 Jun 2018 13:57:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:5394:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 13:57:07
 -0700 (PDT)
In-Reply-To: <1523447304-21037-1-git-send-email-faiz_abbas@ti.com>
References: <1523447304-21037-1-git-send-email-faiz_abbas@ti.com>
From:   Robert Nelson <robertcnelson@gmail.com>
Date:   Mon, 18 Jun 2018 15:57:07 -0500
Message-ID: <CAOCHtYjrgRTAz4ZfkQVWL0YzC8SGbC9p1b8VYJ1TWLy5JXs3mQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: am33xx: Add pinmux data for mmc1 in am335x-evm,
 evmsk and beaglebone
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     linux kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 6:48 AM, Faiz Abbas <faiz_abbas@ti.com> wrote:
> am335x-evm, am335x-evmsk and am335x-beaglebone are currently relying on
> pinmux set by the bootloader to set the correct value for mmc1. Fix
> this by adding pinmux data for the same in kernel.
>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  arch/arm/boot/dts/am335x-bone-common.dtsi | 9 ++++++++-
>  arch/arm/boot/dts/am335x-evm.dts          | 9 ++++++++-
>  arch/arm/boot/dts/am335x-evmsk.dts        | 9 ++++++++-
>  3 files changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
> index e67b4d6..f9e8667 100644
> --- a/arch/arm/boot/dts/am335x-bone-common.dtsi
> +++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
> @@ -161,7 +161,14 @@
>
>         mmc1_pins: pinmux_mmc1_pins {
>                 pinctrl-single,pins = <
> -                       AM33XX_IOPAD(0x960, PIN_INPUT | MUX_MODE7) /* GPIO0_6 */
> +                       AM33XX_IOPAD(0x960, PIN_INPUT | MUX_MODE7)              /* spio0_cs1.gpio0_6 */
> +                       AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0)       /* mmc0_dat0.mmc0_dat0 */
> +                       AM33XX_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0)       /* mmc0_dat1.mmc0_dat1 */
> +                       AM33XX_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0)       /* mmc0_dat2.mmc0_dat2 */
> +                       AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0)       /* mmc0_dat3.mmc0_dat3 */
> +                       AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0)       /* mmc0_cmd.mmc0_cmd */
> +                       AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0)       /* mmc0_clk.mmc0_clk */
> +                       AM33XX_IOPAD(0x9a0, PIN_INPUT | MUX_MODE4)              /* mcasp0_aclkr.mmc0_sdwp */

We went one pin too far on the Beagle's here:

0x9a0 ( mcasp0_aclkr.mmc0_sdwp ) = Routed to P9_42, (muxed with C18,
to a shared pin on the header), so not connected to the microSD
socket...

https://github.com/beagleboard/beaglebone-black/blob/master/BBB_SCH.pdf

Looking at this evm schematic, it looks like 0x9a0 should be removed
too, but I'm not sure on all revisions:

http://processors.wiki.ti.com/images/a/a2/TMDSSK3358_3H0009_REV1_2B_SCH.pdf

Regards,

-- 
Robert Nelson
https://rcn-ee.com/
