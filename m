Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE83C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C726924F4E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:53:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C726924F4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933274AbeFZTxo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 15:53:44 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:37470 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932160AbeFZTxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 15:53:39 -0400
Received: by mail-yw0-f196.google.com with SMTP id m201-v6so2566661ywd.4;
        Tue, 26 Jun 2018 12:53:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VtpTc9FFYSmmj7OWhDdvpn/e/yA54+yLQ9rYeaoc1A8=;
        b=PyvOotYxzdmUoo4Euffeo3AQbEUgtbqSdpwz+2OkKFyVGCjXyq0ymh8GjYMN6aBdZL
         QRW0zjAjaFgSav0nbUsI8eaRU71+FQ9ALwrBn1RHCVDcWsavYmZKr6p4f2uJD6CkuDoA
         9//4iZr+BXApgTBvdXwKzf0fret0+L2tUxJqKYByl+5G/ljEFqV541TYLSexH5yTTDQC
         bpAa/UwPok87vfEYTWABrxv+CjCrapzzGeUVmSADf/gUKWAWkakDacW6j3QHfqWSj+9n
         YxA1wsVxllG6MYndV43r72qDYgmizxAo1zeyQwNqk1GHsWJeO5SyB8ovwhd44OYLx6pH
         W+rQ==
X-Gm-Message-State: APt69E0qSvkH25gC+Pg/p+tLycEBpb3qJyocXgt4BHyAw6wHk6wmUxbe
        KzcPtbdYo4Ofcp3saWuc9A==
X-Google-Smtp-Source: AAOMgpcKGTJ7nff5c062HggiiPkvIoQPY/DRsUWYBxMhCLUj478830Pes7htulxHcvOn2LXSo/kblA==
X-Received: by 2002:a0d:fc46:: with SMTP id m67-v6mr1499754ywf.52.1530042818503;
        Tue, 26 Jun 2018 12:53:38 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id r133-v6sm972984ywr.45.2018.06.26.12.53.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 12:53:37 -0700 (PDT)
Date:   Tue, 26 Jun 2018 13:53:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rohit Kumar <rohitkr@codeaurora.org>
Subject: Re: [PATCH 1/2] dt-bindings: clock: Introduce QCOM LPASS clock
 bindings
Message-ID: <20180626195336.GA25448@rob-hp-laptop>
References: <1528961943-12506-1-git-send-email-tdas@codeaurora.org>
 <1528961943-12506-2-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528961943-12506-2-git-send-email-tdas@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 01:09:02PM +0530, Taniya Das wrote:
> Add device tree bindings for Low Power Audio subsystem clock controller for
> Qualcomm Technology Inc's SDM845 SoCs.
> 
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  .../devicetree/bindings/clock/qcom,lpasscc.txt     | 46 ++++++++++++++++++++++
>  include/dt-bindings/clock/qcom,lpass-sdm845.h      | 18 +++++++++
>  2 files changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
>  create mode 100644 include/dt-bindings/clock/qcom,lpass-sdm845.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,lpasscc.txt b/Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
> new file mode 100644
> index 0000000..16cabc4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
> @@ -0,0 +1,46 @@
> +Qualcomm LPASS Clock Controller Binding
> +-----------------------------------------------
> +
> +Required properties :
> +- compatible	: shall contain "qcom,sdm845-lpasscc"
> +- #clock-cells	: from common clock binding, shall contain 1.
> +
> +Note that #address-cells, #size-cells, and ranges shall be present to ensure
> +the lpasscc can address the various lpass cc registers.
> +
> +Child Node Properties :
> +The Low Pass Audio clock controller would need to define the following child
> +nodes with the properties.
> +- compatible	: shall contain all of the below for clocks in each LPASS domain
> +			"qcom,sdm845-lpass-gcc",
> +			"qcom,sdm845-lpass-cc",
> +			"qcom,sdm845-lpass-qdsp6ss"
> +- reg		: shall contain base register address and size,

I can't really see any reason to have these child nodes. Just put 3 
entries in reg in the parent.

Rob
