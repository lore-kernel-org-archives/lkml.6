Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B595FC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698F42088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 698F42088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbeGYP7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:59:20 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51449 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729079AbeGYP7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:59:19 -0400
Received: by mail-it0-f65.google.com with SMTP id e14-v6so761593itf.1;
        Wed, 25 Jul 2018 07:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AltBz0JPzuF6jOpx6AYJgdFsEoOa6QXXtvPy3lHu9eI=;
        b=N9raC7KjkrPdtSzYczqwTfNIWdIMM7qKKlZvrkrAzRF0U96ix5YcsxKV9K4pWkv9hs
         j0IM/8dJ10McO3r2AT8Wy4Wkqgel5bDtaV/XhHGp7CeUuqcxV87u88oe0x6NwEzqk6Q0
         v+Wo6G+C2RJU3SmHbfIquHWTwE9EN67sr1LzC+drpqeinbmeHOqXH7BUUy1eTxpH7iZB
         EXmo1xXPmHJvOlyOe44+qWV4mHWF0aXh1Ml2ppvqjwHVppsYivhKIdwkExUolw0cZRZO
         Lw+WdtdtEMkeQHDeTHvoM7RJg0Gu28FAUi6qJ6wwMEe30DGfZClElNuo0QcBDOvmSyFF
         Spow==
X-Gm-Message-State: AOUpUlFSYAUglnxjuRd0y7wb/Y36HOY5XTXoY+SJ64F2AhEbnX05nLxs
        JJ2/mu6kuavM5wGiHGpvyw==
X-Google-Smtp-Source: AAOMgpdxwnlZChpvYwcBhYhB9/CbDcnmhROAoEiHkaMYyXobk4BXmwnhxfZMsvV5d2HXriu14iXXWQ==
X-Received: by 2002:a24:a005:: with SMTP id o5-v6mr6562527ite.124.1532530038201;
        Wed, 25 Jul 2018 07:47:18 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id y190-v6sm2375913itg.40.2018.07.25.07.47.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 07:47:17 -0700 (PDT)
Date:   Wed, 25 Jul 2018 08:47:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Houlong Wei <houlong.wei@mediatek.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Sascha Hauer <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        CK HU <ck.hu@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Monica Wang <monica.wang@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>, ginny.chen@mediatek.com,
        enzhu.wang@mediatek.com
Subject: Re: [PATCH v23 1/4] dt-bindings: soc: Add documentation for the
 MediaTek GCE unit
Message-ID: <20180725144716.GA29676@rob-hp-laptop>
References: <1532482002-11164-1-git-send-email-houlong.wei@mediatek.com>
 <1532482002-11164-2-git-send-email-houlong.wei@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532482002-11164-2-git-send-email-houlong.wei@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 09:26:39AM +0800, Houlong Wei wrote:
> This adds documentation for the MediaTek Global Command Engine (GCE) unit
> found in MT8173 SoCs.
> 
> Signed-off-by: Houlong Wei <houlong.wei@mediatek.com>
> Signed-off-by: HS Liao <hs.liao@mediatek.com>
> ---
>  .../devicetree/bindings/mailbox/mtk-gce.txt        |   57 ++++++++++++++++++++
>  include/dt-bindings/gce/mt8173-gce.h               |   44 +++++++++++++++
>  2 files changed, 101 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/mtk-gce.txt
>  create mode 100644 include/dt-bindings/gce/mt8173-gce.h

Reviewed-by: Rob Herring <robh@kernel.org>
