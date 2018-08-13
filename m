Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C46C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1695F2175D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1695F2175D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732298AbeHNBjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 21:39:44 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53628 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730203AbeHNBjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 21:39:44 -0400
Received: by mail-it0-f68.google.com with SMTP id 72-v6so15659207itw.3;
        Mon, 13 Aug 2018 15:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vQ3WQCnh4gzBd76l0hJr2lcAj9zyBYv2TeJYJTRdTB8=;
        b=V9dM2yfCg0cvtvuoWcRD2IW81212IjO3lBVnDkncL/VZJAPr3zyk8vhRwC3zPnGzef
         W9ZBrzakNc6f8AMo4lj9aR9pCcQXPSh/s4tPKy2FtT9IxxVLLA7RD963ZsabZ1MGcOOo
         y8BJ9Vu9FDh6vVX2qhvql9KlxFK+jhzV53WzfiE3/DO/zGmp9Z5Cr/Mf75R7b7w7NsZM
         qWnwK4cQniQhY+0/f2HYOvQPYnD/tBkSaiN/qY05NFSIwBZzJ1dd0cBCFarR8lnI497/
         vQ0SvpfUJ0L0/IORwowUHZ3FVctVaHi3FH20s8OUgxEG5lwmbSLz4BmWjiZ3M05teA7W
         cHLg==
X-Gm-Message-State: AOUpUlFosfexmOGHn1jG94JmRXeG4b/geoUsj3YtaF3UfiFS+6Rpm0+A
        +m6o2zcLET4gmFSwI70Dzw==
X-Google-Smtp-Source: AA+uWPy8fc+u1tFwrPkud+5UCtemN7W8WHw7RktYoowc6ZmV8DIVeRsYG/ls5hKBuAfEt0ERi2/qQw==
X-Received: by 2002:a02:4dda:: with SMTP id t87-v6mr17097729jad.51.1534200925457;
        Mon, 13 Aug 2018 15:55:25 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id b11-v6sm7563207ioc.16.2018.08.13.15.55.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 15:55:24 -0700 (PDT)
Date:   Mon, 13 Aug 2018 16:55:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 4/4] dt-bindings: net: phy: mscc: vsc8531: factorize
 vsc8531,led-N-mode
Message-ID: <20180813225524.GA19219@rob-hp-laptop>
References: <20180730130236.3837-1-quentin.schulz@bootlin.com>
 <20180730130236.3837-4-quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730130236.3837-4-quentin.schulz@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 03:02:36PM +0200, Quentin Schulz wrote:
> VSC8584 supports 4 LEDs while VSC8531 only supports 2. Let's factorize
> the documentation for LED mode properties and give the 4 default values
> (the first two being shared between VSC8531 and VSC8584).
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> ---
>  .../devicetree/bindings/net/mscc-phy-vsc8531.txt | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
