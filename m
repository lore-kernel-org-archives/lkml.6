Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A6DC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4692258CB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4692258CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932262AbeF1B6D (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 21:58:03 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38087 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750942AbeF1B6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 21:58:01 -0400
Received: by mail-ed1-f68.google.com with SMTP id a5-v6so4176397edt.5;
        Wed, 27 Jun 2018 18:58:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=D0W6+m47+631Mx1IZDQkpujTVIyw0zDALVMBqp/1hZM=;
        b=gAlLPOh9xW0E0sqMyMuOw9NxiUS6rksIHxZnHJeEP//wNJmGRix+aVxgn1xI98yq8Z
         R2DDY4Sv7fzsyt0kEVzkZfZyoprVxLTmN5ehr0hUCpxBci5eyIlQkN2YX0XQKMDmzZjr
         Wf+oOOstrZkWZvhVoeOm3q766M/l//nvLIwJ058S3F96l/P3Z7UbdprvznrmMCrugHxt
         kTDMGabZ+9xo7ny642TThBzIuYO5aag2OSR5y2BYkE9FmM5ARu0P8+9AheqPc0LtoquH
         mEM7jwoVQSOE8B9f9FHhKKLBMosOfs9GpHRPbbSN5bjvqpTsWqY0FZ8xbFBZ3p/1y0bO
         illA==
X-Gm-Message-State: APt69E1UdtKqGLdAXSViEeiC86v+MVLLHJtkIfOufczSfR8h66Zy39ZU
        XVA2nV/cQRpIzDZCVPNCjFOM6IKw
X-Google-Smtp-Source: AAOMgpfv9y3WLiGghURaCnXKtTAoyO+hsJe4dqC/muykS+BMsPlThShPSfU/5mEUWxb5Y8smr1LxqA==
X-Received: by 2002:a50:9704:: with SMTP id c4-v6mr7331544edb.246.1530151079583;
        Wed, 27 Jun 2018 18:57:59 -0700 (PDT)
Received: from mail-wr0-f182.google.com (mail-wr0-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id o6-v6sm3434542edc.37.2018.06.27.18.57.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 18:57:59 -0700 (PDT)
Received: by mail-wr0-f182.google.com with SMTP id h10-v6so3792471wrq.8;
        Wed, 27 Jun 2018 18:57:58 -0700 (PDT)
X-Received: by 2002:adf:a54d:: with SMTP id j13-v6mr7377733wrb.155.1530151078773;
 Wed, 27 Jun 2018 18:57:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 18:57:38
 -0700 (PDT)
In-Reply-To: <20180625120304.7543-8-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net> <20180625120304.7543-8-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 28 Jun 2018 09:57:38 +0800
X-Gmail-Original-Message-ID: <CAGb2v66xYd1cCN7M82HvEovCkVdidsC7ceDbUhiPcy-otPLTHA@mail.gmail.com>
Message-ID: <CAGb2v66xYd1cCN7M82HvEovCkVdidsC7ceDbUhiPcy-otPLTHA@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v3 07/24] drm/sun4i: Split out code for
 enumerating endpoints in output port
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
> Until now, each node has one input port and one output port. However,
> with TCON TOP this is no longer true. It has 3 input and 3 output ports.
>
> In order to prepare to this situation, split out the code which checks
> all endpoints in input port and adds available components to fifo.
>
> This patch doesn't do any functional change.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
