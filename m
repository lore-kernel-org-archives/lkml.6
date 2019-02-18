Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589C7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277F92173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550507762;
	bh=MJwNWChgbMmJsYfzGROcZfELeBC9joxSS+OU/KSG8p0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LWIn8nr+aPPBadc2g52qTINm6mm71fHSJ1VKcCesbb/3pjdhKoFcmurtFrcF3zBy1
	 lU8InSg/Gy7jLv44kz4PYPWMgYW3Mh03hxfY5cr+sY4O6gqz9WTrPIr5sap8mILg1k
	 TR/uwdrLDTs6AyVo+wqVo9ENZvsWyjd7iHkE6YPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389765AbfBRQgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:36:01 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38683 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389434AbfBRQf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:35:59 -0500
Received: by mail-ot1-f66.google.com with SMTP id m1so29285464otf.5;
        Mon, 18 Feb 2019 08:35:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5t1I1YWmOCGfkrNJVJPcvywIoqaoGu3OB54u7RrBuRA=;
        b=gI/nc5gXhoQ3xiATQeUZB6jPZ8Fowz+KPNqB1E6K+p6neID/UogrlOwcNHtljq2bo1
         dheZ34QEeFN8dbYGAf8F4wXCH8HdEfSISDdNWT2BcHqULGXythbsOoj9H5PQneqG5gYe
         ugYJAjGe1BAQNrZWF6ceGyqH4dRoHBQ2cVbgBVvZ2GHEVyzZ/peAujHna9xDVVHjMTRI
         RW1qqimdiRbHiBcAG6hID7qsxbz4JLkrKGDIjwxch5VAh4LKEvZH3nF0sIN2THtTwYOl
         w4hY6mhRiID9YUxgJAOZtCGAV4q1b2uOQUfeXIlJKq/QYEsCEuO6mNYB/ghR0ZYO0I+4
         ymvQ==
X-Gm-Message-State: AHQUAuaq42TzOzY+gMPH8TkDxztjhSau6fxaT6zOm6V99BTf/EQMIwIj
        Ueul7CsID7POcvNsyi7pcg==
X-Google-Smtp-Source: AHgI3IZnMhkkp8HIYX8TvmAOVWI+axNVybYrjYlMC7UPjT1cd46IGinTWui1zA3gb0+oaacDkQyidg==
X-Received: by 2002:aca:6cc9:: with SMTP id h192mr15462456oic.161.1550507758691;
        Mon, 18 Feb 2019 08:35:58 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a27sm6069346oiy.6.2019.02.18.08.35.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 08:35:58 -0800 (PST)
Date:   Mon, 18 Feb 2019 10:35:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v6 04/11] dt-bindings: input: add DT bindings for max77650
Message-ID: <20190218163557.GA18049@bogus>
References: <20190214140022.19201-1-brgl@bgdev.pl>
 <20190214140022.19201-5-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214140022.19201-5-brgl@bgdev.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2019 15:00:15 +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Add the DT binding document for the onkey module of max77650.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  .../bindings/input/max77650-onkey.txt         | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/max77650-onkey.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
