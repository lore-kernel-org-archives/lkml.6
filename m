Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6D3C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E60920881
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:18:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E60920881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbeIJXNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 19:13:22 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43672 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbeIJXNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 19:13:22 -0400
Received: by mail-oi0-f68.google.com with SMTP id b15-v6so41998262oib.10;
        Mon, 10 Sep 2018 11:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xL30Mt8FfLGImV5WCn+UaoExb59V7JOMgRzHpx83pDE=;
        b=q2lL3W+j7JvY4t0YooRJR17H33elqdf6EBZB+SuinaVzLdbb3VA78IhSPcVcpOPpTO
         F4VSvhFuAeOatSExY1y7tfZ3+xx0Hl/xhss1by2z48AtEX/0wfPBuJt9KNVKHZthuk/N
         VfCuPPJP5EsnCP+V9UkcKQOhSV990L58yUXIwRj5fBw9O4F2WPYMqbtI6dYYEQ/Ocbrp
         673cKJYC8eyYE42gb3dXiRNnyK1SySnMjGJ+6eSu+wl7YFWf0lPr3ee1BhI/2CyFRXnU
         ZUGq9PEzua1jO11W0ch4oYoDiG3TaG6l4ZYhFxELH6cVTuP354BAYzlFa0Xqgh0B6rvr
         HUBw==
X-Gm-Message-State: APzg51DIBiUnwEY9SeZvB9OwqwFDkEo5Lo9LrL501BXDsvwA1VPpmEK3
        FFwz8bUbWiLyKlnt0qyQlw==
X-Google-Smtp-Source: ANB0VdY3YjowZ5azeFSQhD+AlJfoH2iK4475ElBrQvo0Hg8Q4jTEqyY/Ri7TRr/bVArxnJ6+rrQ7og==
X-Received: by 2002:aca:4914:: with SMTP id w20-v6mr24943250oia.5.1536603481749;
        Mon, 10 Sep 2018 11:18:01 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 10-v6sm11814039oip.29.2018.09.10.11.18.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 11:18:01 -0700 (PDT)
Date:   Mon, 10 Sep 2018 13:18:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     axboe@kernel.dk, hdegoede@redhat.com, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v5 5/9] dt-bindings: ata: ahci-platform: document
 phy-supply
Message-ID: <20180910181800.GA9759@bogus>
References: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
 <20180903100201.23131-6-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903100201.23131-6-clabbe.montjoie@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 12:01:57PM +0200, Corentin Labbe wrote:
> This patch document the new optional phy-supply.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  Documentation/devicetree/bindings/ata/ahci-platform.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> index f495774c8af9..45b451961612 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> @@ -31,6 +31,7 @@ Optional properties:
>  - clocks            : a list of phandle + clock specifier pairs
>  - resets            : a list of phandle + reset specifier pairs
>  - target-supply     : regulator for SATA target power
> +- phy-supply        : regulator for PHY power

This should be mutually exclusive with the phys property. If you have a 
phy node, then its supply belongs there.

>  - phys              : reference to the SATA PHY node
>  - phy-names         : must be "sata-phy"
>  - ahci-supply       : regulator for AHCI controller
> -- 
> 2.16.4
> 
