Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777D4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43BAB218D3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551137911;
	bh=kUeq3DiWvOIg3paAxhwKlJUtoeuyl3XRLatag54/G7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TNJu57tNAsI3QhFxnTsgBqhBLOEJKAWFy7Q6BQwSgA1CWOy20YpLbpQVtkNa+SXeg
	 KHD2DwQTh83r0W2GJijwrWoJongWZ8ndy0UCiZ6GRmk0IVI4S7KD8pdts58tyZvzzW
	 qKOmA3LvMnZ8fO+xuiDaTDbi3tL74LPQXk4F6jYU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbfBYXi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 18:38:29 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36419 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfBYXi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 18:38:29 -0500
Received: by mail-ot1-f68.google.com with SMTP id v62so9521477otb.3;
        Mon, 25 Feb 2019 15:38:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U7FKRGmmtnscCAcu/6MyDWLelZ2qc5MZgs5wX8RryE4=;
        b=B5KFZ1gbcom0A+7YKA/f3r1cgg+FAVUuibE4xcNKPzDP7Ubkoa89RFlHC8WJjIfb5r
         R0Ve+wAvmMJtNIw91MaJfzx1KYDXwYavws7LXlugEDxymMngVvmnEWZX3O9CE5VMe/XK
         +49r7/LIzU4gjolWOPex98egw9XoRSO47BqtlJyxsL6YrdN/yXmHnvLkqlClX9Fl5GXy
         m3hStuSOHbVrRb6YKK2ReGsebIZMKUgwrxI+AFMoPYFvA2m7XVRLJscVSvmZczgOEDZb
         qgcf5s2z41WPJEMwvgUfwYsXvBDI9gNqeqNqN9d+lxE7FjOxzYkkIUG6VksVHiHM3fNh
         yYCg==
X-Gm-Message-State: AHQUAuam6EiQfKRBEdP59M89fBpqrc4NE5Z7EQOV1JjedQ7SrwVYtWjV
        T1SCgP6nw2Ud88RNwqSuvHCIyzo=
X-Google-Smtp-Source: AHgI3IaDLCeW9BDvLokKMdoyLwns8cwWHymkbareLXnlTq7kZYlbdI2v5XU6QNsjMVfJ9+KaNoS56Q==
X-Received: by 2002:a9d:7544:: with SMTP id b4mr13592027otl.326.1551137908561;
        Mon, 25 Feb 2019 15:38:28 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d67sm5267453oig.36.2019.02.25.15.38.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 15:38:27 -0800 (PST)
Date:   Mon, 25 Feb 2019 17:38:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Virendra Kakade <virendra.kakade@ni.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, lee.jones@linaro.org,
        mark.rutland@arm.com, sre@kernel.org, moritz.fischer@ettus.com
Subject: Re: [RFC 3/6] power: supply: Ettus Research E31x charger driver
Message-ID: <20190225233827.GA29092@bogus>
References: <20190212010143.3729-1-virendra.kakade@ni.com>
 <20190212010143.3729-4-virendra.kakade@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212010143.3729-4-virendra.kakade@ni.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 07:01:40PM -0600, Virendra Kakade wrote:
> Document bindings for the E31x devices charger.

Fix your subject. It is the same as patch 4.

> 
> Signed-off-by: Virendra Kakade <virendra.kakade@ni.com>
> ---
>  Documentation/devicetree/bindings/mfd/e31x-pmu.txt |  8 ++++++++
>  .../bindings/power/supply/e31x-charger.txt         | 14 ++++++++++++++
>  2 files changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/e31x-charger.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/e31x-pmu.txt b/Documentation/devicetree/bindings/mfd/e31x-pmu.txt
> index ebb5625f6c74..3798886578ba 100644
> --- a/Documentation/devicetree/bindings/mfd/e31x-pmu.txt
> +++ b/Documentation/devicetree/bindings/mfd/e31x-pmu.txt
> @@ -4,11 +4,19 @@ Required properties:
>  - compatible : Must be "ni,e31x-pmu"
>  - regmap     : Must be <&regmapnode>
>  
> +e31x-pmu has a sub-device called e31x-charger.
> +
> +For the e31x-charger properties please refer to:
> +Documentation/device-tree/bindings/power/supply/e31x-charger.txt
> +
>  Example:
>  
>  pmu {
>  	compatible = "ni,e31x-pmu";
>  	regmap = <&devctrl>;

regmap is a linux thing. How is the h/w addressed?

>  	status = "okay";
> +	charger: charger@0{

unit-address without 

> +		compatible = "ni,e31x-charger";

No other properties or DT resources? Then you don't need a child node in 
DT. The driver for the parent node can instantiate child devices like a 
charger.

> +	};
>  };
>  
