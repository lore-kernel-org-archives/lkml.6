Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65CFC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C53620873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="XyEbPzzk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfANQRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:17:37 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45151 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfANQRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:17:36 -0500
Received: by mail-wr1-f65.google.com with SMTP id t6so23492034wrr.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 08:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4p+O550P4PmeHsRiiGgAr3h7rECX1BnrJkegqPtODXA=;
        b=XyEbPzzkWtZ4LJ6TNvLUnJ/97LfdAVHVRpn8ANNDfLYPgr0cIFUzKBQ6TAep5MnKmk
         FcLB9EjZtmtCk//MPpjHz30QebM/iGvPnSC+GhYz4tAPEvbhTHOmXRKCTDcZiT2iaVgP
         A0Cq0imEjlibaNIJyNNE8THnkv5EvwXTWVOI6UzwBR62D3k1FB0P/f30KL7NfXgk46GX
         08M55TGXm6nYWUYQjejIEqMLlYkqza0xl/b5skRRawAvgfE6JeBLWvE1sj4lx4d1phto
         b+vtuRjwrIqi2yr6HP/j5w936bOAKJ/x5PHdXBY9oNnx8QQcBWoZU+nMPafhuhaEnHkH
         ZCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4p+O550P4PmeHsRiiGgAr3h7rECX1BnrJkegqPtODXA=;
        b=AD7p+/NLqm2SRFhIcgE1SNPd0/I/NKg0qzszhAJOEXwz4b7WsIx/wqLRIYcKBo8EE9
         /0jkXgcqHGxtKBVv8zCaz63Sak8j53+U43QOKz9sLIXWwhlLVo5/6Gp7tFEmrgpjUXWc
         YKSgwyxPKIA4HZMmwlmvRY4bZxmLcEmPjOErAPbULwWuxL+5d/IcchZO7iwxflIBUf38
         w6m8wpsTjiYh8mB1Uyx9BN6TVLIiownl3/AkQTMbSvSD95Gq5eCkohN9DXLidwWmyZx0
         2pFAopDROuotYts++d2sxynSblBeRUzhrBwBic5rwDbU37lyTMYrO475cmMP9vhaY+u5
         074g==
X-Gm-Message-State: AJcUukcFAhavHv+ZFVtE032T2Ua/xAC3QxlIeO2+sAFZosSCxjf7VCIh
        UhF5UFtUK+P5L0tQYE4CkT2lig==
X-Google-Smtp-Source: ALg8bN4OJfihWfmzg6Tr2wSMvv+npldLGCzOvAZs6aeEldl6W5I1lme+56RLrCSoBG4kTv1AWQtrEw==
X-Received: by 2002:a5d:4652:: with SMTP id j18mr25638155wrs.279.1547482653875;
        Mon, 14 Jan 2019 08:17:33 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f10sm7760917wmb.35.2019.01.14.08.17.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 08:17:33 -0800 (PST)
Subject: Re: [PatchV2 1/2] ARM64: dts: meson-gxbb-odroidc2: Fix usb phy
 regulator power failed warning
To:     Anand Moon <linux.amoon@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
References: <20190113153022.5040-1-linux.amoon@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <c73797cc-f954-483e-1713-324b4929f889@baylibre.com>
Date:   Mon, 14 Jan 2019 17:17:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190113153022.5040-1-linux.amoon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On 13/01/2019 16:30, Anand Moon wrote:
> Override the dr_mode from "host" to "peripheral" for dwc2
> usb_phy0->usb0 initilization of OTG Micro-B type.
> Changes fix the below warning for phy poweron failed --> -22
> 
> Changes fix the initialization of c9000000.usb phy
> 
> [    1.203900] phy phy-c0000000.phy.0: USB ID detect failed!
> [    1.208048] phy phy-c0000000.phy.0: phy poweron failed --> -22
> [    1.213877] WARNING: CPU: 1 PID: 44 at drivers/regulator/core.c:2054 _regulator_put.part.11+0xf0/0xf8
> [    1.222953] Modules linked in:
> [    1.225976] CPU: 1 PID: 44 Comm: kworker/1:1 Not tainted 5.0.0-rc1-xc2ml #3
> [    1.232872] Hardware name: Hardkernel ODROID-C2 (DT)
> [    1.237794] Workqueue: events deferred_probe_work_func
> [    1.242878] pstate: 80000005 (Nzcv daif -PAN -UAO)
> [    1.247623] pc : _regulator_put.part.11+0xf0/0xf8
> [    1.252280] lr : regulator_put+0x34/0x48
> [    1.256159] sp : ffff00001176bb00
> [    1.259437] x29: ffff00001176bb00 x28: 0000000000000000
> [    1.264698] x27: ffff80007f31beb8 x26: ffff000010eeb7e0
> [    1.269959] x25: 0000000000000000 x24: 0000000000000009
> [    1.275220] x23: ffff00001176bbc8 x22: ffff80007ed9d500
> [    1.280482] x21: ffff0000111bd6c8 x20: ffff80007ed9d700
> [    1.285743] x19: ffff80007ed9d700 x18: 000000000000006f
> [    1.291004] x17: 0000000000000000 x16: 0000000000000000
> [    1.296265] x15: 0000000000000400 x14: 0000000000000400
> [    1.301527] x13: ff00000000000000 x12: ffffffffffffffff
> [    1.306788] x11: 0000000000000038 x10: 0000000000000040
> [    1.312049] x9 : ffff0000111d58b0 x8 : ffff0000111d58a8
> [    1.317310] x7 : ffff80007ed9db00 x6 : ffff80007ec21b00
> [    1.322571] x5 : ffff80007f400248 x4 : ffff80007fba9b00
> [    1.327833] x3 : ffff0000112d9eb8 x2 : ffff80007ec21b00
> [    1.333094] x1 : 0000000000000000 x0 : 0000000000000001
> [    1.338356] Call trace:
> [    1.340773]  _regulator_put.part.11+0xf0/0xf8
> [    1.345085]  regulator_put+0x34/0x48
> [    1.348621]  regulator_bulk_free+0x30/0x50
> [    1.352675]  devm_regulator_bulk_release+0x18/0x20
> [    1.357421]  release_nodes+0x1b0/0x220
> [    1.361127]  devres_release_all+0x34/0x50
> [    1.365094]  really_probe+0xec/0x290
> [    1.368630]  driver_probe_device+0x54/0xe8
> [    1.372684]  __device_attach_driver+0xb8/0xe8
> [    1.376997]  bus_for_each_drv+0x78/0xc8
> [    1.380792]  __device_attach+0xd4/0x130
> [    1.384587]  device_initial_probe+0x10/0x18
> [    1.388727]  bus_probe_device+0x90/0x98
> [    1.392522]  deferred_probe_work_func+0x6c/0xa0
> [    1.397010]  process_one_work+0x1e0/0x318
> [    1.400975]  worker_thread+0x228/0x428
> [    1.404684]  kthread+0x124/0x128
> [    1.407876]  ret_from_fork+0x10/0x18
> [    1.411410] ---[ end trace de5fd1b262c1f56a ]---
> [    1.416055] WARNING: CPU: 1 PID: 44 at drivers/regulator/core.c:2054 _regulator_put.part.11+0xf0/0xf8
> [    1.425123] Modules linked in:
> [    1.428144] CPU: 1 PID: 44 Comm: kworker/1:1 Tainted: GW 5.0.0-rc1-xc2ml #3
> [    1.436422] Hardware name: Hardkernel ODROID-C2 (DT)
> [    1.441340] Workqueue: events deferred_probe_work_func
> 
> Fixes: 5a0803bd5ae (ARM64: dts: meson-gxbb-odroidc2: Enable USB Nodes)
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> Rebased on Kevin's amlogic/v5.0/fixes branch
> Changes from patch v1 [0] https://lore.kernel.org/patchwork/patch/1031243/
> - Split the patch into two part
> - Fix the commit message
> - Added Tested by Kevin Hilman
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> index 1cc9dc68ef00..25a36d117183 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> @@ -302,6 +302,7 @@
>  
>  &usb0 {
>  	status = "okay";
> +	dr_mode = "peripheral";
>  };
>  
>  &usb1 {
> 


Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

PS: Please add a cover-letter next time !

Neil
