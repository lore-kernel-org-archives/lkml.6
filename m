Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F29D2C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 03:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FA320693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 03:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1FA320693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933556AbeFMDUg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 23:20:36 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55637 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933226AbeFMDUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 23:20:23 -0400
Received: by mail-wm0-f68.google.com with SMTP id v16-v6so2071954wmh.5;
        Tue, 12 Jun 2018 20:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=S7ga92kEysaCWAc6Lfr2w/7QyMFvTlYeDxp/uPsaWgE=;
        b=jP6KGjCUTGBUnHtsu/3bhgis5MfOFZG0QTHrKO2R/m1gfrvcqbNmayAwQibYVVuaTt
         7IH9OVc9GY7IqK9XuADlL4hGoc4ORYlUyVtGy9eUdpWgdk1ryGrjjocNEcd9m2DPOIlL
         VIM/lfI8W0wPqfVBykIEsiRdWTAgLZLyAazMq26c2ad6czptKEopaESZSn/LvkDVraYu
         L/wbY1G8ElLCpGiK2Uo5ESYM6hKC0uvj7LbrrQBWBzCLAZE07AWMGxuRqDByveuBe4Uk
         iNsT3fb2Ep3NI4ACz3Tte0twSxDsG8h9jQ6WRpQyIjd/Nsoe+2Y3VEIssLbQS+NFDIhn
         1NLg==
X-Gm-Message-State: APt69E2ceuRFSldhyxOyEHriZ2lW/OuXXcnLgnlzD32HcPmj9pVf+7fl
        o3waaUlShvoPrRI6MyS/Pp1RrrNC
X-Google-Smtp-Source: ADUXVKJOvi4NsJsj1gvNLJ/kFJwejIKrjyaQMKlx/V5OtUD6KIPp4T3A/o9QkeSFpm2TrRlq0iEjzw==
X-Received: by 2002:a50:f552:: with SMTP id w18-v6mr2059245edm.230.1528860021314;
        Tue, 12 Jun 2018 20:20:21 -0700 (PDT)
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com. [74.125.82.41])
        by smtp.gmail.com with ESMTPSA id e1-v6sm730968edr.23.2018.06.12.20.20.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 20:20:19 -0700 (PDT)
Received: by mail-wm0-f41.google.com with SMTP id v131-v6so2432220wma.1;
        Tue, 12 Jun 2018 20:20:19 -0700 (PDT)
X-Received: by 2002:a1c:850c:: with SMTP id h12-v6mr2126275wmd.116.1528860019507;
 Tue, 12 Jun 2018 20:20:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a158:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 20:19:59
 -0700 (PDT)
In-Reply-To: <20180612200036.21483-3-jernej.skrabec@siol.net>
References: <20180612200036.21483-1-jernej.skrabec@siol.net> <20180612200036.21483-3-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 13 Jun 2018 11:19:59 +0800
X-Gmail-Original-Message-ID: <CAGb2v65PyFjC9vQjLj4wGqZ4ETuZd5dF664gwbCRf66=wKOH0w@mail.gmail.com>
Message-ID: <CAGb2v65PyFjC9vQjLj4wGqZ4ETuZd5dF664gwbCRf66=wKOH0w@mail.gmail.com>
Subject: Re: [PATCH v2 02/27] clk: sunxi-ng: r40: Allow setting parent rate to
 display related clocks
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
> Display related peripherals need precise clocks to operate correctly.
>
> Allow DE2, TCONs and HDMI to set parent clock.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
