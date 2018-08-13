Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D07FC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C5B217BC
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Cqr8jFjK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mKpyXItJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C5B217BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730913AbeHMWZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 18:25:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49296 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729990AbeHMWZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 18:25:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 788B7608C9; Mon, 13 Aug 2018 19:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534189314;
        bh=Z1pwl6YpK+RNK+ZfTUHyTzqH23bcLmuRWvulf9EHyQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cqr8jFjKTP+gGSl5BaRAnt7t4UCVsiYY9UxpTbD/gLGdQsEvedB0gsGhFi9i9/p/d
         xQ3ZjgWRO3L83A5T35XNsQ1fZ1UXa1KzSJsju5AXF3orXgLoCkzNty9ISWtRK0D9pa
         DWiBxFHcP9oheMoDND1mG6i6xRrClcS4OpNHUadM=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B6D6B60214;
        Mon, 13 Aug 2018 19:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534189313;
        bh=Z1pwl6YpK+RNK+ZfTUHyTzqH23bcLmuRWvulf9EHyQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mKpyXItJ2b9j4+/bbdmYS+nL/Beq0A2EzSv4GL6KtZAMVv9z6t96Hh/Zx3netJzmK
         1y8u2Ejehxa1EqMut2BFT1ifhlZiRkE8fgRpYPRp94aEytp4JBIb4+7HnNUDHMZUMN
         3szo1HwvguaO2Vmdo3b3YoDcn9qZgWL0h/HW8ChQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B6D6B60214
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Mon, 13 Aug 2018 13:41:52 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     swboyd@chromium.org, evgreen@chromium.org,
        linus.walleij@linaro.org, bjorn.andersson@linaro.org,
        rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND RFC 2/4] drivers: pinctrl: qcom: add wakeup gpio
 map for sdm845
Message-ID: <20180813194152.GG5081@codeaurora.org>
References: <20180801020021.9782-1-ilina@codeaurora.org>
 <20180801020021.9782-3-ilina@codeaurora.org>
 <8636vyxyub.wl-marc.zyngier@arm.com>
 <20180801200405.GB6422@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180801200405.GB6422@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01 2018 at 14:04 -0600, Lina Iyer wrote:
>On Wed, Aug 01 2018 at 02:42 -0600, Marc Zyngier wrote:
>>On Wed, 01 Aug 2018 03:00:19 +0100,
>>Lina Iyer <ilina@codeaurora.org> wrote:
>>>
>>>Add GPIO to PDC pin map for the SDM845 SoC.
>>>
>>>Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>>>---
>>> drivers/pinctrl/qcom/pinctrl-sdm845.c | 76 +++++++++++++++++++++++++++
>>> 1 file changed, 76 insertions(+)
>>>
>>>diff --git a/drivers/pinctrl/qcom/pinctrl-sdm845.c b/drivers/pinctrl/qcom/pinctrl-sdm845.c
>>>index 2ab7a8885757..e93660922dc2 100644
>>>--- a/drivers/pinctrl/qcom/pinctrl-sdm845.c
>>>+++ b/drivers/pinctrl/qcom/pinctrl-sdm845.c
>>>@@ -1277,6 +1277,80 @@ static const struct msm_pingroup sdm845_groups[] = {
>>> 	UFS_RESET(ufs_reset, 0x99f000),
>>> };
>>>
>>>+static struct msm_pinctrl_pdc_map sdm845_wakeup_gpios[] = {
>>
>>[huge array]
>>
>>>+};
>>
>>Why isn't that array part of the DT? I'd expect other SoCs to
>>eventually use a similar mechanism, no?
>>
>I agree and it should be.
>
>One place I am thinking is to add it to the DT definition of PDC
>controller as a data argument -
>
>	tlmm: pinctrl@000000{
>	[...]
>		interrupts-extended = <&pdc 30 IRQ_TYPE_LEVEL_HIGH 1>,
>                     <&pdc 31 IRQ_TYPE_LEVEL_HIGH 3>,
>		      <&pdc 32 IRQ_TYPE_LEVEL_HIGH 5>,
>						   ^
>						   |--- Provide the GPIO
>						   for the PDC pin here.
>	};
>
>	pdc: interrupt-controller@b220000 {
>		compatible = "qcom,sdm845-pdc";
>		reg = <0xb220000 0x30000>;
>		qcom,pdc-ranges = <0 512 94>, <94 641 15>, <115 662 7>;
>		#interrupt-cells = <3>; <-------- Increase this from 2 ?
>		interrupt-parent = <&intc>;
>		interrupt-controller;
>	};
>
>Would that be acceptable?
>
Any ideas on how to do this better?
>Thanks,
>Lina
