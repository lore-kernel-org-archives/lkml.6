Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C34C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C855322507
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vx/d3U1I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C855322507
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388966AbeKPGJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:09:57 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46537 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeKPGJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 01:09:57 -0500
Received: by mail-pl1-f196.google.com with SMTP id t13so7006624ply.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 12:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=q277+5qFk8kEho+4l2RpapvvZALvIMIOICelZD0Ddoc=;
        b=vx/d3U1IeocX8+MqUsF+Z76pvWac7gPkAQWfgtRSEBVOtLXrTnChZ5I0Bo4qx3lT+d
         /NJdt1cI5egXJ4sXOQjUfaZNxFYPh8fKXe4ItU/QkniDo7saryCwekpQ/kFovkkyYITJ
         yFqpNAne3DIsYPypoCwLmOF+PL2/MFXVmcnZ7FhPeX95CgEkHSA1JLA6Kd4zTh3hEKFG
         XlFo31jzuGc6zUCil9G0rDavOhD2zso7oQymudRdTScduoi2wgMy23tBb1jNBurPdIdg
         TiCVJp7BWSHtzx54Y8EsSfNCQbkgBeqpVup0q9SYQVqDDF+gbHCPkmHhp4KDP1TJyfco
         7Rzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=q277+5qFk8kEho+4l2RpapvvZALvIMIOICelZD0Ddoc=;
        b=g2x8+nQNhIBvoLFgGtiLgywu04hTbhToBsjmxmcBTqWbqhmS0CZKP8evzEg9HKyeTO
         IBJJsFn9yC2O62N5kkMuY8wH/V7IcpuAdP1ferd0v2tF6FgyYq+RtFhX4TK+CbZs22H1
         uiP+uCeshs+tlkWyj4e0C0QhrfQvZc4LsLHE+tftFTvpYSBZiY3Du4VG5qZTRPyb50M9
         xSf+dgjqcJLZGjESuHuQeteh5iGC2Q4xQeyjzJKS7MVyYV0C68O4A56w+jIXDjKsAMMh
         r47H7VKau7OlejDFzQjKz6VHw30nu+oQhoNenXXdRhyPCDS/A5SEiuk+uDbiaruNTnDq
         bImw==
X-Gm-Message-State: AGRZ1gLMdg/B+nuamgOPrU6N9M6VeuE8PsJncYooatSoB4dewnNS5jEi
        tszpcvaCzH0EK/sKf/yM8FKD0Q==
X-Google-Smtp-Source: AJdET5ehYI5HXt//pQICSygYQBmpnE0rjgmuB3ze/vgMRyhdWqi+ccnV0b9Cruu+iT9S0Q1ADk/Ttw==
X-Received: by 2002:a17:902:7587:: with SMTP id j7mr7680109pll.191.1542312042938;
        Thu, 15 Nov 2018 12:00:42 -0800 (PST)
Received: from localhost ([107.181.189.87])
        by smtp.googlemail.com with ESMTPSA id n17-v6sm59798582pfj.148.2018.11.15.12.00.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 12:00:42 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RESEND] arm64: dts: meson-gx: Add hdmi_5v regulator as hdmi tx supply
In-Reply-To: <1541683478-5173-1-git-send-email-narmstrong@baylibre.com>
References: <1541683478-5173-1-git-send-email-narmstrong@baylibre.com>
Date:   Thu, 15 Nov 2018 12:00:41 -0800
Message-ID: <7hmuqadsba.fsf@eze.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The hdmi_5v regulator must be enabled to provide power to the physical HDMI
> PHY and enables the HDMI 5V presence loopback for the monitor.
>
> Fixes: b409f625a6d5 ("ARM64: dts: meson-gx: Add HDMI_5V regulator on selected boards")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Queued for v4.21 (branch v4.21/dt64)

Kevin
