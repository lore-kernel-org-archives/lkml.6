Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C5FC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE7320851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544568350;
	bh=Tlph4yMiD8guD33qTff3+AKiuWGT/dAQEOXJ+AKFOVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HwUQ3kGPCvUh703tLy6v1q9E1YIQkrLQMJM2yOUFB1oCHxiQRALPNaIVXOunug3yA
	 ozp3cEav5tSQ68diB2hI1/laFkm70FzctRoXvSaTFZuNRLEyEs6SySx5ZnBXaCkHqK
	 Djnxt4sOzYak93vzhv0vttnYUYHXb8BHqPGUfiJE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE7320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbeLKWpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:45:49 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41725 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbeLKWpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:45:35 -0500
Received: by mail-ot1-f68.google.com with SMTP id u16so15750763otk.8;
        Tue, 11 Dec 2018 14:45:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0dWTg9ooH5/ZUcwb3VJnMt5qfYKp8zo1y2roSzqTnGQ=;
        b=cMdaQ/skR9X1k1vZDYkEnA9xSl6AKRCXSzAqLxtRfe+i6IWF61jMUhVqBWZhKGhzkh
         WGTAvnXwEqmHXUlPe94W19cOdfGD+uYmgnIsYffcyS90ECXMaBds2LI7Ks3IRcu1xN+c
         ddmKajrbZM9+dT9AspRcdsPmq44hRFhv8NF7GIo5AJK3RugRU+5zDZaDeOP5XX0gjTMn
         LIb5aLU+h9rmH1yn6/+L+T6g72WHuX/e/Rj3tmKoind6rm5pXK4GwoJGyWc7iYy9ugwh
         ukSbWeH69mr8NPD25XMhYhy5d8O2/I2mqlGybSlVILqNbnikymF3x9aNDW3r3Es0LlgD
         laeQ==
X-Gm-Message-State: AA+aEWYXJ12ZZy3hIUEJq9sb3fY08JGon3SYuHfILuEaOLk7V4S4mczs
        b7h2XmFLjHnhFDxpCjuJNg==
X-Google-Smtp-Source: AFSGD/XIAd2psJdg54TVpUi7izp5QbMc23Yd8erug8cvQCInN8z0PY3sv7m4eSv0jJE1VP8ZaHf/6A==
X-Received: by 2002:a9d:871:: with SMTP id 104mr12521641oty.189.1544568335008;
        Tue, 11 Dec 2018 14:45:35 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 102sm8782727otj.65.2018.12.11.14.45.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 14:45:34 -0800 (PST)
Date:   Tue, 11 Dec 2018 16:45:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Weijie Gao <weijie.gao@mediatek.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [RESEND PATCH 1/4] dt-bindings: mtd: mtk-quadspi: update
 bindings for MT7629 SoC
Message-ID: <20181211224533.GA2363@bogus>
References: <235ade9c5cda19fb0c9356913e3f56ad86600f59.1543472168.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <235ade9c5cda19fb0c9356913e3f56ad86600f59.1543472168.git.ryder.lee@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018 14:29:53 +0800, Ryder Lee wrote:
> This updates bindings for the MT7629 SPI-NOR controller.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mtd/mtk-quadspi.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
