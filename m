Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A2DC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B8721A14
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hXacUov1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B8721A14
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932683AbeGCJUp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 05:20:45 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38322 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753973AbeGCJUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 05:20:43 -0400
Received: by mail-wr0-f196.google.com with SMTP id j33-v6so1181904wrj.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 02:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r3yniJNeqnlnMhcnXzYyPrMT+rEIVKDSv0a4cYZBfts=;
        b=hXacUov19DNcbrX+f6AYB/HuXrEbDSgPLt4Teu5hfoBunWT2+MqvXnsrGmtFxlYsyf
         Wr6N5jAVT5EQfy42uF341chl30tdES+oJOjebxJasXECjN6DM4A9m/m3/OX/jfMqX96N
         yeyyxT46Kgan2laGSOhc++qrLvmah2V9p/f/MpV/7Ru3CGDxrYr+0kUJicVHz+JFzzmn
         34wAJfjnzsplK0a/q2tZMQieEAnNM8mSpTIN/FxexjZGMza5nU0uYBCe+YyO6Zn0v2az
         DHYl7D/oKlH/cpMtTfgFpeB3i8nRFvpfUGs06KLPvnnkdEXuVpWEru09Mzviy9Zjc62c
         DlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r3yniJNeqnlnMhcnXzYyPrMT+rEIVKDSv0a4cYZBfts=;
        b=U7AIu4g3eK+iBPIkPBjnDLf9+2o45SalBmZouwJcIPCNzU9eBl6py/cUtPp4kitNBd
         H/KXpqeI0RvwPz71RKlJDSJOdVYhZ6F+v7UAnnKWk17lg2ZxQh6UK8UcfiezoXhPoUJu
         Ra3nUT9sen6JFDMtVWnoDp967jzqjL3WGYwMUTkmdPljYA2eHP7yyuVzRvV3qHzc48AT
         V9Ok8vw93kI9JSsmqwAdaXBsyJQGVvxsJVoOIdqtWSuz3lO7sKJOS4mo/BZWJV48mUTd
         bDhQeBRFnpxm904I4W/5vAXEI8RWP9pP1fdbk3nooAOXVtqaM2n/VyYf1X+j9LZoe/ng
         dHZA==
X-Gm-Message-State: APt69E0wKbD3tsEVhY5vGYGbx/xuU7l28qAQcNX9EwlPAK6AuwkLmolE
        Q10gPhQjnsycHuaOBs616IG9vw==
X-Google-Smtp-Source: AAOMgpdovtA1W3tVOh3tbJ6fHze8cppiq/Z3xGSXjJjEloUvOqKdyU9QZuoN3upm04z0VGR1mdvpPQ==
X-Received: by 2002:adf:a706:: with SMTP id c6-v6mr22804645wrd.61.1530609642226;
        Tue, 03 Jul 2018 02:20:42 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b15-v6sm767409wrs.96.2018.07.03.02.20.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 02:20:41 -0700 (PDT)
Message-ID: <1530609640.2900.184.camel@baylibre.com>
Subject: Re: [PATCH v2 1/2] clk: meson-axg: add pcie and mipi clock bindings
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Tue, 03 Jul 2018 11:20:40 +0200
In-Reply-To: <20180702213118.19222-2-yixun.lan@amlogic.com>
References: <20180702213118.19222-1-yixun.lan@amlogic.com>
         <20180702213118.19222-2-yixun.lan@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-02 at 21:31 +0000, Yixun Lan wrote:
> Add the pcie and mipi clock dt-bindings for the pcie driver.
> 
> Since the mipi clock isalso used by the pcie driver,
> we add it together in this patch.
> 
> Tested-by: Jianxin Qin <jianxin.qin@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  include/dt-bindings/clock/axg-clkc.h | 3 +++
>  1 file changed, 3 insertions(+)

Applied. Thx
