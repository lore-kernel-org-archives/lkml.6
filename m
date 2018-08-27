Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2229AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 13:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94264208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 13:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HsmW0W2b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94264208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbeH0RIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 13:08:21 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51829 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeH0RIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 13:08:21 -0400
Received: by mail-wm0-f65.google.com with SMTP id y2-v6so8085917wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 06:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JeRrrc9NyswkW/XkGCb7hV56FUxkP98R03WOgCLuZhU=;
        b=HsmW0W2b6jD8DDnqARFq8F/m3UL6158dfe3b898wsqPsqpbqWXMU7K9sRo2osxlloM
         u28KJyYSfReViN/KoR+TseXqsjb60GY6HWxFAs8WUJwa9GvHZCBwxmc9wkYw6BfMvygy
         XBTSl5Z7H/ah+eOHXJCYlm3TKZvXWUYrLoT6+SNeqeEbQjol87LdekcE1tM5MEf8o3l1
         wXZhsIPACJyjkKfX7pIbnDKyfUR298OfvVdXyU5vGeZvwICDPg4Cj5H6gyGi0yVS9mWe
         g+yr4b/Byl9EHTEHEzv0CvMLizys0RytBalY4jah5g10ncW14Wc96EEg+QqKovIoQELE
         WZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JeRrrc9NyswkW/XkGCb7hV56FUxkP98R03WOgCLuZhU=;
        b=apNv4Wr1ocPFc5R4rxsjmHn1iONIT4IRC79od1uvaOufxIDT2DBZzB4Pa34mSA0gQD
         8gaNzAl2K99ZtD2GPuoMxnkzdRzd4fNIqbr1cMthJBZsgLBxAEezAdWfFO3Eg3sr6t60
         /GFAh8BfzOb0TrFVcacCY/nFmEsJlyNvP0f8zMNWxlwaGpgsKXzaiMm8ldQQSDlNlZVP
         RyfwHRF+l6+y4SReD0vlrGzj9jAptLFAmF548EQQk87/BP55vcaHfTWftLyR6OCnKJA/
         7wJtPi3PezrYab4iitKTfNlOMGZuD7C0OFuS3Q+s4u9YG0N4gzdLLeBxJv2KZGIhm6f+
         SLyQ==
X-Gm-Message-State: APzg51DVaXcJX3KPAhP+yUUtrYwqqfKxEWu4mcsKE0hFUVqQSVXaHAKM
        ZfpqN/cnGlESkhWWC1eEY/fhcA==
X-Google-Smtp-Source: ANB0Vdajf8a/3HWkG2KFmN6S2wsglbOHijKqDrTq8CxXcsgC3Zf3WtHegVhOxNj13QwsvK4CXOgMTg==
X-Received: by 2002:a1c:70b:: with SMTP id 11-v6mr5482348wmh.151.1535376102298;
        Mon, 27 Aug 2018 06:21:42 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i125-v6sm17530596wmd.23.2018.08.27.06.21.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 06:21:41 -0700 (PDT)
Message-ID: <9dd477896f4dc3b354d5875f8c4ecce1807c375c.camel@baylibre.com>
Subject: Re: [PATCH] clk: meson-axg: pcie: drop the mpll3 clock parent
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yixun Lan <yixun.lan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Qin <jianxin.qin@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 27 Aug 2018 15:21:40 +0200
In-Reply-To: <20180801121625.9488-1-yixun.lan@amlogic.com>
References: <20180801121625.9488-1-yixun.lan@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-01 at 12:16 +0000, Yixun Lan wrote:
> We found the PCIe driver doesn't really work with
> the mpll3 clock which is actually reserved for debug,
> So drop it from the mux list.
> 
> Fixes: 33b89db68236 ("clk: meson-axg: add clocks required by pcie driver")
> Tested-by: Jianxin Qin <jianxin.qin@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> 
> ---

Applied, Thx

