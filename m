Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047D6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE1FC2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vMkLQMSl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbfAQUD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 15:03:58 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37032 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728801AbfAQUD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 15:03:57 -0500
Received: by mail-pf1-f195.google.com with SMTP id y126so5349692pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 12:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=CFnl8dyjGiuRB3x9RlqOHQmlDV1KXXaciQgsX6gUhkU=;
        b=vMkLQMSlzFUUMoB2rdPseJ2wFWNIx7yMkFLoMjvbGe9ZQ11W8ATa4sW8NCKNDLrMfE
         Pe0BxgOLxifJxiv6/eDPQ22CS/6tl5R6EQ9ED+L62/RKYqm1uEotxe2Tf3JOaEhHUFfS
         qxjU1xBh99gcsbGHz8GiyNqz2O5lBKdZpCJuDCF8sUrsKP5hR4uDxXcMWRM5mFL34nBS
         OWJ0BUwDf1sLG/mZwfRRSHUh0y3v4i5nxXPJX+5tgL6JSoIuVcQzvZvTPIwvbfvTXePB
         qUE7ywFzJmnaJ3lkDteqJo5Yh14lioTeKY1uw4wXyh6wSCmYZWxn3dRyNA5sVDih4eGQ
         ytGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=CFnl8dyjGiuRB3x9RlqOHQmlDV1KXXaciQgsX6gUhkU=;
        b=D2FX+NnEepa376JjBCrNtaMLpElMB/7qdwDDqGIHoPBS03Q8CTQzepmWy8J33DQil+
         V+p6D37QUM9iCH/Lg76Eo/07h53heTahaol7HmAU5Dh1R7zjXETMexx2fbqWQkyNF66Z
         MrCD5n4vRL0+rjFaqoztaRFHM0fhZAdyaOAfCuZW4UDF0tCYKVtNgqYds5MeVbbzkslm
         9o7k1aYf/m9IzDZ8YrC6GfVOrGcvnCWMvAqrBskdqq208/G6iuSuaF9lGhr7G8eLYQXr
         bWNHoHqHr8VuseNcRIMSy1mVqTxGBORr/Rnil+h2mWY+n6R6I41F4uGQwmMsJsMkikRk
         9kMA==
X-Gm-Message-State: AJcUukdcDimiZio8F7y9D+FQ06B3IXP8yjbEE5P2RywtUaLPNyX+qvYr
        sKE9nKQOaboyvdu34+QdB33Vlw==
X-Google-Smtp-Source: ALg8bN5jZaJngh1RR5VggI5q8YZhlkSYnkHJ60CjmRQnCCjaKEsSpZU0QBvT1vqA2BcKmnmat393ug==
X-Received: by 2002:a63:334a:: with SMTP id z71mr14802353pgz.400.1547755436912;
        Thu, 17 Jan 2019 12:03:56 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:e076:9fe9:59e2:1e0b])
        by smtp.googlemail.com with ESMTPSA id v191sm4040650pgb.77.2019.01.17.12.03.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 12:03:56 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Subject: Re: [PATCH] arm64: dts: meson-axg: add efuse device
In-Reply-To: <20190117100234.30989-1-jbrunet@baylibre.com>
References: <20190117100234.30989-1-jbrunet@baylibre.com>
Date:   Thu, 17 Jan 2019 12:03:55 -0800
Message-ID: <7ho98faw5w.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Add efuse to the AXG family
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Queued for v5.1,

Thanks,

Kevin
