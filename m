Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71067C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3241B20817
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3241B20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbeKRCSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 21:18:35 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41964 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeKRCSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 21:18:35 -0500
Received: by mail-oi1-f195.google.com with SMTP id j21so537138oii.8;
        Sat, 17 Nov 2018 08:01:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=99IukoexswF128/k24Y6AlJQEQIjGiMkTJn1umMEO8Y=;
        b=rGO+mV83C0MZSDvOOZWSj9brnHjsADsd5xoXcgNQG7GiVZvt9i6P5GPxXlG+gtJPvj
         1duV5TVt88Rw2GT8R4sgja9ejYGs7Va6gpGs1r8VYr97cCH5IpUe7QcCCkqNcLXYbkpp
         LiYD734MKDZEvlhHOwusFmFuJ1kR6AnJ82xTDcpzYgIwhns3pbr3hzGm1JNArafaBjO7
         CNnqlX3BuyEGmiTQ7ybzmMDmrq65lXQJo/enpD66dD/1G5fNaJuhSox8Rf8lxAXpZrWF
         dxW4CHoXvEtabn9I3r3BZuKTtNM7SDXyEdUKbm7P5IPWOn9rp926ahtYZEBa3E6yOr4d
         8AXg==
X-Gm-Message-State: AGRZ1gIlRo8coJPj++fceAfnYNxjebhqUZm/KP/X08cHO+ybA9+TEMGN
        514lWxOI2c9ptQSDUDMaf0eHOCI=
X-Google-Smtp-Source: AJdET5ddmdpKirEJxd6AXZM28UWm9D/aFKe4gVBb/M6KunclVYq/cDq/EJ9mnQmze5/nomIDtcTzLw==
X-Received: by 2002:aca:f341:: with SMTP id r62-v6mr3669099oih.230.1542470488616;
        Sat, 17 Nov 2018 08:01:28 -0800 (PST)
Received: from localhost ([166.137.105.180])
        by smtp.gmail.com with ESMTPSA id i35sm1142737ote.69.2018.11.17.08.01.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 08:01:27 -0800 (PST)
Date:   Sat, 17 Nov 2018 10:01:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND v2 1/2] dt-bindings: arm: amlogic: add libretech
 aml-s805x-ac bindings
Message-ID: <20181117160123.GA29221@bogus>
References: <20181116151539.18501-1-jbrunet@baylibre.com>
 <20181116151539.18501-2-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116151539.18501-2-jbrunet@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2018 16:15:38 +0100, Jerome Brunet wrote:
> Add bindings for the Libretech aml-s805x-ac board, aka 'La Frite'.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
