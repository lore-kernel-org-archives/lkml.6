Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60A8C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9074120836
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tT7cvWRm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9074120836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753430AbeGCOmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:42:47 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54000 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752908AbeGCOmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:42:46 -0400
Received: by mail-wm0-f67.google.com with SMTP id b188-v6so2648651wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 07:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3g5quYi4Jd0RH932B8ZOg+GY9ahX9AVxk/hTgTXXABI=;
        b=tT7cvWRmMkvUslJcbtqt+sY9us7OfNspaAZ7bqx0Lp+T0WBsP71oQYh4DZas7Z9Sup
         qY6ohJlcYlfG13H2FMVSbm67lv824VIyaFMjDNsd1TxSSRvtXjZVOCAlhPdrHMSvYTki
         Ac8LFrMEclugCWXsW2Id7VI9qQwJLPVyJwmaGQsnjPIbeX+XJSc2Ww0mOyBERztv+JDD
         SCY2zEJWjp/CZ40319IBdcIDtQSsGX+UsvQkcQGqnK4/p8ikdHk/GcwFPicrkhKZ8dun
         ROHz1utqtcuRWMddnApI4zflczRG6rC0MMoCwVYzl6h6PJQ6SikX2DqH+rCfTCHeuLe6
         EKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3g5quYi4Jd0RH932B8ZOg+GY9ahX9AVxk/hTgTXXABI=;
        b=JwGW4ETJ4JpyYtsGHyfJ/dxBJWuBDP37bQ3N4/v7GsM/ffpvKBope1xU2sjxrsvbA/
         dywCWYasyACNZKvfWGfQGS+J/fJb9edbZ8or0m1ejTmCPMfZ154gX69bUWcvz+HsJ9C6
         SB8Gy9PAP5WSnhdXSGefRDtUW26ck96/nr7PLYrn83qqAJ3OBWnsbgqwin4jRv2Ootwt
         qfOW8qA/RXspZWf3xgdz2aLafnJMCUf4I3c7Nv1vNQX1kI1wLBfbxoayLyeClw1GNeW0
         T1HYW55xFZBN8zBNGU85Bc2yAWHkg0rwT0HZJKHGDAZeUK0orf6SflB4nvEZNLM+4YX0
         OD+g==
X-Gm-Message-State: APt69E0Ppfgh2VUtdzGsP0+UfW6XnWCAacbPDqZJP7JDz5DDAq+9/QGX
        siWFl6mFIM6twg2gk2DbSVNpLg==
X-Google-Smtp-Source: AAOMgpeWa0VtnIaWj4+BLchTMSckPRrRCuES1Z60VPY6RIGiLh2YAEB18DbOZPsPC7PwVP6VrqX7fA==
X-Received: by 2002:a1c:3610:: with SMTP id d16-v6mr11852956wma.126.1530628965027;
        Tue, 03 Jul 2018 07:42:45 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c10-v6sm2679993wrh.44.2018.07.03.07.42.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 07:42:44 -0700 (PDT)
Message-ID: <1530628963.2900.207.camel@baylibre.com>
Subject: Re: [PATCH v2 2/2] clk: meson-axg: add clocks required by pcie
 driver
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yixun Lan <yixun.lan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Jianxin Qin <jianxin.qin@amlogic.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 03 Jul 2018 16:42:43 +0200
In-Reply-To: <f23be559-4a64-7fbd-a7f7-4bdc2b6aabac@amlogic.com>
References: <20180702213118.19222-1-yixun.lan@amlogic.com>
         <20180702213118.19222-3-yixun.lan@amlogic.com>
         <1530609862.2900.187.camel@baylibre.com>
         <7c8b47a9-67bc-b685-8c90-084299631fb0@amlogic.com>
         <1530615672.2900.205.camel@baylibre.com>
         <f23be559-4a64-7fbd-a7f7-4bdc2b6aabac@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-03 at 22:05 +0800, Yixun Lan wrote:
> Sorry, I'm asking..
> 
> because as I checked the clk-meson[1] tree, branch  - next/drivers,
> it's not updated which it's still my original version..
> 
> Yixun

Indeed. It pushed now.
