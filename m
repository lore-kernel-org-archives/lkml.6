Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E4DC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 22:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69AEA2174A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 22:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69AEA2174A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbeHUBue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 21:50:34 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46229 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbeHUBue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 21:50:34 -0400
Received: by mail-oi0-f67.google.com with SMTP id y207-v6so28693013oie.13;
        Mon, 20 Aug 2018 15:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rK529Mwfnn9Qhxw4Xde5bB9WfLxlb5M4X9RZAmpIVqQ=;
        b=D0a49w2tTqvuBusGMKLXLBmklXdoRJh2VxiO+9P7Fqxi53UM08cG8LsG5Lc2HAAl8R
         BspeKFhIzzTUYX/MRqO1SH1YZxRQKnh+H3AqK8PNiKrE1zkltm36xvXQOBbogb4q0TnC
         HIduXGtzUx24bybfV5IOkuadnbJ+Z6SbI9foJCAbfJZNpMtKvgsh37D93G5VEopqcyqV
         v1E1BanhfKdvxauFE4Nsj4fYYgeS8QnVQDXoad6p5txjprOaQoSHPi512QG76Op9WKuN
         nPOzqxZe80gfPmZAlMWsn6ps8sSgJHeoUs+vH0U1PD8QcuPdSB301N+bIehijSxTE/OX
         9K+g==
X-Gm-Message-State: AOUpUlGynGKFxplkNWs8HwUfhie8NrQGiTHCsoZEoneN2tuBLRXp3NiF
        raDSQaAc1luqewrGmREgFQ==
X-Google-Smtp-Source: AA+uWPz2WR/bOaRGZm5CA0krIH1dD5ozVxP57KtfW26OPuCe5uiLzVlR0xbfm+I2z4NJsQTnIDmwpA==
X-Received: by 2002:aca:d452:: with SMTP id l79-v6mr14717515oig.222.1534804386799;
        Mon, 20 Aug 2018 15:33:06 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m11-v6sm17454542oif.27.2018.08.20.15.33.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 15:33:06 -0700 (PDT)
Date:   Mon, 20 Aug 2018 17:33:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: thermal: rcar-gen3-thermal: Add
 r8a774a1 support
Message-ID: <20180820223305.GA32108@bogus>
References: <1534517584-14434-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1534517584-14434-3-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534517584-14434-3-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2018 15:53:04 +0100, Fabrizio Castro wrote:
> Document RZ/G2M (R8A774A1) SoC bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
> This patch applies on top of next-20180817
> 
>  Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
