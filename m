Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB442C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC4D20892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC4D20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732206AbeGaAwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 20:52:25 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:35902 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732109AbeGaAwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 20:52:24 -0400
Received: by mail-io0-f196.google.com with SMTP id r15-v6so11353069ioa.3;
        Mon, 30 Jul 2018 16:15:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sVMaZjr8TIu0DCd8ZzNpncy39a6B4cVCgwDNFo6KgwE=;
        b=sId3vmpMIZDrRE4nY1sDvCnSWCL5+Blq0DPvS/BRtCIrt4DytX8U4RX6nf/6hez96B
         QLf/YP3xWSKRhFk31iZSvpU6jHAPUwOw2d4bnF971/xo8/lXZdFL40cKlIWnoMf6b9TS
         BMeAvDLiE/rCGA+g+hqL+42w0jYMrfB0A8epEp6l3YZr+hife57/0lDQPc6QDrIU1k1Z
         d3uv4jiGWBE2tWXxW8RCUyCejbsI+tgiJU0BE1VlUpnB3GsymAvz83nUp5Ro2/lVCKAI
         s3/VE+o/Hd46Pw0Wts1YzvxCYv58zPyHke1HoiaFDFbArtJZqh0u44I3ChGK1LqIjo+I
         uAcA==
X-Gm-Message-State: AOUpUlGDXzNpFm6k2PLZxNrjrKnQsh7IrIJJ7UvPNLoMZhzAfb+MIXmq
        /R5KCxRpKxH6I1C4BUHWIA==
X-Google-Smtp-Source: AAOMgpe9b5sy7npRFWjWQRcmmaoPbYNtydyZr7geqGPzFLqVE4Ez2ySLPCVanX3TwbIdh/8p87fQog==
X-Received: by 2002:a6b:828d:: with SMTP id m13-v6mr16498828ioi.161.1532992507750;
        Mon, 30 Jul 2018 16:15:07 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id w8-v6sm669177itb.0.2018.07.30.16.15.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 16:15:07 -0700 (PDT)
Date:   Mon, 30 Jul 2018 17:15:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Emmanuel Vadot <manu@freebsd.org>
Cc:     srinivas.kandagatla@linaro.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, catalin.marinas@arm.com,
        will.deacon@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] nvmem: sunxi-sid: add support for H5's SID
 controller
Message-ID: <20180730231506.GA8608@rob-hp-laptop>
References: <20180727115205.20955-1-manu@freebsd.org>
 <20180727115205.20955-3-manu@freebsd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727115205.20955-3-manu@freebsd.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 01:52:04PM +0200, Emmanuel Vadot wrote:
> The H5 SoC have a SID controller that looks like the one in A64, the
> cells are in the same offset but doesn't contain the same data (thermal
> sensor calibration for example).
> Add a binding for it.
> 
> Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
> ---
>  Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
