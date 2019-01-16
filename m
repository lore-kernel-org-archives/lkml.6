Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06109C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C797C20675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EbdCLzRM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404479AbfAPONl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:13:41 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34166 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404414AbfAPONk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 09:13:40 -0500
Received: by mail-wm1-f68.google.com with SMTP id y185so1152891wmd.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 06:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YJTy0VKIOsglahI3zd0Hx3bNo5OPbZtFS02kFMS3EAE=;
        b=EbdCLzRMfQA6MMr7z9vuHXwjl9Bo9dK4IALI90sccMASgAnPdyo5XXOHSnj+573Xao
         HVMNM4+vZk6xzMh+Utp48sZSYHHME3HnRRqEO8SATcvMJkPMMZlb71RyX8u62aNaTVq/
         tcVdbnFSyPkNeo8xCxpDKv/pFMo3Yzv72IiP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YJTy0VKIOsglahI3zd0Hx3bNo5OPbZtFS02kFMS3EAE=;
        b=otay5FYNFh/SHCdCT3XznSBYpt9kgYzH6B8Ry3TqBJf4kh4kq4hhG7r9nzkjiLb30D
         Z0H2/NFtJ+7gcPDnZodc/nEiEYgwtBa8MDoGOV6+DwGYdsAfckIEA2PTJEqdbXoPaoG7
         O85KvvYaZ1jaOczksBpMCEZzpoiMhLp6ovqh4vJTYEuQA6joV5u/mVRvODS6Fl6L++WS
         qOq1khGRfbQfqOVLAR1f43riYpKqF/nnR1xw5geyltXSnZN96s6vz9UaUhqBFy8DUYoO
         clrRQMoeQ7ZvprynFBVnR1IBqlc0z9Er5Esfx4tuXiloXwTAiIrohgYaesNqg30sd5Rj
         8U4g==
X-Gm-Message-State: AJcUukdZXtLLet9n7DrjWinWhek6bmQczxt+p5vuZMbma/ON5IeqVDWv
        wKD3I9t6eq4mJ2dcKB/bAHfw74z3a80=
X-Google-Smtp-Source: ALg8bN6uksis/2WyM5RZ60DY43jumuz6Y8gM1BMXUreaHb2ZKn11flBo0Yo7EkNlekoR+yE7rlTIlA==
X-Received: by 2002:a7b:c852:: with SMTP id c18mr7393071wml.49.1547648018661;
        Wed, 16 Jan 2019 06:13:38 -0800 (PST)
Received: from dell ([2.27.35.149])
        by smtp.gmail.com with ESMTPSA id p10sm23305592wrt.25.2019.01.16.06.13.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 06:13:38 -0800 (PST)
Date:   Wed, 16 Jan 2019 14:13:36 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Cc:     Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mfd: tps65218.c: Add input voltage options
Message-ID: <20190116141336.GG23399@dell>
References: <1546523226-358-1-git-send-email-Christian.Hohnstaedt@wago.com>
 <1547453794-18770-3-git-send-email-Christian.Hohnstaedt@wago.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1547453794-18770-3-git-send-email-Christian.Hohnstaedt@wago.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2019, Christian Hohnstaedt wrote:

> These options apply to all regulators in this chip.
> 
> ti,strict-supply-voltage-supervision:
>   Set STRICT flag in CONFIG1
> ti,under-voltage-limit-microvolt:
>   Select 2.75, 2.95, 3.25 or 3.35 V UVLO in CONFIG1
> ti,under-voltage-hyst-microvolt:
>   Select 200mV or 400mV UVLOHYS in CONFIG2
> 
> Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
> Tested-by: Keerthy <j-keerthy@ti.com>
> Reviewed-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/mfd/tps65218.c       | 89 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/tps65218.h |  4 ++
>  2 files changed, 93 insertions(+)

This looks like regulator code.

Why aren't you placing it into the regulator driver?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
