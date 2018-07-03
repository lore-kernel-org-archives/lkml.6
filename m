Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF78C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 516CC24339
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 516CC24339
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753494AbeGCXEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 19:04:15 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:34061 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753183AbeGCXEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 19:04:14 -0400
Received: by mail-yb0-f193.google.com with SMTP id e9-v6so1368854ybq.1;
        Tue, 03 Jul 2018 16:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M4c/qRNwuftgh6yH3z4mrzKMRpisdWqttzu/c4Di/nA=;
        b=Kfoc/foxD+EqBDbfsJzD/nHl7ayAffnVzZjV0gUKPSH4gfPSWmOZu6f/lE1gxjoTC/
         GYEKOrzNCehr9dnlEAksNdyckDEeaT2IgtYO5CmucswtLnYPbTsmLwNZoaR5PYIzDIZZ
         s6bWOAgLZQlIXQghy5BobsdGWTCY4WUHOlopyBlbmSc24lajys6kPBd5KZRW3kVcaZC4
         L38Fty4hNn3g3VDLh+395RJO8VEWyDTlsLssqDhjjze8x53/Ui6yqcbXSNY/js5tyUy5
         sMRMbyjPU8/Fhxjje42XTLVYoMRAFHb95PZDS5BXyytFduaT5E6WeF2hOyEqgvI2ylTa
         syOg==
X-Gm-Message-State: APt69E2YkL6Q7QqE3HFFnX+ImuI+GJ5q0FGuKBXZrufaU3Pz2TRjws9u
        Nc3lzYvTVYQN5wtWkTpUmw==
X-Google-Smtp-Source: ADUXVKKc2gnMBGK+Ua/a/cmc9D20SYJhHASDMVyT2c0j0n6NqSDIFYD6qYCA5ru5iNx70URBCKWNZA==
X-Received: by 2002:a25:9a49:: with SMTP id r9-v6mr15886103ybo.451.1530659053341;
        Tue, 03 Jul 2018 16:04:13 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id p134-v6sm925114ywe.30.2018.07.03.16.04.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 16:04:12 -0700 (PDT)
Date:   Tue, 3 Jul 2018 17:04:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luis Araneda <luaraneda@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/5] dt-bindings: xilinx: Add missing zynq boards
Message-ID: <20180703230410.GA31330@rob-hp-laptop>
References: <20180628054205.17737-1-luaraneda@gmail.com>
 <20180628054205.17737-3-luaraneda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628054205.17737-3-luaraneda@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 01:42:02AM -0400, Luis Araneda wrote:
> The bindings were missing when adding the device-tree files
> Also, improve description of existing boards
> 
> Signed-off-by: Luis Araneda <luaraneda@gmail.com>
> ---
>  .../devicetree/bindings/arm/xilinx.txt        | 22 +++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Documentation/devicetree/bindings/arm/xilinx.txt
> index b9043bc35..f1e911058 100644
> --- a/Documentation/devicetree/bindings/arm/xilinx.txt
> +++ b/Documentation/devicetree/bindings/arm/xilinx.txt
> @@ -8,15 +8,33 @@ Required root node properties:
>  
>  Additional compatible strings:
>  
> -- Xilinx internal board cc108
> +- Xilinx CC108 board
>    "xlnx,zynq-cc108"
>  
> -- Xilinx internal board zc770 with different FMC cards
> +- Avnet MicroZed board
> +  "avnet,zynq-microzed"
> +
> +- Adapteva Parallella board
> +  "adapteva,parallella"

This is documented in adapteva.txt, but I'd prefer if you put it 
here and remove adapteva.txt.

> +
> +- Xilinx ZC702 board
> +  "xlnx,zynq-zc702"
> +
> +- Xilinx ZC706 board
> +  "xlnx,zynq-zc706"
> +
> +- Xilinx ZC770 board, with different FMC cards
>    "xlnx,zynq-zc770-xm010"
>    "xlnx,zynq-zc770-xm011"
>    "xlnx,zynq-zc770-xm012"
>    "xlnx,zynq-zc770-xm013"
>  
> +- Avnet ZedBoard board
> +  "avnet,zynq-zed"
> +
> +- Digilent Zybo board
> +  "digilent,zynq-zybo"
> +
>  - Digilent Zybo Z7 board
>    "digilent,zynq-zybo-z7"
>  
> -- 
> 2.18.0
> 
