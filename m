Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDB1C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E202588A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AIhRfg4r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8E202588A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753245AbeFYV4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 17:56:05 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33713 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751828AbeFYV4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 17:56:03 -0400
Received: by mail-wr0-f195.google.com with SMTP id k16-v6so15155880wro.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 14:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CJYWMTzl0aBYJg+zeFWSj8FvZ5Ld9jQq52cOLUJv81k=;
        b=AIhRfg4r0kXXRZdIWdiMqpmVICykBfEy9FFnZV89AIVMP33F5l+0R56Z8X0QIrtCZa
         mBINvPPBnChktDfu5TcFmMBnRzYzYjP2yTh//WN0RI4ULpVJ3u+2SWZX0essh7OrPszP
         mWeAPCIV+j9UC0Yo4T5W82ZyyhImX+PieUMmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CJYWMTzl0aBYJg+zeFWSj8FvZ5Ld9jQq52cOLUJv81k=;
        b=J7C9TWlg788SXHoASwJh9WMAsaOjhrIdeBwX49MkyX+rC0gt6mr83antapGw6AReWD
         bNnkiJf3EeIPrJI80skECAy/TcMoJIJXWHlsW/+U6Wx1vWPJXAtu9wKCBqrouFBDykCa
         tDRO9mMhjPKMEGG2Fqxt0bz/rfCsjWeDaSFP6o/IAT7VQbRiANUSatFOY6w7YGMX0/56
         yibGZr5aT8uB0tkkrUemuptq9qRx9RJEHZckiRTD5op37HDwz5rszc387gY8tXpuEadY
         b3lawa9r2sSQiRV0jioS4y1P9aEgwEmf7/fT9yCXzInCgOT0SJ2oTKewN8yPaBrWNJ3f
         YA/g==
X-Gm-Message-State: APt69E3D4oqIXyLNgJvArPl1Q7GEfrICQ018Y/r5g/7SbVN0H16AvaHD
        xOsz4eACLLa67WOibQ39+GVADSSGOoIj3QJ8VBDlfA==
X-Google-Smtp-Source: AAOMgpeWokuvF5KywFa6nWnGmJhvCIwJE3/TitbQbeFPLbrAk+CPYZ6BlNG5ge3dIwvCrQK9tLMaC/LDxMij6AvnPa8=
X-Received: by 2002:adf:9582:: with SMTP id p2-v6mr11170255wrp.252.1529963762718;
 Mon, 25 Jun 2018 14:56:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:c202:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 14:56:02
 -0700 (PDT)
In-Reply-To: <CANcMJZASEDRxaXwdG96nNeEDPrDm_ap5MjhXonEcg=yHZ8F=qg@mail.gmail.com>
References: <20180613151305.17240-1-ryan@edited.us> <CANcMJZASEDRxaXwdG96nNeEDPrDm_ap5MjhXonEcg=yHZ8F=qg@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 25 Jun 2018 14:56:02 -0700
Message-ID: <CALAqxLWjJKsU+XJmANzx-aO2ruszwbBnPV2yV5WoyVStO+5K0A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: hikey: Define wl1835 power capabilities
To:     Ryan Grachek <ryan@edited.us>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Tony Lindgren <tony@atomide.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>, Eyal Reizer <eyalr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 11:30 AM, John Stultz <john.stultz@linaro.org> wrote:
> On Wed, Jun 13, 2018 at 8:13 AM, Ryan Grachek <ryan@edited.us> wrote:
>> These properties are required for compatibility with runtime PM.
>> Without these properties, MMC host controller will not be aware
>> of power capabilities. When the wlcore driver attempts to power
>> on the device, it will erroneously fail with -EACCES.
>>
>> Signed-off-by: Ryan Grachek <ryan@edited.us>
>
> Fixes: 60f36637bbbd ("wlcore: sdio: allow pm to handle sdio power")
> Tested-by: John Stultz <john.stultz@linaro.org>
> Acked-by: John Stultz <john.stultz@linaro.org>
>
> Wei Xu: This fixes a functional regression with wifi on the HiKey
> board that was introduced in 4.18-rc with commit 60f36637bbbd
> ("wlcore: sdio: allow pm to handle sdio power").

Wei Xu: Just wanted to follow up to make sure this wasn't missed for
4.18-rc, as I haven't seen it upstream or in -next, and it fixes a
recently introduced regression.

thanks
-john
