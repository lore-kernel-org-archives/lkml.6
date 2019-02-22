Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7838C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80B14207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="JZqGxsPC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfBVAwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 19:52:24 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:4676 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfBVAwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 19:52:23 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6f47ce0000>; Thu, 21 Feb 2019 16:52:31 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 21 Feb 2019 16:52:22 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 21 Feb 2019 16:52:22 -0800
Received: from [172.17.136.14] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 22 Feb
 2019 00:52:22 +0000
Subject: Re: [PATCH V3] arm64: tegra: add topology data for Tegra194 cpu
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190213081252.GA647@ulmo>
 <1550075622-1072-1-git-send-email-byan@nvidia.com>
X-Nvconfidentiality: public
From:   Bo Yan <byan@nvidia.com>
Message-ID: <c70c91f6-b719-cb86-2fe1-e6231c089ce9@nvidia.com>
Date:   Thu, 21 Feb 2019 16:52:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550075622-1072-1-git-send-email-byan@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550796751; bh=kaFeCAeiQE6H2VW9/YAxCoEcwKzsTPPj/vBN81xJ1QM=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=JZqGxsPCEB4Yog6e2pxd4YUWRb1NQjZ7Gi1ePnwSFhqi2+3y3xQZsEKOsRFt6WsV0
         nWAO+ecJhBc7AE+9/mLx+byD2mfz9xnMmz+orZ6Esc6xUybBwvKcBD+G/iLOzPPjT0
         Rmk2UmuFAdAmG1IS4he0ZXbeAdQS5bKfnOiDdU1lybRUSWVF//Ko45Elopv7BlUu11
         BTdyacg+KmV5/Mtnxif5bqZzxTJoDCE/yw2c+twaBWE8l2bEW0cA/MHN0BBv8Ejq1U
         srl7b3Q/oXIUHHiYXA1YMcqo6zmHZm0VYaK+wDYDzSqsGFomnrNdmpY6119dxmRFpi
         eUIEfKIbqtjkw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch V3 adopted changes suggested by Thierry.


On 2/13/19 8:33 AM, Bo Yan wrote:
> The xavier CPU architecture includes 8 CPU cores organized in
> 4 clusters. Add cpu-map data for topology initialization, this
> fixes the topology information in
> /sys/devices/system/cpu/cpu[n]/topology
> 
> Signed-off-by: Bo Yan <byan@nvidia.com>
> ---
> V3: Replaced phandles with full path to CPU node
> V2: remove cache nodes, add topology data only
> 
>   arch/arm64/boot/dts/nvidia/tegra194.dtsi | 42 ++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> index 6dfa1ca..708d20c 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> @@ -870,6 +870,48 @@
>   		#address-cells = <1>;
>   		#size-cells = <0>;
>   
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&{/cpus/cpu@0}>;
> +				};
> +
> +				core1 {
> +					cpu = <&{/cpus/cpu@1}>;
> +				};
> +			};
> +
> +			cluster1 {
> +				core0 {
> +					cpu = <&{/cpus/cpu@2}>;
> +				};
> +
> +				core1 {
> +					cpu = <&{/cpus/cpu@3}>;
> +				};
> +			};
> +
> +			cluster2 {
> +				core0 {
> +					cpu = <&{/cpus/cpu@4}>;
> +				};
> +
> +				core1 {
> +					cpu = <&{/cpus/cpu@5}>;
> +				};
> +			};
> +
> +			cluster3 {
> +				core0 {
> +					cpu = <&{/cpus/cpu@6}>;
> +				};
> +
> +				core1 {
> +					cpu = <&{/cpus/cpu@7}>;
> +				};
> +			};
> +		};
> +
>   		cpu@0 {
>   			compatible = "nvidia,tegra194-carmel", "arm,armv8";
>   			device_type = "cpu";
> 
