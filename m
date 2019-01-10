Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C99C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22495206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpCjGaIB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbfAJSq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:46:27 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44956 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfAJSq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 13:46:27 -0500
Received: by mail-pl1-f196.google.com with SMTP id e11so5558996plt.11;
        Thu, 10 Jan 2019 10:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qdmfkEPHzANqefEUYiYiWKHzOhmx+tGvDPxNGGEwQ9s=;
        b=QpCjGaIBZ5OSeTSuf2Xf4FjR/PCtMtZzsYEfDj0q9BKjAmGE6dt4/aUbTozuZCcGri
         mUc4rw2305ZBHlOEKwu5gMYwIF5LughMsFDN9wRRlzlyDiVdfVohYujaYO3n5C7/ho+K
         Xvz7JK7NHcy4CjKWmAQ1kbcfeQlW+HYtLOSa8W/4JesvIyXVzkcdLDh2Hmt1/ysKc+L5
         jIH7Me6urGKn0ucEWzLFI6j9VSFCBIvySNzj7T+zasQnL+3Xze9aAKLR9wctx/XystSg
         AEeJFI1CFSTxqMIMTkWsIuTvwWgFvsVtX1O5Rj6WvZlZzq1xeMGEjIGE1RByoJGNJkwN
         qAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qdmfkEPHzANqefEUYiYiWKHzOhmx+tGvDPxNGGEwQ9s=;
        b=d+XJd7d5Xw1YRM2kt6WMIDdjiIUw7UyV0PcnWGkN14LbFkkzKhcdv4KMW0yNc/aw/O
         LlD9Fjo/IgPZvGXX1qW09qWJXvmOdNdqMM7dPJgPHoV6M3cStahfg0NTS30VS2hyygpP
         Wby1XgBhmEfirQPMoQTN6QNkdkzZt27S7Henq6Xob2t3rqDib7pDhGTT1NkqE94jAp/X
         98RJ+5ReWyjJKH3SRiGFblWSn0BLlpf5JaUtBPnqESTxVvWfvlq9piX6d0rB9SZrjDLD
         o7jr4/8YNfrWXttIiTrIboFwzTBXsrGIIzb9cEcNxOvLSLqvMQGQJ2RphoVogUopO4G/
         S6Cg==
X-Gm-Message-State: AJcUukcyBOpfqlLpOuieB+0B1JsD3Zn2HVWG9by3NToluahvpqTHRb4U
        8YBZmLoX2wW8xU07kl/JdhYZoy31
X-Google-Smtp-Source: ALg8bN75GJHWo2OJGdMVpmRNYxOHGc6XdcEpMtYhQb9HG3yBlhlLl3JiQkYUz5IkQwl51HSRiNTI+g==
X-Received: by 2002:a17:902:b406:: with SMTP id x6mr10925298plr.329.1547145986435;
        Thu, 10 Jan 2019 10:46:26 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w185sm113287305pfb.135.2019.01.10.10.46.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 10:46:25 -0800 (PST)
Date:   Thu, 10 Jan 2019 10:46:24 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Xiaoting Liu <xiaoting.liu@hxt-semitech.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, shunyong.yang@hxt-semitech.com,
        dongsheng.wang@hxt-semitech.com
Subject: Re: [PATCH v3 2/4] dt-bindings: hwmon: add dps650ab documentation
Message-ID: <20190110184624.GC9010@roeck-us.net>
References: <cover.1546918172.git.xiaoting.liu@hxt-semitech.com>
 <0527fcf7155ea12a2a1be680b3617691e6e26d72.1546918172.git.xiaoting.liu@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0527fcf7155ea12a2a1be680b3617691e6e26d72.1546918172.git.xiaoting.liu@hxt-semitech.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 10:24:33AM +0800, Xiaoting Liu wrote:
> Bindings for Delta Electronics DPS-650-AB power supply.
> 
> Signed-off-by: Xiaoting Liu <xiaoting.liu@hxt-semitech.com>

Waiting for DT maintainer Ack to apply. Note that you did not copy
linux-hwmon@vger.kernel.org. As a result, it _may_ get lost since
https://patchwork.kernel.org/project/linux-hwmon/list/ is my primary
means to track hwmon patches, and it isn't there.
If I don't the patch after the Ack, please resend and remember
to include the hwmon mailing list.

Thanks,
Guenter

> ---
> v3:
>   Change patch commit message.
>   Add vendor delta to the compatible property.
> ---
> v2:
>   Change the patch subject.
> ---
>  Documentation/devicetree/bindings/hwmon/dps650ab.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/dps650ab.txt b/Documentation/devicetree/bindings/hwmon/dps650ab.txt
> new file mode 100644
> index 000000000000..32d89e4f4956
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/dps650ab.txt
> @@ -0,0 +1,11 @@
> +Bindings for Delta Electronics DPS-650-AB power supply
> +
> +Required properties:
> +- compatible : "delta,dps650ab"
> +- reg        : I2C address, one of 0x58, 0x59.
> +
> +Example:
> +	dps650ab@58 {
> +		    compatible = "delta,dps650ab";
> +		    reg = <0x58>;
> +	};
> -- 
> 1.8.3.1
> 
