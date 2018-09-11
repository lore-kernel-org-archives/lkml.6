Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BB7C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E4220880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83E4220880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbeIKWO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 18:14:56 -0400
Received: from foss.arm.com ([217.140.101.70]:46982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728122AbeIKWOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 18:14:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAAB37A9;
        Tue, 11 Sep 2018 10:14:36 -0700 (PDT)
Received: from [10.37.8.51] (unknown [10.37.8.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C3D23F703;
        Tue, 11 Sep 2018 10:14:33 -0700 (PDT)
Subject: Re: [PATCH 11/11] dts: tc2: Update coresight bindings for hardware
 ports
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, frowand.list@gmail.com,
        devicetree@vger.kernel.org, mathieu.poirier@linaro.org,
        arm@kernel.org, Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
 <1536661032-30481-12-git-send-email-suzuki.poulose@arm.com>
 <20180911170113.GA27663@e107155-lin>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <fbde78a0-6487-7bdb-d02b-4fbf556f536e@arm.com>
Date:   Tue, 11 Sep 2018 18:15:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180911170113.GA27663@e107155-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2018 06:01 PM, Sudeep Holla wrote:
> On Tue, Sep 11, 2018 at 11:17:12AM +0100, Suzuki K Poulose wrote:
>> Switch to the new coresight bindings
>>
> 
> I still see the below warnings:
> 
> vexpress-v2p-ca15_a7.dtb: Warning (graph_child_address):
> 	/replicator/in-ports: graph node has single child node 'port@0',
> 	#address-cells/#size-cells are not necessary
> vexpress-v2p-ca15_a7.dtb: Warning (graph_child_address):
> 	/funnel@20040000/out-ports: graph node has single child node 'port@0',
> 	#address-cells/#size-cells are not necessary
> 
> I need the below patch to fix them, let me know if it looks OK, I can
> amend and apply.

Thanks for reporting. I purposefully added the "address-cells" and 
followed the format everywhere in the series thinking that, that is
indeed the formal way of doing it, rather than having implicit port
numbers. I can send an updated series fixing it everywhere.

Regards
Suzuki


> 
> Regards,
> Sudeep
> 
> -->8
> 
> diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
> index 3a5090616bc6..8b926c30ccd1 100644
> --- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
> +++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
> @@ -443,11 +443,7 @@
>   		};
>   
>   		in-ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			port@0 {
> -				reg = <0>;
> +			port {
>   				replicator_in_port0: endpoint {
>   					remote-endpoint = <&funnel_out_port0>;
>   				};
> @@ -462,11 +458,7 @@
>   		clocks = <&oscclk6a>;
>   		clock-names = "apb_pclk";
>   		out-ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			port@0 {
> -				reg = <0>;
> +			port {
>   				funnel_out_port0: endpoint {
>   					remote-endpoint =
>   						<&replicator_in_port0>;
> 

