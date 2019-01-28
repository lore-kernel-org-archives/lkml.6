Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA19C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E011F20989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVd3dqYQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfA1TEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:04:36 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34054 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfA1TEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 14:04:35 -0500
Received: by mail-pg1-f195.google.com with SMTP id j10so7620436pga.1;
        Mon, 28 Jan 2019 11:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xhwTaNjNUp5cl5RzBHj8SgkWwruP00WgoVu3B1El6xs=;
        b=oVd3dqYQgO5BRmAJD7j2II3X5hEQJn/y2WXDHyGlIqkuho1QixQXPPfnq1oK4+O73g
         Kia4qh6M3A9IGDH5mSiF/hHdBLB4I4R4t000Gzlvw7Av/w1upfQM+q+ArA5f/OMrIThp
         IKknuWMZiv5Q2HCXwrVYB/ll6Y8OJg2/C6ZF7sd4B9VPrSHIuEyUkKPRTrABHS/YI1p3
         Phz3AS4KYqz6XuUe746zoCQMHnddfoikEfznucWuB0M1Zuo+rSPuEzDhAUdHhfFMz3Pe
         DYadNkvxvflF96GimDj7xCheMbiecgn1zu004rOQ6Aq6gDgwxsEPyvvLmt4Ujvh0RN3F
         6orw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xhwTaNjNUp5cl5RzBHj8SgkWwruP00WgoVu3B1El6xs=;
        b=muYtG3jh+mZyTtdSJtEMaEP3S7tB5TK3ehdN5JGLI97Y6DJDwViTQftQG6+18G7dYc
         0KIL/96opqjn/BGXmGwtUU4BtC/sOxcDTaZPnx/6b2yllcmia5kRlwunTi4wkXyMkHu9
         xy7cui6gxOUeqE7+nw4OvFXfTpFXdm2+XCIqruTJLueJy+ogFfpsA+RtZ6BaqTKCwTxr
         y30b4vKzuC2VG39s5g0Vmx8cLjiLbh7XMEaF27Hm96p+x3f5m65JsYG909wrVKBqsvrW
         cBPdktuGKZuZu6/VXONN8Ma49qLdPQqysnRFL35zJPD1jurAEwNlkBMuNBfMl550dAkP
         /iiA==
X-Gm-Message-State: AJcUukcSksRtoCPNuytZWkSvBU77TMQGwIvFbKFO3KSs2Mx4ZwIp02/f
        HQI04Z8mspTaniUCN37Fb+0=
X-Google-Smtp-Source: ALg8bN5VVAfpIP4nG4Fl9bsq/cftUVaDwU2zSl722GbGhbcz1WkMfYeKyxMXUM09sdGzqqvmx6Wq7A==
X-Received: by 2002:a63:e5c:: with SMTP id 28mr19389002pgo.369.1548702274698;
        Mon, 28 Jan 2019 11:04:34 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id h79sm53105601pfj.186.2019.01.28.11.04.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 11:04:33 -0800 (PST)
Date:   Mon, 28 Jan 2019 11:04:32 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Martin Kepplinger <martink@posteo.de>
Cc:     devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>
Subject: Re: [PATCH 3/3] Input: st1232 - add Martin as module author
Message-ID: <20190128190432.GB34692@dtor-ws>
References: <20190128084449.16070-1-martink@posteo.de>
 <20190128084449.16070-3-martink@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128084449.16070-3-martink@posteo.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 09:44:49AM +0100, Martin Kepplinger wrote:
> From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> 
> This adds myself as an author of the st1232 driver module as Tony's
> email address doesn't seem to work anymore.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/st1232.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
> index 19a665d48dad..906b233970aa 100644
> --- a/drivers/input/touchscreen/st1232.c
> +++ b/drivers/input/touchscreen/st1232.c
> @@ -346,5 +346,6 @@ static struct i2c_driver st1232_ts_driver = {
>  module_i2c_driver(st1232_ts_driver);
>  
>  MODULE_AUTHOR("Tony SIM <chinyeow.sim.xt@renesas.com>");
> +MODULE_AUTHOR("Martin Kepplinger <martin.kepplinger@ginzinger.com>");
>  MODULE_DESCRIPTION("SITRONIX ST1232 Touchscreen Controller Driver");
>  MODULE_LICENSE("GPL v2");
> -- 
> 2.20.1
> 

-- 
Dmitry
