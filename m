Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEC6C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBDB72145D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:30:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBDB72145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeIYQg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 12:36:56 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35874 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeIYQg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 12:36:56 -0400
Received: by mail-ed1-f66.google.com with SMTP id f4-v6so18900832edq.3;
        Tue, 25 Sep 2018 03:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kl3dpFdhMMofwmfXZ/Y/wZ0XviklHnLSVKjXe8MwiDw=;
        b=cDqoyRxIySKL+NSW1JURMXmFSeD7yQy4ljduxb3/fEk4Ygh73k0bpwwgQFCqTsBBhB
         wOjCMd8+GTc5FbhK6/KNnSlsUtKx2fQMrNb/kDhivgs1qKeDwgBUe1+w9udri9jjZTrR
         PmEQ3+Bmt8/QaaUaJJqRLdV32M3Y7jTfpHu9vJrllnE4A5ceRSPgwFf+9140LcvVJe8X
         5d5VlZJVEz9vA8X7TGQa9ZuTD74qXLXt1taxvZQ91WAG+qiM7U5qVBItnUygywyxc/yB
         28PyX0Ii2PMLIMX1KvxbHA+90d8r+b4dON0CCslKu9sjmg45buIVlECWxNC6Uji9caJ/
         NSfQ==
X-Gm-Message-State: ABuFfojx5omFHLBzruJ5Q6EYc34H2W1VJ26BPMgUf4cSjoF3g2DE3GaT
        ov4BDu8/b9Oblunrk09Mra/bv6ftuE0=
X-Google-Smtp-Source: ACcGV62r2NEXYBY2vQD5JQPBBA3OFm0B9P3pZH363nslTPrjBq5YEH7kWTV68lf4vLPix/XKnvn7Kw==
X-Received: by 2002:a50:8ad8:: with SMTP id k24-v6mr12122599edk.176.1537871401300;
        Tue, 25 Sep 2018 03:30:01 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id t44-v6sm7689153edd.96.2018.09.25.03.29.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 03:30:00 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id j15-v6so18683507wrt.8;
        Tue, 25 Sep 2018 03:29:59 -0700 (PDT)
X-Received: by 2002:adf:8483:: with SMTP id 3-v6mr405995wrg.34.1537871399577;
 Tue, 25 Sep 2018 03:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180925084940.27903-1-jagan@amarulasolutions.com>
In-Reply-To: <20180925084940.27903-1-jagan@amarulasolutions.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 25 Sep 2018 18:29:48 +0800
X-Gmail-Original-Message-ID: <CAGb2v64vzD5y5PMRscfWkdh+7b=KUJFf0chvOpsrw6XTg+_YYg@mail.gmail.com>
Message-ID: <CAGb2v64vzD5y5PMRscfWkdh+7b=KUJFf0chvOpsrw6XTg+_YYg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] arm64: dts: allwinner: a64: Add display pipeline
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.io>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
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

On Tue, Sep 25, 2018 at 4:49 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Allwinner A64 have a display pipeline with 2 mixers/TCONs, the first
> TCON is connected to LCD and the second is to HDMI.
>
> The HDMI controller/PHY pair is similar to the one on H3/H5.
>
> Add all required device tree nodes of the display pipeline, including
> the TCON0 LCD one and the TCON1 HDMI one.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> [Icenowy: refactor commit message and add 1st pipeline]
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Merged both patches for 4.20. Thanks.
