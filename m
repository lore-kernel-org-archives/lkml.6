Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4FC80C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC21208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ExRIGerS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Tnx5f9T3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC21208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754693AbeFNG0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:26:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51804 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752681AbeFNG0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:26:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 156E2607BB; Thu, 14 Jun 2018 06:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528957591;
        bh=ZVzD3EdpIsUtJ8v6h64nmHCaDx8IiWwVOSp/VNaWKso=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ExRIGerSNo136inRrN/LvdUHg2dDWriXC/p+5FnDP6zPy5XgNLhKAA7ENL4nraL3K
         S+PZGPrmzLSW6rfLjoIu2I1HmsdY1ZsD6cemwjbHEWoMrSRHWG0YS5puQdq022VSQK
         hHjLNTfJoql/WXEJIj7Ba63+n4zJiaqGMM7Nm0f0=
Received: from [10.79.40.88] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C205D601D2;
        Thu, 14 Jun 2018 06:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528957590;
        bh=ZVzD3EdpIsUtJ8v6h64nmHCaDx8IiWwVOSp/VNaWKso=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Tnx5f9T3SkuqNECKyAZ+7IlZiovFDO2pXimP99iuz8cfJigjJPmS6d+cMI2sr0k34
         anRFYuSWtVweM70sxhlCtSGgMARZAEtU3tg7jFZSXBPtq1h7sjf31MjNg7rX62xVEX
         SNJ5gx+Qw8+D/cDAukMZHmhxY4RO8AVnuGeJ5UhQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C205D601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v3 5/7] dt-bindings: power: Add qcom rpmh power domain
 driver bindings
To:     David Collins <collinsd@codeaurora.org>, viresh.kumar@linaro.org,
        sboyd@kernel.org, andy.gross@linaro.org, ulf.hansson@linaro.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180612044052.4402-1-rnayak@codeaurora.org>
 <20180612044052.4402-6-rnayak@codeaurora.org>
 <ca7fd33a-5ecd-203e-4a83-09c4f1074c2e@codeaurora.org>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <383ec081-d03b-5d71-3f28-9be31a3356d9@codeaurora.org>
Date:   Thu, 14 Jun 2018 11:56:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <ca7fd33a-5ecd-203e-4a83-09c4f1074c2e@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 06/14/2018 03:42 AM, David Collins wrote:
> Hello Rajendra,
> 
> On 06/11/2018 09:40 PM, Rajendra Nayak wrote:
>> Add DT bindings to describe the rpmh powerdomains found on Qualcomm
> 
> s/powerdomains/power domains/
> 
>> Technologies, Inc. SoCs. These power domains communicate a performance
>> state to RPMh, which then translates it into corresponding voltage on
>> a PMIC rail.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---
>>  .../devicetree/bindings/power/qcom,rpmhpd.txt | 65 +++++++++++++++++++
>>  1 file changed, 65 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/qcom,rpmhpd.txt
> 
> include/dt-bindings/power/qcom-rpmhpd.h from patch 6/7 should be moved to
> this patch.

right, Rob mentioned this too, I will move it in v4.

> 
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
>> + - power-domain-cells: number of cells in power domain specifier
>> +	must be 1
>> + - operating-points-v2: Phandle to the OPP table for the power-domain.
>> +	Refer to Documentation/devicetree/bindings/power/power_domain.txt
>> +	and Documentation/devicetree/bindings/opp/qcom-opp.txt for more details
> 
> Could you please mention here that qcom,level properties in the associated
> opp-table should use the RPMH_REGULATOR_LEVEL_* constants?  RPMh ARC
> resources depend upon the RPMH_REGULATOR_LEVEL_* constants to provide a
> mapping of levels supported by hardware.
> 
>> +Example:
> 
> Could you please add this here?
> 
> #include <dt-bindings/power/qcom-rpmhpd.h>

I will, I wasn't sure its okay to reference a kernel include file in a DT
binding documentation. But looking around it seems like its common practice.

> 
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
> 
> As per qcom-opp.txt, 'qcom,level' should be used, not 'qcom-level'.

d'oh! I just keep getting this wrong.

> 
> Where is the qcom-opp.txt patch?  It isn't part of the v3 patch series but
> was in the v2 series [1].

Oops, looks like I accidentally dropped it in v3 :(

> 
> Could you please change this to be the following?
> 
>     qcom,level = <RPMH_REGULATOR_LEVEL_RETENTION>;
> 
> Also, please use the level constants for all other subnodes in this
> example as well.
> 
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
> 
> Could you please add an example consumer DT node as well which uses
> "SDM845 Power Domain Indexes" from qcom-rpmhpd.h?  It isn't clear how a
> specific power domain (e.g. SDM845_CX) is specified from the consumer
> side.  It also isn't clear how the consumer specifies a mapping for the
> power domain levels that it will be using.

I can add an example consumer with a power-domains property pointing to
the phandle and index (as is general practice)

For specifying the power domain levels, I am not quite sure what the approach
we would use. One way is for consumers to use OPP bindings, but that wasn't
liked by some and we now have plans to stuff it all within the clock driver code.
In which case I expect we would just maintain internal mapping tables for clock
frequencies/power domain levels so nothing comes in from DT, or maybe it will
come in from DT, i just don't know.

I can certainly describe the OPP way a consumer could map to a power domain level,
but I am not sure how the clock bindings if any would be at this point to handle this.

regards,
Rajendra

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
