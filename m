Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BE5C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F1D20858
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="albLv87q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F1D20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389020AbeKPGZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:25:56 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35476 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbeKPGZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 01:25:54 -0500
Received: by mail-pf1-f194.google.com with SMTP id v9-v6so10225846pff.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 12:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=+HOXid5qGwDwuXmbb30deKvvul/CHsc21hABNWZYiQY=;
        b=albLv87qTJ6T9BngIXisWu1MMf+uZEp9i0SpwPDzd1/8AfDNA6oOzsbxVBikjD+roQ
         sFo4i29btpnkUBi/8VzLq4mwXE6YX+bLrUsFL32HH+kq/hBV5tziDxQ+23MDT+k3UHKq
         49LyOZk/5jsAhZImRVcxZMLraLZGdtyaHRQZVWZFT+/I3VIi6zbMJSCcE7PYY15V/xcb
         ayNUV5OnxxDEMcsSP7w8IwX+BCEoQkJzp1af5pMYF0YcRZ5BGaUdXSkzP610rXBWGYBP
         7yEtN3pi5xjU/zayUvJ+6KXoLI7FQHvGEbEI+8E5POtWX8r76yvRyCwQyJT27irYVPRc
         taJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=+HOXid5qGwDwuXmbb30deKvvul/CHsc21hABNWZYiQY=;
        b=R7lsl39zvyVk+5Wd9k0/oj5yPxbK6R5RraaGpb4saidjPTF6ckIoUB5nCqv0SCv0jI
         5JgSiY6vDOGwH5bD5LSPcVf/kzKQKP9gvWBkn20JqwAEOwDst8XI3eifQca3MMUuZaSC
         lH0CmtvehBrJlIe81YjqSg84ytA+hUWEm6sRBfGEbzfxl2rfsS0s1luuZ5gD4qEt9ucK
         uhosXL5F+oXr6K4118eHbiAHXVMlxYnelvlG+4Nxad87wfwuOoZZmO9X5OFR/Yujrv1z
         td53cFZsRJg/cTLzEce15AHPyrlaWGvJ0A/FmUlmOuGv8e2apzmgYvt7w/TlWqzxS654
         2k4Q==
X-Gm-Message-State: AGRZ1gK35Q26vPuucCAMGYEgAXd4me9ZTXf6TcdegVhMFzpnl4V1XcW1
        DOQEjHkKXCrqqmJZtX9feMkcfUNKn8Otgg==
X-Google-Smtp-Source: AJdET5e9E+Ot/77tXyMAnb000lVTS3p5IF0NYSaJ3EpF6W/oq/FfakwoJdMXt0pkclPTpXXszcfzSg==
X-Received: by 2002:a62:6547:: with SMTP id z68-v6mr7744736pfb.169.1542312997406;
        Thu, 15 Nov 2018 12:16:37 -0800 (PST)
Received: from localhost ([107.181.189.87])
        by smtp.googlemail.com with ESMTPSA id j186-v6sm49444888pfg.117.2018.11.15.12.16.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 12:16:36 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     He Yangxuan <yangxuan8282@gmail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        narmstrong@baylibre.com, carlo@caione.org
Subject: Re: [PATCH] ARM64: dts: meson: p230: disable advertisement EEE for GbE.
In-Reply-To: <20181109125936.3siduqtjmj6vv5ur@raspberrypi>
References: <20181109125936.3siduqtjmj6vv5ur@raspberrypi>
Date:   Thu, 15 Nov 2018 12:16:35 -0800
Message-ID: <7hh8gidrks.fsf@eze.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

He Yangxuan <yangxuan8282@gmail.com> writes:

> This patch disable EEE advertisement for P230 board (DWMAC + RTL8211F).
> If not disable it, the network connection is not stable, will got issues
> like throughput drop or broken link.
>
> Signed-off-by: He Yangxuan <yangxuan8282@gmail.com>

Thanks for the patch.

Queued for v4.21 (branch: v4.21/dt64)

Kevin
