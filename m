Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA5DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F2C218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545338156;
	bh=+TJebNVLOLkngRB0Fz358fGC9BrsOz0eh2CMZUodByk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cn/wot38Yv2kNAoMKFUj0PCLyfMbTONcuhcPvAR2fKzTyrH+gep02r3A/fH4PU1q6
	 GAfYAVb8/vii6+abiHLDjk+3ILD9k8qbOJIK4xW1TQ4g21PsSGJ6eUz5hXNr/uIIUQ
	 q+a/fY4nJ2rSjrYXMdI3D7ToKqvelqhwUpQDvwaQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389640AbeLTUfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:35:55 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:54313 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732267AbeLTUfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:35:55 -0500
Received: by mail-it1-f193.google.com with SMTP id i145so3930982ita.4;
        Thu, 20 Dec 2018 12:35:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xY7qRHGgX/X1+QTLc15wcTmWoGPME+maH0J1xrCWkRo=;
        b=F0+ZxksZPQHd/DduAFWf+bmIOUh4+gtYBKKZJJ+16j7mnZUuGG2irSJm8gDKywUeJC
         YhBfd7KhWrn2mGIWVXOfDWTXm5KSQ30xK+PNHnmUrBIL4jLJObalCzYEuWF0/XApw9MY
         gva4sp0Eoq0q3kohKupCI/vQ9SmDnYrkIVbVvkuzWnZlQu/zhmDLq4Bm4SULZPcfSMgh
         JZw3mPOD3nRfScOSEQ9EfoDE3XenwxL2R4FOoNaYq0Iyy29Ub0jekEMEAdArEcrLJc2+
         ocotCrvUzE89XIaLmuqlMyhN9l0V38y7+nm2HG98Pk5Qu2GqrJqjDcpywxNepygrQzLj
         /Mqw==
X-Gm-Message-State: AA+aEWbfmvwAHCzf6Ked0Wwwy32ca4Ay02OjVNf7D/LjdGYoIXyrToXN
        NvxXyBOICr/RfEFN1bICcQ==
X-Google-Smtp-Source: AFSGD/W0Qqnf8weDfA8AU63EFAEsXjTc4Ju3kfcxLR3ihUK+VbTC0MS64nCPq7k5Wn4Ie4oWW3+DmA==
X-Received: by 2002:a02:9281:: with SMTP id b1mr24329112jah.86.1545338153936;
        Thu, 20 Dec 2018 12:35:53 -0800 (PST)
Received: from localhost ([2607:fb90:20d2:a5e2:49af:e73e:5a36:3b50])
        by smtp.gmail.com with ESMTPSA id i135sm5673339iti.34.2018.12.20.12.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 12:35:53 -0800 (PST)
Date:   Thu, 20 Dec 2018 14:35:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: can: rcar_can: Add r8a774c0 support
Message-ID: <20181220203552.GA17852@bogus>
References: <1544732378-6268-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544732378-6268-1-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018 20:19:38 +0000, Fabrizio Castro wrote:
> Document RZ/G2E (r8a774c0) SoC specific bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/net/can/rcar_can.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
