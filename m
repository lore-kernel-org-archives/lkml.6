Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AA9C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E9B2087A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E9B2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbeIDNFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 09:05:19 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36761 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeIDNFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 09:05:19 -0400
Received: by mail-ed1-f65.google.com with SMTP id f4-v6so2595866edq.3;
        Tue, 04 Sep 2018 01:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RVKJMr6rtf5AgyWtRMxYRYEwyfRMPAbLQ/iTzJHrukI=;
        b=sO5wILISq7EtJ6OrAlQbdkft5ttnFJXcdycmKtnYRLliTUGidTiDnnd9EdeDDTGutW
         OPIuZXeOKNQFmwaaLnxpVOXpHCsEHOyyDOwh7KocN+fvFJIbtkppay39FEcRJlRH/QKE
         JfbaO+86ANSHofOcexZYnEKC7XhUAE8m8YSYx90tXEq09kNbShNX5eiIobCq0tH3gRAf
         6Nf8/BbZUWq63k4ytoARX5kRRg7H4mFWpU0ZIZln+EQ7GxbHLc9yRo6oU4OSqEGJvPJd
         Yl7GYNMUt0dmPnoXS3Tp48TDIYrDp3nyYErjnMBBynFbJltJ/O6qMmPu5mreD/J0U+is
         9EiQ==
X-Gm-Message-State: APzg51BSuQNOjVWWNWmPp9IA1pFTjuuIiPBX6qnNJ3WMS8ZE7vL8f0je
        WeWOWDWcPxU3ss1WBfPV65A2ycPxYhU=
X-Google-Smtp-Source: ANB0Vdaah/5JRi30dzfuRscRtXwtv51Jpm2XwBd3Axt8ofDlGcx1XOUC3Q4nkS5MZ0N6leLvJw/uPA==
X-Received: by 2002:a50:9ac5:: with SMTP id p63-v6mr35775081edb.112.1536050471240;
        Tue, 04 Sep 2018 01:41:11 -0700 (PDT)
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com. [74.125.82.46])
        by smtp.gmail.com with ESMTPSA id i3-v6sm12057400eda.84.2018.09.04.01.41.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 01:41:09 -0700 (PDT)
Received: by mail-wm0-f46.google.com with SMTP id y139-v6so3437890wmc.2;
        Tue, 04 Sep 2018 01:41:09 -0700 (PDT)
X-Received: by 2002:a1c:6646:: with SMTP id a67-v6mr1774573wmc.157.1536050469625;
 Tue, 04 Sep 2018 01:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180902072643.4917-1-jernej.skrabec@siol.net> <20180902072643.4917-3-jernej.skrabec@siol.net>
In-Reply-To: <20180902072643.4917-3-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 4 Sep 2018 16:40:56 +0800
X-Gmail-Original-Message-ID: <CAGb2v65y1W=52SAFFqyCOnHd80nx+oPHUDeysHWBy7o8_g=eeQ@mail.gmail.com>
Message-ID: <CAGb2v65y1W=52SAFFqyCOnHd80nx+oPHUDeysHWBy7o8_g=eeQ@mail.gmail.com>
Subject: Re: [PATCH 02/27] arm64: allwinner: h6: add system controller device
 tree node
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
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
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 2, 2018 at 3:27 PM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
>
> From: Icenowy Zheng <icenowy@aosc.io>
>
> As we have already binding for the H6 system controller, add its node
> to the device tree.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> [fixed compatible string]
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
