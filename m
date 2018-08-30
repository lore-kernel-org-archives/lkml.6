Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CAFC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B583F20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CwqwWRPy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="G/WTucWU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B583F20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbeH3KcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 06:32:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42374 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbeH3KcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 06:32:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2539860242; Thu, 30 Aug 2018 06:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535610708;
        bh=fkH0kA/HWLHQasSeFUKIum96DwmoNTaOEwwbXlUQ5Mo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CwqwWRPys2Tv0op3Vdtq6+qccCIWi7owsFgFAJLvPxHBv9dTW3wvWjM+7O7hdsYxt
         u9YMFAA9NWot7ZXel+H98IbFrZurp3i2OuBr5ar6Cx7QoeKAVgHoR+YJQ8e57Rzly7
         aUYW5w8C/tgQbgiTaHjmYJABj2DqryoH5YnPdimA=
Received: from [10.79.128.159] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B0DCA60388;
        Thu, 30 Aug 2018 06:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535610707;
        bh=fkH0kA/HWLHQasSeFUKIum96DwmoNTaOEwwbXlUQ5Mo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=G/WTucWUrCBXMXqPwDfuiZUrVJgBmv0ao5KAeNg19jW+IsQk/aojNIDKZHst8DHD1
         Z41q+8nC1X3QwBF6DiFHsQ06wIeHt1FssskDdgRGX2GI7c8Gwu3nJlkx322k71El6H
         gb6d7/MoCsM3pndnzi3f7t7h+hpwM3Isv6VbgUI8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B0DCA60388
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v4 2/6] dt-bindings: power: Add qcom rpm power domain
 driver bindings
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     sboyd@kernel.org, andy.gross@linaro.org, ulf.hansson@linaro.org,
        collinsd@codeaurora.org, mka@chromium.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180627045234.27403-1-rnayak@codeaurora.org>
 <20180627045234.27403-3-rnayak@codeaurora.org>
 <20180703223554.GA32313@rob-hp-laptop>
 <20180704055757.4li26b6poxllmh2k@vireshk-i7>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <1463d24b-481d-eecd-9e44-e7a5a993e5fc@codeaurora.org>
Date:   Thu, 30 Aug 2018 12:01:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180704055757.4li26b6poxllmh2k@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/4/2018 11:27 AM, Viresh Kumar wrote:
> On 03-07-18, 16:35, Rob Herring wrote:
>>> +qcom,level values specified in the OPP tables for RPMh power domains
>>> +should use the RPMH_REGULATOR_LEVEL_* constants from
>>> +<dt-bindings/power/qcom-rpmhpd.h>
>>> +
>>> +	rpmhpd: power-controller {
>>> +		compatible = "qcom,sdm845-rpmhpd";
>>> +		#power-domain-cells = <1>;
>>> +		operating-points-v2 = <&rpmhpd_opp_table>;
>>> +	};
>>> +
>>> +	rpmhpd_opp_table: opp-table {
>>> +		compatible = "operating-points-v2-qcom-level";
>>> +
>>> +		rpmhpd_opp_ret: opp1 {
>>> +			qcom,level = <RPMH_REGULATOR_LEVEL_RETENTION>;
>>> +		};
>>
>> I don't see the point in using the OPP binding here when you aren't
>> using *any* of the properties from it.
> 
> Yeah, that's the case for now. But there are cases (as Stephen
> mentioned earlier [1]) where the voltage values (and maybe other
> values like current, etc) would be known and filled in DT. And that's
> why we all agreed to use OPP tables for PM domains as well, as these
> are really "operating performance points" of these PM domains.

Rob, are you fine with these bindings then?
If so, can we please have your reviewed-by?
