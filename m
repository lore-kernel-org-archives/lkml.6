Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B60C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5821A2070C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546890210;
	bh=W6jwHh/yJOnwmq61Ic6uLQyakooKGi6BqbLk5NkT49k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lX5bZxSGXrUFWUrzXR88E6hZBjeUgAZoWRl/DOoK+x2JVV29E14N1B3Gs3ei3dEJV
	 jJKpTa43m7tftj/Bu5tB0C3sbHcNg2Z3Hk4AjifDeDWEMI0Os+U2jSrflW7+Xorwjs
	 MIl2ASR+CxN3nLHWg+9kP/x5/fvAgUx+JHmL6oLE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfAGTn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:43:29 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40855 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfAGTn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:43:29 -0500
Received: by mail-ed1-f67.google.com with SMTP id g22so2017710edr.7;
        Mon, 07 Jan 2019 11:43:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QbcsgA437JRwXRdJuKKrTWpwd9J769Z1gTHyqC2hzVw=;
        b=jbq+jx/VRL1giF973r5yBaH3zWmO/JNYavYuiYwwdEbjyZ6II9tvbNALt4t78mWCN4
         q+b2xZuMJTdJlwuoiy7mjMmz5E/lPOwFhPDMC9gyVMZsmnVZoK9oA1VgMo8ZRAKkrh0Q
         VkvVD9XUe/hB5ZTWQ+7m+Kw6ij/30jumKO4PGQahk+1PPi/aL9iroGKTw5lFWb2p7cH4
         4H/B44CA3pdNmVfJtIGmLWaz9ZmmYeN03f8WFCxPACu9OjmOuD/OAlDwMd14WTSNDKxI
         F1GD/TPgUXqjMdWJE+BFZyo1I6rOdlcZ9yxn7jNM5yfXVkqzoR/O1+vSbovj3vEODmtI
         OeJA==
X-Gm-Message-State: AA+aEWayms6pE35BMvsJQIdL2MsWcOvwBEBVZVsjWpMNXqz9+G/BsYHH
        DgVj9Zt9Anf6vWwidRZFWaM=
X-Google-Smtp-Source: AFSGD/XICWzeAB+Axq/KZkTrA3BqyYJ0HYyf/e4yhqC1UTcXCNi5iayZIQpWwhoMTqaWfY0WEEfM6w==
X-Received: by 2002:aa7:c152:: with SMTP id r18mr57710418edp.258.1546890207126;
        Mon, 07 Jan 2019 11:43:27 -0800 (PST)
Received: from kozik-lap ([194.230.155.148])
        by smtp.googlemail.com with ESMTPSA id c29sm31310075eda.75.2019.01.07.11.43.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 11:43:26 -0800 (PST)
Date:   Mon, 7 Jan 2019 20:43:24 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Ben Dooks <ben@simtec.co.uk>, Kukjin Kim <kgene@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: mach-s3c24xx: Fix boolean expressions in
 osiris_dvs_notify
Message-ID: <20190107194324.GC3313@kozik-lap>
References: <20190103201408.GA27754@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190103201408.GA27754@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 02:14:08PM -0600, Gustavo A. R. Silva wrote:
> Fix boolean expressions by using logical AND operator '&&'
> instead of bitwise operator '&'.
> 
> This issue was detected with the help of Coccinelle.
> 
> Fixes: 4fa084af28ca ("ARM: OSIRIS: DVS (Dynamic Voltage Scaling) supoort.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  arch/arm/mach-s3c24xx/mach-osiris-dvs.c | 8 ++++----

Thanks, applied with fixing up -Wparentheses warning. I think you should
update your GCC.

Best regards,
Krzysztof
