Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA96C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91EEF25900
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91EEF25900
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933581AbeFYMab (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:30:31 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:39476 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933130AbeFYMa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:30:29 -0400
Received: by mail-ed1-f49.google.com with SMTP id w14-v6so5297520eds.6;
        Mon, 25 Jun 2018 05:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3Fqaokd9YoXMPbABdPp8PrThI284lwaAHGOAtLScEqU=;
        b=bwbcyXHHj7cp5xnya/TXOhS9uHyfVyhK69qlDqP/68q4XG29E64PYCEKftIBinBOHo
         Iwbb22LD94vinvnDjhdlkgFJXFuFCXHpqX8ISrgTd+Z7akgHqyBX7m1Zx6pc/hBU8ED6
         rch6OAKjNW6EyocCej11MUz21AD5vuDZQtt2afLcu7ZDWfo4iicZsRJK2GJzGuGVKPtj
         gV+fd8azsStkeGYOQVKB1a2hH2zLUgoeQugqZrijlxK5yh3XGR6czq1JuVN6w0Tlz6Wd
         GsbcxWy0S2M2Sd1XOD3b6cTe2bZXvGWsk0eM8stakEt4K+5dCkZWfvTsdQKc3doIeygi
         hfVA==
X-Gm-Message-State: APt69E3/zcpCOPLgFKh/L74tLqX4iah/2aXnM041/Cl3Nxx+ZiQZRhF6
        UxPNKkVomieHYy9wlwn6Lc3GEfx6
X-Google-Smtp-Source: ADUXVKIy+0XNFTTrjLfjKwwyq8MW2KRFenuA7md93t6yjw3TN5nStlOPnVxaKuWCnogMa263YA4ZZA==
X-Received: by 2002:a50:d690:: with SMTP id r16-v6mr2582158edi.259.1529929827904;
        Mon, 25 Jun 2018 05:30:27 -0700 (PDT)
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com. [74.125.82.50])
        by smtp.gmail.com with ESMTPSA id f25-v6sm6834884edd.87.2018.06.25.05.30.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 05:30:26 -0700 (PDT)
Received: by mail-wm0-f50.google.com with SMTP id 69-v6so9783670wmf.3;
        Mon, 25 Jun 2018 05:30:26 -0700 (PDT)
X-Received: by 2002:a1c:850c:: with SMTP id h12-v6mr872405wmd.116.1529929826578;
 Mon, 25 Jun 2018 05:30:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 05:30:06
 -0700 (PDT)
In-Reply-To: <20180625120304.7543-4-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net> <20180625120304.7543-4-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 25 Jun 2018 20:30:06 +0800
X-Gmail-Original-Message-ID: <CAGb2v64itH+8HEE0OVx+ys4fKg31pZcS3m0WUguH=Ny-t347ww@mail.gmail.com>
Message-ID: <CAGb2v64itH+8HEE0OVx+ys4fKg31pZcS3m0WUguH=Ny-t347ww@mail.gmail.com>
Subject: Re: [PATCH v3 03/24] clk: sunxi-ng: r40: Export video PLLs
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
> Video PLLs need to be referenced in R40 DT as possible HDMI PHY parent.
>
> Export them.
>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
