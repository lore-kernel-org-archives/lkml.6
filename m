Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCD8C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0832208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0832208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbeJPCjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:39:24 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42213 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbeJPCjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:39:24 -0400
Received: by mail-ot1-f67.google.com with SMTP id c23so18175375otl.9;
        Mon, 15 Oct 2018 11:52:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r3SmFRTFIjnO+AAf6M+ymxtrPF1y/tjMdEV1hl+BPyA=;
        b=n/b2igxUHL5M9b+Wsq6lJ81f2ZGEYOb4+wBPPF8c78/OYKccuk8PEUQxsOzWWuvkVe
         751SVNcdkTYlQ8io2nqhl82fh3cF0xO+IejTg6Zvr2NhY3Drk5qjE1Rfq/uWIPZhmJuZ
         j+pw6nkPMRZ3TtdOOCOA5Cy6GaKh/9hNu7Z33SXqxKN2JEjqqAbjYubR7njWOurouuCc
         7s3E1QkxoTDO95Ki/2ItnqCawSnxr3wlfb51k3vL2LFXjVUGsygc6pMv+hSrphDypWUi
         VikyLztfAvM2H9uds1OvtH8hxx/0g47Azcr7qoXOej6g7K4LcE9pntymLnLeLLTJxsul
         1iDQ==
X-Gm-Message-State: ABuFfogREzQL77RdJrscqoR3WBd8EUQ5OH76EERdHzyM+Z9o6jrKXtEv
        Evgr4wxO/HLBfv5QRDVcAUPyBMo=
X-Google-Smtp-Source: ACcGV60xDHBwpTi7+lJMxZTCQvMl4kQBD8wEjLhWNw1365Eq6p/DhwrSFSYFT35yMNiixLaqmlrT7Q==
X-Received: by 2002:a9d:62cb:: with SMTP id z11mr12655374otk.342.1539629574086;
        Mon, 15 Oct 2018 11:52:54 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w1-v6sm3484486oif.1.2018.10.15.11.52.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 11:52:52 -0700 (PDT)
Date:   Mon, 15 Oct 2018 13:52:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     andy.gross@linaro.org, sre@kernel.org, mark.rutland@arm.com,
        david.brown@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        jonathan@marek.ca
Subject: Re: [PATCH RFC 1/5] dt-bindings: power: supply: bq24190_charger: add
 bq24192 and usb-otg-vbus
Message-ID: <20181015185252.GA8056@bogus>
References: <20181001053005.18906-1-masneyb@onstation.org>
 <20181001053005.18906-2-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001053005.18906-2-masneyb@onstation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 01:30:01AM -0400, Brian Masney wrote:
> Add support for the ti,bq24192 variant and a child node for the
> usb-otg-vbus regulator.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  Documentation/devicetree/bindings/power/supply/bq24190.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/bq24190.txt b/Documentation/devicetree/bindings/power/supply/bq24190.txt
> index 9e517d307070..8f2560824a97 100644
> --- a/Documentation/devicetree/bindings/power/supply/bq24190.txt
> +++ b/Documentation/devicetree/bindings/power/supply/bq24190.txt
> @@ -3,6 +3,7 @@ TI BQ24190 Li-Ion Battery Charger
>  Required properties:
>  - compatible: contains one of the following:
>      * "ti,bq24190"
> +    * "ti,bq24192"
>      * "ti,bq24192i"
>  - reg: integer, I2C address of the charger.
>  - interrupts[-extended]: configuration for charger INT pin.
> @@ -19,6 +20,12 @@ Optional properties:
>  - ti,system-minimum-microvolt: when power is connected and the battery is below
>    minimum system voltage, the system will be regulated above this setting.
>  
> +child nodes:
> +- usb-otg-vbus:
> +  Usage: optional
> +  Description: Regulator that is used to control the VBUS voltage direction for
> +               either USB host mode or for charging on the OTG port.

What about the regulator properties?

> +
>  Notes:
>  - Some circuit boards wire the chip's "OTG" pin high (enabling 500mA default
>    charge current on USB SDP ports, among other features). To simulate this on
> -- 
> 2.17.1
> 
