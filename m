Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346AFC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7CCF25C2E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:23:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7CCF25C2E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753127AbeF1CXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 22:23:02 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45420 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752491AbeF1CW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 22:22:59 -0400
Received: by mail-ed1-f67.google.com with SMTP id x22-v6so4194423edq.12;
        Wed, 27 Jun 2018 19:22:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uZUslHGqIoSriNy0N02Y+aJPgyPSuBwL0ddVpNuX0vk=;
        b=b33u+FzfMbpSx/58b2LGNBm/c/Cv1FlUsYigouPyxHzC26iwRtR5oBUxkbbtXxzzho
         YvdYgJQUjnXNZ/VwnX5ZKKMYWKPo8sLdE4pF0Zvdx85VHy5L7NzzacKwsERS4spFbJQo
         Z4kJ6xPPV2VKKMICeOrionLe/hQWo/SnVg243QALhXaO0EpCBtE3yeNYxMiuG5XKYCn1
         uWfuLLkGKbBINXt1tG5M48ADqxxTCa8G8MN9NaSOOFMur8I9v6KBY/DbjCyyrnredgR+
         QY+ngrTmKwo3tqxUmlyh2gt9eAEW2r1iTknQ/XQVAXkPfU/VGOXzHwrPjFr550vUiyB0
         CoZg==
X-Gm-Message-State: APt69E3F4gFD2VaCv4k0t1B7hCkrgLmyUH11ucm8vQ9oBqVt5MWgxVxr
        mZlOoJ5BK3jCghSepyh+LE1J002W
X-Google-Smtp-Source: AAOMgpdMjaGlylhKR+RLyPYGda44VifFVcFXKShQx8yDzHcEv4qqTGVMIew6NVttbAWLyi8CtfVyhg==
X-Received: by 2002:aa7:da4b:: with SMTP id w11-v6mr7565872eds.54.1530152577994;
        Wed, 27 Jun 2018 19:22:57 -0700 (PDT)
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com. [74.125.82.49])
        by smtp.gmail.com with ESMTPSA id p30-v6sm3260455edc.5.2018.06.27.19.22.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 19:22:57 -0700 (PDT)
Received: by mail-wm0-f49.google.com with SMTP id v16-v6so7809147wmv.5;
        Wed, 27 Jun 2018 19:22:56 -0700 (PDT)
X-Received: by 2002:a1c:1bc5:: with SMTP id b188-v6mr689910wmb.143.1530152576789;
 Wed, 27 Jun 2018 19:22:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 19:22:36
 -0700 (PDT)
In-Reply-To: <20180625120304.7543-17-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net> <20180625120304.7543-17-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 28 Jun 2018 10:22:36 +0800
X-Gmail-Original-Message-ID: <CAGb2v65En4RbVdRu7c6MJUztVhC36dWr0kaO9bqc9PtuXAcsww@mail.gmail.com>
Message-ID: <CAGb2v65En4RbVdRu7c6MJUztVhC36dWr0kaO9bqc9PtuXAcsww@mail.gmail.com>
Subject: Re: [PATCH v3 16/24] drm/sun4i: Enable DW HDMI PHY clock
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
> Current DW HDMI PHY code never prepares and enables PHY clock after it is
> created. It's just used as it is. This may work in some cases, but it's
> clearly wrong. Fix it by adding proper calls to enable/disable PHY
> clock.
>
> Fixes: 4f86e81748fe ("drm/sun4i: Add support for H3 HDMI PHY variant")
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

So why does it work on the H3? Because there's only one PLL that the whole
display pipeline uses?

We should probably tag this for stable. So,

Cc: <stable@vger.kernel.org>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
