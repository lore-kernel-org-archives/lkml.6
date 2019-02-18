Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFF0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 03:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8596E218C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 03:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbfBRDbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 22:31:48 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43197 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727939AbfBRDbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 22:31:47 -0500
Received: by mail-ed1-f67.google.com with SMTP id m35so8650959ede.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 19:31:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y1jbZK2oK+T+9k9VdDasqi0vOffyrkQfUDkEzJRzB2w=;
        b=MsuM7Ms/ICqs4ryTB87uFvhbUxyFaFdAX4NUoXwA3hQEL36zlgZXaLguTv+1gybCRB
         df+L/jzY7229MIpv7O0J8Nv7stoJcwMsGvsG5Hr7R23ESGeIAM3Mnj9BjCDbzRiaJl8K
         NZ5YSvh5FIAs6f2hiKbKhvU056ZGDavxmNdOVufHlHnivviSQzhMrZtaYxVnzPITGiu0
         xh689X9zrUfZB3m4jOXPTrCwiN+leJJ/nEvAePcEfGc7OsKKL1S7g/vx/Jf3tjygK2vV
         5d3HXq9bMdUqA/ePFVOM0/3nhhQM06b84Sa2sc0uSqCIAHApkZicV+JtCm25xU6NJCmp
         8Gzw==
X-Gm-Message-State: AHQUAubKu7eqgEWWDfgJR+mLFOXEEZcTMGq4lbwJma35X9rOLLup6mdM
        mGfdZk8GTf+eq6kadtg8LQn5HxctbTE=
X-Google-Smtp-Source: AHgI3IZkJV8nEo5TexCnm14cakVFbBVG7ufWOsd6yFAm6TXQ4BoCC7Fk7KtvnsDy6HvKXCWjZHPoRA==
X-Received: by 2002:a17:906:f87:: with SMTP id q7mr15066081ejj.158.1550460705910;
        Sun, 17 Feb 2019 19:31:45 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id h44sm1589880edh.34.2019.02.17.19.31.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 19:31:45 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id f14so16770468wrg.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 19:31:45 -0800 (PST)
X-Received: by 2002:adf:efc2:: with SMTP id i2mr14684795wrp.44.1550460704807;
 Sun, 17 Feb 2019 19:31:44 -0800 (PST)
MIME-Version: 1.0
References: <641301f26ac895e39b15d62a2ba069b853ab5b09.1550178066.git.rask@formelder.dk>
In-Reply-To: <641301f26ac895e39b15d62a2ba069b853ab5b09.1550178066.git.rask@formelder.dk>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 18 Feb 2019 11:31:35 +0800
X-Gmail-Original-Message-ID: <CAGb2v64u-3bei1X_P+bandmnPqvMrShEq_mniEzm4DdEn29CQw@mail.gmail.com>
Message-ID: <CAGb2v64u-3bei1X_P+bandmnPqvMrShEq_mniEzm4DdEn29CQw@mail.gmail.com>
Subject: Re: [PATCH] regulator: axp20x: Fix AXP806 dcdcb copy/paste bug
To:     Rask Ingemann Lambertsen <rask@formelder.dk>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Olliver Schinagl <oliver@schinagl.nl>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 5:24 AM Rask Ingemann Lambertsen
<rask@formelder.dk> wrote:
>
> An obvious copy/paste bug was introduced with the conversion to sybolic
> register masks. The result is contradictory output like this:
>
> vcc-dram: Bringing 1100000uV into 1450000-1450000uV
> vcc-dram: 1450 <--> 1550 mV at 1050 mV
>
> This patch fixes it:
>
> vcc-dram: 1450 <--> 1550 mV at 1500 mV
>
> Fixes: db4a555f7c4c ("regulator: axp20x: use defines for masks")
> Signed-off-by: Rask Ingemann Lambertsen <rask@formelder.dk>

Acked-by: Chen-Yu Tsai <wens@csie.org>
