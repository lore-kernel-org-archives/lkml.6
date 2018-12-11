Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECB9C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A910F2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544564411;
	bh=3AfxaFQiJJW+8VP+mJHWXcsCL4JbfgEkwAD2z6TLYLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V+YTZdLKhIdXa1X76YGBnc+E0BHEkTAgFfYipQJdXFYJO7jOckAGsKGE/yh+RI9Xr
	 Ogon6+ngl39RrqttXDnmwershTG5zajQH7ma/6sufAyB0EM9mqYdc65Tbjlu50HZ+q
	 /7ZnI9zyGybj1lfp1yk30Qe5p1p4yu8OnOqoYEPA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A910F2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbeLKVkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:40:11 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46558 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeLKVkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 16:40:10 -0500
Received: by mail-oi1-f196.google.com with SMTP id x202so13279568oif.13;
        Tue, 11 Dec 2018 13:40:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ti3usXyyz5GKh74ebUVTJ8w7aK3eRhhYMFFgsPBQmv4=;
        b=D3oVue499PSvQ44gXTgsAZlJfEm+JawwJnAcu/z5k/IKYE56vA4cQNdnxkSsU7+r8W
         mcmtJOQ6gw9HQNIbbs2WuXlnAXFaxCPF7R1Ap5h/Rr7H7FsKxUAHqNXk1ZLdh1doaorF
         5XrWRwQbaA7qyHn9pI+Ut4KhpOfrsDGxa9BIeNhVMRLVu2yT7Riz7zVD/vvLdLmTTA5t
         4fdbx7Kx7LjKEg4hZOqUd0LbeptmjM3PHf0MiByBRIde2zTgEDJ5Q0V/HxVXzRkk6WM9
         zibqkszx5nKn/1W9StU/d5seihUknOct8fPryAy9LrOdhTp8Hn/Xsd7Oa3VHUN6Ecbj1
         UVvg==
X-Gm-Message-State: AA+aEWYChzL0pjzTcyUNm1OCN9Re0WxpbUT7Znqj2aewm3kBcODeimjV
        PpRTaXjFncMNulSrpYUKqxznzCM=
X-Google-Smtp-Source: AFSGD/X7S2OVHtIkDLhMpgAIiIvunUGE5fqOlC5/lH1PKxq48rjlNPer83ZCB1TNc+osrTLRfmrRKQ==
X-Received: by 2002:aca:3f42:: with SMTP id m63mr2142422oia.270.1544564409730;
        Tue, 11 Dec 2018 13:40:09 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b18sm7679531oii.51.2018.12.11.13.40.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 13:40:09 -0800 (PST)
Date:   Tue, 11 Dec 2018 15:40:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     zoro <long17.cool@163.com>
Cc:     alexandre.belloni@bootlin.com, a.zummo@towertech.it,
        mark.rutland@arm.com, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: rtc: sd3078: add device tree
 documentation
Message-ID: <20181211214008.GA17683@bogus>
References: <1542968084-3982-1-git-send-email-long17.cool@163.com>
 <1542968084-3982-3-git-send-email-long17.cool@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542968084-3982-3-git-send-email-long17.cool@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 06:14:44PM +0800, zoro wrote:
> The devicetree documentation for the SD3078 device tree
> binding is added with a short example.
> 
> Signed-off-by: zoro <long17.cool@163.com>
> ---
>  .../devicetree/bindings/rtc/rtc-sd3078.txt         |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/rtc-sd3078.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/rtc-sd3078.txt b/Documentation/devicetree/bindings/rtc/rtc-sd3078.txt
> new file mode 100644
> index 0000000..676cee8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/rtc-sd3078.txt
> @@ -0,0 +1,13 @@
> +SD3078 Real Time Clock
> +============================
> +
> +Required properties:
> +- compatible: Should contain "whwave,sd3078".
> +- reg: I2C address for chip.

If nothing else you can just add to bindings/rtc/rtc.txt (queued for 
4.21).

> +
> +Example:
> +
> +sd3078: sd3078@32 {

rtc@32

> +       compatible = "whwave,sd3078";
> +       reg = <0x32>;
> +};
> -- 
> 1.7.9.5
> 
> 
