Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5D9BDC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0590120660
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0590120660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754209AbeFLS1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 14:27:37 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35299 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752696AbeFLS1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 14:27:35 -0400
Received: by mail-yw0-f193.google.com with SMTP id v131-v6so7848853ywg.2;
        Tue, 12 Jun 2018 11:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WC9MusjZg8Gu9y09Nwy+RhoTfiQuWDYXKWHAtATWWEY=;
        b=bOmYgftI5zVjzFSU7NaHYpgMeW33b7tvu1+LlgHYLtn3D3JYYnOFexTbprqVfRU62B
         LmxmwhdNmnIWZbrJpBhk05cZ/bVVc1e6sk2D3p3VnMzcr2E6ebSlOSlbN3t5mAaR4tdR
         vY8eSovQDZMCbTG4WDJorUO3TQxqsbMEexak3nEEbBr69NPN7g+hlffvFltIWmTNEte1
         cT/qs7Q3ZgAA660ixs/2K0cxc6xc0SklfrPmBaWthoEkIZiC2tX1itjduh+8HUziDEVm
         j0/Rfvxh3uqpC30sP6KbLtrX4MKdX3G9f4vYjYd+SkYJGiJqfmJ8xQdEJh8ZS8zHcIlF
         s5fw==
X-Gm-Message-State: APt69E3ixQl8hXuF7W9VNriE0t6roQX554wu/3rcV9WzeWAt/Dy+eAom
        +7ioL+Tgk+k9cc7W83dAFw==
X-Google-Smtp-Source: ADUXVKIbMo73Z8umSN5wnFpTG+N6roR9gx3FTkBFmNBFAfn3xu9ks1+xa0e+gpQgVuSx0ZTZQaiJVw==
X-Received: by 2002:a0d:fd87:: with SMTP id n129-v6mr737527ywf.258.1528828054476;
        Tue, 12 Jun 2018 11:27:34 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id v72-v6sm408160ywg.25.2018.06.12.11.27.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 11:27:33 -0700 (PDT)
Date:   Tue, 12 Jun 2018 12:27:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Colin Didier <colin.didier@devialet.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?iso-8859-1?Q?Cl=E9ment?= Peron <clement.peron@devialet.com>
Subject: Re: [PATCH v7 3/5] dt-bindings: timer: add i.MX EPIT timer binding
Message-ID: <20180612182731.GA11378@rob-hp-laptop>
References: <20180611155001.3506-1-peron.clem@gmail.com>
 <20180611155001.3506-4-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180611155001.3506-4-peron.clem@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 05:49:59PM +0200, Clément Péron wrote:
> From: Clément Peron <clement.peron@devialet.com>
> 
> Add devicetree binding document for NXP's i.MX SoC specific
> EPIT timer driver.
> 
> Signed-off-by: Clément Peron <clement.peron@devialet.com>
> Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  .../devicetree/bindings/timer/fsl,imxepit.txt | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/fsl,imxepit.txt

Reviewed-by: Rob Herring <robh@kernel.org>
