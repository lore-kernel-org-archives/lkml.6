Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D69C282CB
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027DD21736
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fQk60jkq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbfA1HTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 02:19:41 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33236 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfA1HTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 02:19:41 -0500
Received: by mail-wm1-f65.google.com with SMTP id r24so9683267wmh.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 23:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TXYHMJ2QbFqSZ0VMU5oqBXlbGmWhaw/EnvaZ4/gwCyc=;
        b=fQk60jkqTWKQOZ07LChas50kmBwP0C3F6i+ED9JpOiqeo3xa5NR8UZyE0Yxw9kzPAn
         1z+4C0lu5Z4RV7b2EvM1KzK6RfwiKRZFNhCNCEn0RgLu5VVE1uZBoU3MkH/dkDnriqmd
         5gpzPXQw3OTNszHw6Y05EW6dvO9Kvsg7LnP/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TXYHMJ2QbFqSZ0VMU5oqBXlbGmWhaw/EnvaZ4/gwCyc=;
        b=P1DNRuyeO1I3nC1jx5TVRQ/67g9W622SSDkpoAgnxu5l2SP7AjbDWbmJfBo69h6h5/
         AP7v+VS3ZHtO+ypRPhfNqGzqRRm2I+mE20lrJmC4LDo7rAKT2eEDl6e9PF6KqJ5VAqh3
         +MH7lwYQDdqbNkhUMeVR0g6Muc7Q5Y6CpIlQXKzrAwIjFPLfhQ1Sv8mZU35LobWBdMUI
         3bjCMm72ck2hfgQ/XIobrIwGX/5hpL4jKbJAOXtm2C+Aee1Cj2RFww5uYKcnHwyPyEBy
         OQo4+EgY6A9KR0GIN/JwK3kdYz2WHR2OrNUXY5R9GNRwN905sORpOtAnwk041iRVfd/Z
         r03g==
X-Gm-Message-State: AJcUukdXA+EuNCGmgbODelurnBQG3lUr2riSURPwciWjz/h1pZVu/pbE
        Ja7OXipyc75OL+wJlrIzSrAo1A==
X-Google-Smtp-Source: ALg8bN60H1UnmQzAd6CC5HV7/G5IW96x8oGqfJ7eDrkCMFPks2zRNzQpSRTHzjv3j6GgB7dcD5gFzg==
X-Received: by 2002:a7b:ce84:: with SMTP id q4mr16649262wmj.105.1548659979125;
        Sun, 27 Jan 2019 23:19:39 -0800 (PST)
Received: from dell ([2.27.35.198])
        by smtp.gmail.com with ESMTPSA id y138sm80954826wmc.16.2019.01.27.23.19.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 23:19:38 -0800 (PST)
Date:   Mon, 28 Jan 2019 07:19:36 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com, robh+dt@kernel.org,
        mark.rutland@arm.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        linux@roeck-us.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [RFC PATCH v2 00/10] support ROHM BD70528 PMIC
Message-ID: <20190128071936.GD4678@dell>
References: <20190125110110.GA29171@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190125110110.GA29171@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2019, Matti Vaittinen wrote:

> Patch series introducing support for ROHM BD70528 PMIC
> 
> Please note that patch 1 breaks compilation without patches 2 and 3
> 
> ROHM BD70528 is a programmable Power Management IC for battery
> powered 'ultra low power' systems like the pre-announced NXP
> i.MX7 ULP. This patch series introduces support for the PMIC.

It looks like you've sent this set un-threaded, which means as people
reply to the patches, they are going to be spread out into the four
winds (in Inbox terms).

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
