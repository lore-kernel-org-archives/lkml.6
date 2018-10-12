Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5330AC6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0722150D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QUvj46lr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ceiQ8fRC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB0722150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbeJMB0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:26:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53596 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeJMB0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:26:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8983860AD8; Fri, 12 Oct 2018 17:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539366777;
        bh=du7PJrqkGUD50YQFbBoXW+9X9LDanKXmoeyCRpP3/oI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QUvj46lr2w5c7Cy/oTddu1DlUKnabDCN7IzK/gJnkYtRt4tLjONHLtY1gNsDGDwxn
         KseTG26/jsRLrrzfk6Fs9DpUjEX4eP+2TtMk4ZY3YFSd9UYxiI3QUrdjzkn902uyuX
         lndNG/7KVyraZTge7GPFHDnWmypl2psFoZ3hdTcM=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8CF996063F;
        Fri, 12 Oct 2018 17:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539366776;
        bh=du7PJrqkGUD50YQFbBoXW+9X9LDanKXmoeyCRpP3/oI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ceiQ8fRCip+ZdsX3BUoBPP0BJwBaucdXxJFbDzaNUWYzn3c8ya+iCBouqkf+Ti19P
         qqpNKa4l03sSSLTnYWm4y5Z9YgYtPGQVbFsBOeUT9bVCyOcm4If1ei0ln431cqMAER
         j+XGbe6+ItkxoEvcTAYIK3m5LfxiT4XWkTGsYHH0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8CF996063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Fri, 12 Oct 2018 11:52:55 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, rjw@rjwysocki.net, ulf.hansson@linaro.org,
        khilman@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org,
        mka@chromium.org
Subject: Re: [PATCH RFC v1 8/8] arm64: dtsi: sdm845: Add cpu power domain
 support
Message-ID: <20181012175255.GJ2371@codeaurora.org>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-9-git-send-email-rplsssn@codeaurora.org>
 <20181012173500.GB23170@e107155-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181012173500.GB23170@e107155-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12 2018 at 11:35 -0600, Sudeep Holla wrote:
>On Thu, Oct 11, 2018 at 02:50:55AM +0530, Raju P.L.S.S.S.N wrote:
>> Add cpu power domain support
>>
>> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index d3662a8..aadaa20 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -96,6 +96,7 @@
>>  			reg = <0x0 0x0>;
>>  			enable-method = "psci";
>>  			next-level-cache = <&L2_0>;
>> +			power-domains = <&cpu_pd>;
>>  			L2_0: l2-cache {
>>  				compatible = "cache";
>>  				next-level-cache = <&L3_0>;
>> @@ -111,6 +112,7 @@
>>  			reg = <0x0 0x100>;
>>  			enable-method = "psci";
>>  			next-level-cache = <&L2_100>;
>> +			power-domains = <&cpu_pd>;
>>  			L2_100: l2-cache {
>>  				compatible = "cache";
>>  				next-level-cache = <&L3_0>;
>> @@ -123,6 +125,7 @@
>>  			reg = <0x0 0x200>;
>>  			enable-method = "psci";
>>  			next-level-cache = <&L2_200>;
>> +			power-domains = <&cpu_pd>;
>>  			L2_200: l2-cache {
>>  				compatible = "cache";
>>  				next-level-cache = <&L3_0>;
>> @@ -135,6 +138,7 @@
>>  			reg = <0x0 0x300>;
>>  			enable-method = "psci";
>>  			next-level-cache = <&L2_300>;
>> +			power-domains = <&cpu_pd>;
>>  			L2_300: l2-cache {
>>  				compatible = "cache";
>>  				next-level-cache = <&L3_0>;
>> @@ -147,6 +151,7 @@
>>  			reg = <0x0 0x400>;
>>  			enable-method = "psci";
>>  			next-level-cache = <&L2_400>;
>> +			power-domains = <&cpu_pd>;
>>  			L2_400: l2-cache {
>>  				compatible = "cache";
>>  				next-level-cache = <&L3_0>;
>> @@ -159,6 +164,7 @@
>>  			reg = <0x0 0x500>;
>>  			enable-method = "psci";
>>  			next-level-cache = <&L2_500>;
>> +			power-domains = <&cpu_pd>;
>>  			L2_500: l2-cache {
>>  				compatible = "cache";
>>  				next-level-cache = <&L3_0>;
>> @@ -171,6 +177,7 @@
>>  			reg = <0x0 0x600>;
>>  			enable-method = "psci";
>>  			next-level-cache = <&L2_600>;
>> +			power-domains = <&cpu_pd>;
>>  			L2_600: l2-cache {
>>  				compatible = "cache";
>>  				next-level-cache = <&L3_0>;
>> @@ -183,6 +190,7 @@
>>  			reg = <0x0 0x700>;
>>  			enable-method = "psci";
>>  			next-level-cache = <&L2_700>;
>> +			power-domains = <&cpu_pd>;
>>  			L2_700: l2-cache {
>>  				compatible = "cache";
>>  				next-level-cache = <&L3_0>;
>> @@ -1170,6 +1178,11 @@
>>  					  <WAKE_TCS    3>,
>>  					  <CONTROL_TCS 1>;
>>
>> +			cpu_pd: power-domain-controller {
>> +				compatible = "qcom,cpu-pm-domain";
>> +				#power-domain-cells = <0>;
>> +			};
>> +
>
>After all the discussions, I see this power domain actually influence
>not just CPUs but other devices. So this should be top most power domain
>in the system with lots of devices or their power domains pointing to it.
>Why is this just pointing to cpus ?
>
The domain powers off even when devices remains powered on. The devices
themselves are not part of this domain, they have their own rails,
clocks and domains. Those domains will get powered off when the devices
are suspended or the device are not in use.

This CPU domain is responsible for setting the domain controller to
enter a low power state and in addition help lower the state of the
shared resources that are used by the devices even when the devices
themselves are powered on.

-- Lina

