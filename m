Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF09C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 991142083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:23:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991142083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbeLGSXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:23:35 -0500
Received: from foss.arm.com ([217.140.101.70]:51464 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbeLGSXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:23:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA277EBD;
        Fri,  7 Dec 2018 10:23:34 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC9A93F5AF;
        Fri,  7 Dec 2018 10:23:32 -0800 (PST)
Date:   Fri, 7 Dec 2018 18:23:27 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        bkumar@qti.qualcomm.com, thierry.escande@linaro.org
Subject: Re: [PATCH v2 1/6] misc: dt-bindings: Add Qualcomm Fastrpc bindings
Message-ID: <20181207182327.64mtkfx6v4wlwccz@lakrids.cambridge.arm.com>
References: <20181207163513.16412-1-srinivas.kandagatla@linaro.org>
 <20181207163513.16412-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207163513.16412-2-srinivas.kandagatla@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 04:35:08PM +0000, Srinivas Kandagatla wrote:
> The FastRPC driver implements an IPC (Inter-Processor Communication)
> mechanism that allows for clients to transparently make remote method
> invocations across DSP and APPS boundaries. This enables developers
> to offload tasks to the DSP and free up the application processor for
> other tasks.
> 
> Co-developed-by: Thierry Escande <thierry.escande@linaro.org>
> Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/misc/qcom,fastrpc.txt | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt b/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
> new file mode 100644
> index 000000000000..06e8c25839d5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
> @@ -0,0 +1,73 @@
> +Qualcomm Technologies, Inc. FastRPC Driver
> +
> +The FastRPC driver implements an IPC (Inter-Processor Communication)
> +mechanism that allows for clients to transparently make remote method
> +invocations across DSP and APPS boundaries. This enables developers
> +to offload tasks to the DSP and free up the application processor for
> +other tasks.

Which hardware does this node represent?

If this is functionality provided by another block of hardware (i.e. the
DSPs themselves), it would be better to have nodes for them.

> +
> +- compatible:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "qcom,fastrpc"
> +
> +- reg
> +	Usage: required
> +	Value type: <u32>
> +	Definition: DSP Processor ID.
> +	Possible values are :
> +			0 - ADSP
> +			1 - MDSP
> +			2 - SDSP
> +			3 - CDSP

Why is this in a reg?

To be, a phandle to the relevant DSP would seem better.

> +
> += COMPUTE BANKS
> +Each subnode of the Fastrpc node represents compute context banks available
> +on the dsp. The name of the nodes are not important. The properties of these
> +nodes are defined by the individual bindings for the specific service
> +- All Compute context banks MUST contain the following property:
> +
> +- compatible:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "qcom,fastrpc-compute-cb"
> +
> +- reg
> +	Usage: required
> +	Value type: <u32>
> +	Definition: Context Bank ID.
> +
> +- secured:
> +	Usage: Optional
> +	Value type: <boolean>
> +	Defination: Indicating context bank is secured

In what sense?

Does this mean Secure / Non-secure in the TrustZone sense?

> +
> +- nsessions:
> +	Usage: Optional
> +	Value type: <u32>
> +	Defination: A value indicating how many sessions can share this
> +		    context bank. Defaults to 'One' when this property
> +		    is not specified.

Presumably the default is 1, rather than 'One'.

What is a session? How do there share a context bank?

> +
> +Example:
> +
> +fastrpc {
> +	compatible = "qcom,fastrpc";
> +	qcom,smd-channels = "fastrpcsmd-apps-dsp";
> +	reg = <0>; /* DOMAIN_ADSP */
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	cb@1 {
> +		compatible = "qcom,fastrpc-compute-cb";
> +		reg = <1>;
> +		iommus = <&lpass_q6_smmu 1>;

These iommus should be associated with the device (i.e. the DSP itself).

Thanks,
Mark.

> +	};
> +
> +	cb@2 {
> +		compatible = "qcom,fastrpc-compute-cb";
> +		reg = <2>;
> +		iommus = <&lpass_q6_smmu 2>;
> +	};
> +	...
> +};
> -- 
> 2.19.2
> 
