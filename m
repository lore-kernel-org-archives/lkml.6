Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBF3C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C6A218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545342124;
	bh=OmBTaIO6ZLU6/AYt5lDNx0Ohpi7ViC4/hokQ8ig8Io0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KaBXbGyjV8lg3uQ21optAxK2LgOdpzsB/WsLszwyEa1IwVnv41kPFgGCoo5D0z77T
	 Lxy2W0z973IS0vQblba3qQ/q/sJOEN6MmUaKyk7VC5ENFnjtosX9KCOF5dM4iOJZp8
	 0a897IKCLPWPhrM2fXcV3k4eWLkO/z7wAnvSgH1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390036AbeLTVmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:42:03 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45322 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732606AbeLTVmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 16:42:03 -0500
Received: by mail-oi1-f194.google.com with SMTP id y1so3131432oie.12;
        Thu, 20 Dec 2018 13:42:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5YsEhyaUPRZXg/JZZlbqLdZiJRNmQFO+ziEMYQYfyvo=;
        b=MnXLsuFv0rmFHsN2SOV8Z5kWlMjAqevRTELENbfIcSYZVU62OwF+NomTE/WHLUX3tX
         dpegFGRZjpVM1Dpr52cv6ygUCWPT7Y7m7UNv6IeGnHagkpnbmb8CyFIYNHZCxnGUy5jp
         GROM2bmmorCnQoGk5/8h8IHRNwburg8a1jfZBKOqvr87BS7SoRC1JA7BF8cOVmDHo/l/
         kcBQOuYHYH0iptkeRaJgxwWnZuHoj+nq5yz6HgXYm8Rqqppz/1pmmGTrCf9EQye5VGdx
         GfIlf+vFcPraVhiKPjGzX+1N9kckcwanwET611V8tCG1CsSlvCY043HA2Pv09M8/9iF3
         JcJg==
X-Gm-Message-State: AA+aEWbMBelz9envI8TxtqtdWPzdtKPHdgaGIHTb06ISNDC47irx0dWp
        qL3WR52F8ZulC7bb25aBiw==
X-Google-Smtp-Source: AFSGD/VV1VdaqkMb24ABWv2itXTSQrD2vxZU0AokEdO6vky4wcTCLiw0ujWoS+/Cy3CBdCC/Usg1xg==
X-Received: by 2002:a05:6808:493:: with SMTP id z19mr316745oid.46.1545342122097;
        Thu, 20 Dec 2018 13:42:02 -0800 (PST)
Received: from localhost ([2607:fb90:1cd6:97bd:49af:e73e:5a36:3b50])
        by smtp.gmail.com with ESMTPSA id u18sm10224498otk.1.2018.12.20.13.42.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 13:42:01 -0800 (PST)
Date:   Thu, 20 Dec 2018 15:42:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, hjc@rock-chips.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        robh+dt@kernel.org, mark.rutland@arm.com, architt@codeaurora.org,
        a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        linux-clk@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 07/15] drm/rockchip: dw-mipi-dsi: add support for
 rk3368-variant
Message-ID: <20181220214200.GA15833@bogus>
References: <20181217123650.6773-1-heiko@sntech.de>
 <20181217123650.6773-8-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217123650.6773-8-heiko@sntech.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018 13:36:42 +0100, Heiko Stuebner wrote:
> Add the compatible and grf values and allow the driver to also
> not select a specific crtc input on systems with only one vop.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  .../display/rockchip/dw_mipi_dsi_rockchip.txt |  1 +
>  .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 25 +++++++++++++++++--
>  2 files changed, 24 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
