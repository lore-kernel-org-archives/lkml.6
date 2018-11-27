Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF5BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 01:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B16B208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 01:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B16B208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbeK0MgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 07:36:04 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36247 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeK0MgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 07:36:04 -0500
Received: by mail-ot1-f65.google.com with SMTP id k98so18648227otk.3;
        Mon, 26 Nov 2018 17:39:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6b5jQyNRAyg+v44lZExl5NEOUQXdmPgBtwHEOu+E1Sk=;
        b=oRPBisMrqbdTl5ZamB+qLpncYNJc2juCY2TqZ7LeqLW8fcACpjiOl5WVCCOJABy1Zo
         3Zd9umMCS2LvjWOcPBVyTiES+R3zHWjFMU5x2tY3I74UkyWC6FiX0X6CeABtJRDUPmVG
         dWLQr81s05Nboz0GFpJy6vNVCM+idi3UYcYgZjE1l3CuLShwNCtxP5iRzgx/DmQyBiht
         oBS0SEnwNhSBV43izSycKLiO6voPNyWyRLl0C2n8J8+QqPH27NUj0yQYmTKzkXj4xFUg
         Tga33Fk40+uXke61BFUCUiwQs+JTln1I+KI9EoO/NIbQZoeBAMU0coLSj0Bs+4hXBHCY
         SO9w==
X-Gm-Message-State: AA+aEWbovU0MGL9OoO9wzXJSM1v3816RwnVh+QLKHIZerOMpJbvQ0Jjj
        7xHpuRAt/1+c/tymFN8OOA==
X-Google-Smtp-Source: AFSGD/W4Pk46yWx5LQoe/b0QlA438ILAxzWk6n9bwbvqmLpsu2OS/Tyz9Ivp04SJe4XtKEV8xhMxDw==
X-Received: by 2002:a9d:d6d:: with SMTP id 100mr11712909oti.69.1543282795664;
        Mon, 26 Nov 2018 17:39:55 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l5sm599378oil.15.2018.11.26.17.39.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 17:39:55 -0800 (PST)
Date:   Mon, 26 Nov 2018 19:39:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mesih Kilinc <mesihkilinc@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com,
        Mesih Kilinc <mesihkilinc@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Julian Calaby <julian.calaby@gmail.com>
Subject: Re: [RFC PATCH v4 14/17] dt-bindings: sram: Add Allwinner suniv
 F1C100s
Message-ID: <20181127013954.GA25380@bogus>
References: <cover.1543131714.git.mesihkilinc@gmail.com>
 <f80ca2de497c44c9415b02ac9aba93721d723730.1543131714.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f80ca2de497c44c9415b02ac9aba93721d723730.1543131714.git.mesihkilinc@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Nov 2018 10:43:17 +0300, Mesih Kilinc wrote:
> The suniv ARMv5 F1C100s chip has similar sram controller to sun4i A10.
> Add compatible string for it.
> 
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> ---
>  Documentation/devicetree/bindings/sram/sunxi-sram.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
