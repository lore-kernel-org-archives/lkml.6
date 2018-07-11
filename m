Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C59C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71AE3208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:55:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71AE3208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732594AbeGKC5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:57:54 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36763 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732505AbeGKC5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:57:53 -0400
Received: by mail-ed1-f65.google.com with SMTP id t3-v6so17989761eds.3;
        Tue, 10 Jul 2018 19:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oXZY/9GNshfDR4tIaBvbGRco44l78GLfoErtXT3m0Uw=;
        b=HojHat48kMxd2svwLThuljM0ggYEQRTA1XpUCuP8qv0x+VG9ZWrprWOChxOmLj4gS3
         0sSqfKxYDvB68qKm4FBdVhOoiGjc3blwT8nAD/G28TEPloblYeRTkUdkvbxFA95lX81f
         02m7VKtTaKNm2NoDkmwlQNDcUSig7H47n9c6H5SzeL5qAWG8rH3Mk2vwQw3QyC2KF9zq
         zJJWMDSqzu31UhPMwnVWwOaluDjIvpyYZWoVErscgSptjgoCu8JISM6SICOu2fGKX1lZ
         9Ua/LgA4qJ2F3Ir5ZG65orGk8aP+eKuEpEk/nRq33KNIQmEA0e5tNjsabcRScT1e7IRJ
         r7DA==
X-Gm-Message-State: APt69E3Zq3dTuc7LXhzFgcVthN/714RVnaii1WSKX3dfGzeVy2mOZYAi
        SXOIUg9P9a+qzc1KUwf3eSI4MLDZ
X-Google-Smtp-Source: AAOMgpej4QSuEqetyVIiRd3k8TpP+l8YCSuKpyPqxrJeRjCK6sRMD3WY7ApQAnmt4SmfplvQu0z5Zw==
X-Received: by 2002:a50:b8c4:: with SMTP id l62-v6mr28145099ede.80.1531277747466;
        Tue, 10 Jul 2018 19:55:47 -0700 (PDT)
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com. [74.125.82.49])
        by smtp.gmail.com with ESMTPSA id j7-v6sm9250747edh.76.2018.07.10.19.55.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 19:55:47 -0700 (PDT)
Received: by mail-wm0-f49.google.com with SMTP id s12-v6so880284wmc.1;
        Tue, 10 Jul 2018 19:55:47 -0700 (PDT)
X-Received: by 2002:a1c:7c0c:: with SMTP id x12-v6mr16767826wmc.58.1531277746990;
 Tue, 10 Jul 2018 19:55:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 19:55:26
 -0700 (PDT)
In-Reply-To: <20180710203511.18454-9-jernej.skrabec@siol.net>
References: <20180710203511.18454-1-jernej.skrabec@siol.net> <20180710203511.18454-9-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 11 Jul 2018 10:55:26 +0800
X-Gmail-Original-Message-ID: <CAGb2v64N__6BctU5cxUHUxGtnc14ps18VrWfMC=kykOn8C+fKg@mail.gmail.com>
Message-ID: <CAGb2v64N__6BctU5cxUHUxGtnc14ps18VrWfMC=kykOn8C+fKg@mail.gmail.com>
Subject: Re: [PATCH v2 08/18] ARM: dts: sun8i: r40: Add mixer ids to TCON TOP
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 4:35 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> sun4i-drm DT binding, second paragraph of the first section says:
>
> For all connections between components up to the TCONs in the display
> pipeline, when there are multiple components of the same type at the
> same depth, the local endpoint ID must be the same as the remote
> component's index.
>
> Add mixer ids in R40 DT as mandated by DT binding.
>
> Fixes: 05a43a262d03 ("ARM: dts: sun8i: r40: Add HDMI pipeline")
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
