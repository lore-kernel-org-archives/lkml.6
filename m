Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75606C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1364120858
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jzb7E+Rg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1364120858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbeKPGQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:16:54 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35777 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbeKPGQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 01:16:54 -0500
Received: by mail-pg1-f193.google.com with SMTP id 32-v6so9497354pgu.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 12:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=uAHTFQzf0pb/u2U7587xEB18KLNvKbDKVoQOOQGJPSY=;
        b=jzb7E+RgOy0Tj2FmchzY4Se1Hu/kaZ6B6zgBaC+3EacVqulD8QCGBEUYBeqemmYng9
         msj96liqZezBvD1AxsjOP3/qfYq/NoGRy3aVpW55Me7J9FBzH0xO7kLAwUm7YZfrvr+p
         RCEaZ9t6LSdQ042axxbh101pH5iUbagp+3PS2kRtJ1INgD2wfpH/2CMYFXr18xvZr5j+
         W8rZ/cbo6naBg4EhnIxlGGNIGuWLGGMhdeaq/LCScwXN7m/KG9iyez+Rd3OJFMG3aciR
         VeUopQGq39BT3a5JByMhZESnQqC45sozzwmewG1WiklZeH4IyHasGh3Txziw+h4wpuDe
         3uvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=uAHTFQzf0pb/u2U7587xEB18KLNvKbDKVoQOOQGJPSY=;
        b=GTnOyY4lh7zSBTHpn4+JjsQdL/GFF3qNbwfucGJ3mzzcIT6WUJI/kTy5k9y3HEtrgV
         Vvinui5oPfMCb+A0L5bHc0G3oYr2KOcVr3GnmiAjhJRWQwV1r2UfJ1iAwVyIJkVtiYdZ
         A+ffRiWr3XoAz77wnoHBxkXmZh+cFEfZF4WBGrluqLAi9J7XV7t17gTbkdkgYQNV5MCh
         i3wHwmxy6xsCdPIg0LlkOZA/J+K3gAcftgOutDWfurXskIaLODGYRLXKYbghi7vCFpzV
         R+YBi8XWTeoAZQPSPrT8xhQ2VFL5VdXmJ6ubTSvBAg7vOsQsUXgt9UfOMwtjOYqUs905
         GpEQ==
X-Gm-Message-State: AGRZ1gKhY86MQbXYuYzvAHg01h3h9fTgfBKpMuLxiOPhNRRpltuzZkyh
        V+M4JW8/28wgHR046IJDai7gJg==
X-Google-Smtp-Source: AJdET5cBgeDRdQhR27PmRxiyXByKr68hfI6A8DFUkpyIUqMx8HnQWlRgr1Mva2J81Hk5VbPcvUFFwQ==
X-Received: by 2002:a63:104d:: with SMTP id 13mr7094182pgq.303.1542312458724;
        Thu, 15 Nov 2018 12:07:38 -0800 (PST)
Received: from localhost ([107.181.189.87])
        by smtp.googlemail.com with ESMTPSA id m9sm22772965pgd.32.2018.11.15.12.07.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 12:07:38 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/4] arm64: dts: meson-axg: enable SCPI
In-Reply-To: <20181108135352.8459-1-jbrunet@baylibre.com>
References: <20181108135352.8459-1-jbrunet@baylibre.com>
Date:   Thu, 15 Nov 2018 12:07:36 -0800
Message-ID: <7hk1ledrzr.fsf@eze.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> The goal of this patchset is to enable SCPI (dvfs and hwmon) the axg
> platform. The first patches in this series fix a few issues to acheive
> this.

Queued for v4.21 (branch: v4.21/dt64)

Kevin
