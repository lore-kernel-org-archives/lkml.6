Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786EEC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7A320827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGyizKUS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbfAHRfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:35:51 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39218 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfAHRfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 12:35:50 -0500
Received: by mail-qt1-f196.google.com with SMTP id u47so5263086qtj.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 09:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bQeG/bTYFgG4QFMLKTEBa9/B0VgVbffUqu5K1tWUHxA=;
        b=DGyizKUSlAGBIEaGyznWWbRK8/HqNUwIRS0T2bak4Be9XM8IQ064cxcYUgscyeT1Qb
         41ps8zamyeRo/uaBG1TSR/zioWPWlz8XtfhOwDtuWinWpJdo52hltYwoVdbmVamwWr/5
         M5rYI7G2fp84njHYGwOuAdDN1ffYPrTtR4SMWPJAX3y2k7ZqdfaCuW2pIMptfWUjXBqN
         dVz3EkDUe7nVWRRoVnZCUx7Tcp8J9uwAvyaQq55bYj9oH85ACZGLXaCTDvno9ED7aJ/7
         TwfC3PW2RQHsbKqfL7HuuGAnyHCdTHacToY/PKWEBg0FccYqVQqSsnd5SbLo0FtG7V0I
         MJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bQeG/bTYFgG4QFMLKTEBa9/B0VgVbffUqu5K1tWUHxA=;
        b=MNPEpLjror5ehYwGwVLhmlpOWGtvbBUU7TpIg7D9/B9WsFRg/glXqxljCGxlpoxLxg
         it8jIcBeVYc7R7ucuINkhzS1KhvC/UPfIDetj7YCl1x4m//x39mrkUtzEBp/8U8LKTa0
         JvarKvsQrNQpi9fvqvSsb3lAG/M3jjHmyDKbGWiF7Of/2QusL0Hv+/B0M9+idbGaa5Np
         lAKrrtmtkmsG9eFJ/OrG93xYTAbs7dVEq+kO2Sz9GksUEL9DmKSCYiuhL1EgRCyJi9Km
         jjNp5X68XaVg7bpRlqNr116NsdjE/ha4QTkcWWA0Dbtc8PMPenCZ5BPc5ViSAQt4hITR
         uPVA==
X-Gm-Message-State: AJcUukcPM9+IdWwBXFkuMTi8IGibUKhVniz7Mt3rCa7AIkGced1QwLVd
        2EKBk537IYphHFpC6m8f0dIY1VNUcQgB39D7mzA=
X-Google-Smtp-Source: ALg8bN7JU4O1yk7PnwBKHsn3+TgNirmfweumaL0fdDrhp+BfHIBO47/8LYsYSEwvXbdzWIdXH6/0QGQS3WIfc56Oy14=
X-Received: by 2002:a0c:8542:: with SMTP id n60mr2559309qva.205.1546968949355;
 Tue, 08 Jan 2019 09:35:49 -0800 (PST)
MIME-Version: 1.0
References: <20180815095934.11205-1-enric.balletbo@collabora.com>
 <20180815095934.11205-2-enric.balletbo@collabora.com> <2908229.jFki8unlfB@phil>
In-Reply-To: <2908229.jFki8unlfB@phil>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Tue, 8 Jan 2019 18:35:38 +0100
Message-ID: <CAFqH_50tz1Toi6L1Ju5imyMRPzN1bDg7mxzcLrJWvdxOwknfdw@mail.gmail.com>
Subject: Re: [PATCH 1/4] phy: rockchip-inno-usb2: fix misspelling and
 kernel-doc documentation.
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Alexandru Stan <amstan@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        kieran.bingham@ideasonboard.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        kernel@collabora.com, Benson Leung <bleung@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko and all,

Missatge de Heiko Stuebner <heiko@sntech.de> del dia dc., 15 d=E2=80=99ag.
2018 a les 12:31:
>
> Am Mittwoch, 15. August 2018, 11:59:31 CEST schrieb Enric Balletbo i Serr=
a:
> > Fix the typo flase -> false and clean up the kernel-doc documentation i=
n
> > phy-rockchip-inno.usb2.c and fix the following warnings when documentat=
ion
> > is built.
> >
> >   :58: warning: missing initial short description
> >   :69: warning: cannot understand function prototype: 'enum usb_chg_sta=
te '
> >   :97: warning: missing initial short description
> >   :136: warning: cannot understand function prototype: 'struct rockchip=
_usb2phy_port_cfg '
> >   :157: warning: cannot understand function prototype: 'struct rockchip=
_usb2phy_cfg '
> >   :163: warning: Function parameter or member 'port_cfgs' not described=
 in 'rockchip_usb2phy_cfg'
> >   :187: warning: cannot understand function prototype: 'struct rockchip=
_usb2phy_port '
> >   :204: warning: Function parameter or member 'port_cfg' not described =
in 'rockchip_usb2phy_port'
> >   :207: warning: missing initial short description
> >   :234: warning: Function parameter or member 'dev' not described in 'r=
ockchip_usb2phy'
> >   :234: warning: Function parameter or member 'clk480m_hw' not describe=
d in 'rockchip_usb2phy'
> >
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>

I included this patch in these series because I found the errors when
I was working on this. But this patch doesn't really depend on the
other patches and probably I should have had to send independently. I
am planning to send a new version of these series excluding this
patch. I think that the patch can be already picked (still applies
cleanly and is fine to pick?) or do you prefer I resend?

Thanks,
 Enric

>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
