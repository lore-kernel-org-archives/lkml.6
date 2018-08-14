Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F42AC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1190F21711
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1190F21711
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbeHNXmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 19:42:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35937 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbeHNXmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 19:42:19 -0400
Received: by mail-pf1-f194.google.com with SMTP id b11-v6so9781501pfo.3;
        Tue, 14 Aug 2018 13:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2s/GG+alCa95gSpO1k+7y1QKUGhsOnaTASGnnaRP8ZA=;
        b=agoPWeYevHVNv0pc8izDLOOCXLhNTaq5MJdlQWhbUum2Qhnw42meE7tXKPtkwn3zuX
         PDVbdrhkBwJSne2/ysHMQScUSkg4m5bSuY+OPRjEJkUVxFe3s4ZYiF6XFyeMPn0pMAcZ
         x3ElXfp70ZkZ7XsSZYJMgrMY00kdgQpX/rPoPW6vIhAicBWVHNItV1GjGCK+cW1PF2nj
         Ny6og/lz1K9Zszy6goRSx+4L/V6KikW3Ps9UsJcIEd+xFO7vwyeTZOhWHA2+q5UcoqPf
         LHcFlMrLV7266OadC6ntzFi93IJU9ap5meab3lsKf0YRmc2vjyahlpnC3EMPOFyk1bBq
         dZAw==
X-Gm-Message-State: AOUpUlGE2INMANpce0scJSBjTqO7xbOy/NJv9ldYM3IK/4gtGzvjXDk6
        CkXSwp1RHznpCAcaWETGBA==
X-Google-Smtp-Source: AA+uWPwQRq/0YsFd+ICKym9YXxMpBYK7nzDXi01d3m4j4kALkDixVzQPN8L4Wocij2FCztRQ44yo/A==
X-Received: by 2002:a63:66c7:: with SMTP id a190-v6mr22434583pgc.411.1534280002264;
        Tue, 14 Aug 2018 13:53:22 -0700 (PDT)
Received: from localhost ([74.118.88.158])
        by smtp.gmail.com with ESMTPSA id z184-v6sm28746776pgd.83.2018.08.14.13.53.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 13:53:21 -0700 (PDT)
Date:   Tue, 14 Aug 2018 14:53:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     xuwei5@hisilicon.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
        guodong.xu@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 1/4] dt-bindings: arm: hisilicon: Add binding for Hi3670
 SoC
Message-ID: <20180814205320.GA17448@rob-hp-laptop>
References: <20180810175339.25421-1-manivannan.sadhasivam@linaro.org>
 <20180810175339.25421-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810175339.25421-2-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Aug 2018 23:23:36 +0530, Manivannan Sadhasivam wrote:
> Add devicetree binding for Hi3670 SoC.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
