Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA006C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C5120837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="pXpl2xdw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96C5120837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbeLGPXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 10:23:15 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43315 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeLGPXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 10:23:15 -0500
Received: by mail-pl1-f195.google.com with SMTP id gn14so1969656plb.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 07:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JodBqiRXXKLscH3my/7i73K/xOLDQ0X9/sGyV6sYDZw=;
        b=pXpl2xdwOQuszH7DWDXy3vX/PWn0A0H/G/k52mdhuASZXFoGJHC77b8GeY8yLrQqVZ
         xXai4jduU/4ujhNP57Jjf4paCc25FgbYCXTZuuXp9JATfS0G6F/Ot3XSaimfRWm0iq+b
         KKvNL+y6AzO2akksi19nXAKsEyEk/xMo4fwznD54ffFlGsfJWDROi8xMhg3Rgqm4NJ/H
         Kc6nxaF8MZcnLgelF1gIi8fkMJQjm6dvjFf1WbWmOQJ60Id4G03Wx2nAhL/aPY2QGF2s
         jNMbaD/cvOb3esKuHPJbjKUgFV+BHjXa7XUIAQYTeu4uR9xI+l5LE17GWuLJAqf4Ft7q
         u1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JodBqiRXXKLscH3my/7i73K/xOLDQ0X9/sGyV6sYDZw=;
        b=GNfi9HVZB8wa3S53NmokXCBAmtFGqAB2RdYb7IbNe2YNmZ09rxTxM32kIzYwzyFZZb
         VQ9y/18dtr0mb1jutziX4s/IiBwG1xnmR3gXr0SzCNa7DxM7b4wOvcXbXL7Y7DbwO28x
         NH0IDKHYV6VS9xMobWDVsnDgTUicopFzrRPxQ0SdsSu3PnOIMB++ewZXyxU+etpYnvki
         EyofGifGGWZsZb6ECvjETShtg3/zA15bgQ9g279XalzfB12P0/I7d85bIiaYvT9TakTj
         8a2cW5ZzPMk1QrP6OA3qnd2ccGqRyu9woNtsViW530rxh+VOXOPW5EnvfwjwLMHgfIpr
         bTFQ==
X-Gm-Message-State: AA+aEWZtZfCwgKGxDquGAuRm+K9Hj4ncoPIK0Kj6PRVGsb3oMWCAevk3
        VrUaXMnjIPTOiWZ5KiIn/du3Yg==
X-Google-Smtp-Source: AFSGD/X34F2+FgJirq/p6YtPkkTznDWMPQWPpE2SbDn2A+JSCl4ItP1MDdMMDBGzC+C8qqu38atbMA==
X-Received: by 2002:a17:902:bf44:: with SMTP id u4mr2529687pls.5.1544196194201;
        Fri, 07 Dec 2018 07:23:14 -0800 (PST)
Received: from cisco ([128.107.241.185])
        by smtp.gmail.com with ESMTPSA id g136sm5560507pfb.154.2018.12.07.07.23.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 07:23:12 -0800 (PST)
Date:   Fri, 7 Dec 2018 08:23:09 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc:     linux-kernel@vger.kernel.org, mpatocka@redhat.com, dima@arista.com,
        pasik@iki.fi, peterz@infradead.org
Subject: Re: [PATCHv6 0/7] tty: Hold write ldisc sem in tty_reopen()
Message-ID: <20181207152309.GA30796@cisco>
References: <20181119125208.GC15229@reaktio.net>
 <addf7faa-f6e9-df6b-8dad-4c43b71cfc1e@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <addf7faa-f6e9-df6b-8dad-4c43b71cfc1e@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 12:24:20PM -0200, Guilherme G. Piccoli wrote:
> Hi, thanks Dmitry for the re-spin - hopefully now the pa-risc issues
> are fixed.
> 
> BTW, any news on the pa-risc testing? We're just waiting on this to get
> the patchset merged?

As far as I know it has been, I got a mail from Greg yesterday about
the patch I tested and it looks to be in tty-next,

https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?h=tty-next&id=83d817f41070c48bc3eb7ec18e43000a548fca5c

So maybe any fixes in this series need to go on top?

Tycho
