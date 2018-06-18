Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA57C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879432075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fPglJkVN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fPglJkVN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 879432075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936973AbeFRVYT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 17:24:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60182 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936232AbeFRVYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 17:24:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B23B860558; Mon, 18 Jun 2018 21:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529357056;
        bh=k8Aa+JERFUSGJRXFe+h6zWHRfDxH2Xn+LZyZQQyk2l4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fPglJkVNGrc5b/z5JKIlh6Bak28fRE54Fe9F+Cr12ZQf+HvlIjdwZB+U4I8VfFykq
         v7lHI8Hlkzd/1u53hQ6v6YR038QLMivJmFmxAP87HVSSs75cS6Z+yyzzshAVSoC5L1
         ngjVQ5lZpnm3QWtIZWK+PKDOT+b9BQC9ylzcqLtE=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BA91360558;
        Mon, 18 Jun 2018 21:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529357056;
        bh=k8Aa+JERFUSGJRXFe+h6zWHRfDxH2Xn+LZyZQQyk2l4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fPglJkVNGrc5b/z5JKIlh6Bak28fRE54Fe9F+Cr12ZQf+HvlIjdwZB+U4I8VfFykq
         v7lHI8Hlkzd/1u53hQ6v6YR038QLMivJmFmxAP87HVSSs75cS6Z+yyzzshAVSoC5L1
         ngjVQ5lZpnm3QWtIZWK+PKDOT+b9BQC9ylzcqLtE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BA91360558
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Mon, 18 Jun 2018 15:24:14 -0600
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
Subject: Re: [PATCH 1/2] arm64: dts: sdm845: Add rpmh-rsc node
Message-ID: <20180618212414.GI21724@codeaurora.org>
References: <20180618205616.102750-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180618205616.102750-1-dianders@chromium.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18 2018 at 14:56 -0600, Douglas Anderson wrote:
>This adds the rpmh-rsc node to sdm845 based on the examples in the
>bindings.
>
>Signed-off-by: Douglas Anderson <dianders@chromium.org>
>---
>
> arch/arm64/boot/dts/qcom/sdm845.dtsi | 19 +++++++++++++++++++
> 1 file changed, 19 insertions(+)
>
>diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>index cd308b84bed7..19b006293d3b 100644
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
>+			qcom,tcs-config = <SLEEP_TCS   3>,
>+					  <WAKE_TCS    3>,
>+					  <ACTIVE_TCS  2>,
>+					  <CONTROL_TCS 1>;
Sorry, my example had this incorrect order and I just noticed this. We
will need to fix the example as well.

The first TCS should be ACTIVE_TCS, then followed by SLEEP_TCS and
WAKE_TCS. This order is important and should match what is set in the
firmware.

 qcom,tcs-config = <ACTIVE_TCS  2>,
                   <SLEEP_TCS   3>,
		   <WAKE_TCS    3>,
		   <CONTROL_TCS 1>;

While the above configuration would work for now, it would fail, when we
enable system low power modes, which would use TCSes 2-7 for sleep and
wake set transitions from the firmware.

Thanks,
Lina

>+		};
>+
> 		intc: interrupt-controller@17a00000 {
> 			compatible = "arm,gic-v3";
> 			#address-cells = <1>;
>--
>2.18.0.rc1.244.gcf134e6275-goog
>
