Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572AAC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067CF21533
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:43:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 067CF21533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbeI0XC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:02:27 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46434 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbeI0XC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:02:26 -0400
Received: by mail-oi1-f193.google.com with SMTP id k64-v6so2712710oia.13;
        Thu, 27 Sep 2018 09:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WiTrU+Kq7H1VsKaSHOUODjJyDX778HcRscqjH1ffkQg=;
        b=sIjgq3ci8C6o6q2a6zptlD5Ce4Zkauac6nWTyMWMzWyka+evX+vr/LLVSxrS688v1x
         mncsxGjQnDZlyypkvf+8ULcm91jdqhCSsRr6etFK11mdGOc5RyKkjd/c89laq/XgVUl7
         kBWuN7BdkYSRKhwkeXTZ5L0E41ReeKxs146l8rRBmw5ph2AtEjKtokuEleufvj+T6Puq
         oiSIHEsUGI9UYm8xDOew3viCktuZea12FqDIqnisMQZGWGrZobgF/RxTctXq6bqoIR7q
         i3FMSLqxKyUpet8xP4V/qJMfAjeiOajGtmNYRGuwfbDVKpl5Ko4w2mlzG8L3jnne9yzB
         SlFQ==
X-Gm-Message-State: ABuFfogh90ref6OrpI3WV9/9SHTYvOBGnIElQKvbajkCnEmHtVIagIBh
        CkB/Zabohjxo+JWel+MCCg==
X-Google-Smtp-Source: ACcGV63ukPzaoszKiUDKUabZCYDIltQSWdPNUKWAIACJZe+3cQJVAypRbKxdmyR7jQ1zyN+0+7dNMw==
X-Received: by 2002:aca:6a95:: with SMTP id f143-v6mr3551053oic.62.1538066599250;
        Thu, 27 Sep 2018 09:43:19 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 63-v6sm2056677oti.68.2018.09.27.09.43.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 09:43:18 -0700 (PDT)
Date:   Thu, 27 Sep 2018 11:43:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, devicetree@vger.kernel.org,
        green.hu@gmail.com, palmer@sifive.com
Subject: Re: [PATCH V5 18/30] dt-bindings: csky CPU Bindings
Message-ID: <20180927164317.GA8427@bogus>
References: <cover.1537789736.git.ren_guo@c-sky.com>
 <62098e7d0a7fbdd09f44d7e23333dad258a01bd2.1537789737.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62098e7d0a7fbdd09f44d7e23333dad258a01bd2.1537789737.git.ren_guo@c-sky.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 07:39:21AM +0800, Guo Ren wrote:
> This patch adds the documentation to describe that how to add cpu nodes in
> dts for SMP.
> 
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> ---
>  Documentation/devicetree/bindings/csky/cpus.txt | 70 +++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/csky/cpus.txt
> 
> diff --git a/Documentation/devicetree/bindings/csky/cpus.txt b/Documentation/devicetree/bindings/csky/cpus.txt
> new file mode 100644
> index 0000000..ee3901d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/csky/cpus.txt
> @@ -0,0 +1,70 @@
> +==================
> +C-SKY CPU Bindings
> +==================
> +
> +The device tree allows to describe the layout of CPUs in a system through
> +the "cpus" node, which in turn contains a number of subnodes (ie "cpu")
> +defining properties for every cpu.
> +
> +Only SMP system need to care about the cpus node and single processor
> +needn't define cpus node at all.

We've generally found this is not true. Even for single core, you can 
have power domains, clocks for DVFS, etc.

> +
> +=====================================
> +cpus and cpu node bindings definition
> +=====================================
> +
> +- cpus node
> +
> +        Description: Container of cpu nodes
> +
> +        The node name must be "cpus".
> +
> +        A cpus node must define the following properties:
> +
> +        - #address-cells
> +                Usage: required
> +                Value type: <u32>
> +                Definition: must be set to 1
> +        - #size-cells
> +                Usage: required
> +                Value type: <u32>
> +                Definition: must be set to 0
> +
> +- cpu node
> +
> +        Description: Describes one of SMP cores
> +
> +        PROPERTIES
> +

You need a compatible property for cpu nodes.

> +        - device_type
> +                Usage: required
> +                Value type: <string>
> +                Definition: must be "cpu"
> +        - reg
> +                Usage: required
> +                Value type: <u32>
> +                Definition: CPU index
> +        - status:

You don't need to document status here.

> +                Usage: required
> +                Value type: <string>
> +                Definition: "ok"       means enable  the cpu-core
> +                            "disabled" means disable the cpu-core
> +
> +Example:
> +--------
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		cpu@0 {
> +			device_type = "cpu";
> +			reg = <0>;
> +			status = "ok";
> +		};
> +
> +		cpu@1 {
> +			device_type = "cpu";
> +			reg = <1>;
> +			status = "ok";
> +		};
> +	};
> -- 
> 2.7.4
> 
