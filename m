Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B45C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F92821473
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545087110;
	bh=T4ljsTOvbwEWEyCv1cuujhPrMtt1n9Xiu9vy0Ts4I1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KcdwbO5+Fcpvp9N8RWaxeKfCXECUad+2s3F32RMlfIgFTWzy9PUELinZGC2tfe2vX
	 RVcrqMgH15d2SbiLGK1W6XaEtkJounz346DrBCXxUOyX/Fg3ZrL62QwjxOK4Bg1E3M
	 LacduFVsts/neRUBs/kzW/WowCIWeFbeRs/HEwMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732325AbeLQWvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 17:51:49 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43102 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbeLQWvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 17:51:48 -0500
Received: by mail-ot1-f68.google.com with SMTP id a11so13798011otr.10;
        Mon, 17 Dec 2018 14:51:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ztfJrKBFiuuBhdghvmEiQyMDcD+CmMVAz6025JRdPEQ=;
        b=e9LA4LcLlU5vNNAPdr1DjdW3rY7BR83pn9S/nVW9eqZ5sAWVTes9dpMyISU3i2Rx7M
         bGN/vp2GCtscaBNtRpNfTQ0CGijjZxFImzfXYLI2TRCSEoaLF/UefTJqL3NIydnagmX/
         P1Zh0evCnxXRtKsusbiyk84WfSVpu/pRoyjHYEPsY7u9er4WbDox1i3cE718eDkiv+SF
         FRvQjAd9EPZD1ZYJB698k+Qe9bHAIK3dySEUI+RI05xEg3pauxEFyqNZ48dpKBIF8Fec
         ubmnfttCZyZbl53qosWENCSMQGMLeXPYnmngZIDAEjRBxXU6YmqI1n++xKqT7fOBs1yd
         0Kxw==
X-Gm-Message-State: AA+aEWawL5TGTw7kh1jV3J2efmnazT7mhm8u16UqhYX6dGsvx1Fl+phC
        w12Wb6llG4DyDKS6SRqQ/g==
X-Google-Smtp-Source: AFSGD/VbX28FfNmzAXVheP4CBNfefQh49QY4iydQkGI+5bkLHcH4pcxKwjvuWpobcu27Y8S7Hs9N5w==
X-Received: by 2002:a05:6830:110f:: with SMTP id w15mr10468672otq.222.1545087108013;
        Mon, 17 Dec 2018 14:51:48 -0800 (PST)
Received: from localhost (cpe-70-114-214-127.austin.res.rr.com. [70.114.214.127])
        by smtp.gmail.com with ESMTPSA id q203sm9473549oif.33.2018.12.17.14.51.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 14:51:47 -0800 (PST)
Date:   Mon, 17 Dec 2018 16:51:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        p.zabel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>,
        cphealy@gmail.com, l.stach@pengutronix.de,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, devicetree@vger.kernel.org,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/3] dt-bindings: reset: imx7: Document usage on
 i.MX8MQ SoCs
Message-ID: <20181217225147.GA6109@bogus>
References: <20181217023827.7947-1-andrew.smirnov@gmail.com>
 <20181217023827.7947-3-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217023827.7947-3-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Dec 2018 18:38:26 -0800, Andrey Smirnov wrote:
> The driver now supports i.MX8MQ, so update bindings accordingly.
> 
> Cc: p.zabel@pengutronix.de
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: cphealy@gmail.com
> Cc: l.stach@pengutronix.de
> Cc: Leonard Crestez <leonard.crestez@nxp.com>
> Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-imx@nxp.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  .../bindings/reset/fsl,imx7-src.txt           |  7 +-
>  include/dt-bindings/reset/imx8mq-reset.h      | 64 +++++++++++++++++++
>  2 files changed, 69 insertions(+), 2 deletions(-)
>  create mode 100644 include/dt-bindings/reset/imx8mq-reset.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
