Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABECBC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1A021479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="srKH15O6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F1A021479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbeJIPpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 11:45:46 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:51752 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbeJIPpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 11:45:46 -0400
Received: by mail-wm1-f46.google.com with SMTP id 143-v6so914631wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 01:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=jrlqW5a/v5xDBBATvChyRMwYpWeWeEXFhinRbKx3A+k=;
        b=srKH15O6VKpWf239rwPfBo8BdbS0x4agpUQobW9wHePZHmcHC1/gWibyNkTMRQkIJX
         RFBhI4g7EMLyeqg7zgv5tqPec9rrhwEGXIkfe8cGRlZqicq9S6QNXpIhVu7Fi2aHx2wg
         dqS2a7fYzBQrGOoCUiq+VHnIs8zCF1SD7btHHFtaqLzKPa/U4T9D9waGO58XQEMYernI
         Nn5YR2yCzYKRKo5B6hc96MW/B3GMuG4C/nN/7p1HfXdsJMSh+oo1hYyPmwKToOU7YOM9
         UknICKkMbMXUMUIKz77l0HpXvlyG+zoSWqOSCarZVsog+rk20Omt234+0dN+0eHNJztw
         SVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jrlqW5a/v5xDBBATvChyRMwYpWeWeEXFhinRbKx3A+k=;
        b=QLaFi81WCErdYa1NhWfjXBkkTAKkZH9oKuc6SAUYuykURmzeyf+DUi8CykNa9GTlvt
         JKfE/FIf0E1kBE5UEAW++kN37t4FxABBfP/UmiSeG5qWBvZiKyLTfA6DT+Egn3NcyRZP
         qBo1922TDy2iNYg7yex8QAfAmGKsXxXEdsxh7uoltOMpo/JX31OsipU56XfY4lW6Nvq/
         WNFy1cu+luE73IdebG/h5Ddc5BxISfTWp0NqzX4tExYenss8wwxenCqlvTihM6MT1CaD
         6EJI7lm8Gn432hwmlPKD6FZPepXsV+be2isFf8BpWj25xYv6/aaQm5+OkAOnOlyzsh2+
         O7dw==
X-Gm-Message-State: ABuFfogIYhHIXPFEPNWsLf6gvG0h53oFQdX0fEzYLMyZaeaVTg+crHEe
        d3zlBUjTtN3d1xj7wC174bvfAw==
X-Google-Smtp-Source: ACcGV63Vx/gqsF6aNEIu1XstsfBCYUx7LLbTfqx0VcHJEHX+kwlPRkT7s2o2ue9OlNR8vpcncVHekw==
X-Received: by 2002:a1c:7f83:: with SMTP id a125-v6mr1108687wmd.23.1539073798565;
        Tue, 09 Oct 2018 01:29:58 -0700 (PDT)
Received: from localhost (AStLambert-681-1-25-242.w90-86.abo.wanadoo.fr. [90.86.145.242])
        by smtp.googlemail.com with ESMTPSA id c21-v6sm1325272wmh.26.2018.10.09.01.29.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 01:29:57 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] arm64: dts: meson: s400: emmc updates
Organization: BayLibre
References: <20181002084341.5487-1-jbrunet@baylibre.com>
Date:   Tue, 09 Oct 2018 10:29:56 +0200
In-Reply-To: <20181002084341.5487-1-jbrunet@baylibre.com> (Jerome Brunet's
        message of "Tue, 2 Oct 2018 10:43:39 +0200")
Message-ID: <7hbm834j5n.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> This patchset adds the emmc pwrseq to the emmc node and disable the device
> by default, since eMMC is not the default option for this board.
>
> Jerome Brunet (2):
>   arm64: dts: meson-axg: s400: add missing emmc pwrseq
>   arm64: dts: meson-axg: s400: disable emmc

Appled to v4.20/dt64.

Thanks.

Kevin

P.S.  Looks like I forgot to reply when I applied these, but these are
      already submitted to arm-soc and merged.
