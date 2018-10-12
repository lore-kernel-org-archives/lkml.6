Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAEAC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E0282098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E0282098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbeJLXHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:07:02 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41360 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728857AbeJLXHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:07:02 -0400
Received: by mail-ot1-f65.google.com with SMTP id c32so12747846otb.8;
        Fri, 12 Oct 2018 08:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=omAxrvuKn8252KMiWmMU6p6djXByS8y7n9VCKmpqKYw=;
        b=LuVt3a7fa1IlEsVHb9nitIBfEbH4806a6S49MNKHNYd5xESoa9n7V2nPUNTv5DhCjP
         nTkstKrJkFBd1Shs/RGRqIIiSBpo1kmZ1WCKvHUGLV2xAjTKBYsEBLGdMVtp+HwWwz7E
         yg6IsdgkOvu1lue3ZEjuL5CiOzUv2rbx9xcKI3GA7DviigB85YAg+GNeFXNj68Ee5Psb
         BC8038Gfpa1ufb4LYaUcAkICJhJK57TxtT4cw4Kh/6sIi3RsuhZYlxqfdLnCzyy1UERT
         s8DsycMBBMAG9ZS5CMiOW51ZBuYwQ6DMfAGNlO4vCIsRv7TWPpGpIL8TJ64VVfyAmwmG
         ydxA==
X-Gm-Message-State: ABuFfoh4jtzdaDMeRXCGU5mYuaWV0wH+ycV6k3cXaqo20uuJj9HY6rSg
        F81XaYwJZO59j8dL2Z72bg==
X-Google-Smtp-Source: ACcGV61fKabtqltKthYtjnfT3QehMwZnyn4tLfRMb9BA/IiDXbIgU5Rn6JqG01EanNCh5xV3BQKfPA==
X-Received: by 2002:a9d:5a1a:: with SMTP id v26mr3939772oth.267.1539358440523;
        Fri, 12 Oct 2018 08:34:00 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k68-v6sm396804oib.35.2018.10.12.08.33.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 08:33:59 -0700 (PDT)
Date:   Fri, 12 Oct 2018 10:33:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pascal PAILLET-LME <p.paillet@st.com>
Cc:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>
Subject: Re: [PATCH v3 5/8] dt-bindings: input: document stpmic1 pmic onkey
Message-ID: <20181012153359.GA31604@bogus>
References: <1539016176-4072-1-git-send-email-p.paillet@st.com>
 <1539016176-4072-6-git-send-email-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539016176-4072-6-git-send-email-p.paillet@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 04:29:41PM +0000, Pascal PAILLET-LME wrote:
> From: pascal paillet <p.paillet@st.com>
> 
> The stpmic1 pmic is able to manage an onkey button. It can be configured
> to shut-down the power supplies on a long key-press with an adjustable
> duration.
> 
> Signed-off-by: pascal paillet <p.paillet@st.com>
> ---
> changes in v3:
> * Replace st,onkey-long-press-seconds and st,onkey-pwroff-enabled by 
> power-off-time-sec.
> 
>  .../devicetree/bindings/input/st,stpmic1-onkey.txt | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt b/Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt
> new file mode 100644
> index 0000000..8c58186
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt
> @@ -0,0 +1,30 @@
> +STMicroelectronics STPMIC1 Onkey
> +
> +Required properties:
> +
> +- compatible = "st,stpmic1-onkey";
> +- interrupt-parent: phandle to the parent interrupt controller

Drop this.

> +- interrupts: interrupt line to use
> +- interrupt-names = "onkey-falling", "onkey-rising"
> +	onkey-falling: happens when onkey is pressed; IT_PONKEY_F of pmic
> +	onkey-rising: happens when onkey is released; IT_PONKEY_R of pmic
> +
> +Optional properties:
> +
> +- st,onkey-clear-cc-flag: onkey is able power on after an
> +  over-current shutdown event.
> +- st,onkey-pu-inactive: onkey pull up is not active
> +- power-off-time-sec: Duration in seconds which the key should be kept
> +        pressed for device to power off automatically (from 1 to 16 seconds).
> +        see See Documentation/devicetree/bindings/input/keys.txt
> +
> +Example:
> +
> +onkey {
> +	compatible = "st,stpmic1-onkey";
> +	interrupt-parent = <&pmic>;
> +	interrupts = <IT_PONKEY_F 0>,<IT_PONKEY_R 1>;
> +	interrupt-names = "onkey-falling", "onkey-rising";
> +	st,onkey-pwroff-enabled;
> +	st,onkey-long-press-seconds = <10>;
> +};
> -- 
> 1.9.1
