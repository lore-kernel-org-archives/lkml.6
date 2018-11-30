Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14292C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6B3C2146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6B3C2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeK3PDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 10:03:55 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43918 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbeK3PDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 10:03:55 -0500
Received: by mail-ed1-f68.google.com with SMTP id f4so3692494edq.10;
        Thu, 29 Nov 2018 19:56:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rtVlvmxu/HbPwX1djWwZgBZo6Exl0kkMIvLIu0XvI7s=;
        b=KLuqeSPYh6s8nqp6VO0Jst4pLFmzIpFxQXa3BVz1nJx8F3A953vqPfIN1r9JltgdMN
         IMCYRsP9Fe5PazMQhdcwEjDA1Zcn6y1rpDzIsJX1WXcE0yJ+QMlEmLvpRJNKKYZ4go/1
         8WQMlfqyVpFiXf4/WH0YG8QPmcxjCNJgDE96gdxLGF1GJRQJ7p2avlfK6K6sT8FRBiGy
         nRK+JVcTjFJ9IeH6UketjgOE3QN/6dfgXOPeqWiRbtguT/AdQWGPaFdOx7b5dukQf3Jl
         jxdIkzU5OrB8HB9Ve3lcVhXAo20KwgJGLnZSi6WCDDQHpZ+f0iYCHWy5XFTlbFHdPw2X
         buUQ==
X-Gm-Message-State: AA+aEWaoBEWHpJ0+QtayLU0d+2JGatBj4h2EJUSJNO4JF9CDmFsX4xt9
        da8qglUq1ld3Qh6fE5kJ+XowAp1j+1M=
X-Google-Smtp-Source: AFSGD/Vchm9qRnNZDBd1iQHnGhvoY69TR+eu+f8YwX7GMGugf/QzwcPH8nj4MXB1COurtmRCIpMZpw==
X-Received: by 2002:a50:bb08:: with SMTP id y8mr3884467ede.10.1543550159225;
        Thu, 29 Nov 2018 19:55:59 -0800 (PST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id f35sm1091926edd.80.2018.11.29.19.55.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 19:55:58 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id g67so4281198wmd.2;
        Thu, 29 Nov 2018 19:55:58 -0800 (PST)
X-Received: by 2002:a1c:2382:: with SMTP id j124mr3896642wmj.14.1543550158329;
 Thu, 29 Nov 2018 19:55:58 -0800 (PST)
MIME-Version: 1.0
References: <20181128093013.24442-1-wens@csie.org> <20181128093013.24442-11-wens@csie.org>
 <154344054442.88331.8887745218976145062@swboyd.mtv.corp.google.com>
In-Reply-To: <154344054442.88331.8887745218976145062@swboyd.mtv.corp.google.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 30 Nov 2018 11:55:44 +0800
X-Gmail-Original-Message-ID: <CAGb2v64cER=qU2e_jnZemVfYbtQFNk+ev1MFBQDQu86f98X2dw@mail.gmail.com>
Message-ID: <CAGb2v64cER=qU2e_jnZemVfYbtQFNk+ev1MFBQDQu86f98X2dw@mail.gmail.com>
Subject: Re: [PATCH 09/15] clk: sunxi-ng: r40: Force LOSC parent to RTC LOSC output
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        alexandre.belloni@bootlin.com, Mark Rutland <mark.rutland@arm.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rtc@vger.kernel.org, linux-clk <linux-clk@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 5:29 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Chen-Yu Tsai (2018-11-28 01:30:07)
> > On the R40, in addition to a mux between the RTC's own RC oscillator and
> > an external 32768 Hz crystal, which are muxed inside the RTC module, the
> > CCU also has its own RC oscillator, which runs at around 2 MHz, and can
> > be muxed with the LOSC output from the RTC. This muxed output is called
> > "SYS 32K" in the module clock diagram, but otherwise referred to as the
> > LOSC throughout the CCU documentation.
> >
> > The RC oscillator is not very accurate, even though it has an undocumented
> > calibration function. We really want a precise clock at 32768 Hz,
> > instead of something at around 32 KHz. This patch forces the SYS 32K
> > clock to use the RTC output as its parent, and doesn't bother
> > registering the internal oscillator nor a clock mux.
> >
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
>
> Acked-by: Stephen Boyd <sboyd@kernel.org>

Merged with acks from Maxime and Stephen.
