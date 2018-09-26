Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234E7C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D180B21531
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:06:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D180B21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbeI0DUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 23:20:54 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39882 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeI0DUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 23:20:54 -0400
Received: by mail-ot1-f68.google.com with SMTP id c12-v6so407289otl.6;
        Wed, 26 Sep 2018 14:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FRBas4oFxSzzEUEeGiZ4HGOj40VCHuDBpIyoczmYSoM=;
        b=ZPZr1nK4r0KHgUX1CRiBISeWeDYxQdqvpGKeYwntRg8e45bEr4jMxxJNxy7oDT1i1P
         4K1OQ4B3VmK6Nm3281KOcghEYJ+pu330QVAWXZ9SwCCn0noEMzso+HhGWQKny7TPjUDN
         3eBlXjFIXZcRGmXsZRf2CFrQjWVXMDu/2EHmCjxAVMTqSgUBU8dx9b1SXxVXL84WVxhq
         KOR0YyCAlq/xgIu174e2zFBCYU6ALxtdOcziNM2U1u24ZB2F+8aNO0F9ZY1SVWVQXUMg
         qfUutADlpdCkT5QCDwEA9B304ecJSKzQZObuNSAR0HbvxXB+HWxgSXnzpisvviodBkZG
         f70w==
X-Gm-Message-State: ABuFfog/t31JYmm4ouTVxK++xIBig3/9KknjHLr8+Jhl2CrL/0yPvKYE
        JA/UGH6s1f/ag7ws+EzH5w==
X-Google-Smtp-Source: ACcGV62Rr08BBvPXpqYdV4U1FYfaf6WsZu5rcppmoDMVhN6nsQOcRevNW6fX95FranF9ypUIrXVo/w==
X-Received: by 2002:a9d:fa4:: with SMTP id d33-v6mr5282699otd.84.1537995964660;
        Wed, 26 Sep 2018 14:06:04 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q204-v6sm20035oih.49.2018.09.26.14.06.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 14:06:04 -0700 (PDT)
Date:   Wed, 26 Sep 2018 16:06:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     heiko@sntech.de, robh+dt@kernel.org, vicencb@gmail.com,
        shawn.lin@rock-chips.com, ezequiel@collabora.com,
        enric.balletbo@collabora.com, pbrobinson@gmail.com, tom@vamrs.com,
        dev@vamrs.com, stephen@vamrs.com, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v3 2/4] dt-bindings: arm: rockchip: Add binding for
 Rock960 board
Message-ID: <20180926210603.GA6297@bogus>
References: <20180913180545.29756-1-manivannan.sadhasivam@linaro.org>
 <20180913180545.29756-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913180545.29756-3-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Sep 2018 23:35:43 +0530, Manivannan Sadhasivam wrote:
> Add devicetree binding for Rock960 board from Vamrs Limited.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
