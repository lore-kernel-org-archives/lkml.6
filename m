Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DB5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8818F2177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550520938;
	bh=lbNbOxhOfCBLDCOESBwtB3X9vWXwXIbltxnRMcz1gGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MbnQblGabrz5Cy+RXZavvblUE1dqaPn3N4KboCg1x6SewbK+uFnGXeebrQ7xjP1ce
	 ySJNPFG+A0pBvU9BBJv4iFtNxreDe4XrUsP9SsglLUunqrOgiwgj0OLPrQ737AHi1H
	 ViXUB71K0WJYtIj0zMrBZrCnt4Czhejpt81jPRrA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbfBRUPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 15:15:36 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39001 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbfBRUPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 15:15:34 -0500
Received: by mail-ot1-f67.google.com with SMTP id n8so30386643otl.6;
        Mon, 18 Feb 2019 12:15:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kuiPC8lGTlOODnJMwUliO4t+HFFW2OqGJAApYAO+zVI=;
        b=tukzzCm8NxbrNuXAo5mCS+Mp+CamIdOD2S0Ve+00yzhc+0fccrVPe88A3SBNttNuD9
         i7XoUyCtgEGSs7U7BDg8hln22j0lPo3DHDkwTJen5Th1/y0ONRRUtdkW98wh+4BEZENf
         Lhhm4LtkujRqKjnacUuIpM5IcOEVisTNY90xuv6vqDDPoGfJNgYUtr5rROf5FqvaQ8i9
         a3HLieNYWaaXVcONegrb3XZ0vyyrFmPAZfNevBE/RT6HW3mQ3HTnzSHGuBLQavni9oCT
         0UTZCpIonQEU+zG282CZkDaYmFpiUBDhPVa4OuTZVu+Lpy7fpI4mQcDVTFOtTVVQzEv3
         T8cw==
X-Gm-Message-State: AHQUAuYcjksvn1HCQhzT4Sx9EWTX+Jcm6A4JlNQNncKdxY8qU1rNgcW6
        pRR72KrB1uiIXora4DSp+A==
X-Google-Smtp-Source: AHgI3IZQpurcj/GrPpCeEucc575DKRB40gsqFqW/8IksEVcFj4mJvNj7GUeeKH+6yAtuV6UdyU296w==
X-Received: by 2002:a9d:4708:: with SMTP id a8mr10245885otf.51.1550520933526;
        Mon, 18 Feb 2019 12:15:33 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l134sm937258oih.43.2019.02.18.12.15.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 12:15:32 -0800 (PST)
Date:   Mon, 18 Feb 2019 14:15:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, marc.w.gonzalez@free.fr, andy.gross@linaro.org,
        david.brown@linaro.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/4] clk: qcom: Add MSM8998 Multimedia Clock
 Controller (MMCC) driver
Message-ID: <20190218201532.GA19638@bogus>
References: <1550377885-10618-1-git-send-email-jhugo@codeaurora.org>
 <1550377947-11414-1-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550377947-11414-1-git-send-email-jhugo@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2019 at 09:32:27PM -0700, Jeffrey Hugo wrote:
> Add a driver for the multimedia clock controller found on MSM8998
> based devices. This should allow most multimedia device drivers
> to probe and control their clocks.
> 
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
>  drivers/clk/qcom/Kconfig                      |    9 +
>  drivers/clk/qcom/Makefile                     |    1 +
>  drivers/clk/qcom/mmcc-msm8998.c               | 2915 +++++++++++++++++
>  include/dt-bindings/clock/qcom,mmcc-msm8998.h |  210 ++

If you need to respin, this file goes in the binding patch.

>  4 files changed, 3135 insertions(+)
>  create mode 100644 drivers/clk/qcom/mmcc-msm8998.c
>  create mode 100644 include/dt-bindings/clock/qcom,mmcc-msm8998.h
