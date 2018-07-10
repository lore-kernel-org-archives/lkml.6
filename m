Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D305C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36638208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QI/JyrX7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36638208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934400AbeGJPvs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:51:48 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36395 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933381AbeGJPvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:51:46 -0400
Received: by mail-wm0-f67.google.com with SMTP id s14-v6so24908662wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 08:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mM0WbnqZDH2CYBlyos9obkoIHoEOT9eJJXKgsGQxVsQ=;
        b=QI/JyrX79TczWrn/mFb31fKa2BYi4r5DULIn1jINtWdm7WqkcGHefndoh0LnIgL59R
         cKu1G1EgxK/0MlN5z+k/eb+nho7X6RcDvAigSroCK1k0keb8SXNlFHM4ygPn/Tz6yXPx
         qLvJNImKnfRSkxKqx/W3ggdDUXmHPi3Tq4pZBHAKqIjhVLMBvvc/QSpKk/MKwguyyLdP
         nLhC9dydea8PJvsvMWIuYAIhQmGbp8e8Z4Fqi0KXZrj3KYCAVDuIcQNzyrYPmaxueJ66
         ys8D3Px0EEAStL8sbKyfv4PjES76Ca2vzfkGlwyNw6kn1WqFsFEGIrXE81Mdnb6c3cBd
         9qHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mM0WbnqZDH2CYBlyos9obkoIHoEOT9eJJXKgsGQxVsQ=;
        b=iNS1iuj/yny2uRSql5ytStS5GEhngEJsb0wnjIuCBA/pdZxHyttYfkttLGl4haX9Al
         L/w0Boc2bIqqgh0g1mt6ZKStZZUsoRH2nC3pe71VS5v6lTFy8SvbqKdslk3F8+z/zrj2
         YTbN94AKLlRvuF6zM9a5wtUV6W9ZNq9+CVL9ecTxjTh0vzIZFpvG77PlJODEoTQj4fEG
         atQrCirEiGKb7lV+d+e9Xod7iiLoMllCGfk1AtIun1gG7+3/tKrgd/ObrWIr7aTHYSqo
         je728rojUsyo+gGSL8jUZB66YagC+ttF63RK60+PGxYXltT0oC1JG88+XMuPXafKQ62E
         WLoQ==
X-Gm-Message-State: APt69E1WNno4mVTek8t3Hn44SyjSnhSKAPGCfdtfrag+aZPixpvMPpUT
        A6qXFiC787t/XCFPWW4pdBuAow==
X-Google-Smtp-Source: AAOMgpdeteEws0/LSuag8SJgNlDDSa01IQYuU58P3nJatejKxXrVotbXGBjkZZYvvzEan121Lpai7g==
X-Received: by 2002:a1c:894f:: with SMTP id l76-v6mr14777530wmd.103.1531237905249;
        Tue, 10 Jul 2018 08:51:45 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id e2-v6sm12449513wrr.8.2018.07.10.08.51.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 08:51:44 -0700 (PDT)
Message-ID: <1531237902.2708.76.camel@baylibre.com>
Subject: Re: [PATCH 3/3] clk: meson-g12a: Add EE Clock controller driver
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yixun Lan <yixun.lan@amlogic.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        jian.hu@amlogic.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        qianggui.song@amlogic.com, sboyd@kernel.org, khilman@baylibre.com,
        mturquette@baylibre.com, linux-kernel@vger.kernel.org,
        bo.yang@amlogic.com, qiufang.dai@amlogic.com,
        linux-arm-kernel@lists.infradead.org, carlo@caione.org,
        linux-amlogic@lists.infradead.org, sunny.luo@amlogic.com,
        linux-clk@vger.kernel.org, xingyu.chen@amlogic.com,
        Rob Herring <robh@kernel.org>
Date:   Tue, 10 Jul 2018 17:51:42 +0200
In-Reply-To: <cb832db4-ad2c-09c1-86ae-e7f9c05cd872@amlogic.com>
References: <1531134767-29927-1-git-send-email-jian.hu@amlogic.com>
         <1531134767-29927-4-git-send-email-jian.hu@amlogic.com>
         <CAFBinCBB9N_p6S_-dfiV=zDCf-RYnA3C-ir6oNLC7JAfdOqqiw@mail.gmail.com>
         <ec49c089-bccf-9aac-5d0f-43bc27770ad9@amlogic.com>
         <1531216472.2708.71.camel@baylibre.com>
         <cb832db4-ad2c-09c1-86ae-e7f9c05cd872@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-10 at 20:59 +0800, Yixun Lan wrote:
> > > > > +static const struct of_device_id clkc_match_table[] = {
> > > > > +       { .compatible = "amlogic,g12a-clkc" },
> > > > 
> > > > I wonder if that should be "amlogic,meson-g12a-clkc" (I know that AXG
> > > > and GXBB/GXL/GXM omit the "meson-" prefix, but I am not sure if that's
> > > > correct - I'll CC Rob Herring on the dt-bindings patch)
> > > > 
> > > 
> > > we're fine with either way, since the g12a is recently new added SoC.
> > > 
> > > but I guess those old compatibles which already exist won't be changed,
> > > as it will break the DT
> > 
> > Yes, I doubt we are going to change the compatibles. With or without the meson
> > prefix, I suppose it going to stay that way.
> > 
> > It is worth thinking about it for new drivers though.
> > We already have the "amlogic,", so do we really to prefix even more with "meson-
> > "
> > 
> > Also, if we were really strict about that scheme, should meson8b compatible be
> > 
> > "amlogic,meson-meson8b-foo-bar" ... the SoC is meson8b, not just 8b after all ?
> > 
> > For the particular case of the clock controller, I don't care very much, as long
> > as the compatible is coherent with documentation.
> > 
> > I might have a preference for the current compatible ... just for consistency
> > with the other clock controllers.
> > 
> 
> do you imply that we should just stick to 'amlogic,g12a-clkc'?
> 
> it sound good to me, at least it's shorter than 'amlogic,meson-g12a-clkc'..

I did not imply anything.
Martin raised a valid point. I'm merely giving my opinion on the matter and I'm
interested to get others view on this.
