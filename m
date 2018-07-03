Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A883CC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68507247F2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68507247F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753476AbeGCWqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:46:01 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:36585 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753076AbeGCWp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:45:59 -0400
Received: by mail-yb0-f196.google.com with SMTP id s1-v6so1356702ybk.3;
        Tue, 03 Jul 2018 15:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MJWusLf+zpGza8DvqEAyWXP3q9hQqFi2J7904ADwx9c=;
        b=cRzQeehz0dxIyK8kksXbhQA0PiU35WD3R01hEFepIYRfh+3LwG1+xbsT8Y84l90idD
         SBAJywEUHmSZR3eW38QK7+FTR6t3tGSEJ83duZyiewh9aKpTFXLeBcsHC1Bv0wqMw4X6
         TJa8IcAE34ieaHBK7P1aO/HRuiG22qIKFWn21+SrZoVgXhJQoTVgi9BCEe1YEaVEIk7y
         /BMz+snUb2aWObnWpqkNqJlulzF3W3+CF7CBtx0YadSVhfwQDQ+6rqUsemuJeWF4SeZ5
         BdddisaF1fZ/q73WyvtXd6O/tQ+fLcsyJwpJvmb/cpb81GS3pwYyEKCCbCukaxaQYKXX
         D2og==
X-Gm-Message-State: APt69E0nStxIiCoTu39uvhd7C3rRmTpwMIxX4Zpeo0pDRrN3T4gg8DPN
        fhdN7daFBcpbv7QHMgPyWw==
X-Google-Smtp-Source: AAOMgpdsN/MAetl+fxmEgFs6603tGfJY5UfaDQfKLFeKIKuR/9aEz8ZvdFLO4ZVDu2YKJ/D0lo/sOg==
X-Received: by 2002:a25:ac08:: with SMTP id w8-v6mr5109421ybi.245.1530657958578;
        Tue, 03 Jul 2018 15:45:58 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id o12-v6sm796926ywj.65.2018.07.03.15.45.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 15:45:57 -0700 (PDT)
Date:   Tue, 3 Jul 2018 16:45:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Piotr Bugalski <bugalski.piotr@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Piotr Bugalski <pbu@cryptera.com>
Subject: Re: [RFC PATCH v2 6/6] dt-bindings: spi: QuadSPI driver for Atmel
 SAMA5D2
Message-ID: <20180703224554.GA13754@rob-hp-laptop>
References: <20180627131609.13681-1-bugalski.piotr@gmail.com>
 <20180627131609.13681-7-bugalski.piotr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627131609.13681-7-bugalski.piotr@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 03:16:09PM +0200, Piotr Bugalski wrote:
> Atmel SAMA5D2 QuadSPI driver was moved from mtd to spi subsystem,
> this change is just moving DT-binding documentation.
> 
> Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Signed-off-by: Piotr Bugalski <pbu@cryptera.com>
> ---
>  Documentation/devicetree/bindings/{mtd => spi}/atmel-quadspi.txt | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/{mtd => spi}/atmel-quadspi.txt (100%)

Acked-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/Documentation/devicetree/bindings/mtd/atmel-quadspi.txt b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
> similarity index 100%
> rename from Documentation/devicetree/bindings/mtd/atmel-quadspi.txt
> rename to Documentation/devicetree/bindings/spi/atmel-quadspi.txt
> -- 
> 2.11.0
> 
