Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC304ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56DB42086E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUw/FxPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56DB42086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731560AbeITAmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 20:42:32 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42984 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbeITAmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 20:42:32 -0400
Received: by mail-ot1-f66.google.com with SMTP id h26-v6so6853153otl.9;
        Wed, 19 Sep 2018 12:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dku9Rrxc0QOiOy4IIYWAr3fWKfvnFMOLu5c/lt+L1dc=;
        b=iUw/FxPNWSKG6pKd8hNpWnRNGuuMRkZcFYdjEX8LgXjCajihWM4QX+kr4pYu7BqRZl
         n977+DNEh1KlRIvZ+8A5kOcq8dQKjqJcSmRydRDHIzt4LM0BAOg04XNFM7PYiKAdsXg5
         CiviwJ5t3pAvtqi7XA5BZTurtx6ntDCoTvia+pZAmmEOntJxB/1KRjJ59JxHz6Iz1ixR
         GTel1RWFQUzjDJHzkFPpwYZ45mFtbRoQExuv7AGx3fysE7XilG+2m76XgDN5JDDs7Dhi
         xU0k4saYY/udo//6UuzeBzhCy2QuMXWoP95AgbUfQgrDx9Kc2thKpXNUQkWNZMcER3C6
         ynqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dku9Rrxc0QOiOy4IIYWAr3fWKfvnFMOLu5c/lt+L1dc=;
        b=Te65hBvV12QcNnp9VaCdnlsdHJzNlt0Vf4RqbJntrZ6NfwSzZG8FjujmsMqZFGR32P
         jBqa8rNzz71P54bPPdTHhFTtNqhTOnDzc2/VkoByBPqZTJQqjVZ+Z05CBIGsteABXm0d
         JGdcevoDm/xGX5JaqKfyChuffUUpu1eZsWRGuHwQH9EOz3PBxbvkZC6edbMIOU9QAQ3n
         Ru//eDDNhDeKu9GsHvIrkNZkJz6hHska2gZcIqWRcCi+MDHN5FBOr/ZShZaiEU+Lt2gQ
         sFDJB/EcyqSUWQPmwo66fNtuLRDUjXvkOVtIy0wDCTLW3GdkZnbB4XC3HQbMNWSYoVyu
         UDOg==
X-Gm-Message-State: APzg51Bu7wLuA7PSsyMLiFjuUguUIwx54AkOzlGdYEJswLIwvtQcz3SY
        Icll8QGIJjV4dtB+rA8udHJTjJQjX/zX8YaE9qKuFewD
X-Google-Smtp-Source: ANB0VdZKBe4wbzjCchpe1E2sjYksqyvQxsLximRYFeNPYJaF4KoaniS4RpCIsXsCCE3pAKtM5S5CoSq1sswhsHNAx9A=
X-Received: by 2002:a9d:2879:: with SMTP id h54-v6mr20984610otd.1.1537383794246;
 Wed, 19 Sep 2018 12:03:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:cca:0:0:0:0:0 with HTTP; Wed, 19 Sep 2018 12:03:13 -0700 (PDT)
In-Reply-To: <20180914224849.27173-6-lolivei@synopsys.com>
References: <20180914224849.27173-1-lolivei@synopsys.com> <20180914224849.27173-6-lolivei@synopsys.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 19 Sep 2018 16:03:13 -0300
Message-ID: <CAOMZO5BU1myguEppOH4FfB_wOGBuFjAzrNQ-eu1hYWthLHBAvA@mail.gmail.com>
Subject: Re: [PATCH 5/5] media: platform: dwc: Add MIPI CSI-2 controller driver
To:     Luis Oliveira <Luis.Oliveira@synopsys.com>
Cc:     linux-media <linux-media@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        all-jpinto-org-pt02@synopsys.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Thierry Reding <treding@nvidia.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Todor Tomov <todor.tomov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis,

On Fri, Sep 14, 2018 at 7:48 PM, Luis Oliveira
<Luis.Oliveira@synopsys.com> wrote:

> +++ b/drivers/media/platform/dwc/dw-csi-plat.c
> @@ -0,0 +1,508 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

According to Documentation/process/license-rules.rst this should be:
// SPDX-License-Identifier: GPL-2.0+

> +static int
> +dw_mipi_csi_parse_dt(struct platform_device *pdev, struct mipi_csi_dev *dev)
> +{
> +       struct device_node *node = pdev->dev.of_node;
> +       struct v4l2_fwnode_endpoint endpoint;
> +       int ret = 0;

No need to assign ret to 0.

> +
> +       ret = of_property_read_u32(node, "snps,output-type", &dev->hw.output);

> --- /dev/null
> +++ b/drivers/media/platform/dwc/dw-csi-plat.h
> @@ -0,0 +1,76 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */

Same as before.

> diff --git a/drivers/media/platform/dwc/dw-mipi-csi.c b/drivers/media/platform/dwc/dw-mipi-csi.c
> new file mode 100644
> index 0000000..926b287
> --- /dev/null
> +++ b/drivers/media/platform/dwc/dw-mipi-csi.c
> @@ -0,0 +1,491 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

Ditto.

> +void dw_mipi_csi_fill_timings(struct mipi_csi_dev *dev,
> +                          const struct v4l2_bt_timings *bt)
> +{
> +

No need for this empty line.

> +       if (bt == NULL)

> diff --git a/drivers/media/platform/dwc/dw-mipi-csi.h b/drivers/media/platform/dwc/dw-mipi-csi.h
> new file mode 100644
> index 0000000..eca0e48
> --- /dev/null
> +++ b/drivers/media/platform/dwc/dw-mipi-csi.h
> @@ -0,0 +1,202 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */

Ditto.
