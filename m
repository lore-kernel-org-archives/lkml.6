Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C6BC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 841E421534
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:19:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 841E421534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbeHOXMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:12:36 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:37353 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbeHOXMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:12:36 -0400
Received: by mail-io0-f194.google.com with SMTP id z19-v6so2036550ioh.4;
        Wed, 15 Aug 2018 13:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BCNJbPQrM+6Pg8LBibXOoKUULC5dhPsu7/6ug9SynPk=;
        b=ZKYN091FAad5Dr1dnpkvce+JOYAs2VEInekKglbAIoSrAOszDVi/PK2isAoMUzPZli
         7Fyy2C1uAjtzqOe1cUt+SUEtX7eAiVJUP0UF9PIr+/7EgHbZk3j+nx0IFpqljzYh/xzw
         3/y033LHIxZxEE9NXhKHRJrpnlFI+F/4u4+lszAGtNZr9SDpxCE4HMG7W3OGe5FbOUw9
         XwybioG1F5+6gju9Zc6uAEm56greU3x5rXIa3XUBYewEAu6CjRH1ELeYju2ZpOTLAQoe
         BPnCVWMtXhVxv4MFEXDzCCbwvJcgVTunCnMPcYZU5oQd8DPawBm9tJZU5I91AS2zSGZs
         S2VQ==
X-Gm-Message-State: AOUpUlEY004FYiI2lq+ZPoYLcBWKnUvjpRz28YkBctzzjmm+D+KFcbnB
        x5y7uGJ6OekQ8rjVFKHAbg==
X-Google-Smtp-Source: AA+uWPwl4+M/gAV2rs6CjPOWxWPJtAcf31sGX2nsZ5FhCHLYdEmvwPnPwJNof1Ostv7S4AQFHoRKZA==
X-Received: by 2002:a5e:860e:: with SMTP id z14-v6mr23739196ioj.67.1534364336481;
        Wed, 15 Aug 2018 13:18:56 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id p74-v6sm6527200iod.25.2018.08.15.13.18.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 13:18:55 -0700 (PDT)
Date:   Wed, 15 Aug 2018 14:18:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Biju Das <biju.das@bp.renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>
Subject: Re: [PATCH] dt-bindings: net: ravb: Add support for r8a774a1 SoC
Message-ID: <20180815201855.GA7965@rob-hp-laptop>
References: <1534250017-15725-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534250017-15725-1-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2018 13:33:37 +0100, Fabrizio Castro wrote:
> Document RZ/G2M (R8A774A1) SoC bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/net/renesas,ravb.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
