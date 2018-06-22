Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3C2C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B282407A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="e1nkOqPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14B282407A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933279AbeFVKlc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:41:32 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55000 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754441AbeFVKl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:41:28 -0400
Received: by mail-wm0-f67.google.com with SMTP id o13-v6so1756811wmf.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 03:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q/Wctey7pt0p9Es5eAhPD2Mkb4xfhbwWcY+NdFzOIvQ=;
        b=e1nkOqPmt1/wTjktEhZij+jdBW1PCLLTHcTWIDT/EfTLzqVbFzOldrAmcjAzmpM/N+
         qRci+IHOH28uxnY/xtXeHXyCyXCZiG94w2JdsbanzDXR85A714ytULHeJuRTze2aD+V4
         IzG3VpvavX/SUGgCb1zNV+JUgK/bUzz/f5ng80UZaIMXOS1XEciAXryzwIU6cstLliWU
         120wghcYlWzkApEppLwjEzcLOIKDC75qSr5AzWxWB1/Y7FYUUsi0y+ZBan9aXeyklnSE
         MZjeZXTgq2OgwiN7ZrFliY7b0bW/XAC1gqXbuEt3qtasPD7CWPY+XvkIN/UJ84NLL1py
         /i6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q/Wctey7pt0p9Es5eAhPD2Mkb4xfhbwWcY+NdFzOIvQ=;
        b=Q/EExY/z9RmiUxya9dPy+zixlWUfXC05faKw7/Io0IthzRXuQImu9LhG2+k2Ow3vPq
         yj9w+Qb0O/zzXQIW6ur84ZrSZKmuTQl0JeQ+YWrqzDdvMubErgSXGKiRXtpb6EIoVX1W
         yztiuAn7Ic2iDh2r60bdLojtj20fsqT+X4HOWh4j4ai2xzVApzfHKWL3pt+rQAcDijby
         BiB2l77cm98iV+QkrVpf2wwV1q46sjF97UX2VAlSYEjLWzHVhR8ZROXg6bRC2HbwFWLH
         yMQSHWwPhUpE8wYsBy+O6UUy7758hstZarkBpylkzuwGHVlRRH4Ecys+epYVjRrm0Ya0
         zGQg==
X-Gm-Message-State: APt69E33Zn4X5bt+EL0YylnPefgCqxRReKYrIP3snVVwj/o6MReHtRz9
        LmebAv+x0xoU2sS5h7601M5R+Q==
X-Google-Smtp-Source: ADUXVKIFq8urHmfyHDNt6FMng+bT5u1Ofn4xtKTLjr3mbZLER5loIomBy7x/ppgkiCbbV/AFO4npWA==
X-Received: by 2002:a1c:3fd1:: with SMTP id m200-v6mr1377535wma.88.1529664087388;
        Fri, 22 Jun 2018 03:41:27 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b14-v6sm7512316wrn.57.2018.06.22.03.41.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 03:41:26 -0700 (PDT)
Message-ID: <1529664085.2900.3.camel@baylibre.com>
Subject: Re: [PATCH] clk: meson: audio-divider is one based
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 22 Jun 2018 12:41:25 +0200
In-Reply-To: <e8898e54-24b1-ec77-1b08-390607640747@baylibre.com>
References: <20180619154753.12788-1-jbrunet@baylibre.com>
         <e8898e54-24b1-ec77-1b08-390607640747@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-20 at 10:31 +0200, Neil Armstrong wrote:
> On 19/06/2018 17:47, Jerome Brunet wrote:
> > The audio divider is one based. This offset was mistakenly dropped from
> > recalc_rate() when migrating to clk_regmap.
> > 
> > Fixes: 88a4e1283681 ("clk: meson: migrate the audio divider clock to clk_regmap")
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > ---
> >  drivers/clk/meson/clk-audio-divider.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clk/meson/clk-audio-divider.c b/drivers/clk/meson/clk-audio-divider.c
> > index 58f546e04807..e4cf96ba704e 100644
> > --- a/drivers/clk/meson/clk-audio-divider.c
> > +++ b/drivers/clk/meson/clk-audio-divider.c
> > @@ -51,7 +51,7 @@ static unsigned long audio_divider_recalc_rate(struct clk_hw *hw,
> >  	struct meson_clk_audio_div_data *adiv = meson_clk_audio_div_data(clk);
> >  	unsigned long divider;
> >  
> > -	divider = meson_parm_read(clk->map, &adiv->div);
> > +	divider = meson_parm_read(clk->map, &adiv->div) + 1;
> >  
> >  	return DIV_ROUND_UP_ULL((u64)parent_rate, divider);
> >  }
> > 
> 
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
> 

Applied for fixes
