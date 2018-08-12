Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80797C46464
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 13:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9D0219C4
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 13:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5FoXUn7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E9D0219C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbeHLPmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 11:42:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46908 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727748AbeHLPmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 11:42:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id h14-v6so11972996wrw.13;
        Sun, 12 Aug 2018 06:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=6cfmsNRCFp0gXEPgvc0uxju+p80nxJSqpsLV0+ja4UQ=;
        b=T5FoXUn7onpr7WADFpx8Zn/kXkd7hIdtVZLGj5bPNFX2fCdX+n5gakx6WFw4szBJUC
         clgC+1pvUBK3nfmFLbpsTXbyuelI856HY7NUFmokCrgYtZuBHZ9iwFc+kMf4VWzDKLXN
         U/DtxTxPPjvQCM/3+DZJfLgQlwrbFDKzidt7SMbct1DM6WiG7yIi4H47kvU+VPmkoIaL
         qS8idruzJfZ/ilKVxFNdSsSc2N4TJmzcVFX+2do9+V/LNP2hO6NkIym/E9ZjFIHg0hQh
         10JGzywdLaPUwCfSsg8399zrsWclwjWvfkwZJo4IV/EjvXWpBup7sfxQexJOmmp4oHQo
         YwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=6cfmsNRCFp0gXEPgvc0uxju+p80nxJSqpsLV0+ja4UQ=;
        b=AMNuXa9C+cjfWHfeJKaDR6UZ61FqjevnX+VAJ4DjQc0otxlKqCTGjeeRrHYaM8uiXD
         +YQEREln5GRXK7XgbTwel3DTYll56iTHtBbDUcxbhIi50m5EyYSpC1Bsna+Gv8cY12ef
         W8HzmVSRqx0XfxBSZ+2icE0T/ysBNyYCn0tjj+QVypgFAD+geOyso30KK5Z0biGsO8Nn
         LIAwPmw35diU2AQUlmW4ZxUV0I6xGuR8rW5EmgmdlKD6Z+50OiQaW5DwDfqvWXcd35rD
         oaTY56KLrGeVZKm2qsjOmVfIifziMx3cXAXsxIe1bLb5Vi0BG1jzzDkSBYwP3lZcJS+k
         vKow==
X-Gm-Message-State: AOUpUlFbJkLJRRS7jYLyCYPtsjmtKSCHIcqASZDDR/kPnOgHUwH3t2wc
        uD+B5jFsDmadZ+BC7nQrUA==
X-Google-Smtp-Source: AA+uWPz+A4yQsK1W2vDZZVE6y/OHix8eWafjooRBOK5BXVYRBjiEI4Ks2Di0xDEwHCVk+iRlAcG4xw==
X-Received: by 2002:a5d:66c4:: with SMTP id k4-v6mr8483096wrw.154.1534079093804;
        Sun, 12 Aug 2018 06:04:53 -0700 (PDT)
Received: from Helena.home (host86-141-127-107.range86-141.btcentralplus.com. [86.141.127.107])
        by smtp.gmail.com with ESMTPSA id t15-v6sm18410503wrn.34.2018.08.12.06.04.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Aug 2018 06:04:53 -0700 (PDT)
Date:   Sun, 12 Aug 2018 14:04:49 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <2710770.4cMFGZ35A3@debian64>
References: <20180811162520.11641-1-ctatlor97@gmail.com> <2202961.SmUWKIdeCe@debian64> <4A3869BF-2069-409A-B291-427971AF89FA@gmail.com> <2710770.4cMFGZ35A3@debian64>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pinctrl: qcom: Add sdm660 pinctrl driver
To:     Christian Lamparter <chunkeey@gmail.com>
CC:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Craig Tatlor <ctatlor97@gmail.com>
Message-ID: <0EFAD5B6-835F-49A1-B99D-ACB84F82D06F@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12 August 2018 13:42:27 BST, Christian Lamparter <chunkeey@gmail=2Ecom>=
 wrote:
>On Sunday, August 12, 2018 9:18:19 AM CEST you wrote:
>> On 11 August 2018 18:27:43 BST, Christian Lamparter
><chunkeey@gmail=2Ecom> wrote:
>> >On Saturday, August 11, 2018 6:25:19 PM CEST Craig Tatlor wrote:
>> >> Add initial pinctrl driver to support pin configuration with
>> >> pinctrl framework for sdm660=2E
>> >> Based off CAF implementation=2E
>> >>=20
>> >> Signed-off-by: Craig Tatlor <ctatlor97@gmail=2Ecom>
>> >> ---
>> >>=20
>> >> diff --git
>> >a/Documentation/devicetree/bindings/pinctrl/qcom,sdm660-pinctrl=2Etxt
>> >b/Documentation/devicetree/bindings/pinctrl/qcom,sdm660-pinctrl=2Etxt
>> >> new file mode 100644
>> >> index 000000000000=2E=2E85e6c6c17c04
>> >> --- /dev/null
>> >> +++
>> >b/Documentation/devicetree/bindings/pinctrl/qcom,sdm660-pinctrl=2Etxt
>> >> @@ -0,0 +1,195 @@
>> >> +Qualcomm Technologies, Inc=2E SDM660 TLMM block
>> >> +
>> >> +This binding describes the Top Level Mode Multiplexer block found
>in
>> >the
>> >> +SDM660 platform=2E
>> >> +
>> >> +- compatible:
>> >> +	Usage: required
>> >> +	Value type: <string>
>> >> +	Definition: must be "qcom,sdm660-pinctrl"
>> >> +
>> >> +- reg:
>> >> +	Usage: required
>> >> +	Value type: <prop-encoded-array>
>> >> +	Definition: the base address and size of the TLMM register
>space=2E
>> >> +
>> >> +- interrupts:
>> >> +	Usage: required
>> >> +	Value type: <prop-encoded-array>
>> >> +	Definition: should specify the TLMM summary IRQ=2E
>> >> +
>> >> +- interrupt-controller:
>> >> +	Usage: required
>> >> +	Value type: <none>
>> >> +	Definition: identifies this node as an interrupt controller
>> >> +
>> >> +- #interrupt-cells:
>> >> +	Usage: required
>> >> +	Value type: <u32>
>> >> +	Definition: must be 2=2E Specifying the pin number and flags, as
>> >defined
>> >> +		    in <dt-bindings/interrupt-controller/irq=2Eh>
>> >> +
>> >> +- gpio-controller:
>> >> +	Usage: required
>> >> +	Value type: <none>
>> >> +	Definition: identifies this node as a gpio controller
>> >> +
>> >> +- #gpio-cells:
>> >> +	Usage: required
>> >> +	Value type: <u32>
>> >> +	Definition: must be 2=2E Specifying the pin number and flags, as
>> >defined
>> >> +		    in <dt-bindings/gpio/gpio=2Eh>
>> >> +
>> >> +Please refer to =2E=2E/gpio/gpio=2Etxt and
>> >=2E=2E/interrupt-controller/interrupts=2Etxt for
>> >> +a general description of GPIO and interrupt bindings=2E
>> >You want to specify gpio-ranges here as well=2E The property is
>explained
>> >in Section "2=2E1) gpio- and pin-controller interaction" in
>> >=2E=2E/gpio/gpio=2Etxt
>> >
>> >Without it, the gpio-hogs construct (part of =2E=2E/gpio/gpio=2Etxt) w=
ill
>> >cause
>> >the driver to fail during boot=2E (try it, ;-) )
>> Would gpio-ranges make sense for this, as the gpio and pinctrl are in
>same block?
>Yes, it's part of the =2E=2E/gpio/gpio=2Etxt which you link=2E
>Here's a copy of the relevant section that explains this
>gpio- and pin-controller interaction=2E
>
>
>|2=2E1) gpio- and pin-controller interaction
>|-----------------------------------------
>|
>|Some or all of the GPIOs provided by a GPIO controller may be routed
>to pins
>|on the package via a pin controller=2E This allows muxing those pins
>between
>|GPIO and other functions=2E
>|It is useful to represent which GPIOs correspond to which pins on
>which pin
>|controllers=2E The gpio-ranges property described below represents this,
>and
>|contains information structures as follows:
>|
>|       gpio-range-list ::=3D <single-gpio-range> [gpio-range-list]
>|       single-gpio-range ::=3D <numeric-gpio-range> | <named-gpio-range>
>|       numeric-gpio-range ::=3D
>|                       <pinctrl-phandle> <gpio-base> <pinctrl-base>
><count>
>|       named-gpio-range ::=3D <pinctrl-phandle> <gpio-base> '<0 0>'
>|       pinctrl-phandle : phandle to pin controller node
>|       gpio-base : Base GPIO ID in the GPIO controller
>|       pinctrl-base : Base pinctrl pin ID in the pin controller
>|       count : The number of GPIOs/pins in this range
>|
>|The "pin controller node" mentioned above must conform to the bindings
>|described in =2E=2E/pinctrl/pinctrl-bindings=2Etxt=2E
>|=2E=2E=2E
>
>As for the reason why gpio-ranges is what it is, please look at the ML
>discussion from the "pinctrl: msm: fix gpio-hog related boot issues"
>thread
>on <https://patchwork=2Ekernel=2Eorg/patch/10339127/> and the posts by=20
>Linus Walleij: <https://patchwork=2Ekernel=2Eorg/patch/10339127/#21903101=
>
>and
>Stephen Boyd: <https://patchwork=2Ekernel=2Eorg/patch/10339127/#21867185>=
=2E
>(It's quite a bit to take in)
Thanks for the links, makes sense now, I'll add in v2=2E
>
>> Seems no other qcom pinctrl drivers have it and I'm able to boot
>without it=2E
>Ok, let's run an experiment=2E Please remove the gpio-ranges property and
>try
>adding a test gpio-hog to your device's DTS:
>
>something like (I randomly selected GPIO5, but it shouldn't
>matter which gpio you select here=2E If you know a unused/NC
>pin/gpio, then you can use it instead):
>
>&tlmm {
>	test-hog {
>		gpio-hog;
>		gpios =3D <5 0>;
>		output-low;
>		line-name =3D "test hog";
>	};
>};
>
>compile&install it and then watch the kernel on the next boot:
>
>without the gpio-ranges present, it will spew out something along the
>lines of:
>
>| requesting hog GPIO test hog (chip 3000000=2Epinctrl, offset 5) failed,
>-517
>| gpiochip_add_data: GPIOs 0=2E=2E114 (3000000=2Epinctrl) failed to regis=
ter
>| sdm660-pinctrl 3000000=2Epinctrl: Failed register gpiochip
>
>The single gpio-hog causes havoc and takes down the sdm660-pinctrl with
>it=2E
>And every driver that depends on the pinctrl to setup the pin
>muxing/config
>will fail to load as well=2E (check out /sys/kernel/debug/pinctrl/, it
>will be
>empty=2E)
Yup
>
>Regards,
>Christian

-- 
