Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FE4FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E0620866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U9k1b/T0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E0620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbeINOUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 10:20:51 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36980 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbeINOUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 10:20:49 -0400
Received: by mail-it0-f68.google.com with SMTP id h20-v6so1645197itf.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 02:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/BlB8UQTllvzMuYY1d1m4gw0znVAToq1/vk71vmwwCM=;
        b=U9k1b/T05TzSlxsTQIakiUsEWpgBtAQiDM0nKqv66dioduzcbtjSnC352fSkRB+vNS
         iGWOKgzbovutOboR8JmA24X5TekVvmDnF3K7QDtekZURtAWTfT5F0BBdqD/S9qYf64Vs
         M9rmIZxnz8AJg2/5ILUcq93EMn6+/DCLLUGy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/BlB8UQTllvzMuYY1d1m4gw0znVAToq1/vk71vmwwCM=;
        b=cjwsQAlso9+8a76lBdyBZ6A5dxDGTqmZP67Vf+wO5XmfS99odwiowWEpfgUurh24rY
         W844sHfrO54zcXxi94B642TMv3daT/a/2UqFpcAtpRxl41MRjmXYIRRf9bfL8qWW8Cwx
         mtLFwPLmF4dJsVtoMoYf1WR38NZYbFAO7jHWoNUMRWlsxoWyj+F+hekl3/d2stiQDkhS
         u8FmXOzHUszdRAvC3+11JKFze/oNcy7rqcZtb5GrUXvaWyKmE0psLH5rPqXzGp/hqV5I
         FqyvnrJDzxTOIhll2/QE1flsNeC0ZUlDwgrqMr5nRyjxEJdu/RIM+R+guan9Nh7vtqQ+
         5YaA==
X-Gm-Message-State: APzg51AID8x2AfeELPiGjM0xDPHBkcw2ljOvUkQflQS0b6Kh96xstdNs
        yC5QEML28Vyj+uz7yDFsKHTpCXiKRlUsG81F98d18Q==
X-Google-Smtp-Source: ANB0Vdbu+JfodPH4tiyYs893UugtXcbGPzAPEecKFlVx6IYa+cQRYzRjIoWQlcsDr//7Cq9sonjmpBr4R49G0dPwcVc=
X-Received: by 2002:a24:9d84:: with SMTP id f126-v6mr1534848itd.130.1536916035460;
 Fri, 14 Sep 2018 02:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180912183222.25414-1-stefan@agner.ch>
In-Reply-To: <20180912183222.25414-1-stefan@agner.ch>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 14 Sep 2018 11:07:03 +0200
Message-ID: <CACRpkdZdxLMkECq8BBJHDqKszHPMt2uUPFbwbPVNKXyxu-SWGQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] drm/bridge: add bus flag support
To:     Stefan Agner <stefan@agner.ch>
Cc:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Dave Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        sean@poorly.run, Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        max.krummenacher@toradex.com,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 8:32 PM Stefan Agner <stefan@agner.ch> wrote:

> @Linus Walleij, Laurent Pinchart: Since you have been involved in
> the initial bus timings discussion, I would like to have your Ack
> on at least patch 2/3... If we want to keep the setup/hold timings,
> the patchset should also work without those two patches.

AFAICT this ends up with the PL111 code identical to what I
proposed in my first patch set to support the latching properly,
so I am pretty much happy as long as my hardware does not
flicker. (Rough consensus and running code.) I'm not very invested
in either idea to represent these timings, so
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
