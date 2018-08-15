Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9E6C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01A121527
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FZhFAzN4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="S6r9s7K3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E01A121527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbeHOSdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 14:33:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52630 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729300AbeHOSdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 14:33:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5C51D602CB; Wed, 15 Aug 2018 15:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534347623;
        bh=TIls7p/nmycWqqsaOYUl2mh9MCmUI7lF2skDVyszFUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FZhFAzN47XZpNzcFa0FSoHIawvqylZm415yFt8alYkDGxR19TcvXnkr9dWfhb1tyk
         BXa9sxcmYtfvG3JZDFqtzHmUSe+SG5V4HMUoKKmwh1eY2vT0igXXKSmQMSUHhPDXZS
         iw+3tI0tfLetHM6eNHkpBO2QQQaNoHubiS6+m7x4=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8A33B621FC;
        Wed, 15 Aug 2018 15:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534347622;
        bh=TIls7p/nmycWqqsaOYUl2mh9MCmUI7lF2skDVyszFUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S6r9s7K304A4tkTCix8GtjTeYTWB2A2MZ8o2kUrqh8NvPoQWrv6d+8U+jH9QXs8u6
         UNAaTCuMVievckFY19wNEO5rsiGtDd6C7aKTn3tTAavd8ZbkMpEQR22gnIWPznl9Du
         UAkMzfqSrKahRrkaWfQVZfIC6XN6f6s1WDJFOpF4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8A33B621FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Wed, 15 Aug 2018 09:40:21 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     andy.gross@linaro.org, bjorn.andersson@linaro.org,
        marc.zyngier@arm.com, rplsssn@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, devicetree@vger.kernel.org,
        david.brown@linaro.org, evgreen@chromium.org, dianders@chromium.org
Subject: Re: [PATCH] arm64: dts: msm: add PDC device bindings for sdm845
Message-ID: <20180815154021.GN5081@codeaurora.org>
References: <20180814173058.26143-1-ilina@codeaurora.org>
 <153434688280.37448.5200368407995060713@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <153434688280.37448.5200368407995060713@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15 2018 at 09:28 -0600, Stephen Boyd wrote:
>Quoting Lina Iyer (2018-08-14 10:30:58)
>> Add PDC interrupt controller device bindings for SDM845.
>>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index 24e254efb9d1..399bfbd52c5b 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -1106,6 +1106,15 @@
>>                         };
>>                 };
>>
>> +               pdc: interrupt-controller@b220000 {
>
>Please sort this by unit address within the SoC node.
>
Ah, didn't realize that. Will fix.

-- Lina

>> +                       compatible = "qcom,sdm845-pdc";
>> +                       reg = <0xb220000 0x30000>;
>> +                       qcom,pdc-ranges = <0 512 94>, <94 641 15>, <115 662 7>;
>> +                       #interrupt-cells = <2>;
>> +                       interrupt-parent = <&intc>;
>> +                       interrupt-controller;
>> +               };
>> +
>>                 timer@17c90000 {
>>                         #address-cells = <1>;
>>                         #size-cells = <1>;
