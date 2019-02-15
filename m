Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DA0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 373A8222A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550246710;
	bh=r/G7KAaWirmLoHCACfAk+krdvCpn0NXuiMXY6yeRDPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KSUmUUdGamD8l7xeFDyQEuJUX8bKpfkM0EcDwtnHYQbrtEbrmE/ran0KUC/Qy2PSy
	 NxMj2Jp8E0aE2fb7elryeTgLTt9xF8JAmGCr04mdil9Y8VhDm62JskPptiU4m/mBXC
	 rssnEwWqvUUbAh6NBAQ7GRMLTOJ6aNzDO8udST0I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391283AbfBOQFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:05:08 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33881 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfBOQFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 11:05:08 -0500
Received: by mail-lf1-f66.google.com with SMTP id u21so7587446lfu.1;
        Fri, 15 Feb 2019 08:05:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pvVSU+OeBtnbLINS2fqQeebEh/Lf+PMY28nuMnUdYR0=;
        b=HjFdjm0LEyAZAXI4ov+HIXAk3LhoLRBwsRG4ZtpY3T2Gmr0ItCkTK23ZU7Vlat4yLf
         uHziAkv0238E2PNZyj2iiHLSOar6LLSGE3saYbR2fDSnZtOP5s2nwgdZUt01z5Bh6A49
         tqOBbLn9PpgZlXd+1ILF+zWdUJHzcP/K40moo+OwvqX0itO1/SA7w9FjmN+r2cFbTAHs
         zV9+j2gvuSEZPYlB6kilbbK4zMPtiVXUHSKN0ixOH7TJPvaGrLVhLg2z2mMf79Ont4+4
         UvkJfjG4/tF3GBozvlCMb79Z27p90d3Pc72NGxS7ck763gmaNz8d50OX5kwOFLb7uDnr
         Cq2Q==
X-Gm-Message-State: AHQUAuaH4gti/KauAPS2wZPcNz3IgK2IRH+MoNSaXtHIFRQkIXE1HQGK
        PQyv3gu/wSvAnhidIA/YIiI=
X-Google-Smtp-Source: AHgI3IZRcnlB46Fnw+lqoINS7IG2dpHY6TaBaBqVmAUpJPIafA96D5LXIxG+4kwQCsRiLn251kDSgQ==
X-Received: by 2002:a19:5611:: with SMTP id k17mr5705165lfb.168.1550246705884;
        Fri, 15 Feb 2019 08:05:05 -0800 (PST)
Received: from xi.terra ([85.230.190.116])
        by smtp.gmail.com with ESMTPSA id f10-v6sm1298296ljc.31.2019.02.15.08.05.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 08:05:04 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gufyz-0000qc-Eh; Fri, 15 Feb 2019 17:04:57 +0100
Date:   Fri, 15 Feb 2019 17:04:57 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Loys Ollivier <lollivier@baylibre.com>
Cc:     devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: gnss: add mediatek binding
Message-ID: <20190215160457.GO28278@localhost>
References: <1550070569-18588-1-git-send-email-lollivier@baylibre.com>
 <1550070569-18588-3-git-send-email-lollivier@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550070569-18588-3-git-send-email-lollivier@baylibre.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 04:09:27PM +0100, Loys Ollivier wrote:
> Add binding for Mediatek-based GNSS receivers.
> 
> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> ---
> v4:
> Use standard names for reset-gpios and gnss-fix-gpios
> s/an/a UART
> 
> v3:
> Removed the I2C and SPI interfaces references.
> Removed the "mediatek,mt3339" compatible line.
> Added the optional propertied (reset, fix)
> Added the pin names for the optional properties.
> 
> v2:
> Renamed bindings from Globaltop/gtop to Mediatek/mtk.
> Moved current-speed as an optional propertie.
> Removed the status line in the example.
> Added "mediatek,mt3339" compatible.
> 
>  .../devicetree/bindings/gnss/mediatek.txt          | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gnss/mediatek.txt
> 
> diff --git a/Documentation/devicetree/bindings/gnss/mediatek.txt b/Documentation/devicetree/bindings/gnss/mediatek.txt
> new file mode 100644
> index 000000000000..12283d429baa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gnss/mediatek.txt
> @@ -0,0 +1,37 @@
> +Mediatek-based GNSS Receiver DT binding
> +
> +Mediatek chipsets are used in GNSS-receiver modules produced by several
> +vendors and can use a UART interface.
> +
> +Please see Documentation/devicetree/bindings/gnss/gnss.txt for generic
> +properties.
> +
> +Required properties:
> +
> +- compatible	: Must be
> +
> +			"globaltop,pa6h"
> +
> +- vcc-supply	: Main voltage regulator (pin name: VCC)
> +
> +Optional properties:
> +
> +- current-speed		: Default UART baud rate
> +- gnss-fix-gpios	: GPIO used to determine device position fix state
> +			  (pin name: FIX, 3D_FIX)
> +- reset-gpios		: GPIO used to reset the device
> +  		  	  (pin name: RESET, NRESET)
> +- timepulse-gpios	: Time pulse GPIO (pin name: PPS1, 1PPS)
> +- v-bckp-supply		: Backup voltage regulator
> +  			  (pin name: VBAT, VBACKUP)

As we discussed, I changed this to "vbackup-supply" (here and in the
driver) before applying.

Note that git reported some whitespace errors above too (spaces before
tabs) that I fixed up. Not sure why checkpatch doesn't complain.

All now applied.

Thanks,
Johan
