Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57150C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC412084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544566617;
	bh=+edi2com7dDHr/gnTQAVX4e6765r2nBNOgLtpwh5XuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zysd+WxlqunP2Xh6RM5Q6EoA58gGl9MNGRvA2zoMxhinBoIKUySZW7OffZ+3suHfi
	 b9F7fmRuOX7QgNHdItThP4PGhHOCMyGLc/hAMN3fR+4wGIHZbcI2+GkTYI/d4FA5q1
	 GHZ0BdoNpaT+BueVrR2EH6hm/gfS9+PfVPaMP24Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC412084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbeLKWQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:16:55 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39069 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbeLKWQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:16:55 -0500
Received: by mail-oi1-f193.google.com with SMTP id i6so13401215oia.6;
        Tue, 11 Dec 2018 14:16:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DDttSym8loLOGw8lNReQ/iWWKOGuBQeN1EAbZF02m+U=;
        b=EBMehxpUt5zf8wcj480wkGGj8E+8KidWskOxxb9cg62AOVifP+g7YWJ49Bc4Gjf+tb
         96juMu4NKcQmjVMChMkPC3XTWQu0yXXhrWMs66Uwc1hSpdZd3vrQinXxxJ1c6sXxQpf8
         peXz1shF8slJxUYUWfon+PZcCv9C6vlXwjBmJPo2giePoDokczUAiZeTBpj0NPmzqFsF
         Ng3+ijlRsmqgGtItw3j48MfcA3ylZi69lIHOt1qDI95F7mxe5mccIVtKz0ajMzvTVfhu
         zO2dvMdrfz1zmqiFVU9ZjG8kF+WAynGNBMQOHRa0HOSv1F4NxeM3wEwz3NunCobUxGzH
         QdWA==
X-Gm-Message-State: AA+aEWZbBhD8SlaqbtiUeaxRkjnIosyWmp/G7h1ZKMt0V8mlheyn8rgV
        ydEEjgGNjWzzd+9oe6bfjw==
X-Google-Smtp-Source: AFSGD/U6zGuj+m/t65FF+N9DvKvscHpsRM1XOENrEZuY3fXqtr5i9OFUw1bBbiVEKxIHz7NxCy7dEw==
X-Received: by 2002:aca:1a0b:: with SMTP id a11mr2407850oia.154.1544566614312;
        Tue, 11 Dec 2018 14:16:54 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i5sm8494610oia.46.2018.12.11.14.16.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 14:16:53 -0800 (PST)
Date:   Tue, 11 Dec 2018 16:16:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     lee.jones@linaro.org, alexandre.torgue@st.com,
        mcoquelin.stm32@gmail.com, arnd@arndb.de, mark.rutland@arm.com,
        gabriel.fernandez@st.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: mfd: syscon: Add optional clock support
Message-ID: <20181211221653.GA18104@bogus>
References: <1543337297-21873-1-git-send-email-fabrice.gasnier@st.com>
 <1543337297-21873-2-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543337297-21873-2-git-send-email-fabrice.gasnier@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 05:48:15PM +0100, Fabrice Gasnier wrote:
> Some system control registers need to be clocked, so the registers can
> be accessed. Add an optional clock.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.txt b/Documentation/devicetree/bindings/mfd/syscon.txt
> index 25d9e9c..a9aaa51 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.txt
> +++ b/Documentation/devicetree/bindings/mfd/syscon.txt
> @@ -17,6 +17,7 @@ Optional property:
>  - reg-io-width: the size (in bytes) of the IO accesses that should be
>    performed on the device.
>  - hwlocks: reference to a phandle of a hardware spinlock provider node.
> +- clocks: phandle to the syscon clock

No. Add clocks to specific bindings using syscon. If you have a node 
with only 'syscon', then that should be fixed.

Rob
