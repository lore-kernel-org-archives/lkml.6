Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA958C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9478220C0E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9478220C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390100AbeGKUAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:00:41 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:45001 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389922AbeGKUAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:00:40 -0400
Received: by mail-oi0-f66.google.com with SMTP id s198-v6so51483965oih.11;
        Wed, 11 Jul 2018 12:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yxH2qUHbTGEpIjP8Fex5SuU0jpW8Wmvf8y4hrDQOHTs=;
        b=BXaBL2G/BH2wdbV6ZREbiLjnCT14A6AbDyGSn/hGgllWzOKjYfOTnhv2z0LpPRrO23
         zLUVeGvidySLWxij2D80d6yjnQ/8Gg0RRktQYofHSPG/09Do2yYoWHiomlRAZHb/d7hJ
         zieYV8QxVnMJKx6PtzOcP+5jjyfCXffEzo3p8QdJGLje8qCMeSENA7Idl7kRpRX1/hnR
         zDhmkU7zvv1NQLWGiYBvhsxNMxdGUPU1bOygJEfHNKdTVnSQdyc9B03krhCZKOMbKuGz
         Q8evyt1t1/Dto+kl0o/C9sj4rNnAoCgGF4AiO9bG7plpuNc2Bn+1w/Jqv4PSV+PP0bsM
         Wfvw==
X-Gm-Message-State: AOUpUlGE6Od/XHfKpJHYmwtO5ZcfmZVz/yvTqGCiv+/q8IynfqHgG9u0
        u5/NNwZN97X5kDMtRwTm+3mM9ss=
X-Google-Smtp-Source: AAOMgpddrcq01Ji8aXEIpaLQffetXFuuSTFU5UW5LMPaQzxmayKsXDMEqEDKjEJjMmUCwefEd+K6gg==
X-Received: by 2002:aca:401:: with SMTP id 1-v6mr77657oie.28.1531338887651;
        Wed, 11 Jul 2018 12:54:47 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id x23-v6sm9731434oie.0.2018.07.11.12.54.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 12:54:47 -0700 (PDT)
Date:   Wed, 11 Jul 2018 13:54:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Koen Kooi <koen@dominion.thruhere.net>
Cc:     linux-omap@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        David Lechner <david@lechnology.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        SZ Lin <sz.lin@moxa.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: Add vendor prefix for Sancloud
Message-ID: <20180711195444.GA17291@rob-hp-laptop>
References: <1531291992-30512-1-git-send-email-koen@dominion.thruhere.net>
 <1531291992-30512-2-git-send-email-koen@dominion.thruhere.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531291992-30512-2-git-send-email-koen@dominion.thruhere.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 08:53:09AM +0200, Koen Kooi wrote:
> Add vendor prefix for Sancloud Ltd.
> 
> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
