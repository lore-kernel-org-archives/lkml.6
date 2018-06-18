Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB628C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683D120693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OBzi+Ju6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CF9u4v7c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 683D120693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936042AbeFRV7H (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 17:59:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54288 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755003AbeFRV7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 17:59:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9AB2A60714; Mon, 18 Jun 2018 21:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529359144;
        bh=HVKfEwyfCoQZjok76qoubiEjXByXAM2w9VNfsLkOInw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OBzi+Ju6OUqF/JAOKJ1aSqPGXpd2Rq/8ZGYQ6M1KX28Rhwt+rpzC7FqLqhs5tZ1Vl
         ZavhImy1kAxcBOEDeaCTbIiNPW2aBpILRo4AKkYTt8Vi6eZblK3uAg0+//MPhM9B1s
         x9gN4i0M+zFDKPNBZw3ZeLLvYz7IYHvBsT0sAyhI=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B173E607EB;
        Mon, 18 Jun 2018 21:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529359143;
        bh=HVKfEwyfCoQZjok76qoubiEjXByXAM2w9VNfsLkOInw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CF9u4v7c60wHBQ0gHAKyzFWvQHBVkV58702ZO04nSGpLkE2rOZOmBumTVKeCZTJP0
         7cMXT37yvB/6/k5wAXytbG3sWodsOJioZZm2VSGOExjs+kDekh0lVDzCbekMNY0P+u
         V4namvw8Vk01SNBgEbrcLSKsjk+ADmn0p8PqbywU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B173E607EB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Mon, 18 Jun 2018 15:59:02 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     andy.gross@linaro.org, sboyd@kernel.org, tdas@codeaurora.org,
        rplsssn@codeaurora.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] arm64: dts: sdm845: Add rpmh-rsc node
Message-ID: <20180618215902.GJ21724@codeaurora.org>
References: <20180618215051.156270-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180618215051.156270-1-dianders@chromium.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the quick spin Doug.

On Mon, Jun 18 2018 at 15:51 -0600, Douglas Anderson wrote:
>This adds the rpmh-rsc node to sdm845 based on the examples in the
>bindings.
>
>Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Lina Iyer <ilina@codeaurora.org>

>---
>
>Changes in v2:
>- Fixed ordering of tcs-config as per Lina.
>
> arch/arm64/boot/dts/qcom/sdm845.dtsi | 19 +++++++++++++++++++
> 1 file changed, 19 insertions(+)
>
>diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>index cd308b84bed7..43a182fb42c9 100644
>--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>@@ -7,6 +7,7 @@
>
> #include <dt-bindings/clock/qcom,gcc-sdm845.h>
> #include <dt-bindings/interrupt-controller/arm-gic.h>
>+#include <dt-bindings/soc/qcom,rpmh-rsc.h>
>
> / {
> 	interrupt-parent = <&intc>;
>@@ -984,6 +985,24 @@
> 			#mbox-cells = <1>;
> 		};
>
>+		apps_rsc: rsc@179c0000 {
>+			label = "apps_rsc";
>+			compatible = "qcom,rpmh-rsc";
>+			reg = <0x179c0000 0x10000>,
>+			      <0x179d0000 0x10000>,
>+			      <0x179e0000 0x10000>;
>+			reg-names = "drv-0", "drv-1", "drv-2";
>+			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
>+				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
>+				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
>+			qcom,tcs-offset = <0xd00>;
>+			qcom,drv-id = <2>;
>+			qcom,tcs-config = <ACTIVE_TCS  2>,
>+					  <SLEEP_TCS   3>,
>+					  <WAKE_TCS    3>,
>+					  <CONTROL_TCS 1>;
>+		};
>+
> 		intc: interrupt-controller@17a00000 {
> 			compatible = "arm,gic-v3";
> 			#address-cells = <1>;
>--
>2.18.0.rc1.244.gcf134e6275-goog
>
