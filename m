Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232B1C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE85120882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548877414;
	bh=eApoqKqSXazuCbhKznQS0o85EhlvMFdoRwIte7e838k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=01ivqNNhXBTwfp+2eDICpyRAe5U2SdXOhcJoQmI0pYIM0jWU0q58FppNq6KFL1nNc
	 V5d9JjG7INLUdolCXiY28ErxbVeTda462hwQqanH8pPVcroW7zkOwgsCflUfNdXI7C
	 EuUtGkb/tglT7W82IsR/TzoMJKEWssuT7hepaOKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387754AbfA3Tnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:43:32 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43046 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387587AbfA3Tnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 14:43:31 -0500
Received: by mail-oi1-f196.google.com with SMTP id u18so641056oie.10;
        Wed, 30 Jan 2019 11:43:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gvBu9xa5IfiUpJwfwVVCLNtcu+OfuVVXaR8Tf9kOYkw=;
        b=g1tQVE11vJXdaimHPMXpMobppb7RKhYsWTwVnilqqGiQwrMrgrc9coOBOSDpMcpw2G
         gfWZfsezDbb5Bsv8rw6Of+CaGxzBlL4BGAgfv+Wi79zdfAnYdUEmoeLki9rXoAdRXwW2
         Z5WgHvYNaAudkISgmBP5gIiPJ0gCrFq4YEMck/G1o/LrLbqLd0hchwkeVUlVjdCimRtt
         KtgNE/kj5WfB8irlPlOzGNAmg0qYlSp1v0tMslCSAbZmQyNC5aa2zmfg3HLSm5yDS+gb
         QzI4xWj067cXaSuoLMrryc67sFugS9ljppAQC6EB8rWjcTKc5NrUfctMFvD0xGrnF87U
         6qIQ==
X-Gm-Message-State: AJcUukcZDRMedel17unISI8l5WLRzOCXhpj+jys36F2MM2xCIuckJHTM
        bsa/JOqQ/iHvY8fsRUJjJg==
X-Google-Smtp-Source: ALg8bN52vBqi77P2POQ4Ta0gxFmKPDl/SUAdZlWhrvGXyP5JBqoHi/5PvbYEZ1bqeOFnzygoi18rfQ==
X-Received: by 2002:a05:6808:246:: with SMTP id m6mr12673275oie.64.1548877410610;
        Wed, 30 Jan 2019 11:43:30 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y2sm844958oto.49.2019.01.30.11.43.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 11:43:29 -0800 (PST)
Date:   Wed, 30 Jan 2019 13:43:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zhou Yanjie <zhouyanjie@zoho.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        paul.burton@mips.com, mark.rutland@arm.com, marc.zyngier@arm.com,
        jason@lakedaemon.net, tglx@linutronix.de, syq@debian.org,
        jiaxun.yang@flygoat.com, 772753199@qq.com
Subject: Re: [PATCH v2 4/4] Irqchip: Ingenic: Add support for the X1000.
Message-ID: <20190130194329.GA22264@bogus>
References: <1548517123-60058-2-git-send-email-zhouyanjie@zoho.com>
 <1548604232-19159-1-git-send-email-zhouyanjie@zoho.com>
 <1548604232-19159-5-git-send-email-zhouyanjie@zoho.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548604232-19159-5-git-send-email-zhouyanjie@zoho.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jan 2019 23:50:32 +0800, Zhou Yanjie wrote:
> Add support for probing the irq-ingenic driver on the X1000 Soc.
> 
> Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
> ---
>  Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
