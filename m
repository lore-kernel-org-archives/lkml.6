Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B191FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 758622086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zPyXGZdu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 758622086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbeKPG1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:27:23 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:40668 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbeKPG1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 01:27:23 -0500
Received: by mail-pf1-f182.google.com with SMTP id x2-v6so10216824pfm.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 12:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=OLu5twcor/F+ueA7gj7wAIqbmEe4fA4mJXqQPEAoz1E=;
        b=zPyXGZduP3tFs1t5KvKF3NxNAOa0Xmms0NDHNW0ZC4gO/UKEubI1FrCX0yXBNqxJ3A
         4QWL80YO00potWs2b4Xr3PTpICOJSBo15D0KmV9SEfTPjKWdwSesR6xn+lFF+eHPL+36
         /MVWDkOf4pt+59zYtBX6uq9SzDDsC8SCLO4YRzO3fEdvHbpBwHbGhdIsFEiGDFk/jDYS
         rgvdz0fPTR3fWRxHMtKygIW69nh0GU40b0uA8JwFDg0ezCZUpIZ/d8KvSZdWfG5bAbo6
         jxrklfZqg2ataSZdW9BarI42PeTg4Efnx1+/SQSqmJhbYhSEk959iZ7xfP4hyw2t4xE4
         EFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=OLu5twcor/F+ueA7gj7wAIqbmEe4fA4mJXqQPEAoz1E=;
        b=UwdPCQVpAnN1SqnS/CWNcMRJwTH/XpO0lbCZwVl8uENo/OMG97hWQq+1F7eJ0I2ZWt
         q0JNLu1dvTTOVLO6b1nOcSJZ3quk4kqbLH2ucIwvVg8+atvUD+hI/LT5DFglLkVKYfZE
         Um0FURj6BeSvskQUZZfA1n21HYyhOCkVrHT+f0mRRUAGMD1tmBfHrQnYSNdmS8ZFjBaN
         2RU+uhCKcqwtTtiLMoP+EQWS2vcvEMvBxuzRoB6A0bFXy2N6JDxxb1yvjPjVN4BpcEgB
         P0jgsNK3baknML6zF3+g/dvwtQhGRuT0PwsXRylIW9X3RMaOlnNqpA/xVstWOVZ/fxRV
         3VuA==
X-Gm-Message-State: AGRZ1gLS3lzPzvZjxis2UHwLFzW1oAK74AoR5rqAJwDmdxlSjcL76Mpl
        HvLW4OGNoIkntJn5+Ac+I/EZMg==
X-Google-Smtp-Source: AJdET5fQ+y3KyEHJ8fcwBhfWPpHbJTGWtFVBK4eBzJ+6k4+pzHASsFspEa4w/CU+5/bL9p1AsmYHtA==
X-Received: by 2002:a62:2901:: with SMTP id p1-v6mr2990043pfp.109.1542313085909;
        Thu, 15 Nov 2018 12:18:05 -0800 (PST)
Received: from localhost ([107.181.189.87])
        by smtp.googlemail.com with ESMTPSA id m85-v6sm28775897pfj.171.2018.11.15.12.18.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 12:18:05 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson: s400: add bcm bluetooth device
In-Reply-To: <20181109132331.12010-1-jbrunet@baylibre.com>
References: <20181109132331.12010-1-jbrunet@baylibre.com>
Date:   Thu, 15 Nov 2018 12:18:04 -0800
Message-ID: <7hefbmdrib.fsf@eze.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Add broadcom bluetooth device on the s400
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Queued for v4.21,

Kevin
