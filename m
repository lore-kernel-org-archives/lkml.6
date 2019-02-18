Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8418C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7118217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550520267;
	bh=Ls8IJ5A3jWQOMuvVB0T4WyT3c5yHrSHSix/O40f6zFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KD8y19gtej8VV+KDralrY5ezO1JVbM5WPBSKxDZ/I1k9PkUN0gFgpEVf4dr5pJpAi
	 BnNqHcQCI7woovfSF2kkOQbtUMaSlFQQ3NkR+3grR9PQfkEdyD3GGKlsVs8y6p0Fkz
	 jhO7nNOpmvUqqz3vYcmU9FYrotHtv2RPUTgk+/fc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfBRUE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 15:04:26 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38540 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfBRUEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 15:04:25 -0500
Received: by mail-ot1-f67.google.com with SMTP id m1so30367968otf.5;
        Mon, 18 Feb 2019 12:04:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6mQejXwrgFZ3BedX4HMo1jkw2T0ZfRCg3meLh2nX308=;
        b=M1dAFhwu4oPK0bNUdNVezU7mGESOs5caxl690+wnW6xHu7Qrw5LHqPjb8R1FLICm51
         ZgdiBpGHQE2XVG+UOXUzIOHmAR68TAvgLdiyYBoFVzf2glAvgZTK/ZCFae+M3mKyQ+wy
         H6Ku8iKlfzDb9qq1wSCj3ZuuAptMHtCgsmRIDp+LUXT4kSH+SR8jGXWgadhi+VcYAFst
         qeGuCPPCz/lY6LJHNCXfN2l3kP3wHDsCb6dgxQXFR02v5RbRipYg3LD7v2+vQ11ZFSy8
         3ukvetOdrvBNCgVWM9+ouLz2he4/y5ZVRLjjuiv8JqNINvvX+ZO03hF4VH07SBn4Qtdp
         Gehg==
X-Gm-Message-State: AHQUAuYzco7vPsiibfLv4fBaZFruh6xIRGpJpwb5CyHdjKHQpd4K1Nkt
        XivqbXrIFoLwZR78AKrc7A==
X-Google-Smtp-Source: AHgI3IaixQlhzZD9Jv9/uFagyhE8+21Lx/r1Lt2VfpKsAe2PJ5JhV21JlGTxNfJD27IgiVREBNJsRg==
X-Received: by 2002:aca:cc0f:: with SMTP id c15mr363896oig.105.1550520264694;
        Mon, 18 Feb 2019 12:04:24 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e13sm3014589otq.61.2019.02.18.12.04.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 12:04:24 -0800 (PST)
Date:   Mon, 18 Feb 2019 14:04:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V2 1/4] dt-bindings: fsl: scu: add general interrupt
 support
Message-ID: <20190218200423.GA2582@bogus>
References: <1550115535-14488-1-git-send-email-Anson.Huang@nxp.com>
 <1550115535-14488-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550115535-14488-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2019 03:44:25 +0000, Anson Huang wrote:
> Add scu general interrupt function support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
> 	no change, just update the patch based on latest next branch.
> ---
>  .../devicetree/bindings/arm/freescale/fsl,scu.txt      | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
