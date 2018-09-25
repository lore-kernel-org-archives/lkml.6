Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4936CC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08ECC20896
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08ECC20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbeIZDqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 23:46:39 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44641 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbeIZDqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 23:46:38 -0400
Received: by mail-ot1-f67.google.com with SMTP id 36-v6so26000832oth.11;
        Tue, 25 Sep 2018 14:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=anN+Ww7PQwWMux5DIZtGKZrSim0kakbrufegPhIWWpU=;
        b=PhaVAHU4BORQ7WYB3OUzGTyQG31TmENQET/8SvkidCdWPk/aAdgKcDB0za8QFKpT4s
         YZ/YakhoErHGfSynM4iuEeojYJQ31hsSvA6qovypNa8JNABY0MFSJ9+T2svwmY3+TFtX
         JaI1s1DxoqWZTGOw4ZIY7zVeL3lCKxxIjrlHLEq1gcalcfwlnBLRyFsiaIagbGcRiBMX
         4X6zLcRy2waZ6Z6KBK6kTaW9sp7jWW1p46X/yrZsqBMeCofbteisbCfw8wT+SlbZC67S
         jB5sdZjNEoNd/xvysK1pPxz2iQCX98wZqrWl6ZpOMz8JVns+P3Api8upkaMNJj0qHN2p
         u5Qw==
X-Gm-Message-State: ABuFfojH+j06fIYx+CxWyuQKMp/pE7EvxUkWxL8urVqV0sGbB7FWA7Hq
        YEq2SJ2vX+dfwnWv6Jlx3A==
X-Google-Smtp-Source: ACcGV60cSTTg6C9pwheLW1XPPy+bKnHfhg5CQfOJoayoFQEufYCxVI9K+FSxCtYNWphRSqJqd8XONQ==
X-Received: by 2002:a9d:7097:: with SMTP id l23-v6mr2006566otj.375.1537911424650;
        Tue, 25 Sep 2018 14:37:04 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w79-v6sm1117407oie.29.2018.09.25.14.37.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 14:37:03 -0700 (PDT)
Date:   Tue, 25 Sep 2018 16:37:03 -0500
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
Subject: Re: [PATCH V2 5/8] dt-bindings: input: document stpmic1 pmic onkey
Message-ID: <20180925213703.GA6116@bogus>
References: <1536325173-16617-1-git-send-email-p.paillet@st.com>
 <1536325173-16617-6-git-send-email-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536325173-16617-6-git-send-email-p.paillet@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 12:59:45PM +0000, Pascal PAILLET-LME wrote:
> From: pascal paillet <p.paillet@st.com>
> 
> The stpmic1 pmic is able to manage an onkey button. It can be configured
> to shut-down the power supplies on a long key-press with an adjustable
> duration.
> 
> Signed-off-by: pascal paillet <p.paillet@st.com>
> ---
>  .../devicetree/bindings/input/st,stpmic1-onkey.txt | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt b/Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt
> new file mode 100644
> index 0000000..b0db90d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt
> @@ -0,0 +1,31 @@
> +STMicroelectronics STPMIC1 Onkey
> +
> +Required properties:
> +
> +- compatible = "st,stpmic1-onkey";
> +- interrupt-parent: phandle to the parent interrupt controller
> +- interrupts: interrupt line to use
> +- interrupt-names = "onkey-falling", "onkey-rising"
> +	onkey-falling: happens when onkey is pressed; IT_PONKEY_F of pmic
> +	onkey-rising: happens when onkey is released; IT_PONKEY_R of pmic
> +
> +Optional properties:
> +
> +- st,onkey-pwroff-enabled: power off on long key-press

This can be implied by the presence of 'power-off-time-sec' or not.

> +- st,onkey-long-press-seconds: long key-press duration from 1 to 16s
> +  (default 16s)
> +- st,onkey-clear-cc-flag: onkey is able power on after an
> +  over-current shutdown event.
> +- st,onkey-pu-inactive: onkey pull up is not active
> +
> +Example:
> +
> +onkey {
> +	compatible = "st,stpmic1-onkey";
> +	interrupt-parent = <&pmic>;
> +	interrupts = <IT_PONKEY_F 0>,<IT_PONKEY_R 1>;
> +	interrupt-names = "onkey-falling", "onkey-rising";
> +	status = "okay";

Don't show status in examples.

> +	st,onkey-pwroff-enabled;
> +	st,onkey-long-press-seconds = <10>;
> +};
> -- 
> 1.9.1
