Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFECC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF3621477
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Z4Lgbq0T";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gkBXMwm2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF3621477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbeHXSds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 14:33:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50272 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbeHXSds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 14:33:48 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E1C4C6083E; Fri, 24 Aug 2018 14:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535122727;
        bh=X5VpSTm7nZIu6xXdzdMQw4BTv9BkYM7kw0H38GgKbvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z4Lgbq0TD0O6LZZeUlxLXAfjWLnZkhvOMadSURgXBXsYys9chk/YslYdGN2Mf0Uqu
         p8VnFNta9s7fc/dHXnTHIJXzRgbfK5p9ZML+P6H3z1GpnPYc54vk6QL341g5MxWsGL
         hflC94WWsEPwBPaEel2czEogsH2TR4Y7QAN6bt8Q=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6156D60C83;
        Fri, 24 Aug 2018 14:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535122721;
        bh=X5VpSTm7nZIu6xXdzdMQw4BTv9BkYM7kw0H38GgKbvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gkBXMwm23IXZgDeNgwttCvN4hbuzWq5igSMu2Si0Tyn/mvyQLbGFad6pWufQy+CkX
         KBINTGrA/Q3xJXMF1++FRezSBPje8VySkx06iAJmcRuagVDq/byyKzco5JWOK9Zwly
         CCKso9U9piofO8HCMKvfLU+fOdA1vOGwl5VDa0BA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6156D60C83
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Fri, 24 Aug 2018 08:58:40 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     David Dai <daidavid1@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        georgi.djakov@linaro.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, grahamr@qti.qualcomm.com,
        evgreen@google.com
Subject: Re: [PATCH v3 2/2] arm64: dts: sdm845: Add interconnect provider DT
 nodes
Message-ID: <20180824145840.GK5081@codeaurora.org>
References: <1535075814-17343-1-git-send-email-daidavid1@codeaurora.org>
 <1535075814-17343-3-git-send-email-daidavid1@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1535075814-17343-3-git-send-email-daidavid1@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23 2018 at 19:57 -0600, David Dai wrote:
>Add RSC(Resource State Coordinator) provider
>dictating network-on-chip interconnect bus performance
>found on SDM845-based platforms.
>
>Change-Id: I58f0bfc3ed484d7b45064dceb94dcfda507e9333
Remove this pls.

-- Lina

>Signed-off-by: David Dai <daidavid1@codeaurora.org>
>---
> arch/arm64/boot/dts/qcom/sdm845.dtsi | 5 +++++
> 1 file changed, 5 insertions(+)
>
>diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>index 1097c7e..4d15784 100644
>--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>@@ -1651,6 +1651,11 @@
> 				compatible = "qcom,sdm845-rpmh-clk";
> 				#clock-cells = <1>;
> 			};
>+
>+			qnoc: qnoc{
>+				compatible = "qcom,sdm845-rsc-hlos";
>+				#interconnect-cells = <1>;
>+			};
> 		};
>
> 		ufsphy: phy@1d87000 {
>--
>The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>a Linux Foundation Collaborative Project
>
