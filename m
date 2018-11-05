Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89084C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 462942081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:45:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 462942081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbeKFGHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:07:24 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46958 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbeKFGHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:07:24 -0500
Received: by mail-oi1-f196.google.com with SMTP id k64-v6so8720151oia.13;
        Mon, 05 Nov 2018 12:45:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VXLNcBt0llxfTL+O3uJcnDX1x/s5upjviRgMS83l+u4=;
        b=MT6WhDL4n/ot4sEs+ZI8F8AlJNUwH8cL1bjthGlXPqVxGnJq4bpERH6eubqnWwHNVL
         ynLyNoqrigP8h38C2T8sveg48X2f63U2nss1pK2ZrKebqvCYhg1yTz41D19SZJxWQqka
         U0Piac8FpoAwZlL0+MHAtCl3A/RtMPwlOOBBhrnFy4aMyD+hk9PV1iAIwJ8QWK5EbGn2
         QQEpzeHs5YsAcUAoLi6LruIkr65QOO6GsfEh5QbW8CXc0cGX7uAAC2B/YeJu1F+DzWAn
         nSfFAc80CcAofFhRP0fT8RztJ64uM5alLAb5oZJJS2iob+GnZHacn1x/zSi3awoA3E5K
         1r5w==
X-Gm-Message-State: AGRZ1gLBbHqbq5APxAZoyCynHZEbO1rd+crAA0dZZOWHk3t8XKd05Ucs
        GRwNg4zsFnEve3Pd9DvrTaxYgZY=
X-Google-Smtp-Source: AJdET5eDvIyZo3hDkhE837PXmSoHVKCTRKfswZYb0oTA3OjAj1UsVaJxGgldPD9BNKfstYTWcO/4dA==
X-Received: by 2002:aca:5884:: with SMTP id m126-v6mr14321023oib.233.1541450753571;
        Mon, 05 Nov 2018 12:45:53 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m63-v6sm15514737oia.30.2018.11.05.12.45.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 12:45:52 -0800 (PST)
Date:   Mon, 5 Nov 2018 14:45:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     thesven73@gmail.com
Cc:     svendev@arcx.com, robh+dt@kernel.org, linus.walleij@linaro.org,
        lee.jones@linaro.org, mark.rutland@arm.com, afaerber@suse.de,
        treding@nvidia.com, david@lechnology.com, noralf@tronnes.org,
        johan@kernel.org, monstr@monstr.eu, michal.vokac@ysoft.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, maxime.ripard@bootlin.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH anybus v3 3/6] dt-bindings: anybus-bridge: document
 devicetree binding
Message-ID: <20181105204552.GA19286@bogus>
References: <20181104155501.14767-1-TheSven73@googlemail.com>
 <20181104155501.14767-4-TheSven73@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181104155501.14767-4-TheSven73@googlemail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  4 Nov 2018 10:54:58 -0500, thesven73@gmail.com wrote:
> From: Sven Van Asbroeck <svendev@arcx.com>
> 
> This patch adds devicetree binding documentation for the
> Arcx anybus bridge.
> 
> Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
> ---
>  .../bindings/misc/arcx,anybus-bridge.txt      | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/arcx,anybus-bridge.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
