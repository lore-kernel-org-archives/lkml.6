Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9ACDC004D1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84ECA21533
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84ECA21533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbeI0FC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 01:02:56 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37107 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeI0FC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 01:02:56 -0400
Received: by mail-ot1-f66.google.com with SMTP id o13-v6so661249otl.4;
        Wed, 26 Sep 2018 15:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aiwEYd0SsbhzuaQYt5rkOoDQbtAkX4SyqpYZCUqYFYs=;
        b=q1JUi/O1Hnvsq/hnUDTBOQyFq6Ajv8EU17WX+0aIpj2UJiGRl1Qi3zdcsLCvT/9aSA
         s6epI/+JI2SZKHdZWEk5yaaIPVBfKJZJ/4e5eTDC4TZWKhvXBg9cjINl+d0HYkI99BV+
         vFiX8cC0am5benPWimakGb2lxoigoAL3QL2KBj0OiBbJhKjHI7OwhrF6+iMzgVyMDOOu
         M2hoeFMtHgf1GpTkyHehVGn+/ya7pBrpSeOkKYIxiyEZYK2ZPAHRWtl4kkbhprVwH+L+
         sXXFS5fj4qR/mOM11+pzLryN+rAeYP1VBSQy1y1OYhtsT4b33khQG0xSoqeCyI2+ECZE
         XJ0Q==
X-Gm-Message-State: ABuFfog6tsGbFfuoj7G0ZlULHq4TDF6WeYkFrbebJxv6Wk+B5TbL05MM
        TkFIOkaDIE/1hl5oCzMd0Q==
X-Google-Smtp-Source: ACcGV63owTNBfmrkDqzqQWi0gd+6vGK3ib2vnuEEyWpx2s+OUkHxvGO61V4rk5mhwlgtOPp7FrqvCg==
X-Received: by 2002:a9d:542:: with SMTP id 60-v6mr5892566otw.71.1538002063879;
        Wed, 26 Sep 2018 15:47:43 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e14-v6sm161665oib.2.2018.09.26.15.47.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 15:47:43 -0700 (PDT)
Date:   Wed, 26 Sep 2018 17:47:42 -0500
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
Subject: Re: [PATCH v5 1/2] dt-bindings: clock: Introduce QCOM LPASS clock
 bindings
Message-ID: <20180926224742.GA9096@bogus>
References: <1537266338-18661-1-git-send-email-tdas@codeaurora.org>
 <1537266338-18661-2-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537266338-18661-2-git-send-email-tdas@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Sep 2018 15:55:37 +0530, Taniya Das wrote:
> Add device tree bindings for Low Power Audio subsystem clock controller for
> Qualcomm Technology Inc's SDM845 SoCs.
> 
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  .../devicetree/bindings/clock/qcom,gcc.txt         |  2 ++
>  .../devicetree/bindings/clock/qcom,lpasscc.txt     | 35 ++++++++++++++++++++++
>  include/dt-bindings/clock/qcom,gcc-sdm845.h        |  2 ++
>  include/dt-bindings/clock/qcom,lpass-sdm845.h      | 16 ++++++++++
>  4 files changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
>  create mode 100644 include/dt-bindings/clock/qcom,lpass-sdm845.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
