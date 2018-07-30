Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6B6C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 20:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54DB320890
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 20:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XeLDsnyr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54DB320890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731803AbeG3VjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 17:39:12 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:37259 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbeG3VjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 17:39:12 -0400
Received: by mail-it0-f66.google.com with SMTP id h20-v6so1019438itf.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 13:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wZ7IykVgdFujF+dPDcPgpGPmbZMEDhXUtVMpaGeqPmA=;
        b=XeLDsnyrXMxdDiN7I4C02ozMWkic0HbXMAjLpIwcUgbHGRVJT5/ZCrWMzMinzpLBuE
         1XbzEp5JuJ28NQMeYpSf2dKtzg8u3k2bQWFTBDesKmnGn83uSmACS2GeWw4QwwUiFySs
         XHoOrmI3HcyeBiGETsU6rq12dRovX+vetcp3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wZ7IykVgdFujF+dPDcPgpGPmbZMEDhXUtVMpaGeqPmA=;
        b=hn3hOHUBPtRyexrK0PF1ghTRrUdl2CaHE5NKPg57Da/I7QMXoDrXriHkbfzAga/NGl
         ZoyGW23g4tDrR0beYObKH4Wy5Ar3sjZd3wZzAat8plqoVlacvU9Z0FpsowJV94GzzveW
         iiQMx5+hU0Zo/84WE8dMrPg8vkYRYUQy9KPr4lTj1+avwLo14tVuy3OYKgqxh/aM+IEX
         1X8/LAe5J+DDDRD1Qeynvw9X2HT/f1ylFiyu+dUqux11lnXqcKy0ndBn/3bHK4a/bRwE
         0uGZC54i2n4+qRVKxTtqLspBnHmnAzCyln8t+79ad6o+7as7X4dZ53/0hx223kgJhkl4
         DP9w==
X-Gm-Message-State: AOUpUlF2yudNTGhExq4rnimdOwlfb3BJ64BR1mRGrtZUyR0cucfOPeqT
        wMLflElcw7hYRFy+i2d7wye/Ag==
X-Google-Smtp-Source: AAOMgpe2g7FvfObp0+qSCNfxWYNNAxTAq+3bmG3WI/RsU7WQR59BQC712943TTO0jk5SrRRgo4eLDg==
X-Received: by 2002:a24:be8f:: with SMTP id i137-v6mr652068itf.61.1532980956095;
        Mon, 30 Jul 2018 13:02:36 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id c97-v6sm284868itd.19.2018.07.30.13.02.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 13:02:35 -0700 (PDT)
Date:   Mon, 30 Jul 2018 14:02:32 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, robert.walker@arm.com,
        coresight@lists.linaro.org, robh@kernel.org,
        frowand.list@gmail.com, devicetree@vger.kernel.org,
        matt.sealey@arm.com, charles.garcia-tobin@arm.com,
        john.horley@arm.com, al.grant@arm.com
Subject: Re: [PATCH v3 0/9] coresight: Update device tree bindings
Message-ID: <20180730200232.GA31755@xps15>
References: <1532686537-12380-1-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532686537-12380-1-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 11:15:28AM +0100, Suzuki K Poulose wrote:
> Coresight uses DT graph bindings to describe the connections of the
> components. However we have some undocumented usage of the bindings
> to describe some of the properties of the connections.
> 
> The coresight driver needs to know the hardware ports invovled
> in the connection and the direction of data flow to effectively
> manage the trace sessions. So far we have relied on the "port"
> address (as described by the generic graph bindings) to represent
> the hardware port of the component for a connection.
> 
> The hardware uses separate numbering scheme for input and output
> ports, which implies, we could have two different (input and output)
> ports with the same port number. This could create problems in the
> graph bindings where the label of the port wouldn't match the address.
> 
> e.g, with the existing bindings we get :
> 
> 	port@0{				// Output port 0
> 		reg = <0>;
> 		...
> 	};
> 
> 	port@1{
> 		reg = <0>;		// Input port 0
> 		endpoint {
> 			slave-mode;
> 			...
> 		};
> 	};
> 
> With the new enforcement in the DT rules, mismatches in label and address
> are not allowed (as see in the case for port@1). So, we need a new mechanism
> to describe the hardware port number reliably.
> 
> Also, we relied on an undocumented "slave-mode" property (see the above
> example) to indicate if the port is an input port. Let us formalise and
> switch to a new property to describe the direction of data flow.
> 
> There were three options considered for the hardware port number scheme:
> 
>  1) Use natural ordering in the DT to infer the hardware port number.
>   i.e, Mandate that the all ports are listed in the DT and in the ascending
>   order for each class (input and output respectively).
>    Pros :
>       - We don't need new properties and if the existing DTS list them in
>         order (which most of them do), they work out of the box.
>    Cons :
>       - We must list all the ports even if the system cannot/shouldn't use
>         it.
>       - It is prone to human errors (if the order is not kept).
> 
>  2) Use an explicit property to list both the direction and the hw port
>     number and direction. Define "coresight,hwid" as 2 member array of u32,
>     where the members are port number and the direction respectively.
> 	e.g
> 
> 	port@0{
> 		reg = <0>;
> 		endpoint {
> 			coresight,hwid = <0 1>;	// Port # 0, Output
> 		}
> 	};
> 
> 	port@1{
> 		reg = <1>;
> 		endpoint {
> 			coresight,hwid = <0 0>;	// Port # 0, Input
> 		};
> 	};
> 
> 	Pros:
> 	  - The bindings are formal but not so reader friendly and could
> 	    potentially lead to human errors.
> 	Cons:
> 	  - Backward compatiblity is lost.
>  3) Use explicit properties (implemented in the series) for the hardware
>     port id and direction. We define a new property "coresight,hwid" for
>     each endpoint in coresight devices to specify the hardware port number
>     explicitly. Also use a separate property "direction" to specify the
>     direction of the data flow.
> 
> 	e.g,
> 
> 	port@0{
> 		reg = <0>;
> 		endpoint {
> 			direction = <1>;	// Output
> 			coresight,hwid = <0>;	// Port # 0
> 		}
> 	};
> 
> 	port@1{
> 		reg = <1>;
> 		endpoint {
> 			direction = <0>;	// Input
> 			coresight,hwid = <0>;	// Port # 0
> 		};
> 	};
> 
>     Pros:
>        - The bindings are formal and reader friendly, and less prone to errors.
>     Cons:
>        - Backward compatibility is lost.
> 
> After a round of discussions [1], the following option (4) is adopted :
> 
>  4) Group ports based on the directions under a dedicated node. This has been
>     checked with the upstream DTC tool to resolve the "address mismatch" issue.
> 
> 	e.g,
> 
> 	out-ports {				// Output ports for this component
> 
> 		port@0 {			// Outport 0
> 		  reg = 0;
> 		  endpoint { ... };
> 		};
> 
> 		port@1 {			// Outport 1
> 		  reg = 1;
> 		  endpoint { ... };
> 		};
> 
> 	};
> 
> 	in-ports {				// Input ports for this component
> 		port@0 {			// Inport 0
> 		  reg = 0;
> 		  endpoint { ... };
> 		};
> 
> 		port@1 {			// Inport 1
> 		  reg = 1;
> 		  endpoint { ... };
> 		};
> 
> 	};
> 
> 
> This series implements Option (4) listed above and falls back to the old
> bindings if the new bindings are not available. This allows the systems
> with old bindings work with the new driver. The driver now issues a warning
> (once) when it encounters the old bindings. The series contains DT update
> for Juno platform. The remaining in-kernel sources could be updated once
> we are fine with the proposal.
> 
> It also cleans up the platform parsing code to reduce the memory usage by
> reusing the platform description.
> 
> Applies on coresight/next
> 
> Changes since V2:
>   - Clean of_coresight_parse_endpoint() to return 1 to indicate a connection
>     record was updated.
>   - Drop documentation for old bindings
> 
> Changes since V1:
>   - Implement the proposal by Rob.
>   - Drop the DTS updates for all platforms except Juno
>   - Drop the incorrect fix in coresight_register. Instead document the code
>     to prevent people trying to un-fix it again.
>   - Add a patch to drop remote device references in DT graph parsing
>   - Split of_node refcount fixing patch, fix a typo in the comment.
>   - Add Reviewed-by tags from Mathieu.
>   - Drop patches picked up for 4.18-rc series
> 
> Changes since RFC:
>  - Fixed style issues
>  - Fix an existing memory leak coresight_register (Found in code update)
>  - Fix missing of_node_put() in the existing driver (Reported-by Mathieu)
>  - Update the existing dts in kernel tree.
> 
> Suzuki K Poulose (9):
>   coresight: Document error handling in coresight_register
>   coresight: platform: Refactor graph endpoint parsing
>   coresight: platform: Fix refcounting for graph nodes
>   coresight: platform: Fix leaking device reference
>   coresight: Fix remote endpoint parsing
>   coresight: Add helper to check if the endpoint is input
>   coresight: platform: Cleanup coresight connection handling
>   coresight: Cleanup coresight DT bindings
>   dts: juno: Update coresight bindings
> 
>  .../devicetree/bindings/arm/coresight.txt          |  95 +++++---
>  arch/arm64/boot/dts/arm/juno-base.dtsi             | 161 ++++++------
>  arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi          |  52 ++--
>  arch/arm64/boot/dts/arm/juno.dts                   |  13 +-
>  drivers/hwtracing/coresight/coresight.c            |  35 +--
>  drivers/hwtracing/coresight/of_coresight.c         | 269 ++++++++++++++-------
>  include/linux/coresight.h                          |   9 +-
>  7 files changed, 359 insertions(+), 275 deletions(-)
>

Good day,

I have applied patches 1 to 7.  I will wait for Rob's ACK before doing the same
with 8 and 9. 

Thanks,
Mathieu
 
> -- 
> 2.7.4
> 
