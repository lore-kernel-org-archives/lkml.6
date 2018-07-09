Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2F0C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65EF520873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1wga+bhJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65EF520873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754576AbeGIMz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:55:58 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54407 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754547AbeGIMzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:55:54 -0400
Received: by mail-wm0-f68.google.com with SMTP id i139-v6so20959394wmf.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 05:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5+/GSfvUfimdV6GEePbS5stgiVERby0RQcMf1fo6qpQ=;
        b=1wga+bhJo7qNirFXp6eOBj8STJJ6XwLjJaEYzWiOrhMRZqcqFkl/ZjrHPWw184hJMA
         bco+pNcbCGoVtCgGuviRRqk13RF2h+b2kEVQgHpte9JnhzBRdLdN6EMxwHMMWL5TsV2G
         NLmPvabh06gTmzqn2Hnu5kSnLJUtN7OL3fWzWTfrnuV+tzg8bcANCl0mx1M2HTZmU8/E
         czmIdKUdvD3bE/nxysqMZz2TdROUunum+4bsE1+oJh3fA71Vbon8UtSdX0ozERHJ+jYm
         6zqArtg2yPdIL0s3EsMZsfqMhQUbNoDR17tk75yCut+wWjMxvNz1WNmtaJssC85YA5cr
         irdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5+/GSfvUfimdV6GEePbS5stgiVERby0RQcMf1fo6qpQ=;
        b=I8Rn8rqxAI6LcwtIyUqMTaTHClGR3x9b+fBn8v2cG1tNh7Vd9W3VHnbN2D5jEFs+uS
         BdSB/q8L2W42AIZyWNiN26NJhxr1uCxwGk4JMVwR0V13C7xl00lTi0vNwfQLPBXCv/B4
         /xw/OLkCm7RHSWh/MIaUeavNss9EnRA8hBG1anB5c7ADwO4O4Icx8l729JzeGOatEBCi
         4Crs6qkQXvXaCl32oZFIhzK/q7ze5GEIPzsiNWmZBhK8gtni0UEuYeTQSYGUmgz+Ktih
         HvGuOi+Tm3W2zJ/cjxqnt+IlOTRbbSYvLBOO2sW+3i+g7uPdLOPNENkR/RsXxgoX0gMT
         vcQg==
X-Gm-Message-State: APt69E3S9Kq90s5jSNAYq9PlrobwMNuaNcWzrqh8dvQ0MrV8AHRVK5U+
        2GUXXNrrtwbzjWH0PcYe8ycHgA==
X-Google-Smtp-Source: AAOMgpcXs5S4WjHGMq0GBV2JCghdJzcsvZLjTfgC9m1tTsPuRcNyYju7//13hNP3L/WV7Z5gp4uayA==
X-Received: by 2002:a1c:c3c6:: with SMTP id t189-v6mr11495834wmf.59.1531140953300;
        Mon, 09 Jul 2018 05:55:53 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j131-v6sm19004429wmb.25.2018.07.09.05.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 05:55:52 -0700 (PDT)
Message-ID: <1531140951.2708.20.camel@baylibre.com>
Subject: Re: [PATCH 0/3] clk: meson: add gen_clk
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 09 Jul 2018 14:55:51 +0200
In-Reply-To: <20180704165458.24149-1-jbrunet@baylibre.com>
References: <20180704165458.24149-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-04 at 18:54 +0200, Jerome Brunet wrote:
> Jerome Brunet (3):
>   clk: meson: gxbb: remove HHI_GEN_CLK_CTNL duplicate definition
>   clk: meson: expose GEN_CLK clkid
>   clk: meson: add gen_clk

Applied
