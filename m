Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6D7C67876
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 09:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E2220895
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 09:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQ5Yg9HJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28E2220895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeJGQ5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 12:57:40 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:45770 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbeJGQ5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 12:57:40 -0400
Received: by mail-wr1-f46.google.com with SMTP id q5-v6so17616740wrw.12;
        Sun, 07 Oct 2018 02:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Km3shdmMfTCI64wZ03MRdpiPgg+D4OMTEmkORIjYWg=;
        b=GQ5Yg9HJNXVZBzJXAsTkxapB2oKPcKNBVVh0yXeAqMIew/x2U0jNg/nOk+hJI50HFo
         imxu8BNCtTQV6BqOS6peryVQ8HXppFU9ORRz3dE5VLQilNe78oGUHzl/UQyYXL1vGog9
         cESTsbkW5vIbSOcQyHbTjhsBj01MSFH4bkODsvtfg6jIjyE86nqYJtIur4ZV0pXLW++P
         wjuSY4TvCA6W4o0w5CHQ4bQURbaIzQVbkxFLXYdzPrr+pR/rSXTnzAzwb163iXDV9GBG
         yPFh8KocLIQNhgdek9X3XuUosBbdcDr0qr/y4LQDiUkrRl5By3FHdw2NavPYo9eThmpC
         2ihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Km3shdmMfTCI64wZ03MRdpiPgg+D4OMTEmkORIjYWg=;
        b=ZjWB9HDQ4EUD7vkGFaJlLeBkt8KEVAw8tpvTrlb4Bv32URXDe+Qi82Bo5wluE9Od7/
         +YEdX1Pbt0kpdiM8ElgbD+i7/PMz9yO+OLvigD/TPuVBCOr3R7ZJsbU+92rO/1IdwFIo
         1ewk0vmfpyNelOrs6t7OzDfrm4gylZRdcULWy88kAqsrFAO6POUBjQhkfoyw3QYYtFGW
         dKXvbLEwcDOa1FdRzCB8FqedLQepHvWcTw9bPZY2Ty/2jD7sOjQ7iJY556B3VdtlLSpf
         obIYT4PcJu96hgpnQDq81uMnKJxFlE5/i9ivo9k3l9Yze6SWWPCDHJI/qAwsEPgrEanS
         uCgA==
X-Gm-Message-State: ABuFfojOV1mD1jTjXCzekMEehb7mhD162B27iPExdXGin1VnPVBqo2Jl
        kLHIVsV3fTOkLFLLRyKZtuU=
X-Google-Smtp-Source: ACcGV60ugt6F0O043Gvkwuo3YlCB5wW7m4CmBQXslDOPAfvdA0giYPTGVH0rJyi/QzHR0cQmjidCRw==
X-Received: by 2002:adf:ef0a:: with SMTP id e10-v6mr13353084wro.292.1538905854578;
        Sun, 07 Oct 2018 02:50:54 -0700 (PDT)
Received: from jernej-laptop.localnet (cpe1-8-82.cable.triera.net. [213.161.8.82])
        by smtp.gmail.com with ESMTPSA id z12-v6sm1220453wrv.46.2018.10.07.02.50.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Oct 2018 02:50:53 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-sunxi@googlegroups.com
Cc:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
        sboyd@kernel.org, airlied@linux.ie, architt@codeaurora.org,
        a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [linux-sunxi] [PATCH v2 00/29] Allwinner H6 DE3 and HDMI support
Date:   Sun, 07 Oct 2018 11:50:52 +0200
Message-ID: <3147828.SFUzx6Pm4T@jernej-laptop>
In-Reply-To: <20181007093905.11253-1-jernej.skrabec@siol.net>
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne nedelja, 07. oktober 2018 ob 11:38:36 CEST je Jernej Skrabec napisal(a):
> This series adds support for Display Engine 3.0 and HDMI 2.0a, which
> can be found on H6 SoC.
> 
> Display Engine 3.0 in comparison to 2.0 mostly adds features needed for
> displaying and processing 10-bit and AFBC formats, which are not yet
> supported by this series.
> 
> This series is based on linux-next at next-20180828, which has working
> R40 display pipeline support. I'll rebase series on later linux-next, if
> needed, once R40 display pipeline support is reintroduced.

Sorry, I forgot to update above text. It is based on next-20181004 and R40 
HDMI support is already fixed.

Best regards,
Jernej


