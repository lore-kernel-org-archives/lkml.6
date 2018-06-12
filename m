Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0F16FC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD57208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1IIwlqc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD57208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935030AbeFLWzS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 18:55:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934002AbeFLWzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 18:55:17 -0400
Received: from mail-it0-f52.google.com (mail-it0-f52.google.com [209.85.214.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 736E320891;
        Tue, 12 Jun 2018 22:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528844116;
        bh=r4QQnRnvReWaqntBLAoK4hGSb7FIkH6CyMjKOj+qyj8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=C1IIwlqcqG6kPNl6YhWmT5XCE304nZGhfz+0lH4uKRqIrS1Dp6JSAPNr/hhwmxnHS
         i/v185YdBijPOtPBV1geeN60TS6sQrWOaC86Rz2+eY+I3Imi43M/vlmXEeygOOXkh6
         i1RGfsGi2e+wpt6qsMdT6z2ZgI7Y6/Pe9HzOJVA4=
Received: by mail-it0-f52.google.com with SMTP id k17-v6so15433990ita.0;
        Tue, 12 Jun 2018 15:55:16 -0700 (PDT)
X-Gm-Message-State: APt69E0bpnwcYmn4BFWps+NrT8AUGo/KLvDNlbDpzhrcrdTlCT2by/ef
        CQnh/5XHgDTJ0/7ez1a5gVfp/uMF9m+Ao3yknw==
X-Google-Smtp-Source: ADUXVKICx+Fik/KHEBFw/A2lrL/fUiui5Q0QQQXMU2M82ktG92vFLQQEkMhW655L7osYnAbupjNHNSp0mEjgNHy9OlE=
X-Received: by 2002:a24:f04e:: with SMTP id p14-v6mr2459181iti.106.1528844115907;
 Tue, 12 Jun 2018 15:55:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:6403:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 15:54:55
 -0700 (PDT)
In-Reply-To: <395f1fe8-76f1-8310-d09e-63e25bca23d2@broadcom.com>
References: <1526668446-20048-1-git-send-email-scott.branden@broadcom.com>
 <d35afa1f-e0fd-84f1-7d42-60595e22cc77@gmail.com> <395f1fe8-76f1-8310-d09e-63e25bca23d2@broadcom.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 12 Jun 2018 16:54:55 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJEFLXFf-Vq9c9XC41vBpisQwxkd06_v8Fmt6X=gp=2_g@mail.gmail.com>
Message-ID: <CAL_JsqJEFLXFf-Vq9c9XC41vBpisQwxkd06_v8Fmt6X=gp=2_g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: stingray: use NUM_SATA to configure number of
 sata ports
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Ray Jui <rjui@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 12:53 PM, Scott Branden
<scott.branden@broadcom.com> wrote:
> Hi Rob,
>
> Could you please kindly comment on change below.
>
> It allows board variants to be added easily via a simple define for
> different number of SATA ports.
>
>
>
> On 18-06-04 09:22 AM, Florian Fainelli wrote:
>>
>> On 05/18/2018 11:34 AM, Scott Branden wrote:
>>>
>>> Move remaining sata configuration to stingray-sata.dtsi and enable
>>> ports based on NUM_SATA defined.
>>> Now, all that needs to be done is define NUM_SATA per board.
>>
>> Rob could you review this and let us know if this approach is okay or
>> not? Thank you!
>>
>>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>>> ---

>>> diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
>>> b/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
>>> index 8c68e0c..7f6d176 100644
>>> --- a/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
>>> +++ b/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
>>> @@ -43,7 +43,11 @@
>>>                         interrupts = <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>;
>>>                         #address-cells = <1>;
>>>                         #size-cells = <0>;
>>> +#if (NUM_SATA > 0)
>>> +                       status = "okay";
>>> +#else
>>>                         status = "disabled";
>>> +#endif

This only works if ports are contiguously enabled (0-N). You might not
care, but it is not a pattern that works in general. And I'm not a fan
of C preprocessing in DT files in general beyond just defines for
single numbers.

Rob
