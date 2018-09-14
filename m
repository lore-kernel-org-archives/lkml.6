Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5313FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5474321476
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Ju23o8fn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5474321476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbeINNrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:47:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36794 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbeINNrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:47:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id j192-v6so1108216wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 01:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dQhaPjYqWaqAejgvdTvRL+ZVVdq++l2SgN73yGLHxlw=;
        b=Ju23o8fnXnMZpUFovGaVG10cBGifZYYKteEtljlUcXktCxQUqqJ4gNVYko9mCfzlcD
         xG2ezMwcxRyVfYZ2mpO7w608HZoFyS+2ybhr9NbSRNcsDUlCJs0YriDX6KVcXc+1fEDO
         pXE24m6VVJLk2CVv3tsnIoLqh08XauS7woll5WaYRg/y6ksI8SdkDjQV0KnrVkODW97A
         8RyL7mLdC9SZu3xLZIWt95NrFFM7XrNy3yQjLKk52HoDi2iI05HvDAiViYhSAXHzql7W
         B9kmUjEclofkUumLHTrC649XAop1Z9z673t+bpDgqFtbPTeuZXtPF222Jrd7A4IqH4cX
         2cEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dQhaPjYqWaqAejgvdTvRL+ZVVdq++l2SgN73yGLHxlw=;
        b=kFYqZT/mtHopj8I1QJgywyaUm5nuEwq6TvnPJxD6KcSVMctbt1/HEySyY+U48n47CW
         zJNrbiAvlI4ssZbOnYrzG/A6er0omInAfwJSB+iaJ5f7cQ10a8+OjZpTlZqKrQLB5stf
         Iq0xcQr9GJSgT5LcHJF713YtD90jtU/MJRVyXF+C6bJwQSQkh7bFGdIbs9qHE254iLaH
         JspTc0KKrRf0/pB/z5huZ9+/bWtO91vpRvMqtDvewFqZyVnorYbU1TlzcbRMhHFyByf0
         z68vXpQ+/bPcOhrTO8p//Pf+QMCtJm+QhW5gJe+Zh2KvkaDXhDE/DNFCVE9Xj+33CrmX
         Msjw==
X-Gm-Message-State: APzg51CacOws2maslh7je4gS9ZkoRTYbKX5juJtD3YIMKeDoL5gCqfZS
        ncFnX9PadosSk2rq9xZoQAiErQ==
X-Google-Smtp-Source: ANB0VdZUZ/TlL7JRUgzXu/mNbvA/bzagAjX+fhzLYmp+plaa/DiOMiLI/74QNL/0tsRX6JcQ88ZuFw==
X-Received: by 2002:a1c:ce0b:: with SMTP id e11-v6mr1432144wmg.47.1536914016832;
        Fri, 14 Sep 2018 01:33:36 -0700 (PDT)
Received: from boomer (uluru.liltaz.com. [163.172.81.188])
        by smtp.gmail.com with ESMTPSA id z101-v6sm10397717wrb.55.2018.09.14.01.33.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 01:33:36 -0700 (PDT)
Message-ID: <6f12fc39c52adaaf63cb99cefe0809a52606c3a8.camel@baylibre.com>
Subject: Re: [PATCH 2/2] clk: meson-g12a: Add AO Clock controller driver
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Jian Hu <jian.hu@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Fri, 14 Sep 2018 10:33:35 +0200
In-Reply-To: <977d8010-6d82-5eac-5da5-6dbe0f73971a@amlogic.com>
References: <1533894868-85815-1-git-send-email-jian.hu@amlogic.com>
         <1533894868-85815-3-git-send-email-jian.hu@amlogic.com>
         <6c855dc62fe6ed1a01216bd708d401a280f8762c.camel@baylibre.com>
         <fff1f982-c9f3-8aa4-b108-6c0998827e79@amlogic.com>
         <89b058a7bba26058fab95dea01155221dbb642ce.camel@baylibre.com>
         <977d8010-6d82-5eac-5da5-6dbe0f73971a@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-28 at 11:35 +0800, Jian Hu wrote:
> Hi: Jerome
> 
> On 2018/8/27 21:07, Jerome Brunet wrote:
> > On Fri, 2018-08-24 at 21:34 +0800, Jian Hu wrote:
> > > > 
> > > 
> > > I am confued about aoclk81's parent clocks.
> > > 
> > > I can not get the example of axg audio clock driver, Could you provide
> > > the link? Had it merged into clk-meson.git?
> > 
> > Yes and mainline as well : drivers/clk/meson/axg-audio.c
> > 
> > Basically this driver is creating bypass input clocks (audio_pclk, mst_in[0-9],
> > etc...) .
> > 
> > This allows to collect input clocks from DT (like any consumer should) will
> > keeping constant in the controller clock tree.
> > 
> > > From what I've seen of your controller drivers, the EE controller should have
> > 
> > one input, the AO should have 3.
> > 
> > 
> > 
> > .
> > 
> 
> I still can not get the example meaning in axg audio driver.

here is one specific example:


https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/meson/axg-audio.c?h=v4.19-rc1#n785


> 
> In 26 page of A113D_Datasheet V0.7 20170725-Baylibre.pdf,We can see the 
> aoclk81 has two parents. clk81 and ao_slow_clk. I can not get 3 parents.
> 
>                           clk81|\
>                         -------| \        aoclk81
> src0 |\                       |  |-------------------
> -----| \     ao_slow_clk      |  |
>       |  |---------------------| /
> -----| /                      |/
>   src1|/
> 
> 
> src0 is from xtal, if can generate 32k clock, but it is never used.
> src1 is from gpio clock, It is never used. If necessary， the ao_slow_clk 
> maybe described.
> 
> So why aoclk81 has 3 parents?

I never said that. I said your clock controller driver should have 3 input
clocks. These clock are the one used by the controller but not produced by it:
for the AO controller xtal, ao_xtal, and ee controller clk81.



