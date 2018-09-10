Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C32C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A05D4206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e1zS135q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A05D4206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbeIJQHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 12:07:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37009 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727683AbeIJQHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 12:07:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so21428684wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 04:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=EN+AityJMOR8zhz8D4wuJqib82/xGKemgPYeBFDJRec=;
        b=e1zS135q20wpxMnJt2eoTVLLJJDP6tCK5MgW15Vy4fwhxjJcSZXGQtw6Zns74dPtxg
         TJG1tJJRa1diYApy342LGkQsQlLpR6kmTiI+V4wHkYLroTwlIRVebUizpcWZWmvDfzyE
         ysTEbDoDj11O1ox/QU8An1pdefJxigh5uNqV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=EN+AityJMOR8zhz8D4wuJqib82/xGKemgPYeBFDJRec=;
        b=EHK+LEaX93BzJVfnimxaWoWeMKzxvaAPy/foKN7079d5hEC2ArWm+SncmtubmLd8KN
         kLrwTaAC098iXdXV4T0Y2e1jnd65sQQUKT1wzLGBLeW82w+3s7DmSX3iBISaHDQ9//Vx
         S/bGRprMnXn1C/cjXMgONJWlENZedNHVQWrSjR6KCWi6U4X85TGUNnAoYWswb8TdJImB
         MGoUg0NAbQh6qZDkqG4TeaRYKEzmvX6kKcMZJASSmau/wNhhe2iYJ4JJVIgVsanRtZak
         sTimoMBVxXaefRbQd9RQHEMa27KbP7ExQ9CxEPECcxhLpGSLxRrvmtA2sRY6MTOYvz8o
         OfSw==
X-Gm-Message-State: APzg51Bv7lCM8fzEpZtBSF54A3rIkdA/kOzqt+ohHbNmEmVhApn9g+/t
        FIRskokX8Gl+WF6zny1qMOEjfw==
X-Google-Smtp-Source: ANB0VdbUa6j7pW6mnJh8VFmteeDLvalIISgaOtF0whBnfwDYsDiWS71SsWYxqTW3+GraLCY1k/TZxQ==
X-Received: by 2002:a5d:470d:: with SMTP id y13-v6mr15221854wrq.229.1536578051002;
        Mon, 10 Sep 2018 04:14:11 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id y205-v6sm7072230wmc.3.2018.09.10.04.14.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 04:14:10 -0700 (PDT)
Date:   Mon, 10 Sep 2018 12:14:08 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] mfd: omap-usb-host: Fix dts probe of children
Message-ID: <20180910111408.GK28860@dell>
References: <20180425142922.128233-1-tony@atomide.com>
 <20180830221853.GX7523@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180830221853.GX7523@atomide.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018, Tony Lindgren wrote:

> Lee,
> 
> * Tony Lindgren <tony@atomide.com> [180425 07:31]:
> > It currently only works if the parent bus uses "simple-bus". We
> > currently try to probe children with non-existing compatible values.
> > And we're missing .probe.
> > 
> > I noticed this while testing devices configured to probe using ti-sysc
> > interconnect target module driver. For that we also may want to rebind
> > the driver, so let's remove __init and __exit.
> > 
> > Cc: Roger Quadros <rogerq@ti.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> > 
> > This is OK to wait for v4.18 merge window as the related dts node has
> > not yet been updated to probe via ti-sysc interconnect target driver.
> 
> Sorry I just noticed this is still pending, it should be
> applied as a fix for the -rc series.
> 
> Do you want me to resend the patch?

Just back from vacation.

No thanks, I'll get to it.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
