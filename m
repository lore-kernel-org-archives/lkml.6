Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3B0C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 759012082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 759012082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeJZFwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 01:52:41 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43851 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeJZFwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 01:52:41 -0400
Received: by mail-ot1-f66.google.com with SMTP id k9so10557842otl.10;
        Thu, 25 Oct 2018 14:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cKbjaxIBVid7Y4wgLkIRBifTXAenvvwZZk1547pBafQ=;
        b=WaLLiN2sP5dXgvjTEhxURkLfbGRY14api8sCuqun29OvaAJfhweTf15KkyWzctHDFR
         3nmohG9nQBhvZZAoMgt5Cd0bNSe/9QuzNGAPC0I5Z+Xcre9u0Ab/5WcDw8jwb3ro1dM/
         pi9E3PtL3z0FhhUGRhXspyyiQQMYWPS6SBn37zX/tuIfTOGhCh2u1p5QlBDV5lQON2v3
         oIIXv/YzNmCmwN2zImvsFVaVjkll5Hz+P5uO2LIYZaW8FIMmqN3mazo2CgE9ZfkcK71J
         ytcxsiEXtt6iumxgKzNnioEyQd5opHqZRvj/iM77KsiqCvpav2ePCNUDJNOkmX3i9/Nj
         xURQ==
X-Gm-Message-State: AGRZ1gK4j7ihzFFteiwt2vxVPxodZfpKko/cu8cORwOzAVPnGWZaKmxO
        +JYNpYbfpBzuo9OrkMO9Aw==
X-Google-Smtp-Source: AJdET5cX/i/EZ31Bg3RJ7VwOf09v5YkmNYA2Mu+cgSq8CiCHoaCTU2ESfOKIri3QnlHdYPbEmNp/wA==
X-Received: by 2002:a9d:5a83:: with SMTP id w3mr523681oth.87.1540502301705;
        Thu, 25 Oct 2018 14:18:21 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b124-v6sm3448462oii.14.2018.10.25.14.18.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 14:18:20 -0700 (PDT)
Date:   Thu, 25 Oct 2018 16:18:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?S=E9bastien?= Szymanski 
        <sebastien.szymanski@armadeus.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 1/2] drm/panel: Add support for Armadeus ST0700
 Adapt
Message-ID: <20181025211820.GA1173@bogus>
References: <20181024125457.25204-1-sebastien.szymanski@armadeus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181024125457.25204-1-sebastien.szymanski@armadeus.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Oct 2018 14:54:56 +0200, =?UTF-8?q?S=C3=A9bastien=20Szymanski?= wrote:
> This patch adds support for the Armadeus ST0700 Adapt. It comes with a
> Santek ST0700I5Y-RBSLW 7.0" WVGA (800x480) TFT and an adapter board so
> that it can be connected on the TFT header of Armadeus Dev boards.
> 
> Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
> ---
>  .../display/panel/armadeus,st0700-adapt.txt        |  9 +++++++
>  drivers/gpu/drm/panel/panel-simple.c               | 29 ++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/armadeus,st0700-adapt.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
