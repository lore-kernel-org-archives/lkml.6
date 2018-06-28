Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E99C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2E12481D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD2E12481D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752662AbeF1ByC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 21:54:02 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37903 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751803AbeF1ByA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 21:54:00 -0400
Received: by mail-ed1-f68.google.com with SMTP id a5-v6so4172766edt.5;
        Wed, 27 Jun 2018 18:53:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FcDeFTIV6YJrJtDqVVx/lt7gjp2u69AyPfQLdS3KnhQ=;
        b=ALMXnQCFLt/qzwlohAL4VfqF+EwtbMY/pVupPZbXZU+J8FAf0w6m2fde8qZWzrQxCh
         uFPRk5Liece/lizvhCjD33c0VHwzvslF0Dh0Uynk43aT4MgWw/NpyZlGtZ4fNMeGUxy5
         yMxCTXcyTbYFP07evQDZpMEAXh+VdJInyt6KtzyBVoGif2Sb8WH7o2AtFg4X2TO8lm29
         p8tL/j1mvWJZSSd2NERHhVUyolVfGs3r4HPxFFJG3Cd6vYSOywGc4/yuZ+/lwpKM7M+L
         Cp1CuuQcYLAf99X/0/dCas7WT8goSaFLc+R64LM6i+MienOs6giUIKmFp3D0AeZG36l3
         0gbw==
X-Gm-Message-State: APt69E3rfjoTguOMRB+6Kh4OwSye5W4vSjZ2K0OpPEKSbsyI2bJtxmxU
        q1exLfQJsAMm6tgzg1CDbucEZUIJ
X-Google-Smtp-Source: AAOMgpfZ363fuEmhjQdXgvIJQmSQ1WgAtt4WI5bnGY7w+Yiqn6W75+TyYNoSgMKGkeRRIfiGV90XFQ==
X-Received: by 2002:a50:d1c1:: with SMTP id i1-v6mr7660841edg.122.1530150839080;
        Wed, 27 Jun 2018 18:53:59 -0700 (PDT)
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com. [74.125.82.49])
        by smtp.gmail.com with ESMTPSA id l13-v6sm2467965edn.74.2018.06.27.18.53.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 18:53:57 -0700 (PDT)
Received: by mail-wm0-f49.google.com with SMTP id w137-v6so7761399wmw.1;
        Wed, 27 Jun 2018 18:53:57 -0700 (PDT)
X-Received: by 2002:a1c:bf0c:: with SMTP id p12-v6mr6296121wmf.120.1530150836991;
 Wed, 27 Jun 2018 18:53:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 18:53:36
 -0700 (PDT)
In-Reply-To: <20180625120304.7543-7-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net> <20180625120304.7543-7-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 28 Jun 2018 09:53:36 +0800
X-Gmail-Original-Message-ID: <CAGb2v65dNvqcWa7MUMesrEeDGfEmd0xPpKQmbqJ60_FHe=Y_JA@mail.gmail.com>
Message-ID: <CAGb2v65dNvqcWa7MUMesrEeDGfEmd0xPpKQmbqJ60_FHe=Y_JA@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v3 06/24] drm/sun4i: Fix releasing node when
 enumerating enpoints
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
> sun4i_drv_add_endpoints() has a memory leak since it uses of_node_put()
> when remote is equal to NULL and does nothing when remote has a valid
> pointer.
>
> Invert the logic to fix memory leak.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Given this is a fix, it should have Fixes and stable tags.

ChenYu
