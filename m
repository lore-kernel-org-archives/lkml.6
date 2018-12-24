Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C475EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 06:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933CF2173B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 06:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lsyv+T/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbeLXGcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 01:32:46 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41347 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbeLXGcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 01:32:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so10689803wrs.8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Dec 2018 22:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pbk76CrSpTv3KWkqBKf0Ygegn10/ORWX8wSrlE2K1cw=;
        b=Lsyv+T/bPAn/oR8rpgZ4w/Rm1zzOHX4Ifym0QmoBnZu9D7nVPVUeqCpCrh2t5yHMf0
         fuPGiXuqFqQ/ZDDx1eYJMNNoNZcUQlJ5Wy4HNP8LZHnFffntMt+KIN7yHav0fwrBFogb
         bDNK+3TnODRI8G4g21MYk7FstibOlqeJyxHU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pbk76CrSpTv3KWkqBKf0Ygegn10/ORWX8wSrlE2K1cw=;
        b=FAE/DtI1w+0tYWIwfL955iV+23NDlZU33PInW4OVBeyK3cIcRJiYJL0isZ+kNs78Qp
         l/uy11wiQzsyAlFMfKWT6idy3HUblOj72etUnaGSWTu6IyqnyU+N4QEsXhDtdDedGAo7
         RVmBBUa16qkSG19I/cpOzNv+aS9pzWHiF73SjVUam9EIMuLWUs4SF1veUFo+LkGabzlA
         bhXTSHejraWCiNl+hen8ZsBTaRH7417ge7VrnlbC6HikyHx+/fFbNOrojkUCY7olHb9n
         D60DPEbNEwg/wi9F1p2NfGVrKcY4i8alVfOK1SZztxYXgFYf/MvgkmxrNglc6VMUhq5Q
         OZIQ==
X-Gm-Message-State: AJcUukfPd3Xwb1gjnNVnUpg0oXsttJ4h2B968RJT4K/LW8JlZ5X4A14W
        FAR46dgPUycaN3+3Rv+9Y7CvHw==
X-Google-Smtp-Source: ALg8bN7ww9dGy4DfNflHRckAgSExvBWwiFzDvoXCNizYb7jwAPWnQrkQ2qcxnXpG8e/dK1G1RviWsg==
X-Received: by 2002:adf:fc51:: with SMTP id e17mr10372945wrs.268.1545633163166;
        Sun, 23 Dec 2018 22:32:43 -0800 (PST)
Received: from dell ([2a00:23c4:49ca:fc00:514b:a89a:f1e2:7949])
        by smtp.gmail.com with ESMTPSA id a6sm15900711wmh.10.2018.12.23.22.32.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Dec 2018 22:32:42 -0800 (PST)
Date:   Mon, 24 Dec 2018 06:32:41 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
        Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH 2/2] mfd: tps65218.c: Add input voltage options
Message-ID: <20181224063241.GB4846@dell>
References: <1545120356-7749-1-git-send-email-Christian.Hohnstaedt@wago.com>
 <1545120356-7749-3-git-send-email-Christian.Hohnstaedt@wago.com>
 <20181221110128.GO13248@dell>
 <20181223164030.GQ6707@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181223164030.GQ6707@atomide.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Dec 2018, Tony Lindgren wrote:

> * Lee Jones <lee.jones@linaro.org> [181221 11:01]:
> > On Tue, 18 Dec 2018, Christian Hohnstaedt wrote:
> > 
> > > These options apply to all regulators in this chip.
> > > 
> > > strict-supply-voltage:
> > >   Set STRICT flag in CONFIG1
> > > under-voltage-limit:
> > >   Select 2.75, 2.95, 3.25 or 3.35 V UVLO in CONFIG1
> > > under-voltage-hysteresis:
> > >   Select 200mV or 400mV UVLOHYS in CONFIG2
> > > 
> > > Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
> > > ---
> > >  drivers/mfd/tps65218.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 46 insertions(+)
> > 
> > This needs a close review by Tony and any of the other OMAP guys.
> 
> Adding Keerthy to Cc, he's probably the best person to review these
> changes.

But you've dropped the patch, so all he has it a commit log to review?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
