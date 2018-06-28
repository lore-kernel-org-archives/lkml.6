Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F433C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175C624AD3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 175C624AD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753217AbeF1Cm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 22:42:26 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:44716 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752618AbeF1CmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 22:42:24 -0400
Received: by mail-ed1-f46.google.com with SMTP id c17-v6so4216980eds.11;
        Wed, 27 Jun 2018 19:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5M3CW5Agr2iSI9g0CIwyB4dKIIWKiOehtPh3q+Ekh+4=;
        b=dumg7THpJWw9VJ/KjVveyqP6jxaBdrAqvkbZ1AUH49IL/KQIpQt+s0XAJ66fMFrz5O
         6bF+Pu4OhpWsUq8590Psv4zNAw7HDlwgrc5vC0/jk2hI+w/DHWwmhmAemftWtO23qCDW
         weiO+BXJuoR6NpU+CRcgJ5YbpifMVqI+wzhCsybVUxvKIO+oHiFSTQyvQVM/nlDWMCKy
         xrK0jTAkh6CTkwRJCAet4kBW8vRq+F9vGGENGpj7LNyNmGX1+Q9s47DDdKjZulM33OGu
         GdjS292NQuirIwiq49jgqtS9a+1RR65UVjZNgEefWVDuRlrPsOh8eAYrT4yxx2oSIsLz
         TCrw==
X-Gm-Message-State: APt69E1WSo9fz1iKxrOQqBq0ksXnR7AlgzTI9gs3pHPnsar4RhVIHDQJ
        zbU7rbkIVvePg10p4AXxreLReWIZ
X-Google-Smtp-Source: AAOMgpewRKlI5G06EYG5P0Ecpip2MZIhiQKO6Kp2etOW5TGZX1R38OySRVnUqCbZMYLayDaHaL1LCw==
X-Received: by 2002:a50:eb81:: with SMTP id y1-v6mr7530487edr.38.1530153743126;
        Wed, 27 Jun 2018 19:42:23 -0700 (PDT)
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com. [74.125.82.44])
        by smtp.gmail.com with ESMTPSA id s21-v6sm2524045edr.62.2018.06.27.19.42.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 19:42:22 -0700 (PDT)
Received: by mail-wm0-f44.google.com with SMTP id 69-v6so7306655wmf.3;
        Wed, 27 Jun 2018 19:42:21 -0700 (PDT)
X-Received: by 2002:a1c:850c:: with SMTP id h12-v6mr6482299wmd.116.1530153741759;
 Wed, 27 Jun 2018 19:42:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 19:42:01
 -0700 (PDT)
In-Reply-To: <20180625120304.7543-23-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net> <20180625120304.7543-23-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 28 Jun 2018 10:42:01 +0800
X-Gmail-Original-Message-ID: <CAGb2v67DHtUDyPXKykz1LxehGZRJ2PzPC=1G7iW0hoMzD+6Juw@mail.gmail.com>
Message-ID: <CAGb2v67DHtUDyPXKykz1LxehGZRJ2PzPC=1G7iW0hoMzD+6Juw@mail.gmail.com>
Subject: Re: [PATCH v3 22/24] drm/sun4i: DW HDMI: Expand algorithm for
 possible crtcs
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 8:03 PM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> drm_of_find_possible_crtcs() doesn't work when DW HDMI encoder is
> connected to TCON (crtc) through mux in TCON TOP.
>
> In that case TCON TOP HDMI mux input port has to be manually traversed
> and checked if it matches any known crtc.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
