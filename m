Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA8CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51AC218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdFleDy/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbfB0Bmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 20:42:54 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34718 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729335AbfB0Bmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 20:42:54 -0500
Received: by mail-oi1-f195.google.com with SMTP id g16so12156262oib.1;
        Tue, 26 Feb 2019 17:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8vCW/Wa8dcY8A4VZhcPLzXb5kVuJM8/rxF5r1eLFf1A=;
        b=jdFleDy/K/OpFEYG/BEAQsV3ZlQxOap9nG3Vs0jqfwT+wH0G6CRXDEMQML49Kydxbs
         5Q+qpxQy2ITIPdnNc5OjGPxqACsCupf7TgbQDhDc0/B9du96L3N0aRr6EiqgxyvNEyCO
         GaxNtuNzkUivMtBM9aZE/0bCfQMqK+dJLibpD4d0RBUovPQNQGUuWsIzndegVnavgI4s
         sIIs/sePzRJ0uR1ApKzGsx1rpnehjruAWHBF3lOdBMA8riJqalwirHCJWG3xcqmy8Lbf
         eme3ONiwNFqWmgRxy1aKgtGiBx/Cu0D0QufnkpwqjNfLqRMyomWMGc1OJpwlqmgbLjFG
         AZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8vCW/Wa8dcY8A4VZhcPLzXb5kVuJM8/rxF5r1eLFf1A=;
        b=cHbQ1g1nMWnLyJ2o7NGVmsqUL+Jv3lbfskTaxR7Nc14uY+FfoVX3n5MXiohlUT7GC2
         s7LTiyQAr6OxXb97MzXvuRZyuRPOvDYdRnp+6A4HYEGA3awJP+yRM0Uu8++wHIaiEh+Z
         FMi7CDxVuH0oDu00ilX8xdbGqsY7NK/umk2boJoTltDjifie4Pv3raF9f5w6SkeUUcEe
         NjSItC6/uEBIIuPH/dydgfSZSymdWsI+K6DuiVOJByZmnj3960rWG9sNpe19WHBkIrLI
         OQiSB93IIdVWYLZYJNo39vPDm7J85YvXjrWo/CxeYx2Q6+H34PUJbOESYKNgtlziKRD4
         +oBw==
X-Gm-Message-State: AHQUAuYRuhkb+HlrW/3k2KWAflgdceiXRycH8RifRD0aWkl7Ypw4kRgf
        sYFjVIkPeqHx3fWZoOGnCUMn8i/buFXSfYTcZGk=
X-Google-Smtp-Source: AHgI3Iag3I8rQGTloFiQlFwATou16YcDdDgnFdkS8hL1JGgcEQ6A86xFgCYWPkFmURaRoWeyWOONA5OokS6e7zkXaXE=
X-Received: by 2002:aca:b5c1:: with SMTP id e184mr4358645oif.75.1551231772955;
 Tue, 26 Feb 2019 17:42:52 -0800 (PST)
MIME-Version: 1.0
References: <1551230622-30660-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1551230622-30660-1-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 26 Feb 2019 22:42:41 -0300
Message-ID: <CAOMZO5ADvmVO51fbrGjtGsDaN_AQcJs=+mBBQoPzRwhWasJLrw@mail.gmail.com>
Subject: Re: [PATCH RESEND V2 1/2] clk: imx8mq: add GPIO clocks to clock tree
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 10:28 PM Anson Huang <anson.huang@nxp.com> wrote:
>
> i.MX8MQ has clock gate for each GPIO bank, add them
> into clock tree for GPIO driver to manage.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
