Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA30C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 03:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127692255D
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 03:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 127692255D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932990AbeGGDjR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 23:39:17 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37690 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932688AbeGGDjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 23:39:15 -0400
Received: by mail-ed1-f66.google.com with SMTP id v22-v6so9954718edq.4;
        Fri, 06 Jul 2018 20:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=asQ1r79gi4/Fw9/Q7mbuEsYT1hGtP/tWPAmZegLzVt0=;
        b=QenAi2DKtWUluA1I85uFXJaag3SfNCRi9nHDB4SCcXD2+GvjquizOJ+Fw6Y9Ax3C5V
         /E5HLzmnnWPoPqzYuxrTyWxJrjSkGELQK2bYoMIjT/Zs5AEwXg2/EFIsMi7QlHEPw/Y7
         2wgNsVLpImrZ2bpchBAM0QBwzVxjHe9sOlo4RHndQVfLYLFXC8bphisGsVlSHNTIv2K+
         FhvvzPQK1sfeTXFcg1WP7YGAvWbf2EEekxyNqnGouTiAIf8RoVQstE8t5leFTJdDfYkz
         gp9ZFstjh9evFS2h0tE4fgvAawVI7tYj5jWgpEvuCPnxPovJ717I+ixZHWCGuW4zLjjP
         ybYA==
X-Gm-Message-State: APt69E135vEZz7f/Wl9/A1TNxxE6xGTw53hMx69KQdaJ6s+14lHK/o4s
        T6p819xLo7jl45KvGV82uVdqY1p1
X-Google-Smtp-Source: AAOMgpf3vZuAOGte2QaB9hiozdv7I0Q48vpmd/eEVJ/vSw4sWdX/mZer2bCVHIfLdrMcyjXicp2Qag==
X-Received: by 2002:a50:d759:: with SMTP id i25-v6mr13540384edj.260.1530934753786;
        Fri, 06 Jul 2018 20:39:13 -0700 (PDT)
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com. [74.125.82.44])
        by smtp.gmail.com with ESMTPSA id r5-v6sm4629098edp.60.2018.07.06.20.39.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 20:39:13 -0700 (PDT)
Received: by mail-wm0-f44.google.com with SMTP id b188-v6so16431185wme.3;
        Fri, 06 Jul 2018 20:39:13 -0700 (PDT)
X-Received: by 2002:a1c:7c0c:: with SMTP id x12-v6mr8036144wmc.58.1530934753388;
 Fri, 06 Jul 2018 20:39:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Fri, 6 Jul 2018 20:38:52 -0700 (PDT)
In-Reply-To: <20180706153805.25842-6-icenowy@aosc.io>
References: <20180706153805.25842-1-icenowy@aosc.io> <20180706153805.25842-6-icenowy@aosc.io>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sat, 7 Jul 2018 11:38:52 +0800
X-Gmail-Original-Message-ID: <CAGb2v67ataiu6JiZRwdDbbT5WECKmxbxxTTSgfZ_fkY40ok8Og@mail.gmail.com>
Message-ID: <CAGb2v67ataiu6JiZRwdDbbT5WECKmxbxxTTSgfZ_fkY40ok8Og@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2 5/9] arm64: allwinner: dts: h6: enable
 USB2 on Pine H64
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 11:38 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> Pine H64 board has both the USB2 OTG port and the USB2 host port on H6

Nit: USB* pins. A "port" implies something you can plug into.

ChenYu

> SoC wired out to USB Type-A port.
>
> Enable them.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
