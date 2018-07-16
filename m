Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A8CECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDCD520B80
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDCD520B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbeGPQWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:22:20 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:40944 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbeGPQWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:22:20 -0400
Received: by mail-oi0-f67.google.com with SMTP id w126-v6so75704750oie.7;
        Mon, 16 Jul 2018 08:54:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3xBQh1crep9NB199PGr+y5yVehWJy2BS9Jh2mWktqHc=;
        b=JDeab4FmcVV3JOndIOpGW+IpOs1Yy7+YblbQdEfoRcGhWFD3gOLXJ9ZUXYJexTwnC/
         Tr0O/3AsMaSp50vVhZRD9Tn0ilX+DMkoTBlJXZmxrkG85D6RjBJZGZGOrwPVsaiLzeCX
         Kjil2bXDn7IF08U0JTXcx414z/G10W0hF5/UB3lLMSpa2yqjWbOWw9IXFLceaQHTgphh
         ANcxJZHDywEy95bm5W68rEqOLMUQyT0WE8ELMfbVTfBbnDY4UUz2I3ziGfw7Z7+gDW5B
         tXLbaFJSKQx95VsLwoGRyAcC47s13wMRuckpWJkpGFevGiKiXjGKkH7dutmVQtazGtvn
         w6vQ==
X-Gm-Message-State: AOUpUlEUrLMST4+XGiePM8wTUYa4m3ieyd5JGy8VcMd0/ID504vQ3BDm
        x+KEdPeK7D8g5zOqu1C8CA==
X-Google-Smtp-Source: AAOMgpfwBTFJHlko+N/JCCDbTvN/9GK+KnffRicBRwgquDefnT1sR40bMdBQbP9IjNBkHfOCaRKWhg==
X-Received: by 2002:aca:af15:: with SMTP id y21-v6mr19871870oie.324.1531756458376;
        Mon, 16 Jul 2018 08:54:18 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id r131-v6sm20939897oih.16.2018.07.16.08.54.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 08:54:17 -0700 (PDT)
Date:   Mon, 16 Jul 2018 09:54:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     hdegoede@redhat.com, linux@armlinux.org.uk, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, tj@kernel.org, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, thierry.reding@gmail.com,
        icenowy@aosc.io
Subject: Re: [PATCH v3 4/9] dt-bindings: ata: ahci-platform: document AHCI
 reset
Message-ID: <20180716155416.GA32497@rob-hp-laptop>
References: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
 <1531479786-4911-5-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531479786-4911-5-git-send-email-clabbe@baylibre.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 11:03:01AM +0000, Corentin Labbe wrote:
> This patch document the new optional resets for ahci node.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  Documentation/devicetree/bindings/ata/ahci-platform.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> index 5f362af2724c..a5281d7557e3 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> @@ -34,6 +34,8 @@ Optional properties:
>  - phys              : reference to the SATA PHY node
>  - phy-names         : must be "sata-phy"
>  - ahci-supply       : regulator for AHCI controller
> +- resets            : phandle to the reset line of AHCI controller
> +                      If set, must have a reset-names set as "ahci"

A name is pointless if there is only one. Also, the name should be what 
the signal in the block is called which I doubt would be called "ahci". 
A likely name is some form of reset, resetn, etc. which again is 
pointless to name if there is only 1.

If you do have 'reset-names' then that needs to be listed too like 
phy-names.

Rob
