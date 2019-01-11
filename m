Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68B8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A282133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PX0kpIsH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbfAKB2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 20:28:13 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42782 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbfAKB2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 20:28:13 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so5583267pga.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 17:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=2P+pkq/TAVJfpx+QVUhCn9RikOPq88PivZzjtOGkCms=;
        b=PX0kpIsHZAopLUpTUOPcmSxdoYqWG3Yy2a/gSt4fMAnFTPMwwUZp9lvNX7iUhe0CEO
         mr97YQ7w7MATf/6pJT7ZjTp5xduZAHtwnnPdIDJ5cb3ltat7IkZXULfiL7Iz5aMqdKmb
         M1IPOaheORYcAz6PekI7TF5iRMtxmFJWNu6bHeQM56HEB3a+r/+zhiKS29cOuIjP50Dq
         +mv6Kn5EWfNVPwXwYrsIhj7tXR4JUNhGgkE3oiTS/CeZoxr5Nn/fVQjE6mC682Hrq1My
         arIrXEGnTS9VKPbcKRtVdYDn9EYVAKzl1Hk7q6W5/SPh8wZsW9V4vUCpsHs66BuSnPfj
         VqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=2P+pkq/TAVJfpx+QVUhCn9RikOPq88PivZzjtOGkCms=;
        b=XUAyR7xUZM+NvWDvfrk1gUx1fDpJ5Vt+VjtUYe2D6szFtwZm7AuuHPKdRgkfF/KoxW
         hOx2xazpoB2YiGE7/Q3jwFImpEH/vAXWXVe++po4ZBS1QQOLGMQWVB0CF+tmk6vNr/FH
         i6laCBvSvuQiZIJvkWni/1N049TBgVvf7wKYKk+O9BOujsqcbDgXFza3VyAnTy3hTAWt
         7QiTiLJAGcpEu9LQ6/TSRYli5UkhGY8VuFUnfAgSBsP7jOq+zSAFp9mbAOGWIAVDH9Vq
         iuSEBjsyZ3hpsOZz21eQurZIz9RE3kDj9wvudQHOijyotKx4QqD6GMbRzTvds39cx3vU
         wkHA==
X-Gm-Message-State: AJcUukd6R3Oz+4/lyuBUhaIGDES66H9w1o5Q/e/G23h1ftAuLeW9dVE5
        SMUiZbqvs2If5DtaTBYK4HD0rQ==
X-Google-Smtp-Source: ALg8bN5IO4BJcANmQlKQXyWnapZsR/3IqoI/v9r4ESHNsrGTcIk1c3DNbMbLWi6X4V8xHzoCBXXJsQ==
X-Received: by 2002:a63:184a:: with SMTP id 10mr11378583pgy.81.1547170092711;
        Thu, 10 Jan 2019 17:28:12 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id r187sm242710873pfc.63.2019.01.10.17.28.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 17:28:12 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Loys Ollivier <lollivier@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Cc:     Loys Ollivier <lollivier@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v3] arm64: dts: meson: Fix mmc cd-gpios polarity
In-Reply-To: <1547134822-18498-1-git-send-email-lollivier@baylibre.com>
References: <1547134822-18498-1-git-send-email-lollivier@baylibre.com>
Date:   Thu, 10 Jan 2019 17:28:11 -0800
Message-ID: <7hftu0oudw.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Loys Ollivier <lollivier@baylibre.com> writes:

> Commit 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
> changed the behavior of "cd-inverted" to follow the device tree bindings
> specification.
> Lines specifying "cd-inverted" are now "active high".
>
> Fix the SD card for meson by setting the cd-gpios as "active low" according
> to the boards specifications.
>
> Fixes: 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>

Thanks for fixing this!

Queued as a fix for v5.1-rc,

I see that this is being fixed in the driver also, but I think fixing
the DTs is necessary also.

Kevin
