Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836A5ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451B220C01
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 451B220C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbeGPQjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:39:21 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:36920 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeGPQjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:39:21 -0400
Received: by mail-yb0-f196.google.com with SMTP id r3-v6so15632937ybo.4;
        Mon, 16 Jul 2018 09:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zlyKTTZf8dc4vhm2++g5KtZLI5X0bPaqvPDTND6r988=;
        b=cvHcXeyIJzWFf/xhunoAPiPF3Zl+LvmoeD75j6QNKY7qgZD3d8UGmBt0TFJZVEoyld
         95eCXn7Lc8SDlei+CkUYn718dpmqvgkkYqI2nGV0b64vJTKCx46o66fymJ2RFikJBcYt
         7I86fPtPqrT4W1t7+zn3g2ohUQjae1Zri6107BGMvnfyl9EKCGD5DLtii9JxZacTngja
         +VKrmhMIUYTJJnMNy8samsvAt5hzPK44uBbGp3NquLgLoi7B3VCY++mGdsjphamIi7iR
         mNQkd4vx1byB5KDpnXWjoxlAAxeQy91A8vY/OeMXBBc7sJtun7m8zHCXyzM4KJhTmMOi
         ngUA==
X-Gm-Message-State: AOUpUlFm6FyT+H/GsEtcDTNICLZ5G/wyzcZysQXSSWZwQYeDfLJNgOk9
        jKT5ui23yGwQW7zy3Nc1YTA0xSI=
X-Google-Smtp-Source: AAOMgpfk9OT+64IMpK/QbOTFsEDuC/NBvVW0IEHpT11h36PACsCRtwShAofH+oahEDBDSH0obDI9tA==
X-Received: by 2002:a25:6546:: with SMTP id z67-v6mr8667888ybb.453.1531757474598;
        Mon, 16 Jul 2018 09:11:14 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id q127-v6sm235968ywq.83.2018.07.16.09.11.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 09:11:13 -0700 (PDT)
Date:   Mon, 16 Jul 2018 10:11:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Janek Kotas <jank@cadence.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: ufs: Add UFS platform driver for
 Cadence UFS
Message-ID: <20180716161112.GA16292@rob-hp-laptop>
References: <B652B768-D5BC-460F-B0A4-64A2A76064CC@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B652B768-D5BC-460F-B0A4-64A2A76064CC@cadence.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 11:58:04AM +0000, Janek Kotas wrote:
> This patch adds a device tree platform
> driver description for Cadence UFS Controller.

Bindings are not platform drivers...

> 
> Signed-off-by: Jan Kotas <jank@cadence.com>
> ---
>  .../devicetree/bindings/ufs/cdns,ufshc.txt         | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
> 
> diff --git a/Documentation/devicetree/bindings/ufs/cdns,ufshc.txt b/Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
> new file mode 100644
> index 0000000..cb6d62a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
> @@ -0,0 +1,31 @@
> +* Cadence Universal Flash Storage (UFS) Controller
> +
> +UFS nodes are defined to describe on-chip UFS host controllers.
> +Each UFS controller instance should have its own node.
> +
> +Required properties:
> +- compatible	: compatible list, contains the following controller:
> +			"cdns,ufshc"
> +		  complemented with the JEDEC version:
> +			"jedec,ufs-2.0"
> +
> +- reg		: address and length of the UFS register set
> +- interrupts	: one interrupt mapping
> +- clocks	: List of phandle and clock specifier pairs.
> +- clock-names	: List of clock input name strings sorted in the same
> +		  order as the clocks property. "core" is mandatory.

And phy?

> +- freq-table-hz	: Array of <min max> operating frequencies stored in the same
> +		  order as the clocks property. If this property is not
> +		  defined or a value in the array is "0" then it is assumed
> +		  that the frequency is set by the parent clock or a
> +		  fixed rate clock source.

Don't define again here. Just refer to the common definition.

> +
> +Example:
> +	ufs@fd030000 {
> +		compatible = "cdns,ufshc", "jedec,ufs-2.0";
> +		reg = <0xfd030000 0x10000>;
> +		interrupts = <0 1 IRQ_TYPE_LEVEL_HIGH>;
> +		freq-table-hz = <0 0>, <0 0>;
> +		clocks = <&ufs_core_clk>, <&ufs_phy_clk>;
> +		clock-names = "core_clk", "phy_clk";

Doesn't match the doc.

> +	};
> -- 
> 1.9.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
