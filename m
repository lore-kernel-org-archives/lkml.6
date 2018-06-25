Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC56C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C3625BB9
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1C3625BB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934495AbeFYOr5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 10:47:57 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:46547 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934325AbeFYOrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 10:47:55 -0400
Received: by mail-yw0-f194.google.com with SMTP id g123-v6so4500100ywf.13;
        Mon, 25 Jun 2018 07:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jnoq+XDI/WmMysHlBMv6jRwAeJ72bYzUXgPFF/DJt5U=;
        b=CwmbfykN4JI/XlO4Ayy3bgh5jwa+dNysuQrsQjGtYAn0xsbfUbKQ00DlIEzToenZYI
         8hm5GoXire4PAL4iNSf1CrK+Ohlo01bPmlddq61hwxS9Lt0IyjPR1CdV06ucoSKMIrs3
         uh843J8eDQ5v9pSApxdRj1h47pgdBQvOcJAgE28lepnT3L0Go4wtl7t1HFihYMQGW1Jl
         7V6XJG0n0mUA7flhiqna0Qhwh/Ws6pgebpIZ7DGwv6CgU8vIkD4OQq0geFtkRhakVBta
         E2+OD2BoSSFkJbGTePUtRFewlgUNewn1aAkJNTZU74TB7Zsfw3O8Q5hKIOnvbBEG4WiC
         xXjw==
X-Gm-Message-State: APt69E2IFV2f0hAR0o3NiwNS9ELthx2g5DmWRA7sjkifU1guNGVVMyi7
        TTDYKiu39KR9Coi5FXdycQ==
X-Google-Smtp-Source: ADUXVKKJCdc1hDZSjxN1NZiRrPvnTjOcRwM8LGprzfWsTnemElcI1QOazR8JfFBmB7FZwkNU5WI2rw==
X-Received: by 2002:a81:8703:: with SMTP id x3-v6mr6091407ywf.45.1529938074214;
        Mon, 25 Jun 2018 07:47:54 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id k11-v6sm5484386ywc.26.2018.06.25.07.47.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 07:47:53 -0700 (PDT)
Date:   Mon, 25 Jun 2018 08:47:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stefan Agner <stefan@agner.ch>
Cc:     boris.brezillon@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        mark.rutland@arm.com, thierry.reding@gmail.com, dev@lynxeye.de,
        miquel.raynal@bootlin.com, richard@nod.at, marcel@ziswiler.com,
        krzk@kernel.org, digetx@gmail.com, benjamin.lindqvist@endian.se,
        jonathanh@nvidia.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mirza.krak@gmail.com, gaireg@gaireg.de,
        linux-mtd@lists.infradead.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/6] mtd: rawnand: add an option to specify NAND chip
 as a boot device
Message-ID: <20180625144752.GA19064@rob-hp-laptop>
References: <20180624212727.21672-1-stefan@agner.ch>
 <20180624212727.21672-3-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180624212727.21672-3-stefan@agner.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 24, 2018 at 11:27:23PM +0200, Stefan Agner wrote:
> Allow to define a NAND chip as a boot device. This can be helpful
> for the selection of the ECC algorithm and strength in case the boot
> ROM supports only a subset of controller provided options.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
> ---
>  Documentation/devicetree/bindings/mtd/nand.txt | 4 ++++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/mtd/nand/raw/nand_base.c               | 3 +++
>  include/linux/mtd/rawnand.h                    | 6 ++++++
>  3 files changed, 13 insertions(+)
