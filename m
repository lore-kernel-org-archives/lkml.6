Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DDBC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34A4240AA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QhY64nfP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E34A4240AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933551AbeGDGUl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 02:20:41 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44397 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933464AbeGDGUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 02:20:35 -0400
Received: by mail-wr0-f194.google.com with SMTP id r16-v6so919960wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 23:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pdvh8sKU/akjuiRfzctgTxcLv3L5269QGHyotQqXVH8=;
        b=QhY64nfPrLV/JCC9g3qEqxnS+70DpKnVhqed/c1PsLHxRiJD+BQUIKOiRc5keJ0fOk
         lDhzmiPuH0AzaLVpiaARR9EHQHKY8KrfCwPAl2dhgA/bXOIaYY6xRc3E3FvBUYmg0Rgg
         DOsSGtTfxn/cVtHjTiPfPgcjvxxrGod56XNNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pdvh8sKU/akjuiRfzctgTxcLv3L5269QGHyotQqXVH8=;
        b=PK9vxiTYgDNpMjETf+MvYISJ2KoEirsj6AqQj5CE+7/GNxYJjn0hZXDN4nL11vYxH1
         6IN4rZvK+71Z+Ccr/SD++8LYs38fS/xDqEl3Xe/m3/5dr5hMNGehAJ6+a9+TffFqj0or
         RlaT501ASOP4yytewCxkzoItp4hG4/PdiADPQ0Qs4j2RtoUq7/4SX4Dmr99RyOhAlrOv
         Q6O+kr4aVGlcI/aSwdRflc9KHYG1XuOPnZIGHJxePmcpN83KoMrUXrlAfRWlAQAR88k+
         M5aNPqDRCjzuuPCDCmT8z/s311X0q1NhLth1iqHJ0fNJmGa+Muox7alX1qAzVtf8vD7g
         Rjaw==
X-Gm-Message-State: APt69E1lIFQHfvskdILc4fK/9ixOLLtslGvNNUe0uvXdruip9ePX1+l7
        UJt/HaB3kk+fA7CvnhGiMY3QSQ==
X-Google-Smtp-Source: AAOMgpfJa/jTGnBeOfyTBVPMHY2J7PvpsSUlmZLO7kUc58cs4EwTkZApX4D1aTRR20Gz4jJVojcTrQ==
X-Received: by 2002:adf:9e48:: with SMTP id v8-v6mr466032wre.277.1530685234706;
        Tue, 03 Jul 2018 23:20:34 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id d10-v6sm3313116wrj.38.2018.07.03.23.20.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 23:20:33 -0700 (PDT)
Date:   Wed, 4 Jul 2018 07:20:32 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: kempld-core: constify variables that point to const
 structure
Message-ID: <20180704062032.GX20176@dell>
References: <1528865289-3875-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1528865289-3875-1-git-send-email-Julia.Lawall@lip6.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2018, Julia Lawall wrote:

> Add const to the declaration of various local variables of type
> kempld_platform_data for which the referenced value is always only
> dereferenced or passed to a const parameter, to record the fact that
> kempld_platform_data_generic is declared as const.
> 
> The semantic match that finds this issue is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @r@
> identifier i,j;
> @@
> const struct i j = { ... };
> 
> @ok@
> identifier r.i;
> position p;
> @@
> const struct i@p *
> 
> @@
> identifier r.i;
> position p != ok.p;
> @@
> * struct i@p *
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>  drivers/mfd/kempld-core.c |   15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
