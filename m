Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7726C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BBE120675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547583731;
	bh=+lLbNyssG+lmA1iUvuj6qhj58csI3ycuNcDAA8vH9/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EIqdX6B6qgen+qCLAhpBGOabRfJZuoqsDOgJvH464MShHD5q2SIuIgzPKC1JTCxwt
	 Zj7neCH+rhZRK97ptf7Ha+aNO4OqqdR5ccYcpAadMurmq8cm+BFX39J9lfdpPUCNTW
	 TEgsbReGCJ0gXt10JuwW02v39zrvKwLrpuros1uY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389795AbfAOUWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 15:22:09 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39417 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728612AbfAOUWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 15:22:09 -0500
Received: by mail-ot1-f67.google.com with SMTP id n8so3761375otl.6;
        Tue, 15 Jan 2019 12:22:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gIF5aZTkP+Qm5Q6mldfTXdb1D00mW0Aqd5WvmEszGRU=;
        b=crg/650g+yEuL3gD7s7C2D1ZviZPO2Zj/1tSe1qMd4cpHYaZAGxV6UOtPgr42s07Tw
         AuA28jN5jeKizy5Ycnb9iyQYHysrunaosxnIcaP55z8fSmT4VdtHXD+05MvuhXUZzmup
         C+2JfSnyD19xzlV/dtCjaydSxz1DDOqFnwpmkfAT75ZGJ2h8KaV2Ag5PqsRq9woGZKj4
         CgLE1z7tX/XISace0jhGw40DrzLRbVHXXRdpNfGBoDHLci9QftPZciyVFqK33Ys8DwjT
         oeIR/oKGUJzC9BIWMSOS7HwOyIDFnxk9HHmTWVF4x1dlxxkqnbS10pX/FNWAF73H4gxn
         p90g==
X-Gm-Message-State: AJcUukdTYs3XufYdgvyTBkevxVWjwZDlKyEKIlzdmmoQgUzeCYsiGXnc
        ihX81HXJ8KVzPvD06WeF/A==
X-Google-Smtp-Source: ALg8bN5RrZxJT7fSw3sELrWpi92oP8IYY4Uw3miPeZxOGLvYXhOcCddaG1BLMYj0qb0FhGUNR0/AmQ==
X-Received: by 2002:a9d:7b42:: with SMTP id f2mr3118397oto.184.1547583728120;
        Tue, 15 Jan 2019 12:22:08 -0800 (PST)
Received: from localhost ([70.231.7.113])
        by smtp.gmail.com with ESMTPSA id i7sm1659764oth.57.2019.01.15.12.22.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 12:22:07 -0800 (PST)
Date:   Tue, 15 Jan 2019 14:22:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, bkumar@qti.qualcomm.com,
        linux-arm-msm@vger.kernel.org, thierry.escande@linaro.org
Subject: Re: [PATCH v3 1/5] misc: dt-bindings: Add Qualcomm Fastrpc bindings
Message-ID: <20190115202206.GA4849@bogus>
References: <20190114194112.32567-1-srinivas.kandagatla@linaro.org>
 <20190114194112.32567-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114194112.32567-2-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 07:41:08PM +0000, Srinivas Kandagatla wrote:
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
>  .../devicetree/bindings/misc/qcom,fastrpc.txt | 84 +++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt b/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
> new file mode 100644
> index 000000000000..004e636b4133
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
> @@ -0,0 +1,84 @@
> +Qualcomm Technologies, Inc. FastRPC Driver
> +
> +The FastRPC driver implements an IPC (Inter-Processor Communication)

driver or this is a h/w block?

> +mechanism that allows for clients to transparently make remote method
> +invocations across DSP and APPS boundaries. This enables developers
> +to offload tasks to the DSP and free up the application processor for
> +other tasks.
> +
> +- compatible:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "qcom,fastrpc"
> +
> +- label
> +	Usage: required
> +	Value type: <string>
> +	Definition: should specify the dsp domain name this fastrpc
> +	corresponds to. must be one of this: "adsp", "mdsp", "sdsp", "cdsp"
> +
> +- #address-cells
> +	Usage: required
> +	Value type: <u32>
> +	Definition: Must be 1
> +
> +- #size-cells
> +	Usage: required
> +	Value type: <u32>
> +	Definition: Must be 0
> +
> += COMPUTE BANKS
> +Each subnode of the Fastrpc node represents compute context banks available
> +on the dsp. The name of the nodes are not important. The properties of these

Please specify what the node names are.

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

What does 'secured' mean here?

> +
> +- nsessions:
> +	Usage: Optional
> +	Value type: <u32>
> +	Defination: A value indicating how many sessions can share this
> +		    context bank. Defaults to 1 when this property
> +		    is not specified.

Needs a vendor prefix.

> +
> +Example:
> +
> +adsp-pil {
> +	compatible = "qcom,msm8996-adsp-pil";
> +	...
> +	smd-edge {
> +		label = "lpass";
> +		fastrpc {
> +			compatible = "qcom,fastrpc";
> +			qcom,smd-channels = "fastrpcsmd-apps-dsp";
> +			lable = "adsp";

typo.

> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			cb@1 {
> +				compatible = "qcom,fastrpc-compute-cb";
> +				reg = <1>;
> +			};
> +
> +			cb@2 {
> +				compatible = "qcom,fastrpc-compute-cb";
> +				reg = <2>;
> +			};
> +			...
> +		};
> +	};
> +};
> -- 
> 2.20.1
> 
