Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B03C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C534E25D33
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C534E25D33
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932718AbeF1CbL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 22:31:11 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42597 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932205AbeF1CbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 22:31:10 -0400
Received: by mail-ed1-f68.google.com with SMTP id g12-v6so4203208edi.9;
        Wed, 27 Jun 2018 19:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BmY3y8dOL6RENE8Z48Jwh++LPA3xgJv9av9uOn3yqkU=;
        b=hZrczFiAFMy1qx46zjg1GwfVySgECgy03+7SP4xmFRughp7JM+JgHJJ+RHZL5PKu5S
         tqlh/sw35MP83oDtXUDZp9SOia2DEDVCVfoXa6FfWCJIR1wjhFNhktQ/g6b5VqCau5eI
         xosOvKZJdT9z+xd09ea9DfDrI3j1TT9LLpXpZ9J7Ukd3/H8DzEmM25V/2vK22UjTqu/g
         +El74SQWdw3Ox2EAUD5iMWPROJuCgoBg8dp4bnXUnNeCXBzYWLTP4CP2B9PHe4HP1xEa
         B3h+nUiW8c5l1bhlZ/e6xbEHzn3ezTChtL9MtG23KaPlYga2XyDVxXvN2W/7txohBUYG
         JNog==
X-Gm-Message-State: APt69E3IPvvCPSx7v2Y8ArDBzsxf9CH38o0KxjyKPOnKatX/OeLIjVLk
        DAUKxtvLBoCxxJ2CAlrX+RHYPRdd
X-Google-Smtp-Source: AAOMgpc+P6vlVlQ73ODPzBHzXIN9FwlWpcOEB/gh/gPiJczHyY1hyfjl3Mw55gMQM/EfZjR3l+mz1w==
X-Received: by 2002:a50:d8ca:: with SMTP id y10-v6mr603423edj.62.1530153068324;
        Wed, 27 Jun 2018 19:31:08 -0700 (PDT)
Received: from mail-wr0-f170.google.com (mail-wr0-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id s22-v6sm4424626edb.55.2018.06.27.19.31.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 19:31:08 -0700 (PDT)
Received: by mail-wr0-f170.google.com with SMTP id b8-v6so3841061wro.6;
        Wed, 27 Jun 2018 19:31:08 -0700 (PDT)
X-Received: by 2002:adf:a54d:: with SMTP id j13-v6mr7436670wrb.155.1530153067880;
 Wed, 27 Jun 2018 19:31:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 19:30:47
 -0700 (PDT)
In-Reply-To: <20180625120304.7543-21-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net> <20180625120304.7543-21-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 28 Jun 2018 10:30:47 +0800
X-Gmail-Original-Message-ID: <CAGb2v64dC6xdVHCTnVODCubAYD=WQF+zVkaLXWTnrCoYtYuzag@mail.gmail.com>
Message-ID: <CAGb2v64dC6xdVHCTnVODCubAYD=WQF+zVkaLXWTnrCoYtYuzag@mail.gmail.com>
Subject: Re: [PATCH v3 20/24] drm/sun4i: Add support for A64 HDMI PHY
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
> PHY is the same as in H3, except it can switch between two clock
> parents.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
