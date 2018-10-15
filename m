Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2207AC71130
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62A02064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E62A02064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbeJOVMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 17:12:49 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38366 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeJOVMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 17:12:48 -0400
Received: by mail-ot1-f66.google.com with SMTP id l1so18850625otj.5;
        Mon, 15 Oct 2018 06:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t5kqNibiGW4KPuojmRMC/+CmprNmTcmC7zm9i9MelHM=;
        b=EGk+yMQwxfEjMf3IWC9Pr3OAmNjZTmG5AyuA91YbJaZYphHQnfmr1gVgmYfWJ5XNMz
         hMujxq9WQj/bFAmjr/Tqljsbr9Y/MO2WXLs2sZ6CfEzsI++jkgQZNt5rxTK96tFQiHHd
         q7IgazWY8cuhgY66I3FhtSb/sQWt7uZWmSQWIfYJ8RvcCWTDN3PTe8YAmYP6KxsKAg2N
         OXPgKBAB0GL4guK1XmeyAl3wPyA7dA1JSC7ebgssq+IuanpuMB6JaIYvdlML6KA5QR87
         Z3F4VNZuEL/m7AYQkswX4zFhueOFebmzTtaRh7N31LxAx//Rzn4d+Qnfn7Vb9RHoi2Tw
         KgSQ==
X-Gm-Message-State: ABuFfoiSDPYgou5efzZGsap7nZKdnelCnTI2fhEwTTGHWvvct/+OCeKB
        1KoLEBWVduB25Qy6TyFIYjVpSrM=
X-Google-Smtp-Source: ACcGV61Uzx1MDbCGTze+HAbWAdMRd0EPZJORgcIo8u/4BkQ5TgKNqAEZ8jCgaT1m08wA2nkJbL/ApQ==
X-Received: by 2002:a9d:8a4:: with SMTP id 33mr10219852otf.269.1539610049357;
        Mon, 15 Oct 2018 06:27:29 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l64-v6sm3098047oia.26.2018.10.15.06.27.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 06:27:28 -0700 (PDT)
Date:   Mon, 15 Oct 2018 08:27:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shefali Jain <shefjain@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] clk: qcom: gcc: Add global clock controller
 driver for QCS404
Message-ID: <20181015132727.GA19377@bogus>
References: <20181010145138.17185-1-vkoul@kernel.org>
 <20181010145138.17185-3-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010145138.17185-3-vkoul@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 08:21:38PM +0530, Vinod Koul wrote:
> From: Shefali Jain <shefjain@codeaurora.org>
> 
> Add the clocks supported in global clock controller which clock the
> peripherals like BLSPs, SDCC, USB, MDSS etc. Register all the clocks
> to the clock framework for the clients to be able to request for them.
> 
> Signed-off-by: Shefali Jain <shefjain@codeaurora.org>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> Co-developed-by: Taniya Das <tdas@codeaurora.org>
> Signed-off-by: Anu Ramanathan <anur@codeaurora.org>
> [bamse, vkoul: rebase and tidyup for upstream]
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  .../devicetree/bindings/clock/qcom,gcc.txt         |    1 +
>  drivers/clk/qcom/Kconfig                           |    8 +
>  drivers/clk/qcom/Makefile                          |    1 +
>  drivers/clk/qcom/gcc-qcs404.c                      | 2744 ++++++++++++++++++++
>  include/dt-bindings/clock/qcom,gcc-qcs404.h        |  165 ++
>  5 files changed, 2919 insertions(+)
>  create mode 100644 drivers/clk/qcom/gcc-qcs404.c
>  create mode 100644 include/dt-bindings/clock/qcom,gcc-qcs404.h

For the DT bits,

Acked-by: Rob Herring <robh@kernel.org>
