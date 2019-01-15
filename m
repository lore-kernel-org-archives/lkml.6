Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E722C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB4420859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GrNY1wW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388127AbfAOS30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 13:29:26 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43796 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731364AbfAOS3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 13:29:25 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so1692401pfk.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 10:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G/Ec+hGn6ZTj0JOw7FFYrxIIALGWIUus+Esdsha2ycY=;
        b=GrNY1wW2EbXyzjSWbxIWs35WmS1Jr8MEiw05kmmD2wM1E2pbUBWg0HBv0te3H+224b
         a+/nGtpNmIMs3wEeJU4MDw5Dw5YmR5in0a44yIKo5aJTqwZESAYmT0xinYYbLIHyu6Es
         wveQY6LgSkDotzAZUaiVTRMGFmglNRbsDf9qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G/Ec+hGn6ZTj0JOw7FFYrxIIALGWIUus+Esdsha2ycY=;
        b=UtrPLVCanVtE/VUjuEawfXNn3zC70Q2EMXUq7Kkr83siT/f1BJO2Pyl1mW3QG0TQzh
         W83gcHxrOAI27QTYIWfwHvK/+dmqA0B/+AiG1qqpsnoLquOJle0HycMn2F7TV4YCimQ8
         khxT/ShHHLyxWGU9cBXSPbe3eA4VEumTzj3FMmuMzhpLbB7PnbW+s9ddn9dBcziNwRQh
         tBKZwue1V2V70s+dRXwIAfeQIv6Ue0ZPh4cy9ZANyr78k9FpqsrvA4+gxU5WxXSOy/9f
         ZnJx1mPcR3cz55skdAJ1iTtvLjmblb5IvhvUP1DhYezDZ+gC1qOdqjHGYGfiGkCT6ryH
         rLRQ==
X-Gm-Message-State: AJcUukeKm7DPQNV3xrmmpQ3IiBuOG4o0wrI1R2SC7wdJ1cK/uU6CmhDp
        AmBbPBcb3FoZBEj40FCoLU/hOQ==
X-Google-Smtp-Source: ALg8bN6HwbbBBemBF4XdaZYHuRH86z9dnRTCgqIi9kD//uqu6plzv1BXWOonJObt8TK7zzDp3dDpMQ==
X-Received: by 2002:a63:8149:: with SMTP id t70mr5080673pgd.172.1547576964566;
        Tue, 15 Jan 2019 10:29:24 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g6sm4009570pgq.18.2019.01.15.10.29.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 10:29:23 -0800 (PST)
Date:   Tue, 15 Jan 2019 10:28:41 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     kishon@ti.com, andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        balbi@kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 4/6] phy: qcom-qmp: Add QMP V3 USB3 PHY support for
 msm8998
Message-ID: <20190115182840.GF28907@builder>
References: <1547483819-5445-1-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547483819-5445-1-git-send-email-jhugo@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14 Jan 08:36 PST 2019, Jeffrey Hugo wrote:

> MSM8998 contains a single QMP v3 USB3 phy similar to the existing sdm845
> support.
> 
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
