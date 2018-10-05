Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55322C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16926213A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16926213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbeJFDY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 23:24:58 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44589 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbeJFDY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 23:24:58 -0400
Received: by mail-oi1-f196.google.com with SMTP id u74-v6so11389642oia.11;
        Fri, 05 Oct 2018 13:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3c9dYevr3/ZjBFzOnzdfF1FipPZlUr92blF38NhIick=;
        b=e+7Z5LKNVFKfHPmH66E/jfDydUPyvADpsZzGEAmPHbgUu7ThPyM3/j1NtoYyVNc7Wr
         3bWRPFvl0veVngqVEmkRF2fq6elLPZoOHO7hV3Mkq1AxCDbFC7O/yroDoxRlk39TXS+o
         HQF5FTpC3NZcY2x1gFyvb86TDQQHOil01Ilq52X17JqI+FW2VZALFsmb96kgth71Hp0d
         ELChnIWNbuZp8YCssuDbX6J1jAaTSVzCxK8N+8DGOGyJvCvNtoTQRoE0/i683z0Cmpyk
         4JQnIYLtZSBMD1DEGeffMqcI06PFS39tN1kjeE2Y4THBYe72eDvY6Y2iQItLpTrwF++2
         5MIQ==
X-Gm-Message-State: ABuFfoj0X+MXRHlK2CxQDyqK15ev6hMbf5JpOIluQ5kXmsWtmGcta7Mx
        HkzBfzC2V5S+dJ+5U5T3BQ==
X-Google-Smtp-Source: ACcGV61fxjNP7DcLIHqIpErIdZwKVmvQrhCb1jusJe4xGd6YdyTQpohsNRFTOrXNRQWkLzsoXdoEdw==
X-Received: by 2002:aca:1802:: with SMTP id h2-v6mr271783oih.353.1538771078143;
        Fri, 05 Oct 2018 13:24:38 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q15-v6sm2744040otl.43.2018.10.05.13.24.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 13:24:37 -0700 (PDT)
Date:   Fri, 5 Oct 2018 15:24:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net, afd@ti.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v9 1/2] dt-bindings: hwmon: Add ina3221 documentation
Message-ID: <20181005202436.GA28437@bogus>
References: <20181002010523.2019-1-nicoleotsuka@gmail.com>
 <20181002010523.2019-2-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002010523.2019-2-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Oct 2018 18:05:22 -0700, Nicolin Chen wrote:
> Texas Instruments INA3221 is a triple-channel shunt and bus
> voltage monitor. This patch adds a DT binding doc for it.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
> Changelog
> v7->v9:
>  * N/A
> v6->v7:
>  * Restored three channel examples and merged them with the parent one
> v5->v6:
>  * Removed status property as no need to explicitly list it.
>  * Combined all examples into a complete one.
> v4->v5:
>  * Replaced "input-id" with "reg" and added address-cells and size-cells
>  * Replaced "input-label" with "label"
>  * Replaced "shunt-resistor" with "shunt-resistor-micro-ohms"
> v3->v4:
>  * Removed the attempt of putting labels in the node names
>  * Added a new optional label property in the child node
>  * Updated examples accordingly
> v2->v3:
>  * Added a simple subject in the line 1
>  * Fixed the shunt resistor value in the example
> v1->v2:
>  * Dropped channel name properties
>  * Added child node definitions.
>  * * Added shunt resistor property in the child node
>  * * Added status property to indicate connection status
>  * * Changed to use child node name as the label of input source
> 
>  .../devicetree/bindings/hwmon/ina3221.txt     | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/ina3221.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
