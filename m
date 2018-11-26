Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5889BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 201EA20865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 201EA20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbeK0FyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:54:20 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38169 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeK0FyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 00:54:20 -0500
Received: by mail-ot1-f68.google.com with SMTP id e12so13359875otl.5;
        Mon, 26 Nov 2018 10:59:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6J17CH7Q0U69gYiowTVTS39wHDWi+KRq1GVcp3Y2Wys=;
        b=FXwxAq62hlvQ/L7kCJg+B3/KsXZCn6TUVoD93eOYEj+NZK+XYw1uzsLAKJXPjFAVaX
         tz68dfETmTkYIRvxOxmE/qnTKP+sdrLbEBIJSdiOOgRh5QTR7tW1zdwKWW9z43gFxrZ0
         +PH19Sl3OCc1wdxF88KWqH+zDio8OrSrgawNVrXLuuSzW92IsVIhsoGd+GfaCBs/mpU2
         Tf6YfWjcSWu1tyYjvBgIYOjGL7ai3a9jXAIENQhkSmZwhImR7z/NuPcDc9xz0ZLguEVB
         nFyFWtM85d+QXhNaJOwhfisfuCELHDi9bc/xsKXfYJiJCRdL3f1aKiB85wz6ZkJqRfdO
         LNVA==
X-Gm-Message-State: AA+aEWYWl715cSItO2TgV0BCd4brj9LGo8zXOEVco1gaqZjh5lnAn5No
        dPNpE9nWSh+uBtwMo8C4Wg==
X-Google-Smtp-Source: AFSGD/U4YctDoNx8MPrBy+tySECFgoIEUWkUNw5Fq0+Qb25mxAzb/Vt9s1cfIQ6Ctk4mbRDGQ0W6vQ==
X-Received: by 2002:a9d:4618:: with SMTP id y24mr15452904ote.154.1543258758859;
        Mon, 26 Nov 2018 10:59:18 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g18sm846404oic.9.2018.11.26.10.59.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 10:59:18 -0800 (PST)
Date:   Mon, 26 Nov 2018 12:59:17 -0600
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
        Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH v10 2/3] dt-bindings: clock: Introduce QCOM LPASS clock
 bindings
Message-ID: <20181126185917.GA5802@bogus>
References: <1542873221-13693-1-git-send-email-tdas@codeaurora.org>
 <1542873221-13693-3-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542873221-13693-3-git-send-email-tdas@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2018 13:23:40 +0530, Taniya Das wrote:
> Add device tree bindings for Low Power Audio subsystem clock controller for
> Qualcomm Technology Inc's SDM845 SoCs.
> 
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  .../devicetree/bindings/clock/qcom,gcc.txt         |  4 +++-
>  .../devicetree/bindings/clock/qcom,lpasscc.txt     | 26 ++++++++++++++++++++++
>  include/dt-bindings/clock/qcom,gcc-sdm845.h        |  2 ++
>  include/dt-bindings/clock/qcom,lpass-sdm845.h      | 15 +++++++++++++
>  4 files changed, 46 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
>  create mode 100644 include/dt-bindings/clock/qcom,lpass-sdm845.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
