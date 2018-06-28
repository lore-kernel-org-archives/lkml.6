Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBA1C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29D2241AA
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29D2241AA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753154AbeF1CY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 22:24:28 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41811 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752179AbeF1CY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 22:24:26 -0400
Received: by mail-ed1-f68.google.com with SMTP id b12-v6so4191914edt.8;
        Wed, 27 Jun 2018 19:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=izbwCorAaW3BZilV+Ue9DofoTlIwRvxm+PcZ0LJFPDw=;
        b=rtz0TxP23b5CPGFszwYcmVqudhsq4MS7KvZwwmy6kGFroHf2WiHbyFMXLr2baBev8R
         2kyZrvn9GmBh9+EsR/ZXuVYSAXFKqjVerOEpWpmWu2p97Sa7zovFRkuWacqwkpPWwJmL
         pINK7L4oHUbRkk3s/sWm2A9eM2OHWgLYSQk+ulQIYaGspyyxbPGe3PHQR1f1KG1KPQzr
         pnAucs9AdqIAX2OU4MTGuAzwvBLG0oAuyGEKwm/m9BpKqypBynTw/D0bMwxczX7ZlZ6k
         0KnZjrcg+kJLsyAxuFCJvTqRc0Lzt47Z7BGf6Cc7AGUy5B5OzaW1OA/9WoLM/AbonEbz
         1svw==
X-Gm-Message-State: APt69E3Caw+W6pcYCtmAIu6b3etkuEQTwn/qSFLW2WDCq226Wgf6F2YZ
        xOHfKvPWnMNzz62KhPgQVvbih3OQ
X-Google-Smtp-Source: AAOMgpeUILYZu6FG4IRHx27zqvodR3GdF18M4kjvjWu0T9iMUOPNm7LQGol6CWcg8DUwPAUNVWK2Cw==
X-Received: by 2002:a50:c313:: with SMTP id a19-v6mr5242597edb.177.1530152664575;
        Wed, 27 Jun 2018 19:24:24 -0700 (PDT)
Received: from mail-wr0-f169.google.com (mail-wr0-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id j24-v6sm221272edr.90.2018.06.27.19.24.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 19:24:23 -0700 (PDT)
Received: by mail-wr0-f169.google.com with SMTP id e18-v6so3838779wrs.5;
        Wed, 27 Jun 2018 19:24:23 -0700 (PDT)
X-Received: by 2002:adf:a54d:: with SMTP id j13-v6mr7424927wrb.155.1530152663063;
 Wed, 27 Jun 2018 19:24:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 19:24:02
 -0700 (PDT)
In-Reply-To: <20180625120304.7543-18-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net> <20180625120304.7543-18-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 28 Jun 2018 10:24:02 +0800
X-Gmail-Original-Message-ID: <CAGb2v66Ew7bshwiObQsbep9CCNeVeQFzunYrDcQsw+F+7rffHQ@mail.gmail.com>
Message-ID: <CAGb2v66Ew7bshwiObQsbep9CCNeVeQFzunYrDcQsw+F+7rffHQ@mail.gmail.com>
Subject: Re: [PATCH v3 17/24] drm/sun4i: Don't change clock bits in DW HDMI
 PHY driver
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

On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> DW HDMI PHY driver and PHY clock driver share same registers. Make sure
> that DW HDMI PHY setup code doesn't change any clock related bits.
> During initialization, set PHY PLL parent bit to 0.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

and maybe a fixes tag?
