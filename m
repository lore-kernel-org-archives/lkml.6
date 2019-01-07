Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8438AC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F422087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XIoOWHIr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BCcoIe0G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbfAGSSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:18:12 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37062 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfAGSSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:18:12 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 57FCE60303; Mon,  7 Jan 2019 18:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546885091;
        bh=h2y2f6ljErUMEwF8S5vac2OLt0DPZ+yuztxI/VxgrFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XIoOWHIreII/iRdYhcdBoZYmhWwEYjTxSLdgDWaoV19BBRT6iNbdVouqYPxaBmmNP
         cYJyGn0jDWah5IoA3uSMK7gSpbLSuWatss7Mc9P8ZJLXSqUOm8QtJFg3qKLTh1YZPb
         k62qgBZsb/4iMeub2t0b+xD8yUJEC12uM5FG6MH8=
Received: from jackp-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jackp@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ABC1460303;
        Mon,  7 Jan 2019 18:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546885090;
        bh=h2y2f6ljErUMEwF8S5vac2OLt0DPZ+yuztxI/VxgrFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BCcoIe0G9Z6LN0OSfHRvZishwEoZXx4NNFqtC+VcOhngyA5sMZrD3+4SS2QIbAYx0
         Cls+KOA0iTf9zmgzs8CGnCpIVtcnbAFjty09wBzKvywd7EwwghB5j0Eifl6ibxhSZQ
         wvrT5+igSqQl3qLiEQhewqejDZShwYSPLShfpPtE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ABC1460303
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jackp@codeaurora.org
Date:   Mon, 7 Jan 2019 10:18:04 -0800
From:   Jack Pham <jackp@codeaurora.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     kishon@ti.com, robh+dt@kernel.org, bjorn.andersson@linaro.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        balbi@kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v1 3/6] phy: qcom-qusb2: Add QUSB2 PHY support for msm8998
Message-ID: <20190107181749.GA23243@jackp-linux.qualcomm.com>
References: <1546620629-2426-1-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546620629-2426-1-git-send-email-jhugo@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

Spotted a typo below:

On Fri, Jan 04, 2019 at 09:50:29AM -0700, Jeffrey Hugo wrote:
> MSM8998 contains one QUSB2 PHY which is very similar to the existing
> sdm845 support.
> 
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
>  .../devicetree/bindings/phy/qcom-qusb2-phy.txt     |  1 +
>  drivers/phy/qualcomm/phy-qcom-qusb2.c              | 41 ++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
> index 03025d9..3976847 100644
> --- a/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
> @@ -6,6 +6,7 @@ QUSB2 controller supports LS/FS/HS usb connectivity on Qualcomm chipsets.
>  Required properties:
>   - compatible: compatible list, contains
>  	       "qcom,msm8996-qusb2-phy" for 14nm PHY on msm8996,
> +	       "qcom,msm8998-qusb2-phy" for 10nm PHY on msm8996,
                                                           ^^^^
should be 8998.

Thanks,
Jack
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
