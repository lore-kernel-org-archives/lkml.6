Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id ED096C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 06:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988AF20660
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 06:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LgYGynT/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="N1ZczXQA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 988AF20660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932808AbeFLGk5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 02:40:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45020 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753676AbeFLGkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 02:40:55 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 04671606DB; Tue, 12 Jun 2018 06:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528785655;
        bh=grMj8J8UA3dTeNb+8E3z784a6QVuTZsJ28zXykPy2OE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LgYGynT/+wxD6sNihbS9eW4Y0YB2fp3qKY4QSlLdZomxKW5RDckNO4y7MgkXvboV8
         gp0nhrVtcoYt0pwhxkZ13++jtJXE+eiDw118fAYoLtlZ8lApPLxcbuPQt6OpIjj5TH
         W0yPhsnPpsgOb3bgo9ZA8K0YhQF3DV7I8xoF0LFY=
Received: from [10.79.40.88] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 03D40602BD;
        Tue, 12 Jun 2018 06:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528785654;
        bh=grMj8J8UA3dTeNb+8E3z784a6QVuTZsJ28zXykPy2OE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=N1ZczXQAlx/bXC3XcJNAVQz1fxr/kBDPNu5PX6v98i5H6VRXHKg3pfDGiF1Ogy4dx
         /KnqiurHzZYb2Dz1C78wJFQZSKCy/LndueeVBLm+ZJ0w8BhtljL8fw8KwS3HyKTwLi
         MArZacmH4Lu66tdyzb1EfbPWJRyscMQvKYLwy9Ic=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 03D40602BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v3 5/7] dt-bindings: power: Add qcom rpmh power domain
 driver bindings
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        ulf.hansson@linaro.org, collinsd@codeaurora.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180612044052.4402-1-rnayak@codeaurora.org>
 <20180612044052.4402-6-rnayak@codeaurora.org>
 <20180612053953.GA18050@builder>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <8aae8809-77e0-9aa7-0c90-1e6d956ab81e@codeaurora.org>
Date:   Tue, 12 Jun 2018 12:10:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180612053953.GA18050@builder>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/12/2018 11:09 AM, Bjorn Andersson wrote:
> On Mon 11 Jun 21:40 PDT 2018, Rajendra Nayak wrote:
> 
>> Add DT bindings to describe the rpmh powerdomains found on Qualcomm
>> Technologies, Inc. SoCs. These power domains communicate a performance
>> state to RPMh, which then translates it into corresponding voltage on
>> a PMIC rail.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---
>>  .../devicetree/bindings/power/qcom,rpmhpd.txt | 65 +++++++++++++++++++
>>  1 file changed, 65 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/qcom,rpmhpd.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmhpd.txt b/Documentation/devicetree/bindings/power/qcom,rpmhpd.txt
>> new file mode 100644
>> index 000000000000..41ef7afa6b24
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/qcom,rpmhpd.txt
>> @@ -0,0 +1,65 @@
>> +Qualcomm RPMh Power domains
>> +
>> +For RPMh Power domains, we communicate a performance state to RPMh
>> +which then translates it into a corresponding voltage on a rail
>> +
>> +Required Properties:
>> + - compatible: Should be one of the following
>> +	* qcom,sdm845-rpmhpd: RPMh Power domain for the sdm845 family of SoC
> 
> Afaict this binding is identical to the one introduced in patch 1, so I
> would suggest that you just add the compatible there.

Sure, makes sense. thanks.

> 
> Regards,
> Bjorn
> 
>> + - power-domain-cells: number of cells in power domain specifier
>> +	must be 1
>> + - operating-points-v2: Phandle to the OPP table for the power-domain.
>> +	Refer to Documentation/devicetree/bindings/power/power_domain.txt
>> +	and Documentation/devicetree/bindings/opp/qcom-opp.txt for more details
>> +
>> +Example:
>> +
>> +	rpmhpd: power-controller {
>> +		compatible = "qcom,sdm845-rpmhpd";
>> +		#power-domain-cells = <1>;
>> +		operating-points-v2 = <&rpmhpd_opp_table>;
>> +	};
>> +
>> +	rpmhpd_opp_table: opp-table {
>> +		compatible = "operating-points-v2-qcom-level";
>> +
>> +		rpmhpd_opp_ret: opp1 {
>> +			qcom-level = <16>;
>> +		};
>> +
>> +		rpmhpd_opp_min_svs: opp2 {
>> +			qcom-level = <48>;
>> +		};
>> +
>> +		rpmhpd_opp_low_svs: opp3 {
>> +			qcom-level = <64>;
>> +		};
>> +
>> +		rpmhpd_opp_svs: opp4 {
>> +			qcom-level = <128>;
>> +		};
>> +
>> +		rpmhpd_opp_svs_l1: opp5 {
>> +			qcom-level = <192>;
>> +		};
>> +
>> +		rpmhpd_opp_nom: opp6 {
>> +			qcom-level = <256>;
>> +		};
>> +
>> +		rpmhpd_opp_nom_l1: opp7 {
>> +			qcom-level = <320>;
>> +		};
>> +
>> +		rpmhpd_opp_nom_l2: opp8 {
>> +			qcom-level = <336>;
>> +		};
>> +
>> +		rpmhpd_opp_turbo: opp9 {
>> +			qcom-level = <384>;
>> +		};
>> +
>> +		rpmhpd_opp_turbo_l1: opp10 {
>> +			qcom-level = <416>;
>> +		};
>> +	};
>> -- 
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
>> of Code Aurora Forum, hosted by The Linux Foundation
>>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
