Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADE8C37124
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4C7A2089F
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548119757;
	bh=Ls8KZGII30/UITtHlJWd95A80iqkvI2BCwD2JhqTBuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Yhn2dpErrcPZG/x9BXYvHetzUKekFElEeVVfk9RhECWczS9evw7/ZJo70h7tzg0HY
	 oSE7oB3i1B71VvdDmzcJH2jjlr+uvkOGDt8na+npSgBLQhjcbeibA/eZSXKyvSIRJy
	 ijIaI02Qeq/puG0RVCm1QfXFojDyUvepIGb2AtCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfAVBPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 20:15:55 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39703 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfAVBPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 20:15:55 -0500
Received: by mail-ot1-f66.google.com with SMTP id n8so22210440otl.6;
        Mon, 21 Jan 2019 17:15:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BEu3pUUs7cIEbpfX9paEs9a2pDUwLpKNQ18jjse0Z6g=;
        b=kR5Qr5ayLf1q37ibS9dRTnjjSuQvi0CefBJBK/IIHEJTHiM4i32M9uB/SNMOdKv20G
         gU6cOE8Y0oOjRIOd2ryBMXM1rjZdJRPs8Dd09X7he0eTnweDtGjXr3/ATpzA3bqevunS
         4bmfi5pS6Hj0MvC43nmMk0+GNCBrxEFm41Qm0NbjVDj8SGT66OjTm4XvBTuLjIOcrP7Y
         6ncnyX5MOxlCMqrAizZ51KtCaK/eCm9BOFmSH8agTidZKRf07bGYPh9VHkqKrP3rD1Pf
         dqNMLLRM/bZJ6o74mnkPdVdaFPC6HjIO9KZ74EQ4cL7QHHvydxTCPT15ko52tnDugAlu
         j9+w==
X-Gm-Message-State: AJcUukeQigDFTgv/PJIvXZb7U10FL/yHfujRysVNBOk3xWMzj8SpkrLb
        4Yt6vq/QcWxsUrz4YHtE1A==
X-Google-Smtp-Source: ALg8bN7rMWRz4srLSck8KLsBop2z22N3M1X3Rp/DXe4hGBm6ubHY0vBWvhFqUwDPae/5UM8M29rc1A==
X-Received: by 2002:a9d:6b82:: with SMTP id b2mr19585549otq.210.1548119753968;
        Mon, 21 Jan 2019 17:15:53 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s17sm6507367otp.36.2019.01.21.17.15.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 17:15:53 -0800 (PST)
Date:   Mon, 21 Jan 2019 19:15:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <treding@nvidia.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Johan Hovold <johan@kernel.org>,
        Lukasz Majewski <lukma@denx.de>,
        Michal Simek <monstr@monstr.eu>,
        Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ben Whitten <ben.whitten@gmail.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-clk@vger.kernel.org, Biju Das <biju.das@bp.renesas.com>,
        linux-kernel@vger.kernel.org, ebiharaml@si-linux.co.jp
Subject: Re: [PATCH 11/11] dt-bindings: can: rcar_canfd: document r8a774c0
 support
Message-ID: <20190122011552.GA5593@bogus>
References: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1547663874-29411-12-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547663874-29411-12-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2019 18:37:54 +0000, Fabrizio Castro wrote:
> Document the support for rcar_canfd on R8A774C0 SoC devices.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> ---
> This patch depends on:
> https://patchwork.kernel.org/patch/10687999/
> https://patchwork.kernel.org/patch/10688001/
> 
>  Documentation/devicetree/bindings/net/can/rcar_canfd.txt | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
