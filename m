Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55351C169C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 03:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19335217F9
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 03:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="K4LnwqpL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfBGDId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 22:08:33 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41791 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbfBGDIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 22:08:32 -0500
Received: by mail-pf1-f194.google.com with SMTP id b7so4107092pfi.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 19:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=bjV0pff0+Yorv72/l3DDEcnxgGGPgV5xTdNHYgPwYFE=;
        b=K4LnwqpL6tzwKU4ZPpvlqSm1yFcsKqzT2cDka9owHlzN2RqWzelCEYr3m3paVrufpg
         F4a81ac7cUy6Bk1fJJJ7uZQO2EdEV0BoMEtbhcI6HMq5s0UWw5XRLxtWaG5+9y/mIFUv
         k8kOsBDxa4kklUgf9EZRSQPWL1aHNgapHz79+dSmgn2/3s8ZoxUadWhbW7lgOtleaq/f
         OqJBEY4D0u2WA+rGjP3VTMxmfZbb4wugWu6acBXvUwuWhFrUFsx+z5QosEvH9MbqP7PG
         41gNNaZxvFk7tHMf/Kt2EaKA0k4TyMVMs6KEtnm2WtUZn5Mvevwz8hJ9snrN/IYT7KbZ
         UFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=bjV0pff0+Yorv72/l3DDEcnxgGGPgV5xTdNHYgPwYFE=;
        b=A8wYRl5fUfbXEM0usl92RgTCz7wCGVFlSGZZPXHc1i1wO2xmzfIap/ITY5AioDGYaD
         xisJ8Rc/LI4SyP9szyidIkwpGxz+twOPJ3zhHm11YQfeXXIUwEkUSrx5Av12qEh8tncO
         D0X6miX2SEld1MnXbkpbxbkDv5/GQH4/f9EUGKM8zUZ5INSFmZktWipzxOdmVLECRX38
         s+LLcc19Z5zR9C1+rYUkg7KNNH/cTgzh604ugqJjc7Nusw1vLdHWoD8YFT1Vck5XnCI5
         PGlyFNeepTZ+S7SWl7l1VBGWmmLZZPHgoofp1eGPpLNHUfmx+Y83MHoEbTuX6h/+cC18
         t7GQ==
X-Gm-Message-State: AHQUAubvWG8ktOfgl7A8aIlvQA630xK2IxxoUR3v9eIEvcEzh5RhxvA0
        LSNPk0KXTBybFTGQiu+D1L7yxA==
X-Google-Smtp-Source: AHgI3IagxwSg3I87aQnZ4KoOTdbI3Nt3Ewl+l409hzNH/tn8WUnTA+wOxbRVBd3r3RZLtGbv/J9dOA==
X-Received: by 2002:a62:1e87:: with SMTP id e129mr13798221pfe.221.1549508911915;
        Wed, 06 Feb 2019 19:08:31 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:1818:ce94:f47:7c12])
        by smtp.googlemail.com with ESMTPSA id a10sm9303427pfi.138.2019.02.06.19.08.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 19:08:31 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v3] dt-bindings: reset: meson: add g12a bindings
In-Reply-To: <20190201125003.25022-1-jbrunet@baylibre.com>
References: <20190201125003.25022-1-jbrunet@baylibre.com>
Date:   Wed, 06 Feb 2019 19:08:30 -0800
Message-ID: <7h8sysi9ch.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Add device tree bindings for the reset controller of g12a SoC family.
>
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>
