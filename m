Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23006C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D848624EF7
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D848624EF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934703AbeFYO6n (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 10:58:43 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33643 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934437AbeFYO6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 10:58:40 -0400
Received: by mail-yw0-f194.google.com with SMTP id u124-v6so4870198ywg.0;
        Mon, 25 Jun 2018 07:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jRtALafKEKvVGDNA0Jq3BdzUxVfX1mNga9aRhx0gyno=;
        b=t9692Bk2PiLhm6a54uaS3OBxb36lDh/Kl82tIAc0d3jehfB6nDoFpO20rgF9RB4yzW
         hSS+cjDZz3Vv/sZLLnZhIxzPNdouT5LoZSU9ou/TSCYEwcZjQOVVUDpwox8p5tp6vkhw
         SJ5NOfOQIy8VkgiCW118lF8W8eS16iWQx7lcYSIQ46nQekzMgCK2nopqSOuQgjQB55BM
         NmlBQeW5TJ8Zyf0+6QB9kZHZS3MIZUkdAtsp56OXOtZtVRkuJ45VdLF1QXTZeCEs0UNz
         wr1+J3zhOepDicy/Hmn/Rwz5Y8IWdII2e/bS4I1Sbl9UCPspvIWxrxZIl6FZ8xzxmFgB
         WuNA==
X-Gm-Message-State: APt69E3MpIfvt8Z8fpaSFDbLAp+1/2h71oEK2Q+4/MCIFzAw833VSWxV
        nP0GUWMH+S0nXj84lPNcxA==
X-Google-Smtp-Source: ADUXVKLNJr8KekzA6fzt70kph+TJ0dULC6bnNrfw30VugjEUVZ39TiUB4G1GfVNq/036WeZNkjC8fw==
X-Received: by 2002:a81:1b83:: with SMTP id b125-v6mr5776072ywb.39.1529938719812;
        Mon, 25 Jun 2018 07:58:39 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id p81-v6sm5473047ywb.71.2018.06.25.07.58.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 07:58:38 -0700 (PDT)
Date:   Mon, 25 Jun 2018 08:58:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, rtatiya@codeaurora.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v8 1/7] dt-bindings: net: bluetooth: Add device tree
 bindings for QTI chip wcn3990
Message-ID: <20180625145837.GA21153@rob-hp-laptop>
References: <20180625134013.19684-1-bgodavar@codeaurora.org>
 <20180625134013.19684-2-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625134013.19684-2-bgodavar@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 07:10:07PM +0530, Balakrishna Godavarthi wrote:
> This patch enables regulators for the Qualcomm Bluetooth wcn3990
> controller.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
> 
> Changes in v8:
>     * Separated the optional entries between two chips
> 
> Changes in v7:
>     * no change.
> 
> Changes in v6:
> 
>     * Changed the oper-speed to max-speed.
> 
> Changes in v5:
> 
>     * Added entry for oper-speed and init-speed.
> 
> ---
>  .../bindings/net/qualcomm-bluetooth.txt       | 30 +++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> index 0ea18a53cc29..c2b09dd2bf31 100644
> --- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> @@ -10,12 +10,23 @@ device the slave device is attached to.
>  Required properties:
>   - compatible: should contain one of the following:
>     * "qcom,qca6174-bt"
> +   * "qcom,wcn3990-bt"
> +
> +Optional properties for compatible string qcom,qca6174-bt:
>  
> -Optional properties:
>   - enable-gpios: gpio specifier used to enable chip
>   - clocks: clock provided to the controller (SUSCLK_32KHZ)
>  
> -Example:
> +Optional properties for compatible string qcom,wcn3990-bt:
> +
> + - vddio-supply: Bluetooth VDD IO regulator handle.
> + - vddxtal-supply: Bluetooth VDD XTAL regulator handle.
> + - vddpa-supply: Bluetooth VDD PA regulator handle.
> + - vddldo-supply: Bluetooth VDD LDO regulator handle.
> + - vddcore-supply: Bluetooth VDD CORE regulator handle.
> + - max-speed: Maximum operating speed of the chip.

This shouldn't be per compatible really. The definition here is wrong 
too. You should know the max baud for the chip based on the compatible. 
This property is for when the max is less than the max of either the 
chip or host UART.

Rob
