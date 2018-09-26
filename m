Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7993BC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD8321533
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD8321533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbeI0FGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 01:06:35 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34458 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbeI0FGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 01:06:35 -0400
Received: by mail-ot1-f66.google.com with SMTP id i12-v6so686941otl.1;
        Wed, 26 Sep 2018 15:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CZ3UM9qUSlcTWsnJKHOo8gREF4pMwcq6cCuBCBN+iog=;
        b=jLzixaTcO4fUXJUeD/ox4ZhA1ormxNyWj6dNM0/DtwfOQOSdi6w+IN/Fo0qblWcJXp
         nyCx3IsEYh1rzmT1ZQSUpUMqRdZhNf0ZYvAWbVSo2Vk7MAsTTypDKD7aRBsdZ1gQF97i
         eMHk2CYeku2J6Nv9LKYh5nhtjeRhXW8hFfmKAZNiMNRklRGv+XZw6YmhV3yLOzmY17xk
         CV8GhwIzSUfS8pm9OSKblwNt40EgaotU+IUT/V3G8RskukzMyi+x5ADbvUfL1V0qXFe+
         oUbquqhr6tjwy2Js26FudAMI+zyWEqDJIkh6hGaF4VvGjqvYT+3UskX8D9sso3X0jTaD
         TQxQ==
X-Gm-Message-State: ABuFfoiBKsjE70SMwZwjpKcPhOrLtVgesSul2/Dp4MFN3Y/5OMSP7AmY
        gKWgZTnWu4zwn7dt6bh3pg==
X-Google-Smtp-Source: ACcGV6055Ghhgvwdlf9ozGqbt6DmvY4qW5pcD4BNKWrSsooRzkX6WIUTQhPT/1bRg0kfv3eHsqLa/w==
X-Received: by 2002:a9d:7042:: with SMTP id x2-v6mr5478966otj.200.1538002281590;
        Wed, 26 Sep 2018 15:51:21 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m11-v6sm133452otc.18.2018.09.26.15.51.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 15:51:21 -0700 (PDT)
Date:   Wed, 26 Sep 2018 17:51:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dilip Kota <dkota@codeaurora.org>
Cc:     swboyd@chromium.org, dianders@chromium.org, broonie@kernel.org,
        mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, Dilip Kota <dkota@codeaurora.org>
Subject: Re: [PATCH V4 2/4] dt-bindings: soc: qcom: GENI SE SPI controller
 device tree binding
Message-ID: <20180926225120.GA14357@bogus>
References: <1537294047-12093-1-git-send-email-dkota@codeaurora.org>
 <1537294047-12093-3-git-send-email-dkota@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537294047-12093-3-git-send-email-dkota@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Sep 2018 23:37:24 +0530, Dilip Kota wrote:
> Move GENI SE SPI controller device-tree bindings
> from devicetree/bindings/soc/qcom/qcom,geni-se.txt
> to devicetree/bindings/spi/qcom,spi-geni-qcom.txt.
> 
> Signed-off-by: Dilip Kota <dkota@codeaurora.org>
> ---
>  .../devicetree/bindings/soc/qcom/qcom,geni-se.txt  | 27 ++-------------
>  .../devicetree/bindings/spi/qcom,spi-geni-qcom.txt | 39 ++++++++++++++++++++++
>  2 files changed, 41 insertions(+), 25 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
