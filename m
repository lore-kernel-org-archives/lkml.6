Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5551C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A4722070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550878696;
	bh=Ff8+Wm37knHyjW4z1GJ9PwnaGsVHJg2FCCcDHbcYmlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pjJBKRHXPWx4ezdLYA37qmkXCe3LSQFK9fFo0GQ6X3eI5gbyOYHnia21AzSwshUdm
	 O6WMe1edxLVbQU5LEuYwYbZxrRFdvYeKbQm4ZZNEBC2FXOUrXmX8HAoq5bqj3Plym4
	 FrVLb6fAg7ow9ej9VnOa2zN6aZ0tivUlG3I9je78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfBVXiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:38:15 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40322 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbfBVXiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:38:14 -0500
Received: by mail-ot1-f66.google.com with SMTP id v20so3338489otk.7;
        Fri, 22 Feb 2019 15:38:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1nizO+O3jOjh7hVKOxJ1C1X63izeUZlUr3vc7r47AOU=;
        b=fVJJ7AnBkzOU+FFsuxKiq2pexr6bSYMzvM3WSSRx78J5u2OkUwXu0ZEalhL8QzlJVT
         zSzFIkgbkPwM3QtsWZndi7x+lC289QBc5D2sNqS5ZP/2htmDlcMVutldMTEj1N81yLyu
         xCLhNbyYKzeATKdUjnA4J9AShK7JZvbyffvQwCNUMH6iQJyoXcQh8gURpg32Ra+vTn7q
         IVxX7YgybvqKjj7uFDsypakbeum0yxT/UjS9tgb9GDOlYnyQ2589j/6mv7fLtRGz6Tyh
         xfFmjcl+gMqOb2SCYE5YR3m0A6jJvt+ajQ2Sg3IYZqja+/slnAnenPi9+ia/D97bWh2H
         SE4A==
X-Gm-Message-State: AHQUAubhoRlxK7iO6Q4MGPGd1eJXKFWZdjSkT1IF05Wmxd4yGZ/WY7/L
        lC+BYw8kERT8G0K6IIYNbA==
X-Google-Smtp-Source: AHgI3IYSWDh6XITjrw4BLHjg/JWbcAdoVAd5D822js5yCXLKaIB/MkUcTZcmIcg7wK+aj8k6joqkTw==
X-Received: by 2002:a9d:7404:: with SMTP id n4mr4449234otk.54.1550878693455;
        Fri, 22 Feb 2019 15:38:13 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f25sm1048987otl.75.2019.02.22.15.38.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 15:38:12 -0800 (PST)
Date:   Fri, 22 Feb 2019 17:38:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Claudiu.Beznea@microchip.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, sre@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Claudiu.Beznea@microchip.com
Subject: Re: [PATCH v2 3/3] dt-bindings: arm: atmel: add binding for SAM9X60
  shutdown controller
Message-ID: <20190222233812.GA13502@bogus>
References: <1550756716-3032-1-git-send-email-claudiu.beznea@microchip.com>
 <1550756716-3032-4-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550756716-3032-4-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 13:45:56 +0000, <Claudiu.Beznea@microchip.com> wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Add documentation for SAM9X60 shutdown controller.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
