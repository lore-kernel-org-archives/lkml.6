Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C54C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439D92083C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RM7jq/59"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439D92083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbeJOVr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 17:47:59 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40004 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeJOVr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 17:47:59 -0400
Received: by mail-oi1-f193.google.com with SMTP id j68-v6so15131577oib.7;
        Mon, 15 Oct 2018 07:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pfCXLvoXKxc3ObP5wqSTlT8v4ogbnl9QSOSoX8UHkjw=;
        b=RM7jq/59RTVbI0qFo8nC3yRfbd89LP5OKweslXGtVlTE6Ms3+GlcFJE1tx7rPZBXCO
         M/3ZF+A24D+5b9rNSaMsWeBHApDDBoBX/tSULzmtd31+hFafPRdly5Z7KFaAQZQ02Hi9
         aX3JQbUBBYYVsMUqExD6PQ4F+yrbjZXh1jLXP5kgxKVXmlRwG1xH/YppYP1qeepwBPZm
         dC3t4IqpRkvb4roq/aeFUPcAw0G6JOhBn/icXHnidIjhAPmdBLraBhbrLI8ac1Ul3Qsr
         2mBj0ufww3zph5vZTtE+PZyj+BJ7W+iciwOB5gQruvF7CxDdZGijUKQdBeIGz2t/Ru2W
         CcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pfCXLvoXKxc3ObP5wqSTlT8v4ogbnl9QSOSoX8UHkjw=;
        b=iTicPdOTajrh7V3A0s0u5lvUKUWCXrUY3tcTJp53j875/4glpeT2vUk8MZFaSX2H/O
         qteACU2p4nYCfdwEoxJE6A/n8xM5WCyPhj32X2k7PPLaA/zfj/fbnlJdC3A+bkcSL3km
         e1DIf/KLyKCieReaDE/+5c66EiVkgQiOSCckwSGbcbLxznTwXUaQYus4ph4k3MYVQ/tW
         wAUx4BkfDK8Hn2tC3cgm1BZEQMS/0/FQ18NKmMJkOEp6RJp1EqZurgGnZVuIhmUdokNc
         eui3lZFbFfUxDgHiIlQWO1CxCrfQgFRnO+zJL4EyGqa8dZ9Tu2OJmZKioYdeoAhFTiGD
         2e0g==
X-Gm-Message-State: ABuFfogUR02i/YWFsaGH0T7kIry51jBSkmXBckLGYeCHQCRLDU6aktTu
        H6qaZphfBPlzqkUwPV3MMOcGavLFitf6+eln0XA=
X-Google-Smtp-Source: ACcGV602DMStHADXZkiVkMkbenKqn++b4FrOLGLo8BXo2btbAvMh+BU4Psf2x8zo+0gDxpEvork+2hkXSG12EJS/yjQ=
X-Received: by 2002:aca:470f:: with SMTP id u15-v6mr9501387oia.259.1539612153300;
 Mon, 15 Oct 2018 07:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539609921.git.leonard.crestez@nxp.com> <fda62f939da082d640a27e506e7a3defac4f123f.1539609921.git.leonard.crestez@nxp.com>
In-Reply-To: <fda62f939da082d640a27e506e7a3defac4f123f.1539609921.git.leonard.crestez@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 15 Oct 2018 11:02:39 -0300
Message-ID: <CAOMZO5DcBbr7THgCCGtsymYVj_fPFQ9WH7XO5bbQHZLtjOL3Ag@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] crypto: mxs-dcp - Add support for dcp clk
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta Neag <horia.geanta@nxp.com>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 10:28 AM Leonard Crestez
<leonard.crestez@nxp.com> wrote:

> +       /* DCP clock is optional, only used on some SOCs */
> +       sdcp->dcp_clk = devm_clk_get(dev, "dcp");
> +       if (IS_ERR(sdcp->dcp_clk)) {
> +               if (sdcp->dcp_clk != ERR_PTR(-ENOENT))
> +                       return PTR_ERR(sdcp->dcp_clk);
> +               sdcp->dcp_clk = NULL;
> +       }
> +
> +       ret = clk_prepare(sdcp->dcp_clk);
> +       if (ret)
> +               return ret;
> +       ret = clk_enable(sdcp->dcp_clk);
> +       if (ret)
> +               return ret;

Couldn't you use clk_prepare_enable() instead?
