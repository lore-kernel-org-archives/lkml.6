Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA76C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4552086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gdMeAB/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC4552086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbeLJVPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:15:40 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33553 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbeLJVPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:15:34 -0500
Received: by mail-pl1-f193.google.com with SMTP id z23so5842778plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 13:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=qpWHzIv7pNjRZyMT6tgEt1wKg39Uqn+aiTQ/opyFTpE=;
        b=gdMeAB/GikldyE+AGfWPd63GZmMTdKQi0hboZPtbfo6EVY5BX03mBJkexI0YeHYXnE
         CtbNn/GhIRhNLDHP9zTFhoWE0M2KFSqDycZCF7jtBqN8+D6kWJEG9lXsE7JJY1i4kJi8
         +p1tbsayBOE1SeH8p0DApHsnuOlCUYtxMqw9rMQHbx5tMWzBVKIE6k3AO/FA1gdBRu/q
         CP2FazBp9664//NrgviCtkjckNAsa15CkUsJKmZsiNi1c0aVVFX/yQUjy1nRJobYdHO5
         gKu7/fz/YEmkvABiQ5bg7xTEWWBOofBtSXUohgHTUY6ULq+FctuTJE21dGMfOJpxqS4w
         lcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=qpWHzIv7pNjRZyMT6tgEt1wKg39Uqn+aiTQ/opyFTpE=;
        b=QFMKImJSZEdyN+NvvM+17c6T24o6sUtuPu+WRbVNZtpx8Kyeg/pDkPvbRxCV5bcK30
         Vp0S5tiev+dzsd6+yPPhsHQVnupK82aYzYHCegV/ZwArJwM8eSAZ1Y087vjYQo8JRujO
         14fFFFr6K4KLqzEixVU7KLFM3MochiL1d090XdmeBrzoKm1KbUds225Nsn1b0ZGSM9Yk
         AWl34t5YZ24D7yp8Eq7AKSR9KvivfjqU+siJOb1ad69xruvkZqiSwKY+Hj0LUDHMYxH2
         oXCaYRcXwqt2drXga2gaWUstsqeRVYTzdaNuNsorEV7+WMFJAHu1zj490r2R+lW6Wcab
         lZWA==
X-Gm-Message-State: AA+aEWZPCwH5jj4qBgkPs2ZW9DGJf0JA889A1Czpht5xOOhwT7T0sjnK
        hLI5IaD+LdUlAstejvlbZRHR/Q==
X-Google-Smtp-Source: AFSGD/XH6hxq31NE50qY5ngA/X66f4DEawLdoLdY/wcrp1lkFTFoq6f4bV/pIdB8krmRBmo4bGQVJw==
X-Received: by 2002:a17:902:d911:: with SMTP id c17mr9450732plz.151.1544476533954;
        Mon, 10 Dec 2018 13:15:33 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id t21sm15814671pgg.24.2018.12.10.13.15.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 13:15:33 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: meson-gxm: Add support for the Mali T820 GPU
In-Reply-To: <20181210132227.29262-1-narmstrong@baylibre.com>
References: <20181210132227.29262-1-narmstrong@baylibre.com>
Date:   Mon, 10 Dec 2018 13:15:32 -0800
Message-ID: <7hzhtdulqj.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> This patchset adds :
> - Optional reset properties in the midgard bindings
> - Mali T820 Node in Amlogic Meson GXM DTSI
>
> Christian Hewitt (1):
>   arm64: dts: meson-gxm: Add Mali-T820 node
>
> Neil Armstrong (1):
>   dt-bindings: gpu: mali-midgard: Add resets property

Queued for v4.21 (branch: dt64)

Thanks,

Kevin
