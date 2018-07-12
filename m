Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036ADC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B15D8208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Kg89zPZc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="c5zP3xdJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B15D8208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732395AbeGLMls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:41:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42058 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbeGLMls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:41:48 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5E1F060B7B; Thu, 12 Jul 2018 12:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531398746;
        bh=7pTDreQY2cBByzuNBupet42w4BDYYuvtkfdT9YPNbL4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Kg89zPZc4QwCoVJpRWTOk9dFiDmK0BQjGv3wpwvazbSWJqKw/foY2CZhWKtEokeAd
         V3YkqqF35nKBAHVjsAuMoEfPrAqHw+7WV2H+R7uaPsKTO84fCTQLt5kG7/n1BOGsry
         H3sO6gSC88VnLyONwOcPx4zSyKBSOaKPPyVLG4NY=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id B87EC60271;
        Thu, 12 Jul 2018 12:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531398745;
        bh=7pTDreQY2cBByzuNBupet42w4BDYYuvtkfdT9YPNbL4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c5zP3xdJqYYPTpaeo4DKEC/b00tNtrfBtH2/7XVnRkaDdjAJDtlne1AE8qUnO55tp
         QTMqH3n2w0wEKKM6VA3sosgRY1+CJTuoJFZG+rmdfeZWp1dH4tDIZRvML3KkBefAuq
         j9M2XSVsBCChxnVh/Fd045uJWfvocM7mBAlsW4Ss=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 12 Jul 2018 18:02:25 +0530
From:   Amit Nischal <anischal@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk-owner@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: clock: Introduce QCOM Graphics clock
 bindings
In-Reply-To: <153111468812.143105.11066074667783322403@swboyd.mtv.corp.google.com>
References: <1528285308-25477-1-git-send-email-anischal@codeaurora.org>
 <1528285308-25477-4-git-send-email-anischal@codeaurora.org>
 <153111468812.143105.11066074667783322403@swboyd.mtv.corp.google.com>
Message-ID: <d502fe124cb7ba447c81a2a76b925aff@codeaurora.org>
X-Sender: anischal@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-09 11:08, Stephen Boyd wrote:
> Quoting Amit Nischal (2018-06-06 04:41:47)
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.txt 
>> b/Documentation/devicetree/bindings/clock/qcom,gpucc.txt
>> new file mode 100644
>> index 0000000..e311219
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/qcom,gpucc.txt
>> @@ -0,0 +1,18 @@
>> +Qualcomm Graphics Clock & Reset Controller Binding
>> +--------------------------------------------------
>> +
>> +Required properties :
>> +- compatible : shall contain "qcom,sdm845-gpucc".
>> +- reg : shall contain base register location and length.
>> +- #clock-cells : from common clock binding, shall contain 1.
>> +- #reset-cells : from common reset binding, shall contain 1.
>> +- #power-domain-cells : from generic power domain binding, shall 
>> contain 1.
>> +
>> +Example:
>> +       gpucc: clock-controller@@5090000 {
> 
> Drop the double '@'

Oh. I will fix this in next patch series.

> 
>> +               compatible = "qcom,sdm845-gpucc";
>> +               reg = <0x5090000 0x9000>;
>> +               #clock-cells = <1>;
>> +               #reset-cells = <1>;
>> +               #power-domain-cells = <1>;
>> +       };
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
