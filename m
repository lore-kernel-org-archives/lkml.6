Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AFFC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9177122419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qdae9eCj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9177122419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733195AbeKMWqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 17:46:53 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41505 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733060AbeKMWqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 17:46:53 -0500
Received: by mail-ot1-f65.google.com with SMTP id u16so10855736otk.8;
        Tue, 13 Nov 2018 04:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xN0LGQ6GKSJy43NHofIBzrj192ukMKRdBCg2Hi5rE0M=;
        b=Qdae9eCjiUSqO2r62cuK/9m9ZzvtSYTK/UhRzqqPLfme7sbET88VwNlk1/FzyKCETT
         UMI5En8EAwQ4jfJDnQlnuqkizn/Er5EDBGpCiXMQ43Pz6/TN/c6YeM9dbpyG2KyxKyCE
         Db8QHWWvIRYmBl7WTgc8sqoB38Wt3RxG64siU0QNLlY3+0oOEr+qNgwX/JS8kueXV9TY
         QCQan2MX1jyDyXYuuR6zR7dsSjTg5Vfdirzr/j+6aE1NvFCDsKtK0mzq9YcJ8HdnoIk3
         Oxdwa0jOnsDR4uij0N+aShmkdWkuOhA9bIBjDyUtkkGP5uIe+x+/LCrQFHQb8YsTHmEk
         UxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xN0LGQ6GKSJy43NHofIBzrj192ukMKRdBCg2Hi5rE0M=;
        b=GbypmOhy5mQZev6DUg2j33ssP0e0bvUfliyVrYG2oyNlomfh365GGT/LTOz7cljGcg
         j6clYLEY4XbIuMk+Yv/vtDkQ28q/VGJ2b7BGGaEc0oHBbzWJaEP2KEgAv7fTXZIAYdIS
         NXY3k6veECNhFadRAaSS0OzfSuLqd0u2gIzW8nN/SH7pAubybfnP/QGiIvwqLgHySKv3
         7/nfTirIrHGMgH3dPiS1yzoReDdK/eZrMpzLRa9r+wsIZltiwa906y6Y/yJYsbXsYCMO
         gAGI9tP+0bMK8XzXL5tigdxnM8djFLlUNQ41o6A8faf4b70/iF4NZSYCfQorOqSHHPqq
         Scow==
X-Gm-Message-State: AGRZ1gJvybsf+cCXf/PAfvNcA4SEOx8Y7cQIgR5Zqt+Mw5cn5Yb6FrSs
        MVX2qmQf53CjUSbnq4azX8RdR6pwqC83SVZLBLg=
X-Google-Smtp-Source: AJdET5dEUcRcupP4gc8oCFBe0PQSnl8lf2X1lM1YbgbOTxLxneUsn5N/jWzPEaxEF+MZIIOpLHOopBUhNdQx/ZZi/Ds=
X-Received: by 2002:a9d:411:: with SMTP id 17mr2907571otc.78.1542113332956;
 Tue, 13 Nov 2018 04:48:52 -0800 (PST)
MIME-Version: 1.0
References: <cover.71b0f9855c251f9dc389ee77ee6f0e1fad91fb0b.1542097288.git-series.maxime.ripard@bootlin.com>
 <c53e1cdc3b139382b00ee06bf3980d3fd1742ec0.1542097288.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <c53e1cdc3b139382b00ee06bf3980d3fd1742ec0.1542097288.git-series.maxime.ripard@bootlin.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 13 Nov 2018 10:48:51 -0200
Message-ID: <CAOMZO5CjFt1dyu8KOK+jKd88x8hwGNy9aJ-sGgooS9970TGTVQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] media: sunxi: Add A10 CSI driver
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media <linux-media@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 6:25 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> --- /dev/null
> +++ b/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c
> @@ -0,0 +1,275 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

According to Documentation/process/license-rules.rst this should be:

+// SPDX-License-Identifier: GPL-2.0+

Same applies to other places in this patch.
