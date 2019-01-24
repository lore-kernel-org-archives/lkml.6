Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B504DC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82CC2217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="aQzXHUuJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfAXKar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 05:30:47 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13050 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfAXKaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 05:30:46 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4993b20000>; Thu, 24 Jan 2019 02:30:10 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 24 Jan 2019 02:30:45 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 24 Jan 2019 02:30:45 -0800
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Jan
 2019 10:30:43 +0000
Subject: Re: [PATCH 1/6] dt-bindings: timer: add Tegra210 timer
To:     Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20190107032810.13522-1-josephl@nvidia.com>
 <20190107032810.13522-2-josephl@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <a5fec080-d388-5362-7f44-b50f7d7e1adf@nvidia.com>
Date:   Thu, 24 Jan 2019 10:30:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190107032810.13522-2-josephl@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548325810; bh=/25apzAx882srsw4xtzso4rn1Re9J1H/IKll3eUzAJs=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=aQzXHUuJk525Ljz6LiSsdOI+GY4BE4EkzFs/9vsWtBnfsj+dZNIUW8StJmBp6xn8k
         94gaCI76/ffeY9p+0Pw0Xr6aIcYxk+TYis2kirOnziHrRdpS90mhD3dGUhDgtOKg9v
         17NRReEmxSbaGx+Nwg2xsXPAxosJLzKzqxT8aCvYSGCxDAZ17mb4lwB9lEi6cADPb8
         I1G2cG6m1GWww0fUUfJjX9nGBgh3pROsgxfx2xFBe3bwHVrhD0MyKZBS7hWS08jo0z
         3v8KgNCfY5Fxui93NHe6yVLnOV96lijg9SSHmFT7+u9faFdc2fFSHPieeAGkMZ0i8H
         L55oNUApmKOPA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/01/2019 03:28, Joseph Lo wrote:
> The Tegra210 timer provides fourteen 29-bit timer counters and one 32-bit
> timestamp counter. The TMRs run at either a fixed 1 MHz clock rate derived
> from the oscillator clock (TMR0-TMR9) or directly at the oscillator clock
> (TMR10-TMR13). Each TMR can be programmed to generate one-shot periodic,
> or watchdog interrupts.
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
>  .../bindings/timer/nvidia,tegra210-timer.txt  | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
> 
> diff --git a/Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt b/Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
> new file mode 100644
> index 000000000000..ba511220a669
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
> @@ -0,0 +1,25 @@
> +NVIDIA Tegra210 timer
> +
> +The Tegra210 timer provides fourteen 29-bit timer counters and one 32-bit
> +timestamp counter. The TMRs run at either a fixed 1 MHz clock rate derived
> +from the oscillator clock (TMR0-TMR9) or directly at the oscillator clock
> +(TMR10-TMR13). Each TMR can be programmed to generate one-shot, periodic,
> +or watchdog interrupts.
> +
> +Required properties:
> +- compatible : "nvidia,tegra210-timer".
> +- reg : Specifies base physical address and size of the registers.
> +- interrupts : A list of 4 interrupts; one per each of TMR10 through TMR13.

Why do we only add the interrupts for TMR10 - TMR13? What about the others?

Cheers
Jon

-- 
nvpublic
