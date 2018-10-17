Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47782ECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF9221480
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:33:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF9221480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbeJRDa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 23:30:58 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40530 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbeJRDa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 23:30:58 -0400
Received: by mail-oi1-f196.google.com with SMTP id j68-v6so22065231oib.7;
        Wed, 17 Oct 2018 12:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bEESbS4mh1TXnLr0glP3a2qu3nBqaXj0qxeWDRcgqkk=;
        b=KKrCaWrkhRXBiUhzeOzvCbenG0fvNPaB1BmhxbBfqESVOX5SeRcYBkUKDruqcCT//A
         Dp9wO1Mu6sQhk+Qdv6pr0xVmZSxsrDq1tMLLRT4ougO8/GRFRX/uZLrWDina5KXF7O5M
         qHcGyHr1Oc87XUv/jQ8jXreIxKle4oqaXn7zauuTDL2GEfSJZYCuj2N25fnimgExXawf
         wzp3xgp3p/1ZIEZgv0H2YsndPfaj6g/P8HOnFuCT7nbAccEbfn4b0cYuIeGFcynxdB/Q
         FXo284YvNyvCz6XmpwfLpXABDgxxDNQi8lLor+FECi2SXHjbA0LsctruK7PNy+oAjK8e
         qU9Q==
X-Gm-Message-State: ABuFfoghsIRxkiwrEEXRJhXhv2wlu/CezhsHur91Wq2sCanDcZmhY8wd
        qTgXHVbjpp+PKh/8C5mX9w==
X-Google-Smtp-Source: ACcGV62JP8S2dxSGz1Vhtk368tMgXu7Vhlf2rhYGRGQvCMkNPJcMJUxK2YPaCk/Y0LvnDceXRtyNkw==
X-Received: by 2002:aca:4ac1:: with SMTP id x184-v6mr13830610oia.211.1539804827690;
        Wed, 17 Oct 2018 12:33:47 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p6sm6074795otc.43.2018.10.17.12.33.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 12:33:47 -0700 (PDT)
Date:   Wed, 17 Oct 2018 14:33:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        James Cameron <quozl@laptop.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 06/11] dt-bindings: spi/spi-pxa2xx: Add spi-slave property
Message-ID: <20181017193346.GB8853@bogus>
References: <20181010170936.316862-1-lkundrak@v3.sk>
 <20181010170936.316862-7-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010170936.316862-7-lkundrak@v3.sk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 07:09:31PM +0200, Lubomir Rintel wrote:
> This is used to indicate that the chip attached to this controller is a SPI
> master.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  Documentation/devicetree/bindings/spi/spi-pxa2xx.txt | 1 +
>  1 file changed, 1 insertion(+)

This could be rolled into patch 1. Either way,

Reviewed-by: Rob Herring <robh@kernel.org>
