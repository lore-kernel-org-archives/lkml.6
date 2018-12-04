Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC66C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBCFC20834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBCFC20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbeLDUrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:47:36 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33739 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeLDUrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 15:47:35 -0500
Received: by mail-ot1-f68.google.com with SMTP id i20so16536954otl.0;
        Tue, 04 Dec 2018 12:47:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fSCTz2xKuBHtxh7ywbeEpAbuSj2luDE0z7e4Lo4D3oo=;
        b=P591yKUfEBhPHdVQLMsiIapob2RKGFteF4yCY7hDX/IdeIIcwroC9B0uEyRF2clmR6
         j0KLzia/IYVAI9pnCBnALKo/DOPWdmuLRtdvQwoaQI7en2RjJh+s3ryD3mT3twzmnxJV
         9DmFpoP3KN3E1re62dhsK0QRibxrxapAUppDEc/yU2snY6luXELSby0oYqPhPQRg6UHL
         EJbCmiYeIIaoWZygzMjicavHEs7FuNy4Bea5CEdSM1GnewZRaO/sE1nuF4BEXRTUFkXG
         /Ujd4Z8ob86pS29VGfoeIZIzikd/4cdeO5sWexYntK8I3FM8H6uiOcVulPlrC6fiTuDR
         Kpow==
X-Gm-Message-State: AA+aEWYq6w6tKDhp9A0FYZiw/1+VoyPqsOFOzjqjpLQxJC2/sU+OaH53
        GbYftsFkv15S5OMVewKFyg==
X-Google-Smtp-Source: AFSGD/ULXByF7L8ViLYHXoCjDMyJiyl9bTEEBiVBiEtTVkmlYjUnQRw5l+SU5bILz2rpxfKNkuIefg==
X-Received: by 2002:a9d:784a:: with SMTP id c10mr14300244otm.175.1543956455141;
        Tue, 04 Dec 2018 12:47:35 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 52sm32258734oti.30.2018.12.04.12.47.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 12:47:34 -0800 (PST)
Date:   Tue, 4 Dec 2018 14:47:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        mark.rutland@arm.com, alexandre.torgue@st.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH 1/3] dt-bindings: interrupt-controller: stm32: Document
 hwlock properties
Message-ID: <20181204204733.GA14508@bogus>
References: <20181113144805.1054-1-benjamin.gaignard@st.com>
 <20181113144805.1054-2-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113144805.1054-2-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 03:48:03PM +0100, Benjamin Gaignard wrote:
> Add hwlocks as optional property
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>

Should be linaro.org S-o-b?

> ---
>  .../devicetree/bindings/interrupt-controller/st,stm32-exti.txt        | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
> index 6a36bf66d932..cd01b2292ec6 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
> @@ -14,6 +14,10 @@ Required properties:
>    (only needed for exti controller with multiple exti under
>    same parent interrupt: st,stm32-exti and st,stm32h7-exti)
>  
> +Optional properties:
> +
> +- hwlocks: reference to a phandle of a hardware spinlock provider node.
> +
>  Example:
>  
>  exti: interrupt-controller@40013c00 {
> -- 
> 2.15.0
> 
