Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127BEC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 23:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC79B20B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 23:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SsctJRJ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbeLaXNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 18:13:31 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41804 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeLaXNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 18:13:30 -0500
Received: by mail-pl1-f196.google.com with SMTP id u6so13041746plm.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 15:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=yMBeSKQ889w+fJYw7VGEjmN4fDuLhQvIqVZgA3s965A=;
        b=SsctJRJ3shxSsUYEurTjSdE69NoPIVJcFQNXAjlevuy/K6AGcTUmgr1NZEv9nTUAji
         Y4ZWUhKrhonWHawLhGr5AwkTivLEuXoBG2xYDdrF5WkCD/9PDK5JNnng0hbtAG9y7bqb
         1Ok8Cy2qgEj7alM9ATtKranzdvpsIMCXKYXeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=yMBeSKQ889w+fJYw7VGEjmN4fDuLhQvIqVZgA3s965A=;
        b=TUD+G7ENDDCvT+Nmx6TpyHZoR2YPa9V87FRwCjaloBqGQlCp0NgbacZExCjoD9Bapu
         nrazK7A7gN3C6pwAYQAbJwyGetvzk7Y+XY27UA54gRZQL/HL4gGZc5sLFLGBwWe4mccy
         +pJdY/ALV+jbnShFsiKDD3OArK2Kua0PuuhO04dC5M3pl4aV7RkUwRpbGfOetrLe2Iqq
         PqsVCXnnsX76NZx6k1FiNkzPri9P6YnXQ55FOg5p7aSSjS2iZx/y195qdbt/ur2iCh86
         hOe20ilatGssIow12O6KcSaBhNWwyijXEU4xKFBep7ZAsbmBACZsIz88VzfHKYvi1Yls
         V0+w==
X-Gm-Message-State: AJcUukcXVvyood9i6WKqJHndPKiaGhoeMRKbyYWXX6MZOcF/eDZDAsyb
        BR9JMh3cjsPa8RlqOWPovfPs3A==
X-Google-Smtp-Source: ALg8bN5ksP6pCP45Kxc6eQtsVQ6aBgaPZsVJd69BeELZWaSJXQBrHFRVarC7svJwdWQARBmTBmZFsg==
X-Received: by 2002:a17:902:925:: with SMTP id 34mr37317562plm.14.1546298010145;
        Mon, 31 Dec 2018 15:13:30 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id l19sm109821977pfi.71.2018.12.31.15.13.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Dec 2018 15:13:29 -0800 (PST)
Subject: Re: [PATCH 1/2] dt-bindings: reset: Add document for Broadcom STB
 reset controller
To:     Florian Fainelli <f.fainelli@gmail.com>, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20181221013409.14324-1-f.fainelli@gmail.com>
 <20181221013409.14324-2-f.fainelli@gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <67d797f6-fc3a-535c-d336-edcdc70c332e@broadcom.com>
Date:   Mon, 31 Dec 2018 15:13:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181221013409.14324-2-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018-12-20 5:34 p.m., Florian Fainelli wrote:
> Add a binding document for the Broadcom STB reset controller, also known
> as SW_INIT-style reset controller.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>   .../devicetree/bindings/reset/brcm,reset.txt  | 27 +++++++++++++++++++
>   1 file changed, 27 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/reset/brcm,reset.txt
>
> diff --git a/Documentation/devicetree/bindings/reset/brcm,reset.txt b/Documentation/devicetree/bindings/reset/brcm,reset.txt
> new file mode 100644
> index 000000000000..6e5341b4f891
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/brcm,reset.txt
This is brcmstb-reset specific.  File should be brcm, brcmstb-reset.txt
> @@ -0,0 +1,27 @@
> +Broadcom STB SW_INIT-style reset controller
> +===========================================
> +
> +Broadcom STB SoCs have a SW_INIT-style reset controller with separate
> +SET/CLEAR/STATUS registers and possibly multiple banks, each of 32 bit
> +reset lines.
> +
> +Please also refer to reset.txt in this directory for common reset
> +controller binding usage.
> +
> +Required properties:
> +- compatible: should be brcm,brcmstb-reset
> +- reg: register base and length
> +- #reset-cells: must be set to 1
> +
> +Example:
> +
> +	reset: reset-controller@8404318 {
> +		compatible = "brcm,brcmstb-reset";
> +		reg = <0x8404318 0x30>;
> +		#reset-cells = <1>;
> +	};
> +
> +	&ethernet_switch {
> +		resets = <&reset>;
> +		reset-names = "switch";
> +	};
