Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6CCC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 12:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E937218A6
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 12:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbfAZMAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 07:00:50 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43301 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfAZMAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 07:00:50 -0500
Received: by mail-ed1-f66.google.com with SMTP id f9so9353322eds.10
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 04:00:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MkvyQKyPx0n9z17tDMtBMclUX5TkY+xreJjVbAghKVU=;
        b=WPg2+PbzY/nevrQRUJkFXPKSvxrmMOjDT39gzOpgtcOV4APjUr72k7oqgVoBXpYD/X
         o03JWasUZjiwml22KW7maN1MAqugvY69y9y3N4k3QN5yBZfbyOpwHjXzL8NSapKYpSzu
         IPJ18iSSQQHpKm9Fqxsyh8iGlf8aRCNkFh+bCwXQznrbxryyBRqjVAVOMVZcRRPPs2/W
         1PTTdgjib698GEjPxg/O/StsUchsrUiEFfLkXyF5utsAIDVBxB/3BHKxOirVA8nbd6Bp
         TK47eRZokELWFV1pVy8Ebyit68aJ43DJKlrB+TtJriLRRRN5vQTsDufcWMlA+62v+n62
         JEEQ==
X-Gm-Message-State: AJcUukc95HWr5UfpkmFz0+wC3wGStup1q1qV80o6GE7Hh4v+RQfY95ot
        Meahl/GhDqd+5/misHYOajJbH6aP4uA=
X-Google-Smtp-Source: ALg8bN7CWmP2u1tiYtnByNEGxpuux8hxjgEkb4Q4x8AYlZIPYK9iknVtR4GbsQLZ/nvkAHFEEWfS8w==
X-Received: by 2002:a50:9724:: with SMTP id c33mr14334789edb.288.1548504047992;
        Sat, 26 Jan 2019 04:00:47 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id ca21sm976159ejb.3.2019.01.26.04.00.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 04:00:47 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id b11so9181548wmj.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 04:00:47 -0800 (PST)
X-Received: by 2002:a1c:c008:: with SMTP id q8mr9354188wmf.99.1548504047296;
 Sat, 26 Jan 2019 04:00:47 -0800 (PST)
MIME-Version: 1.0
References: <20190126061809.18035-1-anarsoul@gmail.com>
In-Reply-To: <20190126061809.18035-1-anarsoul@gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sat, 26 Jan 2019 20:00:36 +0800
X-Gmail-Original-Message-ID: <CAGb2v66xoFNOfeAM__fr6VU0xU1ER9vinPqayQNQZmxmoF7_-w@mail.gmail.com>
Message-ID: <CAGb2v66xoFNOfeAM__fr6VU0xU1ER9vinPqayQNQZmxmoF7_-w@mail.gmail.com>
Subject: Re: [PATCH] regulator: axp20x: fix ALDO2, DLDO2 and ELDO3 definitions
 for AXP803
To:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Olliver Schinagl <oliver@schinagl.nl>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2019 at 2:18 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> Looks like refactoring didn't go well and left ALDO2, DLDO2 and ELDO3
> definitions broken for AXP803 - now they are using register address
> instead of mask. Fix it by using mask where necessary.
>
> Fixes: db4a555f7c4cf ("regulator: axp20x: use defines for masks")
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
