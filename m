Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B911DC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FCC620869
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tude80Qy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FCC620869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbeICXYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 19:24:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41003 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbeICXYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 19:24:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id s15-v6so510372pgv.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 12:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dZijJODLFOr0c2Bh8fumDsgMKzIk8va86Izs8GwffGo=;
        b=Tude80Qym/sTrWeRkW/TejufGzx/wW9UUB/VvuVVtw1400DWtKcspDSHrKOFa0xP0u
         oGkOKk42MrreWIQY8nk3JUM/eoswnh5oTtkDAIDktl9v/BRaTMik+KqGCKCD62vBITud
         4QV16ObbLOHTKsPEWjFoe7otMEvq8BS4zdwCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dZijJODLFOr0c2Bh8fumDsgMKzIk8va86Izs8GwffGo=;
        b=HHIJ6X/BKDHUXAAHTrHgEwfpKl/rGQn+MROykZGZpIANQeU4ojkPep3QC5e8MMY3Fz
         NFGksXPbugJgt48dxRUs/s4dDQeHMt4jp70kvaeXFal7Z4VmEYVZ+iGEnfMxVRPdWX99
         t3l71Pbhoq56gM+CGLtMTMnM3sJzJZsB/MvIbbyfi6YddBZ1h+xdPaXODA4PrhwNH34K
         LiHrjoLEj6JDYf6VDG5rT6nt4ZAKOlG84/4bA28OfJsf75yf+MN26/T1ebdWbmQS8T3M
         NfFHJKT8r28RKeAPMzmDDHyAg/DDXdXnVIlGIdueZgCbbsXzuK0SG5nEczSOmWSYqRxY
         kWCA==
X-Gm-Message-State: APzg51C0uqdgI0CbDLn7vBiFYmNQ2U8GhaYsxPPtaAFs7eGrJYvS5CbM
        W3fvof2DnKcahB4urwbb9fzyZA==
X-Google-Smtp-Source: ANB0VdYMgThWSin/GaF5K/Ig6nxT29lAeIgLk15qcGCQwxWJtmcVkzEHzp1xoldFi7sj34FKQndlMA==
X-Received: by 2002:a63:4663:: with SMTP id v35-v6mr27903970pgk.178.1536001396919;
        Mon, 03 Sep 2018 12:03:16 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id e7-v6sm24820878pgc.55.2018.09.03.12.03.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 12:03:16 -0700 (PDT)
Date:   Mon, 3 Sep 2018 12:07:05 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] drivers: qcom: rpmh: use struct_size() in kzalloc()
Message-ID: <20180903190705.GA3456@tuxbook-pro>
References: <20180824011753.GA25826@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824011753.GA25826@embeddedor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 23 Aug 18:17 PDT 2018, Gustavo A. R. Silva wrote:

> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct foo {
> 	int stuff;
>         void *entry[];
> };
> 
> instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_ATOMIC);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> instance = kzalloc(struct_size(instance, entry, count), GFP_ATOMIC);
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/soc/qcom/rpmh.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
> index c7beb68..12c057a 100644
> --- a/drivers/soc/qcom/rpmh.c
> +++ b/drivers/soc/qcom/rpmh.c
> @@ -362,8 +362,7 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
>  	if (!count)
>  		return -EINVAL;
>  
> -	req = kzalloc(sizeof(*req) + count * sizeof(req->rpm_msgs[0]),
> -		      GFP_ATOMIC);
> +	req = kzalloc(struct_size(req, rpm_msgs, count), GFP_ATOMIC);
>  	if (!req)
>  		return -ENOMEM;
>  	req->count = count;
> -- 
> 2.7.4
> 
