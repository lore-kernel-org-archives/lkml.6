Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE010C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBABF21534
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBABF21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbeHOXGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:06:41 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:50397 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbeHOXGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:06:41 -0400
Received: by mail-it0-f65.google.com with SMTP id j81-v6so3361816ite.0;
        Wed, 15 Aug 2018 13:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8WCW52dvnJW3AFXUQIVTl5jxB/Kdc2XUr8LsgzqIp/A=;
        b=fBn0iDVaJE79JZRcsF/NlSwtYK0Q078a336py5z2arAiFfc0GVboQzK639ZPgbheFP
         9/UQH2ENam9ejR82AIopJY310lIA2XR2Mj7GV7QKdbFpJGazV53IxVx57Wyn5mmEiCf3
         l4sqkrMH911fyHwDcOKWFp/G8oY1LgAXy5DmkvIi7tWObjgJj/hu8da05197waSgL+tD
         F167TawF8OYXpVfRYA1EUVM9/pKhkVRZYqOdruwQHSlYblSiF45OuVPffjypNZzewqTW
         eSSHMWsQmPuRtS6TVPdMgvFUZuXe3HWFUygAo0FvluQfcECGzu45D4dA0r3wrhoY0Nu7
         YuPQ==
X-Gm-Message-State: AOUpUlERP3sctLw8Fb2/Yb/0xOQTY9BIlEB8+gUibi1dZTYLIymo20g7
        rv0csqAQH19KWco40GRh9g==
X-Google-Smtp-Source: AA+uWPwTXnjc6sYINnk0b1uCmx1AJdmWkhSMMA1IEb9ugTK5QwhZA+g9pzFJU2Nw9sshgfY69OpMig==
X-Received: by 2002:a24:75d0:: with SMTP id y199-v6mr19238273itc.4.1534363982688;
        Wed, 15 Aug 2018 13:13:02 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id z195-v6sm21284427ioe.38.2018.08.15.13.13.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 13:13:02 -0700 (PDT)
Date:   Wed, 15 Aug 2018 14:13:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: gpio: rcar: Add r8a774a1 (RZ/G2M) support
Message-ID: <20180815201301.GA27866@rob-hp-laptop>
References: <1534249957-15543-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534249957-15543-1-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2018 13:32:37 +0100, Fabrizio Castro wrote:
> Document Renesas' RZ/G2M (R8A774A1) GPIO blocks compatibility within the
> relevant dt-bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
