Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C3DC37122
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE81C21721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548117018;
	bh=eaQiUBDfb6E9/VOYkZfCV15xusiVqeKPTawDXxzfKl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AHIHTOa67oFT2t1UAlYKBXfmO5f/vOtNVHh3rZ5BZjByiu7F6Kh+0/8FEcxpBISLZ
	 7o7eviesu+dmtJ/AQje0pjGV47NDo8UdrKgCq0GLsIwwgRomt1+TLYv7JLQBJyjtJU
	 aMuA2xszRZRIeD8ti6+ImTFv+H4kuGztbj8XN+2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfAVAaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 19:30:16 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38628 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfAVAaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 19:30:16 -0500
Received: by mail-ot1-f66.google.com with SMTP id e12so22139660otl.5;
        Mon, 21 Jan 2019 16:30:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XpDQ3gXdzLJtDwqohrw59Qy2bmeppBzply4LsowzBYo=;
        b=Xpty50lHRpxudAQknKYg6g8ZeyXk3xuH56+2C2v7bgH6hRGA7ly4NvBR8QIEYFCC4m
         iNyod5EbH1JOwwmJ1Xk4CWBqXAXU5L0XJjpBYw44TfEhExOCA4g+5IelA1lUZ/hy3pJ2
         GQg8H/y3/XJnpDu1Vx2P6uwHgmbZf6+ExDzIjiXLcty8+j/5dJGyiXTpLMiDkCdiuziw
         dDy2ddUwXIW0RUnLdRRhbdv1XOtLZHNPF2MKO7OVVQ+SzEf58Sdj1CtloAfBttfi8x9V
         eKzKVmFqcic/7/53sxZ4PC3rXGvRb52KhGpCVNirTu0rkkoxGZhDhjs/kr+YIM8o/p4j
         RiaQ==
X-Gm-Message-State: AJcUukd9u7b4NOugIfsfwVszzGcR8pDkMHXRMip2zBVGXpWryxC/6cxo
        XiBp/Z5/XccC63i7CKwNNA==
X-Google-Smtp-Source: ALg8bN4dO/uDXQQAzJ/yiWBBuVgTk1+I1T5uePSipxY4CNYMkXge4HZCM+dusjk1ye6T0Hq8WpXpmw==
X-Received: by 2002:a9d:60b:: with SMTP id 11mr20062213otn.200.1548117015485;
        Mon, 21 Jan 2019 16:30:15 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v20sm6548792otp.10.2019.01.21.16.30.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 16:30:14 -0800 (PST)
Date:   Mon, 21 Jan 2019 18:30:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno <kholk11@gmail.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: smd: Add support for MSM8956/76 RPM clocks
Message-ID: <20190122003014.GA26136@bogus>
References: <2fcdf0e9b1eef55350911984064dd94f16f1fcd8.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fcdf0e9b1eef55350911984064dd94f16f1fcd8.camel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 04:38:58PM +0100, AngeloGioacchino Del Regno wrote:
> From 6aeefad77a2a5d47a9bd009d2d10db2a5dd153a2 Mon Sep 17 00:00:00 2001
> From: "Angelo G. Del Regno" <kholk11@gmail.com>
> Date: Sat, 12 Jan 2019 16:31:09 +0100
> Subject: [PATCH] clk: qcom: smd: Add support for MSM8956/76 RPM clocks
> 
> Add all RPM clocks found on MSM8956/MSM8976 SoCs.
> 
> Signed-off-by: Angelo G. Del Regno <kholk11@gmail.com>
> ---
>  .../devicetree/bindings/clock/qcom,rpmcc.txt  |  1 +

Separate patch preferred, but for a 1 line change:

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/clk/qcom/clk-smd-rpm.c                | 53 +++++++++++++++++++
>  2 files changed, 54 insertions(+)
