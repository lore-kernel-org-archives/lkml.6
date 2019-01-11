Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85A3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8953720872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547223468;
	bh=shnWaSbW1CEUeRleSMf8Sdk+2TAMvetVAW5Arkf8zuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WuSAtnd55XqSc5BwL0q5esXvigd8v7jQokQx8mI9zbjnaslPe2wv61oL0GZiqIscB
	 AhGQoNb0fn/lxGqmQK1Yt/7JSzhDSEJJ3jFZLlxzOk6AU1HscxTdVMjgWBzRy6hXaW
	 JaYawbo5GMtyNFP3CQeNg3AfyHHPbug6+erlpT8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387962AbfAKQRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 11:17:47 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38701 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbfAKQRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 11:17:46 -0500
Received: by mail-ot1-f67.google.com with SMTP id e12so13578061otl.5;
        Fri, 11 Jan 2019 08:17:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wCKPBy722ujKvqJFhsugGIogAhzc4r1bIm2Qf33SkH0=;
        b=K7MMNPChj5xo5hLXMwl1NK6RsaVzd6CNKcu/YANqo6w/U1BRR2feBtLH4oJ4mpmR5i
         bGRRgI8VK3sudZCI7oq4vYlW/r14mdaELheoKpQp76zzmM1OUKc7CP3VN2tJY3uehQQR
         IX10PT+fATedAB0R9UeRXbjEp0hemXl+9Gf/5gDCiILQO1NndIqdSyT4kDNgikCwoL62
         ja6/CQ9qDiKiEjXzLQrQWvLHuFEEAhPS8wzZTPy/rD9iO/ZsXtRpCvHe4Kiw4pGbPv3J
         0glMAFfSy3ophE2FfIiBOKyJVsntteIZwCSckliJ97/gS24NO4UDWoftFkqdu3Sp6pi9
         OPFA==
X-Gm-Message-State: AJcUukcSjiMNN+Mr39iP+XoUCpK4uCMtPN/hxeZhlLOcyGYOzw9jUDW2
        FKNvLm3bKBBoJphgYDCNzg==
X-Google-Smtp-Source: ALg8bN6FoOzDoW96EomQuWN8uqsNKUCzwL0uKLMdEc2uQsXG5jqb03VDiA+JyvpEnmRfLr7DHXT9Dg==
X-Received: by 2002:a9d:5e8c:: with SMTP id f12mr10658507otl.343.1547223465929;
        Fri, 11 Jan 2019 08:17:45 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v141sm40187890oia.25.2019.01.11.08.17.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 08:17:45 -0800 (PST)
Date:   Fri, 11 Jan 2019 10:17:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Cc:     "J, KEERTHY" <j-keerthy@ti.com>, Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: regulator: extend tps65218 bindings
Message-ID: <20190111161744.GA18795@bogus>
References: <1545120356-7749-1-git-send-email-Christian.Hohnstaedt@wago.com>
 <1546523226-358-2-git-send-email-Christian.Hohnstaedt@wago.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546523226-358-2-git-send-email-Christian.Hohnstaedt@wago.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2019 14:47:05 +0100, Christian Hohnstaedt wrote:
> Add input voltage configuration options
> 
> Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
> ---
>  .../devicetree/bindings/regulator/tps65218.txt     | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
