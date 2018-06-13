Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B8D37C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 03:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA99208AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 03:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA99208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754432AbeFMDTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 23:19:11 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55523 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754202AbeFMDTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 23:19:08 -0400
Received: by mail-wm0-f65.google.com with SMTP id v16-v6so2069546wmh.5;
        Tue, 12 Jun 2018 20:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qW4mEnHcrrV7WQI7+eLP6GMIL5gFKc4Be8c6NWjRZcI=;
        b=N6nCyb48f8H20dy/6DD0PPhsqpR2reZdc93bRj0FBBU+rrpUmBzmobH1WjzAMvjGcS
         JMIlFc4X4ryJa7vdJZSYZJn9LGEhUzvlcpMWTSZ8U6FMzWVduc5h4i2K/6PiogA0rOYc
         I99DCvnpUHtVyfUq7P2INRbfHCsyHbDQ+TPRKicaimGNghfLdGpHDpXGDcecXRXAGrXs
         4kKblRnP0eqHPWeE54lDRkHrrvwxrTujpiMtPp7BxLiDBxt15AJpOefMRIFrKxXMQD8a
         w4b4n6XU1R2qPTWMFka+JF1hYVUmhkgl9Tti6/cO7Rvp22q148oz0XhsU4585YNdrfVX
         uzAw==
X-Gm-Message-State: APt69E1vR5vMVjWqBdzrCWdBdyS49a0/Gt22QkILEDRUdvEwtbATN6SC
        bhcKPm9xAf8b9v2qMjPLQxeME0WH
X-Google-Smtp-Source: ADUXVKJpCzYcXs5VqaSpnvb4XY6d2GbVjWXrd4uVT4YWx9e2NWQA3q0O3Rp1NZnlbBca8WRQc/8jfw==
X-Received: by 2002:a50:b223:: with SMTP id o32-v6mr2055157edd.184.1528859947126;
        Tue, 12 Jun 2018 20:19:07 -0700 (PDT)
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com. [74.125.82.43])
        by smtp.gmail.com with ESMTPSA id x15-v6sm855009edd.90.2018.06.12.20.19.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 20:19:06 -0700 (PDT)
Received: by mail-wm0-f43.google.com with SMTP id r15-v6so2118195wmc.1;
        Tue, 12 Jun 2018 20:19:06 -0700 (PDT)
X-Received: by 2002:a1c:bf0c:: with SMTP id p12-v6mr2079024wmf.120.1528859946259;
 Tue, 12 Jun 2018 20:19:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a158:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 20:18:45
 -0700 (PDT)
In-Reply-To: <20180612200036.21483-2-jernej.skrabec@siol.net>
References: <20180612200036.21483-1-jernej.skrabec@siol.net> <20180612200036.21483-2-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 13 Jun 2018 11:18:45 +0800
X-Gmail-Original-Message-ID: <CAGb2v66rUqqUrqmq09hHcGHF1buZieYmu1zOkUXZyyQPtyUZew@mail.gmail.com>
Message-ID: <CAGb2v66rUqqUrqmq09hHcGHF1buZieYmu1zOkUXZyyQPtyUZew@mail.gmail.com>
Subject: Re: [PATCH v2 01/27] clk: sunxi-ng: r40: Add minimal rate for video PLLs
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

On Wed, Jun 13, 2018 at 4:00 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> According to documentation and experience with other similar SoCs, video
> PLLs don't work stable if their output frequency is set below 192 MHz.
>
> Because of that, set minimal rate to both R40 video PLLs to 192 MHz.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
