Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2A8C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0094208E7
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0094208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbeK0JFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 04:05:04 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34273 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbeK0JFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 04:05:04 -0500
Received: by mail-oi1-f194.google.com with SMTP id h25so17456640oig.1;
        Mon, 26 Nov 2018 14:09:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y0oayhIxz+OQZ7TJRCqr+XlmaM0+V7rvvFWI/z/a7fw=;
        b=iFXoVMgCGo3EUtukEc1x1EbTZZQvfqVgYdmiKOR+QE4k7Oi4EHmQOHb/2oqr16QKMm
         scwF5V0iNao2mHY0Gwd4N4jDyKm7ESSErlMwxEqS+TXKvLWW5IAflOHuwOWFrn6ysGtb
         GWhJ0QE0YzMgEMx0EeU0NhQ76uiTX+DYfqvvFCikhRT2JlqCnngp9P2goKi5Ygr4E5dG
         ZvzozystHTFefyvNrPDEks2a7zKVF7Q994JzX2HQvdkstvMfRdO6m/HvCCqwWHo6q8Xz
         JITDeuCQ7IMwxUuc7cY56PNSzA2ERAB04NOzjAAdue5fbEajy4Ef4Une46IjuUoZkyL9
         TlNg==
X-Gm-Message-State: AGRZ1gKhn/94S4V8u3l+cJWZHOoGI7miioMdZidA/kYeYZ+7tK7jEfur
        1WZzbZq9o8O/uqXS+pdr7US4pFw=
X-Google-Smtp-Source: AJdET5dOgZAt7gR/YdpAqVIz+AdEEb2/xkz53gol2zRd9m32UGtLAV7L0mZ7M4j9rz+APFqhRXgK/w==
X-Received: by 2002:a54:478f:: with SMTP id o15mr17088095oic.42.1543270169684;
        Mon, 26 Nov 2018 14:09:29 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b23sm737121otq.5.2018.11.26.14.09.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 14:09:29 -0800 (PST)
Date:   Mon, 26 Nov 2018 16:09:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org,
        Amit Nischal <anischal@codeaurora.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: clock: Introduce QCOM Graphics clock
 bindings
Message-ID: <20181126220928.GA10395@bogus>
References: <1543120569-14444-1-git-send-email-tdas@codeaurora.org>
 <1543120569-14444-2-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543120569-14444-2-git-send-email-tdas@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Nov 2018 10:06:07 +0530, Taniya Das wrote:
> From: Amit Nischal <anischal@codeaurora.org>
> 
> Add device tree bindings for graphics clock controller for
> Qualcomm Technology Inc's SDM845 SoCs.
> 
> Signed-off-by: Amit Nischal <anischal@codeaurora.org>
> ---
>  .../devicetree/bindings/clock/qcom,gpucc.txt       | 18 ++++++++++++++++
>  include/dt-bindings/clock/qcom,gpucc-sdm845.h      | 24 ++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gpucc.txt
>  create mode 100644 include/dt-bindings/clock/qcom,gpucc-sdm845.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
