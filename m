Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBD0C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A1C20C03
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A1C20C03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389536AbeGKP7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:59:05 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:44476 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733301AbeGKP7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:59:04 -0400
Received: by mail-oi0-f66.google.com with SMTP id s198-v6so50130167oih.11;
        Wed, 11 Jul 2018 08:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kwIRPZT0zqiUIbyQv62qjtCgNLTAc6LC2YdbWMMpuJk=;
        b=H2JdfYnnlrWiZhISkJI+DsRGa+7R8JmcUxatZ/INJzRS9U7qIKLR/37oD2ygxZMVSU
         SUpA6ShtrQsz2CaiNl0ajZSHUPKdqv9/PoSqaPo8Fj+/lnDdsnR/JQaH0fxw5LUNKpI9
         KBN71cIJ9p1wybY8YclVKPs1VHGK0w4qy6a5nwPk20uni5uwVDxkTa/q6BTsbqMR+U6V
         KgMldOcUTB7OkMPzjZJFMEzBUuwERyweAhkve5LW+vSGqSvDu1udejXEft8rBht42oF8
         6IRTWIB0IX05BT+0IRtATuzWT/pDZ/av5alQmJhy4jpq926GRrXJ1Z6JcskuQdAKQqk4
         P4LQ==
X-Gm-Message-State: APt69E1Pv67IH28elEclfDninn7eVHC0FtDM6xJbqHL+CAkwotWhCVsB
        jpmrxxGICGOiySTA5skVgw==
X-Google-Smtp-Source: AAOMgpeZm6fS06lIOMkrNhK2Ohjrn5qElXsh39oL0f4FucQr/WlNMDj/JZgMWbC3lcfhqKN46I3dvw==
X-Received: by 2002:aca:4784:: with SMTP id u126-v6mr34810592oia.229.1531324445763;
        Wed, 11 Jul 2018 08:54:05 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id n188-v6sm12780681oia.17.2018.07.11.08.54.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 08:54:05 -0700 (PDT)
Date:   Wed, 11 Jul 2018 09:54:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Frieder Schrempf <frieder.schrempf@exceet.de>
Cc:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        linux-spi@vger.kernel.org, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com, richard@nod.at,
        miquel.raynal@bootlin.com, broonie@kernel.org, david.wolfe@nxp.com,
        fabio.estevam@nxp.com, prabhakar.kushwaha@nxp.com,
        yogeshnarayan.gaur@nxp.com, han.xu@nxp.com, shawnguo@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/12] dt-bindings: spi: Move the bindings for the FSL
 QSPI driver
Message-ID: <20180711155404.GA15363@rob-hp-laptop>
References: <1530789310-16254-1-git-send-email-frieder.schrempf@exceet.de>
 <1530789310-16254-5-git-send-email-frieder.schrempf@exceet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530789310-16254-5-git-send-email-frieder.schrempf@exceet.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 01:15:00PM +0200, Frieder Schrempf wrote:
> Move the documentation of the old SPI NOR driver to the place of the new
> SPI memory interface based driver.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
> ---
> Changes in v2:
> ==============
> * Split the moving and editing of the dt-bindings in two patches
> 
>  .../devicetree/bindings/mtd/fsl-quadspi.txt     | 65 --------------------
>  .../devicetree/bindings/spi/spi-fsl-qspi.txt    | 65 ++++++++++++++++++++
>  2 files changed, 65 insertions(+), 65 deletions(-)

Next time, use the -M option so the move shows any real diffs.

Acked-by: Rob Herring <robh@kernel.org>
