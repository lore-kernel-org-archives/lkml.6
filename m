Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94F3C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8214F2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="JPzsotA6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8214F2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752837AbeGCLBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:01:17 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39938 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752686AbeGCLBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:01:15 -0400
Received: by mail-wm0-f68.google.com with SMTP id z13-v6so1790017wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 04:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P+TW9OWvXwZevEed8yXqoDrLvy9QkO3Sdz7PCCuEecQ=;
        b=JPzsotA6QWdV47z7ZCTFfnGuy5hOeg0VT0RtJKdgluw+6LJWibFu56nGFWtiZf4fsb
         TGtkJjKf70Io/6QDX5Ps36yc9ItouSg1TZUnz+rSng4Z6XDL5NyNUwLw+K2dgvgsp4L1
         D2sw5FMfgNinYW6C9DzMAs7iP/l+/rIimES5IObeWBq1x5fIbQvhoBoP6FjzrxlVZaFG
         yeWT9vhW9oB/pW7YKed17CZ4wa7ZA4hCYXjqLtT8bClEO6wI3Bz4dW2Vn1oTXNAjbfy2
         4/Q+B0C3wWZBYcGw/6lpzX8rJAMIPFhXho58Hozwu+9OlKKjJAyj4L1vkLX5m7+Jk9lV
         nBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P+TW9OWvXwZevEed8yXqoDrLvy9QkO3Sdz7PCCuEecQ=;
        b=LRIJUG86zGuupmGPlDpnQqg1vKZeyywmpsV1CGQi8062dJAW+W9tba/ZdZQIqkti1a
         acn9XJ8y6r4xs0gglX6Z60ANmRJGXAjjICG0XGsboVO/PSyz3i6Ab40jf2c4VAoY87sC
         GVqA6DTvNCkTLK5OeQ67ygXNL7fp6XJkRFdkr+8WK8DvOhwwh0QjLQVT+nQg9HOpV9gX
         c6i11ZdG1MXNCGnxP73DmYFEG4jE4LJeCKFLVJe5xwZuJzYTLwwRHsifAR72r5fM+l9D
         1oxv8MDQQqvk/NrEwWVsSRpVre0y0NfuKZgraPxQJtr0ItlIuqF7SJSU7tuivu0qdEK0
         E6VA==
X-Gm-Message-State: APt69E0Is+abFI4KrymYvDrX+Vg8ZoKXWp8oxUhkQe8Mb21f2Kt6qbA7
        AcGRqsffEfhPn4vKpHBntoQMuA==
X-Google-Smtp-Source: AAOMgpeSp1DceHBrxbgHmS/ODatLsD3baN0QMeBd9ExJq0lCPuFwQ5n48QzGyes+XPsZ1AcHvBN1UA==
X-Received: by 2002:a1c:4083:: with SMTP id n125-v6mr10066676wma.32.1530615674694;
        Tue, 03 Jul 2018 04:01:14 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s2-v6sm851218wro.42.2018.07.03.04.01.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 04:01:14 -0700 (PDT)
Message-ID: <1530615672.2900.205.camel@baylibre.com>
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
Date:   Tue, 03 Jul 2018 13:01:12 +0200
In-Reply-To: <7c8b47a9-67bc-b685-8c90-084299631fb0@amlogic.com>
References: <20180702213118.19222-1-yixun.lan@amlogic.com>
         <20180702213118.19222-3-yixun.lan@amlogic.com>
         <1530609862.2900.187.camel@baylibre.com>
         <7c8b47a9-67bc-b685-8c90-084299631fb0@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-03 at 18:17 +0800, Yixun Lan wrote:
> I'm seeing you already applied this patch, so would you like to
> fix/amend the patch for me, or want me send another patch version?
> 
> thanks

It means that I amended your patch before applying it.
