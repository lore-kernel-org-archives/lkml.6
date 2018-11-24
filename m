Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6A0C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 20:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D672087E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 20:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cQYQ9fUj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D672087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbeKYHrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 02:47:49 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34877 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbeKYHrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 02:47:49 -0500
Received: by mail-lj1-f193.google.com with SMTP id x85-v6so13306171ljb.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 12:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G8aC00oI6Bq6NmQvXgGD7tu98VEEn1Ah4XoyIl86u1E=;
        b=cQYQ9fUjLcnFZGp+CYKwGs2RGLCSTBzErnbBytyqqI295ygJrfkngmYkfCekntnSYa
         +CKi99FfTbT2Zmuesk774/u2Vh5oBA53QYje+uiJasVLrLyRn/yVyPXJmE4m40gYkY/h
         az+d3cvK7ST0NXZFseURt+O3Crmskno2XG5G8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G8aC00oI6Bq6NmQvXgGD7tu98VEEn1Ah4XoyIl86u1E=;
        b=hO4ELJ9/DayY8MP8rml/d/6t03j7pkGGTZ1z8rk2MVDaAcN+w77ARRCCTC6Tz3oWTq
         uBslg8a7lhgBlqcaYq76v/LcD2ctW3cGtX3W6aTlOtDmwUDkVrO3jS0e06I1LHQDzPWs
         iRDnlfsN9+fASBIrLM4LMV7lMheWHWOxNhqsxAzvI/G6eqMIk3/SQnFkJU7MvuZWDNbX
         9uEZ/cM0svwyc+FTPMTEDZUfD7TBtzSYYXicSntvxkKx3nqkKMN/tqCUGKYZ9JYKEBVC
         N884Ol1faplQKUkhoUUbvPVQGLDFq1V+48AdRIEM/rk95ljGWwy6yJd0GneI1CLHXhtN
         ZAbA==
X-Gm-Message-State: AA+aEWbhejkCGfDHr92N9MQ8n+4aboEvg6VJeBkFAHs+t2GCVpeSVe9a
        YAVAFAuK3oBbebcTTwtD4vwV+1k0tdbtCyEUMPyVTQ==
X-Google-Smtp-Source: AFSGD/VkmdUXbCdaOYBUoRQujU4xjke7bxhIGNQAN0RyPQCApFI4hBRgV0wE7Aupt+4+CQrN/HUfWq3W5PGgyNs7Y1c=
X-Received: by 2002:a2e:29d7:: with SMTP id p84-v6mr12907970ljp.12.1543093111035;
 Sat, 24 Nov 2018 12:58:31 -0800 (PST)
MIME-Version: 1.0
References: <20181115221634.22715-1-greenfoo@gluegarage.com> <20181115221634.22715-9-greenfoo@gluegarage.com>
In-Reply-To: <20181115221634.22715-9-greenfoo@gluegarage.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 24 Nov 2018 21:58:19 +0100
Message-ID: <CACRpkdZs+jk-KY7kUnRz8EoSrGN74i2fiXwp8BNuSG6JNxgixw@mail.gmail.com>
Subject: Re: [PATCH 8/9] drm: remove no longer needed drm-get-put coccinelle script
To:     greenfoo@gluegarage.com
Cc:     "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>, sean@poorly.run,
        Jonathan Corbet <corbet@lwn.net>, abrodkin@synopsys.com,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux+etnaviv@armlinux.org.uk,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        kieran.bingham+renesas@ideasonboard.com,
        Shawn Guo <shawnguo@kernel.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>, michal.lkml@markovi.net,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        linux-doc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        virtualization@lists.linux-foundation.org,
        etnaviv@lists.freedesktop.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        cocci@systeme.lip6.fr
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 11:18 PM Fernando Ramos <greenfoo@gluegarage.com> wrote:

> The coccinelle script was used to rename some (deprecated) functions
> which no longer exist now.
>
> Signed-off-by: Fernando Ramos <greenfoo@gluegarage.com>

Patch applied with Julia's ACK.

Yours,
Linus Walleij
