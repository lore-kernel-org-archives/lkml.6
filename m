Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8DDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A447222D0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550094348;
	bh=mfwvUVnhUAQmohtye4FSJHG2vN60atuK4DBY6fe/2S4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gAydQksKsafxz2IWhiufYYpq0C6nceGxO1wbzKBASNCl6cIYUNHJOE3qUXWmNTB11
	 npxZGxX8zoeBXM2dkZi9grSzCPdguWe+SSYCNUfFdfgJXoszava71wMX2zNvrp8NtO
	 ZC/TLmwz+yYh1bPpSwgpRmcGBWKjnHVRP45kjspE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395003AbfBMVpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:45:46 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36236 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729596AbfBMVpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:45:44 -0500
Received: by mail-ot1-f65.google.com with SMTP id k98so7017821otk.3;
        Wed, 13 Feb 2019 13:45:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H7YA8SsV+JE3KW+xHVg+h1GsoWrNebHSkR6Ga8KTla8=;
        b=W/sGES4wqY4fp6fc7bR4Wx/IbmrFOOmYrQ7OYk5SNxmJ+dBR7vjii0cxEnkQeIofjL
         2d8o3CqP70R3gpyfgLD3lv3xPdLn1rkq9RdleKUqg9c7k4uzSfauEGHA3eZHl+jnSnWA
         OIohtARB1vLXqR0MBXil0dZhTzBTveyvUZL8ktuj6Kh6yO3nkrVSp+MZFTTWKPvsB1CA
         2/XOeQpe3qYnpfIaVRUmsQAcyzyG5e3uqbeixt3ie4PJnn0Ubb3Y5JMt+wGt0jUF+1C8
         LEo8DFXNFPtwPnrmnkAW/R8zS1ZjmTO6IQKgcs2JFlRgkQxRDF95t3oJ8ENoofMu9bJ5
         VR2g==
X-Gm-Message-State: AHQUAuYCv+kCD4N5aXc/kss2TfWUiNEeBctyUhgmWTI1tlHHlmrI7Bso
        CEJAxML/N/GLFe5Doi+XWA==
X-Google-Smtp-Source: AHgI3IbSfKujagTw6XadtsrYjRPx+duyQndJTOAOaHb2JbhgstkhIaUiUUVXQxgw1cyNdt6XSYZOtg==
X-Received: by 2002:a9d:6195:: with SMTP id g21mr214946otk.76.1550094343744;
        Wed, 13 Feb 2019 13:45:43 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a68sm226871oih.28.2019.02.13.13.45.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 13:45:42 -0800 (PST)
Date:   Wed, 13 Feb 2019 15:45:42 -0600
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
Subject: Re: [PATCH v4 1/9] dt-bindings: mtd: ingenic: Add compatible strings
 for JZ4740 and JZ4725B
Message-ID: <20190213214542.GA2102@bogus>
References: <20190209192305.4434-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190209192305.4434-1-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  9 Feb 2019 16:22:57 -0300, Paul Cercueil wrote:
> Add compatible strings to probe the jz4780-nand and jz4780-bch drivers
> from devicetree on the JZ4725B and JZ4740 SoCs from Ingenic.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Changes:
> 
> v2: - Change 'ingenic,jz4725b-nand' compatible string to
>       'ingenic,jz4740-nand' to reflect driver change
>     - Add 'ingenic,jz4740-bch' compatible string
>     - Document 'ingenic,oob-layout' property
> 
> v3: - Removed 'ingenic,oob-layout' property
>     - Update compatible strings to what the driver supports
> 
> v4: No change
> 
>  Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
