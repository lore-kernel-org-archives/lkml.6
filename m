Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C2BC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 22:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3492174E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 22:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D3492174E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbeHUBuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 21:50:20 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35588 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbeHUBuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 21:50:19 -0400
Received: by mail-oi0-f68.google.com with SMTP id m11-v6so28773569oic.2;
        Mon, 20 Aug 2018 15:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S6w85FlIlFwmx2Rmw5tyUQk4qtAQUbIfl6YJWkqwrfA=;
        b=DhPpAfT0DnKi67sgO3NKVMDJ4zC43Bm4+tA35PdcAHeLwqOZW1rgMTc6dEX/8AIhEp
         fFCuJZyveGMvhSi8o+a0lL4jX9d4J0MKKZQGGZwS0q6aYs5jUnyxTxCN+bXYZiLFZXcS
         4CZntWjYcN1ZKiHYQ5dZGWgBee8BTVM5I3UMPBf7pTsisMvWsMKQv9Pl1yxm4QNE+0H0
         K3JtwNoKR1X4n2LIp7se5ysX8mHxFhUJjaTO+IAsx5+gcazQJz0X28jcRqfuqqsBDj5i
         dXTJWEHGdKNT9bu/48a11tABJBrqE/7kwRrNNBYGWz700EpZz5Y/hyJCj9RGz+npEHo8
         sKgw==
X-Gm-Message-State: APzg51DiVQY8RpfYt1DR0W0qFD8Z1jhK+qvwbIVadPh2KHk7Zl8PRP7V
        9CNYiWAKvdItx8rcmMqEUw==
X-Google-Smtp-Source: ANB0Vda6o/+qplHpO6ZdrmSjNd/8jpkNL/Xf/q6cc1jrMtd6EZNLaF6Mb8rv6Uew7yqep/jIak1Q2g==
X-Received: by 2002:aca:4f06:: with SMTP id d6-v6mr425547oib.224.1534804372173;
        Mon, 20 Aug 2018 15:32:52 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n84-v6sm7428081oif.23.2018.08.20.15.32.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 15:32:51 -0700 (PDT)
Date:   Mon, 20 Aug 2018 17:32:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: can: rcar_can: Add r8a774a1 support
Message-ID: <20180820223250.GA31663@bogus>
References: <1534516703-11448-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534516703-11448-1-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2018 15:38:23 +0100, Fabrizio Castro wrote:
> Document RZ/G2M (r8a774a1) SoC bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
> This patch applies on top of next-20180817
> 
>  Documentation/devicetree/bindings/net/can/rcar_can.txt | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
