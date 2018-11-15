Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F19C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13918208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="SPatuXT5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13918208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbeKPGFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:05:12 -0500
Received: from mail-pg1-f176.google.com ([209.85.215.176]:38653 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbeKPGFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 01:05:11 -0500
Received: by mail-pg1-f176.google.com with SMTP id f8-v6so9474876pgq.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 11:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=CH10SDDZ6hHXpy8YIB68H5dVJKAng00DYj6IUoGpK0E=;
        b=SPatuXT5jPUAaUj0i6Li+E7+AkH518jCs0GQEzae+S2qbZGRyenoqwBPTS6fEAxZBE
         VVVj2Zihg5d6WWpda+k1M8UV7NOLGlVqMOgjjo6iCcUpIn3SjKZnp/hKIo5psG/BmM0f
         nM5d3tmR/vekG1Sg+Q9agzcL0Cmkcqu391ba8lL1FVBSIir/Qhftfp7gn4y61u9EZn/M
         p/0adm+WuHAHaqErdaA+dvxaE1uscf1+i77krKYgrH8i4+bkxF6UhmDbCnjI4ARrmVlV
         cpWXnKC6+gNoHgGxGrRufk7A3ThiiLRY3BB7zAO1xuk7uwixW3N3xS0udg8oEZ82UeZV
         Lk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=CH10SDDZ6hHXpy8YIB68H5dVJKAng00DYj6IUoGpK0E=;
        b=baToTFXQfQNldOZ4MnK+MgH0je0zroOZNeSLs9DRmNYnTn3XpcTNBvestx0J3h6W/6
         lJ3tJnKLawoYz4WLnk4zZMpAArpX3s/yeQXmLHlWllz+nlwd+w1h7HwSSZ6k7UuR1tp2
         M/muXJXYXgVtT728lzRpMwGgAApw8ACOfn9J4Lnk39mDEpUSNb4YHflvpw9sYOQGPXJg
         DnCx8d40BS4JIujbyTvorX2gMpTEODzD6Ml/NZ8ZT7TC1jVRDjntcZln+VEtJFppWUj6
         YhTDDqrf5F1QtRnFC6WfedySqhLg6eOa9LiPBaUNtWFcVQ0v5pLoO3cHWh8Q5qGYOxgW
         hi/w==
X-Gm-Message-State: AGRZ1gL1Z6T37tdPP2D+PXeO59AEa359sO2A0oMInMJrZRqEqMGCDaJS
        G1AQSAFXDm9Mc0GhCqQ25ny7XA==
X-Google-Smtp-Source: AJdET5dabca52VTH7fIifH2jIupNjz8nNrkMug0sQK1GNR+NAFmKtNQcn6NnIoMHlqJNeN+VXS47vw==
X-Received: by 2002:a62:1308:: with SMTP id b8-v6mr7660702pfj.215.1542311758521;
        Thu, 15 Nov 2018 11:55:58 -0800 (PST)
Received: from localhost ([107.181.189.87])
        by smtp.googlemail.com with ESMTPSA id f62sm27017014pgc.67.2018.11.15.11.55.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 11:55:57 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson-axg: s400: add cts-rts to the bluetooth uart
In-Reply-To: <20181108095640.27876-1-jbrunet@baylibre.com>
References: <20181108095640.27876-1-jbrunet@baylibre.com>
Date:   Thu, 15 Nov 2018 11:55:56 -0800
Message-ID: <7htvkidsj7.fsf@eze.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> The uart used with bluetooth chipset on the s400 has flow control
> available. Let's enable it.

Queued for v4.21 with Neil's tag (branch: v4.21/dt64)

Kevin
