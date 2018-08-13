Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21506C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64C2217C7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D64C2217C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbeHMUVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 16:21:12 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55534 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729029AbeHMUVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 16:21:12 -0400
Received: by mail-it0-f65.google.com with SMTP id d10-v6so14208854itj.5;
        Mon, 13 Aug 2018 10:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4jX2TT2fR4TogwiWEOWTAbf9jmtmdFKnIEeVGPxLYig=;
        b=cZ3h7VnBwBYaRjFSsMsx5g2hBi4OwjsjfiI2uZ5kuh4ZfDeJM3s9Do7BUe6ZFBsXs4
         /PFU5HAgT3fK0hl6qgpF2BiPlUhxlVkK37vEhGW1mioMfOX1Bkls3SO1U/0BfU3W3Yhs
         miBz+JG5yFXF9nA2lH7bVqeq2mUyxW6My90Ee/C83Mui4V5/z8iRT/V6zY8w68VZ3xWa
         Icqq+K2H9ZHF8n4zR9KQZt3qK77ya7knWqdeDiQtn3QiCXI2E2ZixA1UyOCvnAqTaLrb
         JcFEoqeifdjsB2mVX1ZSsRkjjcesGJB1YtI7JGUUFyOkJIuQbGmYYOjIWsp4HrSsnKO/
         gMBg==
X-Gm-Message-State: AOUpUlH/NYd6xfSV1VB798fnB0HJdwsCYZPzTbD9aWvG99DwftsXTP+K
        x121I4MjdHI2UAx+CZwzvw==
X-Google-Smtp-Source: AA+uWPxc3qqJ6UC5jkn3Jz04+ZCNvX1VX5jCeKnIpvtPNn7hstP5vml4XZzXUAqZ2jl9l+ukELaUMw==
X-Received: by 2002:a24:d51:: with SMTP id 78-v6mr11613044itx.103.1534181881035;
        Mon, 13 Aug 2018 10:38:01 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id v13-v6sm6715740ita.38.2018.08.13.10.38.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 10:38:00 -0700 (PDT)
Date:   Mon, 13 Aug 2018 11:37:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Janek Kotas <jank@cadence.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: ufs: Add bindings for Cadence UFS
Message-ID: <20180813173759.GA7302@rob-hp-laptop>
References: <F39BF38C-FD85-4115-975C-8D923518A541@global.cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F39BF38C-FD85-4115-975C-8D923518A541@global.cadence.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 01:25:15PM +0000, Janek Kotas wrote:
> This patch adds a DT binding documentation for
> Cadence UFS Host Controller.
> 
> Signed-off-by: Jan Kotas <jank@cadence.com>
> ---
>  .../devicetree/bindings/ufs/cdns,ufshc.txt         | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
> 
> diff --git a/Documentation/devicetree/bindings/ufs/cdns,ufshc.txt b/Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
> new file mode 100644
> index 00000000..a04a4989
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
> @@ -0,0 +1,31 @@
> +* Cadence Universal Flash Storage (UFS) Controller
> +
> +UFS nodes are defined to describe on-chip UFS host controllers.
> +Each UFS controller instance should have its own node.
> +Please see the ufshcd-pltfrm.txt for a list of all available properties.
> +
> +Required properties:
> +- compatible	: Compatible list, contains the following controller:
> +			"cdns,ufshc"
> +		  complemented with the JEDEC version:
> +			"jedec,ufs-2.0"
> +
> +- reg		: Address and length of the UFS register set.
> +- interrupts	: One interrupt mapping.
> +- freq-table-hz	: Clock frequency table.
> +		  See the ufshcd-pltfrm.txt for details.
> +- clocks	: List of phandle and clock specifier pairs.
> +- clock-names	: List of clock input name strings sorted in the same
> +		  order as the clocks property. "core_clk" is mandatory.
> +		  Depending on a type of a PHY,
> +		  the "phy_clk" clock can also be added, if needed.

Unfortunately, you went the wrong direction. The '_clk' part is 
redundant. Just 'core' and 'phy'.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +
> +Example:
> +	ufs@fd030000 {
> +		compatible = "cdns,ufshc", "jedec,ufs-2.0";
> +		reg = <0xfd030000 0x10000>;
> +		interrupts = <0 1 IRQ_TYPE_LEVEL_HIGH>;
> +		freq-table-hz = <0 0>, <0 0>;
> +		clocks = <&ufs_core_clk>, <&ufs_phy_clk>;
> +		clock-names = "core_clk", "phy_clk";
> +	};
> -- 
> 2.15.0
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
