Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA0AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD4F2086B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsAWOKfc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DD4F2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbeIGTtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 15:49:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:35248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727705AbeIGTtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 15:49:50 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CD982086B;
        Fri,  7 Sep 2018 15:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536332910;
        bh=jMAdw4vIHnCmh6u4I1FZhYNHROFddJnv1Wr/nF14d/Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DsAWOKfcXRJ+iMRk5esUUBdms9zr1tyPUrbbnznIMfCLR/wl+q1A4qn/26ViT+rqq
         op74sW49Hkk0GgYUn6FfrqJZkjUrC3axglcmTkcDtCNGkSf1S097holcDj3g7U51Wb
         gLrjkx7+rrM+44HE82qrxT+ynqV9+TIo2B2PTwAU=
Received: by mail-qk1-f179.google.com with SMTP id z78-v6so9878681qka.0;
        Fri, 07 Sep 2018 08:08:30 -0700 (PDT)
X-Gm-Message-State: APzg51CTx5FqYxGfvy8pK5xPJzYHL1fqIvCV7euGX7xmVOKfDQ5bSQ+2
        ExXL9IRihk7dgMI/g0VZrhVp0szsosZO574Blw==
X-Google-Smtp-Source: ANB0VdaSbCA5NGeXnh2OcL8lyNB2K3NRTY5Z2mTjjExxt2tbJlJirAz01su+zAfs+84kqG1yhedLjqTJVa/BRhuBZs8=
X-Received: by 2002:a37:4453:: with SMTP id r80-v6mr6233077qka.79.1536332909323;
 Fri, 07 Sep 2018 08:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-12-robh@kernel.org>
In-Reply-To: <20180828015252.28511-12-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 7 Sep 2018 10:08:18 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLR_jsVScGBp0cMfhNJrw4bYOAychWX3Ejw1DBzTpRK+A@mail.gmail.com>
Message-ID: <CAL_JsqLR_jsVScGBp0cMfhNJrw4bYOAychWX3Ejw1DBzTpRK+A@mail.gmail.com>
Subject: Re: [PATCH] clk: Convert to using %pOFn instead of device_node.name
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 8:53 PM Rob Herring <robh@kernel.org> wrote:
>
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.


> @@ -492,8 +492,7 @@ static void __init _ti_omap4_clkctrl_setup(struct device_node *node)
>
>         provider->base = of_iomap(node, 0);
>
> -       provider->clkdm_name = kmalloc(strlen(node->parent->name) + 3,
> -                                      GFP_KERNEL);
> +       provider->clkdm_name = kasprintf(GFP_KERNEL, "%pOFnxxx", node->parent);

Turns out xxx was a bad choice as the %p handler eats all alphanumeric
characters. Looks like this has already been applied, so I will send a
fix.

Rob
