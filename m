Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBBDC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D509E20883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbfAHRic convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:38:32 -0500
Received: from gloria.sntech.de ([185.11.138.130]:41502 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbfAHRic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 12:38:32 -0500
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1ggvKd-0001RJ-RZ; Tue, 08 Jan 2019 18:38:27 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Alexandru Stan <amstan@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        kieran.bingham@ideasonboard.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        kernel@collabora.com, Benson Leung <bleung@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/4] phy: rockchip-inno-usb2: fix misspelling and kernel-doc documentation.
Date:   Tue, 08 Jan 2019 18:38:26 +0100
Message-ID: <35160832.xjWYcIOf1W@diego>
In-Reply-To: <CAFqH_50tz1Toi6L1Ju5imyMRPzN1bDg7mxzcLrJWvdxOwknfdw@mail.gmail.com>
References: <20180815095934.11205-1-enric.balletbo@collabora.com> <2908229.jFki8unlfB@phil> <CAFqH_50tz1Toi6L1Ju5imyMRPzN1bDg7mxzcLrJWvdxOwknfdw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

Am Dienstag, 8. Januar 2019, 18:35:38 CET schrieb Enric Balletbo Serra:
> Hi Heiko and all,
> 
> Missatge de Heiko Stuebner <heiko@sntech.de> del dia dc., 15 d’ag.
> 
> 2018 a les 12:31:
> > Am Mittwoch, 15. August 2018, 11:59:31 CEST schrieb Enric Balletbo i 
Serra:
> > > Fix the typo flase -> false and clean up the kernel-doc documentation in
> > > phy-rockchip-inno.usb2.c and fix the following warnings when
> > > documentation
> > > is built.
> > > 
> > >   :58: warning: missing initial short description
> > >   :69: warning: cannot understand function prototype: 'enum
> > >   :usb_chg_state '
> > >   :97: warning: missing initial short description
> > >   :136: warning: cannot understand function prototype: 'struct
> > >   :rockchip_usb2phy_port_cfg ' 157: warning: cannot understand function
> > >   :prototype: 'struct rockchip_usb2phy_cfg ' 163: warning: Function
> > >   :parameter or member 'port_cfgs' not described in
> > >   :'rockchip_usb2phy_cfg' 187: warning: cannot understand function
> > >   :prototype: 'struct rockchip_usb2phy_port ' 204: warning: Function
> > >   :parameter or member 'port_cfg' not described in
> > >   :'rockchip_usb2phy_port' 207: warning: missing initial short
> > >   :description
> > >   :234: warning: Function parameter or member 'dev' not described in
> > >   :'rockchip_usb2phy' 234: warning: Function parameter or member
> > >   :'clk480m_hw' not described in 'rockchip_usb2phy'> > 
> > > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > 
> > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> 
> I included this patch in these series because I found the errors when
> I was working on this. But this patch doesn't really depend on the
> other patches and probably I should have had to send independently. I
> am planning to send a new version of these series excluding this
> patch. I think that the patch can be already picked (still applies
> cleanly and is fine to pick?) or do you prefer I resend?

I would resend it.

The patch is from august 2018, so I'd guess Kishon won't have it in his
inbox anymore, so a resend may be easier for everyone.


Heiko



