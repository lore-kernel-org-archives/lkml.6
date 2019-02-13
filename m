Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90022C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524FA222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550094384;
	bh=swj8QWSC8dzI9Ic4ezM4ScC/gvs2iPt2oUaNOh1i1no=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MGt1Qp7UNdqCuATglWRXVlLtKhSk8S0AECTTK2yXksqufQeOtK6mXkIJktcM+VyYU
	 Hze/TvOl97+TQ2Cy4hTOG+gnj2P9Qm43JGqJ32NbhrYBKqb7bqHiHBgGHbJ+5xu02i
	 HyfBTOJxMLJwaMtaA9kuSyDxxyh1tb9WhqV/W7hU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436933AbfBMVqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:46:22 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37208 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729596AbfBMVqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:46:21 -0500
Received: by mail-ot1-f66.google.com with SMTP id b3so6992917otp.4;
        Wed, 13 Feb 2019 13:46:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lZssmK74WEYiqr7XD9J9iizRSLq1vzrhAaivAYlZdUk=;
        b=niemFxQFep5xxxXMJZ8rJspW7KpaguiNJWDPJtmm3hmd2NJkZcW7ConRc7iS/Blyhf
         6fHXK/fgRzkyEy+k4pHeqs8ngMKLc6fC6fiCOgMxGHI+kJZ/355h4XTlPIYeqh2fsVRC
         WmczYtGGBrWQkRdVhoMPAyGXltRXWAvBrYSQYcAbYAVI5pN7ExnR+g3LDWfMMfomnCBm
         pMmFFnA2Pk0QzVYrXuF+q7kAMRa0zZMasYYk8j7pbwO7g19XWWdLu5CIftMm3mM1yqPZ
         nT1Q7aoFQFKQ2xq0tdxPpbe7PboJzSht2v0X0qOr7gYRaMsu0u8R2oFrMV2CMYV2DXi/
         JQWw==
X-Gm-Message-State: AHQUAubsOJqaqJOM44NAiWskaf4uQaec70wbkGTFCxid6yn8sQtupWxU
        V2bcH3V2yNL8z2kO3jQXUQ==
X-Google-Smtp-Source: AHgI3IYmyj2B8Wnq4mhjFmt/gcl9bgzukHwq6jxmNSMsMf0LZvNKkqMno7P2Iqvhb/n07kiOnETjZg==
X-Received: by 2002:aca:51d3:: with SMTP id f202mr210826oib.114.1550094381064;
        Wed, 13 Feb 2019 13:46:21 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j5sm224340otc.54.2019.02.13.13.46.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 13:46:20 -0800 (PST)
Date:   Wed, 13 Feb 2019 15:46:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Rutland <mark.rutland@arm.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v4 2/9] dt-bindings: mtd: ingenic: Change 'BCH' to 'ECC'
 in documentation
Message-ID: <20190213214619.GA3175@bogus>
References: <20190209192305.4434-1-paul@crapouillou.net>
 <20190209192305.4434-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190209192305.4434-2-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  9 Feb 2019 16:22:58 -0300, Paul Cercueil wrote:
> The JZ4740 ECC hardware is not BCH but Reed-Solomon, so it makes more
> sense to use the more generic ECC term.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Changes:
> 
> v3: New patch
> 
> v4: No change
> 
>  .../devicetree/bindings/mtd/ingenic,jz4780-nand.txt    | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
