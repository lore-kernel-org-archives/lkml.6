Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249CDC6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC20920882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC20920882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbeILTyR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:54:17 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35323 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbeILTyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:54:16 -0400
Received: by mail-ed1-f66.google.com with SMTP id y20-v6so2020222edq.2;
        Wed, 12 Sep 2018 07:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=REIfU6SEqMcoE2kTfRwpg2j4UmM8ONGqJOoF5anEGOc=;
        b=XGrgLWBKLYRaroeZ3X4/PvUaQAlKFKZRKW15lV5WBj2gtCQFF3Q9qAkLjt1JdOw1yJ
         VNlXSfzCa6D0sIJqriSkLrUuqvjZ1yQJ4mHk+25mlUkdptc5yEn9g27MhHpgKwxNtaQT
         l1tbPUdY8K/+52k3LGLgtXO3q+I2yKrJjhbs3W98vKMMiij0/XGNlMKQ44cFEvWDBoFj
         +WcaTccZFynPzeuQUHrZkYRTxBz9wJZZQSQQKldctemnvNRA1c7xJJz8WiiHG9Sn6xWm
         p4OQ9F9Bz0dabhbwlM8oWQztyZHLANtUsZO9ScYUKXjKBC7SlW/vTruXPnk3upX+IVeN
         /QjQ==
X-Gm-Message-State: APzg51Bgir4EEx+AinxgZJ+HYKJtD4YtnhC2+yuAZUi+Oq/viIz29wcu
        VQMchNDSXnysXP11qndwWELGCGvzB2U=
X-Google-Smtp-Source: ANB0VdYmJnQ1MDMpFFUoCYMye8LKjwTAkVk0MfnRrsXKoiw8Fh6eaovHfdnQEZhwxuYZxcQp/9c7rg==
X-Received: by 2002:a50:d798:: with SMTP id w24-v6mr3340800edi.19.1536763764231;
        Wed, 12 Sep 2018 07:49:24 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id k28-v6sm641654ede.11.2018.09.12.07.49.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 07:49:23 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id v90-v6so2383034wrc.0;
        Wed, 12 Sep 2018 07:49:23 -0700 (PDT)
X-Received: by 2002:adf:d245:: with SMTP id o5-v6mr1863031wri.91.1536763763304;
 Wed, 12 Sep 2018 07:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
 <20180902072643.4917-3-jernej.skrabec@siol.net> <CAGb2v65y1W=52SAFFqyCOnHd80nx+oPHUDeysHWBy7o8_g=eeQ@mail.gmail.com>
 <9915D9F1-1C60-4AEF-9074-CE040FCD7BF0@aosc.io>
In-Reply-To: <9915D9F1-1C60-4AEF-9074-CE040FCD7BF0@aosc.io>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 12 Sep 2018 22:49:12 +0800
X-Gmail-Original-Message-ID: <CAGb2v64t40yTbrnkg33N2=jBdnvV45H1XSCF8U230LGAyuVySw@mail.gmail.com>
Message-ID: <CAGb2v64t40yTbrnkg33N2=jBdnvV45H1XSCF8U230LGAyuVySw@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH 02/27] arm64: allwinner: h6: add system
 controller device tree node
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 4:44 PM Icenowy Zheng <icenowy@aosc.io> wrote:
>
>
>
> 于 2018年9月4日 GMT+08:00 下午4:40:56, Chen-Yu Tsai <wens@csie.org> 写到:
> >On Sun, Sep 2, 2018 at 3:27 PM Jernej Skrabec <jernej.skrabec@siol.net>
> >wrote:
> >>
> >> From: Icenowy Zheng <icenowy@aosc.io>
> >>
> >> As we have already binding for the H6 system controller, add its node
> >> to the device tree.
> >>
> >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >> [fixed compatible string]
> >> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> >
> >Reviewed-by: Chen-Yu Tsai <wens@csie.org>
>
> By the way can these patches be applied first? (patches
> related to syscon).
>
> They're also needed for EMAC.

Applied.

BTW, the H6 system control EMAC register also has the internal PHY
related controls seen on H3/H5. IIRC you previously mentioned that
they have no effect?

ChenYu
