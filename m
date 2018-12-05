Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58BEC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A97B2206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LFvzPh62";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lF6vCzCs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A97B2206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbeLEHHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:07:36 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:53680 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbeLEHHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 02:07:36 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8074B6063A; Wed,  5 Dec 2018 07:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543993655;
        bh=Quzb1hQwBFNtc1RbpOa/nOW0/4NTo6km/RlDjph02hk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LFvzPh62pCXLA1Si/OHj30dS8v+ZVWKNgSCg9eRS1Busm2N8DGj34RJDFdH8cu7Yk
         VbLD/vyBuVRYjn7dnFhZhJMuFRNAbVtzJ/dSDXWQItOtN1dnTQTXasWnyLFxKGOlkP
         XtyF1xIiE0IRBnCmEDoh86O+61LKFz0pC8UCa1bg=
Received: from [10.79.128.218] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 11ED560246;
        Wed,  5 Dec 2018 07:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543993654;
        bh=Quzb1hQwBFNtc1RbpOa/nOW0/4NTo6km/RlDjph02hk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lF6vCzCsIXnnvOmMe0hj9lt+I2RC1up1+Idr0oU0bRgP9GjhE51szN5fo/uwwiTWg
         +WM10nUq0L5Hi73lDChF5d1fDjx7PoCTswDUJmENNGx21wG39gN860D882IHaAH1V5
         633rzPEJe9Nzwq1dIzpMz+BiUbImwv+rHH0irm3s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 11ED560246
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v5 7/8] arm64: dts: sdm845: Add rpmh powercontroller node
To:     Stephen Boyd <sboyd@kernel.org>, andy.gross@linaro.org,
        collinsd@codeaurora.org, mka@chromium.org, robh@kernel.org,
        ulf.hansson@linaro.org, viresh.kumar@linaro.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181204052119.806-1-rnayak@codeaurora.org>
 <20181204052119.806-8-rnayak@codeaurora.org>
 <154396536335.88331.9265777410326926096@swboyd.mtv.corp.google.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <f6c6f238-0d5e-e47c-caf7-7e45bd1327dc@codeaurora.org>
Date:   Wed, 5 Dec 2018 12:37:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <154396536335.88331.9265777410326926096@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/5/2018 4:46 AM, Stephen Boyd wrote:
> Quoting Rajendra Nayak (2018-12-03 21:21:18)
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index b72bdb0a31a5..a6d0cd8d17b0 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -1324,6 +1325,56 @@
>>                                  compatible = "qcom,sdm845-rpmh-clk";
>>                                  #clock-cells = <1>;
>>                          };
>> +
>> +                       rpmhpd: power-controller {
>> +                               compatible = "qcom,sdm845-rpmhpd";
>> +                               #power-domain-cells = <1>;
>> +                               operating-points-v2 = <&rpmhpd_opp_table>;
>> +                       };
>> +
>> +                       rpmhpd_opp_table: opp-table {
> 
> This table should go somewhere else? I don't understand why it's in the
> rpmh node because it's not an rpmh device. Does it go to the root? Or
> does it go under rpmhpd itself? I'm not sure.

I could move it to root perhaps, we seem to do that atleast in the case of
GPU. The power domain bindings (Documentation/devicetree/bindings/power/power_domain.txt)
seem to suggest it can't be under the power-controller node itself.
