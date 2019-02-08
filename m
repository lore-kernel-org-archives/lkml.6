Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F3AC282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8576E21907
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="EELu/fbl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfBHAtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 19:49:47 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43131 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfBHAtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 19:49:47 -0500
Received: by mail-pl1-f193.google.com with SMTP id f90so597695plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 16:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=igWMC6rHby596QWZ2CVQNpZ2BdkN0gx1s+3p6FSiN/Y=;
        b=EELu/fblR9WxJjmRDSQOmP5+TvvSI/KEuuzURzyttry409Ld/t+K6SVQFxL6x7T51e
         deyFxzJLjnk5UPsDmdqTh4Cck9z1X+WYAr/2ciKHpIanp+9TNijgeFp+Z7GwnEtEMQqv
         UYbWrYy2h72neWsbErVwRZKjxLeXRtTo4zQ0zlCDOvCdKHMububezs0iEsWDDXfH9uqP
         KdZhAtwcjLXa+6Ajm5cnlrMYGFpvuFY99nMGKkYC9PlIOuV1VebnEfv+jqg3B2I4re2N
         C1pb1BeutJ0/49r6GDrXerBE1jAaDpahnUzjZ8HcFsL/McHfbCJ3krEkNubJ2zHqnZWp
         PnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=igWMC6rHby596QWZ2CVQNpZ2BdkN0gx1s+3p6FSiN/Y=;
        b=fa6kyPHgMbVZk1x6sDit8xYCMoGCHFA/BNT4/eJyL+zlBrgp51SFueBqD7X2YW0Wp4
         lyUbhUJiB0bSoA9vN2kHYr/YBtJXFZ14Ie5kDNHmuYdKTzIKAzqN0JXp/OGoyAkHnhv7
         UyabvGC7m88c9qKhsZJRg1/6PCx1Hxuxfbaky/uOjxR4ywiRjIGi7KJY36moQ4GYCNiE
         2ADPj90ltkQBvBnws6qDtxAzQMf1Q8woPtfsm7yAbPPkGaEpZ2PH1mnz3sH640HXS4J1
         I/8/JPIg9SbTT2oRqwfPZLW69kk4GmIox0k+aWkhUwn36WpLv+D0ONWdQJF1VCrLRVpQ
         jN9w==
X-Gm-Message-State: AHQUAub8tQXB7xoUHXQCVTRsfyWP5+yaEnvFpHTVBym4F3aUwr3oqfXu
        5fKx8HTzPFrC4Ye7Hx7vDEH7ZdQWwqM=
X-Google-Smtp-Source: AHgI3IZuTXzpdYL1QTkcFFChP8DF7vS3FKUitDqgwBCMhR/ypCOd9QZQ/ryUz2TAXKqN1pJAOQhlhA==
X-Received: by 2002:a17:902:8f98:: with SMTP id z24mr19263866plo.40.1549586986699;
        Thu, 07 Feb 2019 16:49:46 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:1818:ce94:f47:7c12])
        by smtp.googlemail.com with ESMTPSA id n72sm44884pfg.13.2019.02.07.16.49.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 16:49:45 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: meson: g12a: fix clk_msr node
In-Reply-To: <20190207132603.694-2-jbrunet@baylibre.com>
References: <20190207132603.694-1-jbrunet@baylibre.com> <20190207132603.694-2-jbrunet@baylibre.com>
Date:   Thu, 07 Feb 2019 16:49:44 -0800
Message-ID: <7hwombf6jb.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> The clk-msr node should be in cbus.
>
> Fixes: eeca2cf15e05 ("arm64: dts: meson: g12a: add clk measure support")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

This one I squashed with the original (in branch v5.1/dt64)

Kevin
