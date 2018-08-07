Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173B0C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A3E21502
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:54:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A3E21502
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389763AbeHGRIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:08:52 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:40107 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388523AbeHGRIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:08:52 -0400
Received: by mail-io0-f193.google.com with SMTP id l14-v6so14213098iob.7;
        Tue, 07 Aug 2018 07:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UJFuBAzxoH4tbKkdltfh/2ouA4wjfiVmaGh4TsKgLjI=;
        b=TiQWyc55cHeDuHq2HkhRJJzC7zihLjiYyqAQeaAnwDI6OyS3g3S3Pr4TzGj9h32RdR
         KYLlgzfx6cRQ9yPfXkaYSahuyE7p8KpJHUZ6KOaWSriclq+IJAVdkj73HE13r7KTF5uK
         YsnqeAVUmhbpHoinWAiQ/qoEgKUDz0jEcZmgWpxRSnAt9IMfrwTbTLmNuKchzK/juy6v
         PHpXzCiYoIBnm6Kt3vY60uKlFau0fxgEB6DIINtM71slubaMfA0+lEOYjCSmdv83jlWh
         Yx3TNIKz2r2Om4/LZSxYAWVnK+Eu/AvURBB0U0qsDj51+yWp/+RsVcD6c4UNiwPUUJOY
         d4HQ==
X-Gm-Message-State: AOUpUlFtWA4/6yQsMqEO8DzkJHyh/lQq7nkGVNFFOHneERXnbwGcM0QO
        Tqlqh+eIg2L8dMJ3I9bNWw==
X-Google-Smtp-Source: AAOMgpfOJAsRcjsKdvfdHLl7Nz6PEtNoU9Q2UBgKpZgCtGKB7xBj/HzECDIqBuYwg62fKR4OMg6GnQ==
X-Received: by 2002:a6b:450c:: with SMTP id s12-v6mr17925372ioa.273.1533653650157;
        Tue, 07 Aug 2018 07:54:10 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id v3-v6sm415673iop.78.2018.08.07.07.54.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 07:54:09 -0700 (PDT)
Date:   Tue, 7 Aug 2018 08:54:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Parthiban Nallathambi <pn@denx.de>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        matthias.bgg@gmail.com, wd@denx.de, sbabic@denx.de, hs@denx.de
Subject: Re: [PATCH v6 2/2] iio: light: Add device tree binding for vishay
 vcnl4035
Message-ID: <20180807145409.GA32028@rob-hp-laptop>
References: <20180807102704.1652656-1-pn@denx.de>
 <20180807102704.1652656-2-pn@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807102704.1652656-2-pn@denx.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 12:27:04PM +0200, Parthiban Nallathambi wrote:
> Adding device tree binding for vcnl4035 and vendor
> prefix for Vishay Intertechnology
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> 
> Changelog in v3:
> - removed interrupt-parent property reference in documentation
> - renamed vcnl4035 to light-sensor
> 
> Changelog in v4:
> - commit message fix
> - same indexing/space in binding
> ---
>  .../devicetree/bindings/iio/light/vcnl4035.txt         | 18 ++++++++++++++++++
>  Documentation/devicetree/bindings/vendor-prefixes.txt  |  1 +
>  2 files changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/vcnl4035.txt

Reviewed-by: Rob Herring <robh@kernel.org>
