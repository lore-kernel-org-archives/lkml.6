Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED72C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4333320836
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1N6oDmb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4333320836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbeHYDBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 23:01:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40862 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbeHYDBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 23:01:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id z25-v6so4932928pgu.7;
        Fri, 24 Aug 2018 16:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TMT98wyFMnw9pm5cVpPWrnQcSK8o66rI/YEkJw3RdCI=;
        b=R1N6oDmb/1pW66kQVvYIT2hhEoVS8lzyAMrdzxs3k42hxa2TSHe4o/R0RN2MpImRrp
         WewwByj/dEo4WjCzaLKd1qw7S9EG9Xuy/IYbnZoegvU+nXKdYwndpJ0ICgejBmTyOQbf
         SOI3A0Rn4+uCCzLTv2L3Rn7AIVyr34rtY1JKnh2qZQ1WcJ8gCla2l1orcEtaS6cwrZUO
         Lxnpe3GjPl91zCJKcvdqnM6rVoUW6lDBh6gfkqI8l6fPjINraIKLCoZVE7mvoVTeTj8V
         0nwxzriwjMXjLwO2nXkyg5uv/LTMqYHAdgBWO2hyLaMC2ebCH2TTL19yTXTdYnaFGspL
         eGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TMT98wyFMnw9pm5cVpPWrnQcSK8o66rI/YEkJw3RdCI=;
        b=VIeqx4FWtzlc88/RGkar+ghqFzdMzvNBlFqeZ11UhuMmDfUYcZ3G0KTuY8Q0Nk/hNu
         w6iTJ4GrA637THTErAVG9bm+sYv1kkAgWLZWuj2qMn1pAO+0PNWpm8woLEBP0DDT7yw+
         zOdQ+zS22UF6Y1LvpCCHqnaGl5w/iBhPoMq47uM1H7NTBTGsyA0e/+Ec0Oez4HTbfQ0Y
         OmEZY4KxkvQC8j82aD+5diouXmES/Px/qrK5QnPiXus7CUaEAFrTUAXQQnHhPCwALD3k
         OFmoE9uYBacIjl5pQDZENGt1cmp5C1ve9tdcJk64WK49OX+sOhto5j9XVDiwhSx9mzzX
         Z1sg==
X-Gm-Message-State: APzg51CPZ208Qqa/Yq7M8ZtVMtKa46SsDLoP9iTM2KToXH+IBx9Oz7n3
        NOHTpM5ThEGWW9yAi4oFa4o=
X-Google-Smtp-Source: ANB0VdZkiUuHR9FgxSUvHqaGN7b4dy27WZC9Z9lxVJWLcNYTqHNJBxsgIevw0aN/sNfh/01Q4wwEsQ==
X-Received: by 2002:a63:4d47:: with SMTP id n7-v6mr3540447pgl.270.1535153073793;
        Fri, 24 Aug 2018 16:24:33 -0700 (PDT)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id c1-v6sm16187992pfg.25.2018.08.24.16.24.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 16:24:33 -0700 (PDT)
Date:   Fri, 24 Aug 2018 16:24:25 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 02/10] dt-bindings: thermal: Fix a typo in
 documentation
Message-ID: <20180824232423.GD25163@localhost.localdomain>
References: <cover.1533815718.git.amit.kucheria@linaro.org>
 <08b528ddc26adcb57539b1ac9d352850d7d80bfb.1533815718.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08b528ddc26adcb57539b1ac9d352850d7d80bfb.1533815718.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 06:02:34PM +0530, Amit Kucheria wrote:
> c(1) + x(1) was actually meant to be c(1) * x(1).
> 
> While we're at it, add some brackets to make it nicer to read.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/thermal.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
> index cc553f0952c5..751104213d08 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
> @@ -152,7 +152,7 @@ Optional property:
>    Elem size: one cell	the sensors listed in the thermal-sensors property.
>    Elem type: signed	Coefficients defaults to 1, in case this property
>  			is not specified. A simple linear polynomial is used:
> -			Z = c0 * x0 + c1 + x1 + ... + c(n-1) * x(n-1) + cn.
> +			Z = (c0 * x0) + (c1 * x1) + ... + (c(n-1) * x(n-1)) + cn.

To be honest, I would prefer if this looks like:
+			Z = c0 * x0 + c1 * x1 + ... + c(n-1) * x(n-1) + cn.

The extra bracketing seams unnecessary confusion

>  
>  			The coefficients are ordered and they match with sensors
>  			by means of sensor ID. Additional coefficients are
> -- 
> 2.17.1
> 
