Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684A5C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14AE521756
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14AE521756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731341AbeHNBew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 21:34:52 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:39138 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730203AbeHNBew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 21:34:52 -0400
Received: by mail-io0-f196.google.com with SMTP id l7-v6so12642772iok.6;
        Mon, 13 Aug 2018 15:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZHtmVaizz9P3rZ8wpwsn8trGucJrrElzOdxfBBENLQw=;
        b=o1bK1378aszM90Qnql/nFo2vFhGB+dUMgYkyJGE/rZ4CY1NlmmUmsBeFZ4Swq/cTaS
         Z465ExhRQWb196z80n2WbuoSUhjP11ScI/MvH0yY5cPjUDgeUkxGR4C/lwProHo8ERoz
         pIaimEQQEAlA0IWTAEIEZ9+lhXwtKth/1mtzKFVfBfmpZikVlpCql0rUpwDkDWpb+8sp
         hoE7fbXj9vhJGv8dD1txEqMvCohfK5higNXtGrJHwZ9gLaiAVvLoaQQt9ESoMXCvGoAP
         uaArkLVtsVBgGzW7Mwby9mYEsQWWOA023QvPg/XgSbl8mXIudTAozt0ZCnsN6VYbHW6f
         LnYA==
X-Gm-Message-State: AOUpUlFE0WBcetc8FBY4fP9WdFMKuI8+FzCuJsh7G5eUNs49nYtTOCIf
        vNOKoBF/ZxzJcno/t7UWNSe7k78=
X-Google-Smtp-Source: AA+uWPzTovm4jTaBCZjHsAyF6dnHllJL148AxMYbQmJGc1rxd5m6R40tvGWNydd28R5UzaqaF7skJg==
X-Received: by 2002:a6b:c389:: with SMTP id t131-v6mr17148680iof.157.1534200634216;
        Mon, 13 Aug 2018 15:50:34 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id z195-v6sm16192473ioe.38.2018.08.13.15.50.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 15:50:33 -0700 (PDT)
Date:   Mon, 13 Aug 2018 16:50:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 2/4] dt-bindings: net: phy: mscc: vsc8531: remove
 compatible from required properties
Message-ID: <20180813225032.GA29518@rob-hp-laptop>
References: <20180730130236.3837-1-quentin.schulz@bootlin.com>
 <20180730130236.3837-2-quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730130236.3837-2-quentin.schulz@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 03:02:34PM +0200, Quentin Schulz wrote:
> Compatible isn't a required property for PHYs so let's remove it from
> the binding DT of the VSC8531 PHYs.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> ---
>  Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt | 5 -----
>  1 file changed, 5 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
