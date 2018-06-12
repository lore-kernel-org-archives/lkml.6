Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C6638C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8623120693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8623120693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754449AbeFLUsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:48:07 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:34242 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754364AbeFLUsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:48:04 -0400
Received: by mail-yb0-f193.google.com with SMTP id n23-v6so132786ybg.1;
        Tue, 12 Jun 2018 13:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5Tnu/shueqjzM+SbkeJ8uoh/mxixQ9QKQTltYL7ofsk=;
        b=LqlTPjKah3HXgAz9MNlxqfhPwyawXcRr5JpR3Fp03DTgW0omYBsOPgql8C2PxGX4WZ
         z+ZOOsUhco00dOCNXkc/W5i8FM82xfks4Qd6Y2AzAGaQVt3sZ6GshwWAB40uGis/I9FV
         Tm4avlVgoCZ/zwaTeY4LBlF8/x7shpyFRiMKvPwTqLHR0Y0hmybZZSMLBdCetjnSaMVF
         jNV5C7FynFV4GdDgu4y5STpLecl9O3+lF1XrdqkMZ6EDl40fRxGa2TI3wcBd+HDR/HIq
         Xg/dLVk/V0u4YZjykbkkOs5zocc1Imh325QmS/eemGi45uJ/TP+s3reIkXZc8wcn0/XU
         7YlQ==
X-Gm-Message-State: APt69E03Np2dbTs8h4vclo8utaUAK95gKKRo6ej38x6aOXUa5+YbnNdo
        8sdQG/bWoEDiU67t5hB9lg==
X-Google-Smtp-Source: ADUXVKLphe1YTDfFMN6jhfZaQriLR1jTxCy3lLa+gQwdI9LFDRqtgPxAzJGH1Gpe3Yq8Kt75lVLtGQ==
X-Received: by 2002:a25:bd04:: with SMTP id f4-v6mr1014087ybk.3.1528836484210;
        Tue, 12 Jun 2018 13:48:04 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id n204-v6sm421431ywb.72.2018.06.12.13.48.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 13:48:03 -0700 (PDT)
Date:   Tue, 12 Jun 2018 14:48:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org,
        sudeep.holla@arm.com, mark.rutland@arm.com, frowand.list@gmail.com,
        matt.sealey@arm.com, charles.garcia-tobin@arm.com,
        john.horley@arm.com, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 6/8] dts: coresight: Clean up the device tree graph
 bindings
Message-ID: <20180612204802.GA15817@rob-hp-laptop>
References: <1527858967-16047-1-git-send-email-suzuki.poulose@arm.com>
 <1527858967-16047-7-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527858967-16047-7-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 02:16:05PM +0100, Suzuki K Poulose wrote:
> The coresight drivers relied on default bindings for graph
> in DT, while reusing the "reg" field of the "ports" to indicate
> the actual hardware port number for the connections. However,
> with the rules getting stricter w.r.t to the address mismatch
> with the label, it is no longer possible to use the port address
> field for the hardware port number. Hence, we add an explicit
> property to denote the hardware port number, "coresight,hwid"
> which must be specified for each "endpoint".
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  .../devicetree/bindings/arm/coresight.txt          | 26 +++++++++---
>  drivers/hwtracing/coresight/of_coresight.c         | 46 ++++++++++++++++------
>  2 files changed, 54 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
> index bd36e40..385581a 100644
> --- a/Documentation/devicetree/bindings/arm/coresight.txt
> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> @@ -104,7 +104,11 @@ properties to uniquely identify the connection details.
>  	"slave-mode"
>  
>   * Hardware Port number at the component:
> -     -  The hardware port number is assumed to be the address of the "port" component.
> +   - (Obsolete) The hardware port number is assumed to be the address of the "port" component.
> +   - Each "endpoint" must define the hardware port of the local end of the
> +     connection using the following property:
> +	"coresight,hwid" - 32bit integer, hardware port number at the local end.

"coresight" is not a vendor and properties are in the form 
[<vendor>,]<prop-name>.

> +
>  
>  
>  Example:
> @@ -120,6 +124,7 @@ Example:
>  			etb_in_port: endpoint@0 {

There shouldn't be a unit address here because there is no reg property.

>  				slave-mode;
>  				remote-endpoint = <&replicator_out_port0>;
> +				coresight,hwid = <0>;

It doesn't make sense for these to be in the endpoint. If you had 
multiple endpoints, then you would have to duplicate it. "ports" are 
a single data stream. "endpoints" are connections to that stream. So if 
you have a muxed (input) or fanout/1-to-many (output) connection, then 
you have multiple endpoints. 

The same applied to the slave-mode property, but that ship has sailed. 
No reason to continue that though.

>  			};
>  		};
>  	};
> @@ -134,6 +139,7 @@ Example:
>  			tpiu_in_port: endpoint@0 {
>  				slave-mode;
>  				remote-endpoint = <&replicator_out_port1>;
> +				coresight,hwid = <0>;
>  			};
>  		};
>  	};
> @@ -154,6 +160,7 @@ Example:
>  				reg = <0>;
>  				replicator_out_port0: endpoint {
>  					remote-endpoint = <&etb_in_port>;
> +					coresight,hwid = <0>;
>  				};
>  			};
>  
> @@ -161,15 +168,17 @@ Example:
>  				reg = <1>;
>  				replicator_out_port1: endpoint {
>  					remote-endpoint = <&tpiu_in_port>;
> +					coresight,hwid = <1>;
>  				};
>  			};
>  
>  			/* replicator input port */
>  			port@2 {
> -				reg = <0>;
> +				reg = <1>;

This will still get flagged as an error. reg must be 2 here.

Rob
