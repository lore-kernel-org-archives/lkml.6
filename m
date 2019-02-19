Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64744C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 06:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32031217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 06:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="l0QWSziy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfBSGez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 01:34:55 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6253 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfBSGez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 01:34:55 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6ba3950000>; Mon, 18 Feb 2019 22:35:01 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 18 Feb 2019 22:34:54 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 18 Feb 2019 22:34:54 -0800
Received: from [10.19.225.182] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 19 Feb
 2019 06:34:51 +0000
Subject: Re: [PATCH v1 04/12] of: Add bindings of gpu hw throttle for Tegra
 soctherm
To:     Rob Herring <robh@kernel.org>
CC:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <edubezval@gmail.com>, <linux-tegra@vger.kernel.org>,
        <rui.zhang@intel.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1545118484-23641-1-git-send-email-wni@nvidia.com>
 <1545118484-23641-6-git-send-email-wni@nvidia.com>
 <20190218203314.GB12911@bogus>
From:   Wei Ni <wni@nvidia.com>
Message-ID: <739a8c81-ee0a-999e-0508-6aa1fba768b7@nvidia.com>
Date:   Tue, 19 Feb 2019 14:34:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190218203314.GB12911@bogus>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550558101; bh=lMyRkFnAKSsRtBDD2Dex8CEHndahW7hVQnj8pbytrG4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=l0QWSziy+pL6smZeg4Lhr6+/W0dsKM1BNWiXA+JZq2v6p9QWQ0uqciJEs/rk0U80T
         yi6w3iPYdaOi4Vt6euAZYyZ4zimKmbOtilJpHx8asMyRNqD+8myngm4Fs/disgs5os
         Go/LSnq/Gq2petMY3GcXqJAsjwdZi38SEaFN65evrVGNxCp5EcUrhyjxDMQf34lRXU
         OgxFbAhw98yNxElIuTJXWLHSqrPs2Lgi+1mJD65gLPY1FLalEd/Xd/0BqEvcIieMex
         1LTvqgq0F0Ww9Yq+jqKaelEL7OMaZnsV9jy07BbQt/RbMtOnPqe9TAnpDIRvMv/0jb
         ouyNrg+Dypkpg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/2/2019 4:33 AM, Rob Herring wrote:
> On Tue, Dec 18, 2018 at 03:34:36PM +0800, Wei Ni wrote:
>> Add "nvidia,gpu-throt-level" property to set gpu hw
>> throttle level.
>>
>> Signed-off-by: Wei Ni <wni@nvidia.com>
>> ---
>>  .../bindings/thermal/nvidia,tegra124-soctherm.txt  | 17 +++++++++++++++--
>>  include/dt-bindings/thermal/tegra124-soctherm.h    | 22 ++++++++++++++++++----
>>  2 files changed, 33 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
>> index ab66d6feab4b..cf6d0be56b7a 100644
>> --- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
>> +++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
>> @@ -52,6 +52,15 @@ Required properties :
>>          Must set as following values:
>>          TEGRA_SOCTHERM_THROT_LEVEL_LOW, TEGRA_SOCTHERM_THROT_LEVEL_MED
>>          TEGRA_SOCTHERM_THROT_LEVEL_HIGH, TEGRA_SOCTHERM_THROT_LEVEL_NONE
>> +      - nvidia,gpu-throt-level: This property is for Tegra124 and Tegra210.
> 
> Also, why not just use percents like nvidia,cpu-throt-percent?

Hi Rob,
We have to use "-level" for gpu throttle, can't use percents. It's
designed by hardware.
BTW, for the cpu-throt, it use "-level" for t132, and use "-percent" for
t124 and t210.

Thanks.
Wei.

> 
>> +        It is the level of pulse skippers, which used to throttle clock
>> +        frequencies. It indicates gpu clock throttling depth and can be
>> +        programmed to any of the following values which represent a throttling
>> +        percentage:
>> +        TEGRA_SOCTHERM_THROT_LEVEL_NONE (0%)
>> +        TEGRA_SOCTHERM_THROT_LEVEL_LOW (50%),
>> +        TEGRA_SOCTHERM_THROT_LEVEL_MED (75%),
>> +        TEGRA_SOCTHERM_THROT_LEVEL_HIGH (85%).
>>        - #cooling-cells: Should be 1. This cooling device only support on/off state.
>>          See ./thermal.txt for a description of this property.
