Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6317EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3736A21903
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389967AbeLURHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 12:07:07 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43327 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732195AbeLURHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 12:07:06 -0500
Received: by mail-ed1-f65.google.com with SMTP id f9so5203924eds.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 09:07:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3hPsT6hn4cJMGwyqOid1QQE02WRghMsDgsiF8hyM1/I=;
        b=olnqJLTAS6d29/IlNdlshfmsyJKMFGHIfGRwI0rNVCBIErD33s1KcAkrjg7K5es6YC
         FAqtblXRaSatP6727YQw5L/liXL08ciF2S9zOIBisEeovRpDs+5YoZB942vcgYBLcDOs
         fIS99jQhFntQJ6lUmRalTqbQdM3dBy7KavWLBzKeMmFVVQB8oGUjcGvDwzPRpPfS3Jau
         jcWLccdHozM6oKO6MW9HyaNrgcFpsAjHJSiPU5uOc7X802VXeUNCTaf+rcDCCyNUVilb
         RJqbE2g7t0WtvDs5QepBdPj+VAB49SgdvFMOcH3UC4GXux7qaLMDrGQyql+xejm/fW6y
         BRyw==
X-Gm-Message-State: AA+aEWYytstl3wL8dn7kLPxeOHNFijW4iSgQ9WWs96y8ezjfDnm/yXJN
        wAuQFdvkKZsFdmLCrbQX3QMH/p3/4+4=
X-Google-Smtp-Source: AFSGD/XVfAZybf+moXJsWcVdMICc171wXfhlcgSWgdjj2XcegPEjqVceji9qah1VyQO9v8QKUNnfZQ==
X-Received: by 2002:a50:f70a:: with SMTP id g10mr2908412edn.25.1545412024310;
        Fri, 21 Dec 2018 09:07:04 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id h47sm7000584eda.8.2018.12.21.09.07.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 09:07:04 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id b11so5963490wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 09:07:03 -0800 (PST)
X-Received: by 2002:a1c:f605:: with SMTP id w5mr3715562wmc.116.1545412023510;
 Fri, 21 Dec 2018 09:07:03 -0800 (PST)
MIME-Version: 1.0
References: <20181221152110.17982-1-codekipper@gmail.com> <20181221152110.17982-3-codekipper@gmail.com>
In-Reply-To: <20181221152110.17982-3-codekipper@gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sat, 22 Dec 2018 01:06:52 +0800
X-Gmail-Original-Message-ID: <CAGb2v67NS8QenKMYSE9DBsCSSbhMDZbsG=agkxxQWUgOtqtMfg@mail.gmail.com>
Message-ID: <CAGb2v67NS8QenKMYSE9DBsCSSbhMDZbsG=agkxxQWUgOtqtMfg@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] ASoC: sun4i-i2s: Add regmap field to sign extend sample
To:     Code Kipper <codekipper@gmail.com>
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "Andrea Venturi (pers)" <be17068@iperbole.bo.it>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 11:21 PM <codekipper@gmail.com> wrote:
>
> From: Marcus Cooper <codekipper@gmail.com>
>
> On the newer SoCs this is set by default to transfer a 0 after
> each sample in each slot. Add the regmap field to configure this
> and set it so that it pads the sample with 0s.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>

The code matches the description, however I lack the in depth
knowledge to understand the difference.

ChenYu
