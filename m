Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD224C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6C72190B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6uAtQrr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732058AbfBLSqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:46:42 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42691 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732046AbfBLSqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:46:42 -0500
Received: by mail-qt1-f193.google.com with SMTP id b8so4176667qtr.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 10:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FSEip40nymgyuc4U0Tm9L0STdSljBmwSEXRX8bkuNCY=;
        b=U6uAtQrr8TcBVpQlV0ti+kmRdiK4GRIc7ymxQLRVHWIiZ2l88PGrm+sQ2UeQxNAo29
         hXqts+VXD8jn2DDnnJb7wVKp+zztrnex6Z/n0oA3Hd+sQvtrCp3A8/6Xvrre6qLa6vd3
         I449SgN648UjNb4gwSFqtbX7Kc9MjBBvOvJYPwKl5Oxuih8DyQi+oeJ5Vw+YwEnytYEr
         YNHPwwhlns0xqbRtigm3olCfvUot8d06fqj8RFLjq0kUmzn3Ef6zTRJx84uzB7InebYj
         uAvwU6gOxlia6HcyLV39wixTgZD/kcwAKeZGUVRXGNPtvS7MSVYUsrf+Qh1h+OhOO1ea
         wpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FSEip40nymgyuc4U0Tm9L0STdSljBmwSEXRX8bkuNCY=;
        b=kjEMEjf0GrVK/pyRwa7py6f5oJnINaWQXjgj0g+EAvAeU9fYWSfg9lLy2P+0MiumgL
         Gm8ip+Y/0cfNjQwW/I3bqKswYHqDzCVwJkJ5hvNacozjm92DZsKFdsqaifHSnM8sWD/x
         tl5mWGimsjvadSppAxmkDqJdokYtdTHQ+L9nrf92IC1LXFUgsVbFTVry3K95Q6+JnwPM
         1DgWUXVlCTv10IMVul8/Za5zXEOHaGq03xttd4BdjDwS9yyZYkk8dBOA57ExndNkKMa0
         rBWxIAnzg/d7gaaIlyQHQcmTYd2k8ZgolOlXFfbfYvnCKJ4Ulpgdh8ZIR55uMrpWcNLW
         KQZA==
X-Gm-Message-State: AHQUAuZrdOvCtlfn75v8fuj2+SwlaXEzvgaLsPbraXQohMdk2Cnqyo3C
        Cg2PL9msQDaZDas4tedFX5A=
X-Google-Smtp-Source: AHgI3IbC6vHbJqOWRR5gam3dl1QbtCq/pGkXg3tdigE/Ese2PQytJBmwFJ+XU7RssAVzlfvQW+82ZQ==
X-Received: by 2002:aed:3c35:: with SMTP id t50mr4098301qte.360.1549997200976;
        Tue, 12 Feb 2019 10:46:40 -0800 (PST)
Received: from localhost.localdomain (209-6-36-129.s6527.c3-0.smr-cbr2.sbo-smr.ma.cable.rcncustomer.com. [209.6.36.129])
        by smtp.gmail.com with ESMTPSA id c202sm18564369qkb.19.2019.02.12.10.46.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 10:46:40 -0800 (PST)
Date:   Tue, 12 Feb 2019 13:46:37 -0500
From:   Konrad Rzeszutek Wilk <konrad@darnok.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Peter Jones <pjones@redhat.com>,
        Konrad Rzeszutek Wilk <konrad@kernel.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] iscsi_ibft: Fix missing break in switch statement
Message-ID: <20190212184636.GB19464@localhost.localdomain>
References: <20190211184323.GA3671@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211184323.GA3671@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 12:43:23PM -0600, Gustavo A. R. Silva wrote:
> Add missing break statement in order to prevent the code from falling
> through to case ISCSI_BOOT_TGT_NAME, which is unnecessary.
> 
> This bug was found thanks to the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Fixes: b33a84a38477 ("ibft: convert iscsi_ibft module to iscsi boot lib")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>


Queued it up in https://git.kernel.org/pub/scm/linux/kernel/git/konrad/ibft.git
> ---
>  drivers/firmware/iscsi_ibft.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/firmware/iscsi_ibft.c b/drivers/firmware/iscsi_ibft.c
> index 6bc8e6640d71..c51462f5aa1e 100644
> --- a/drivers/firmware/iscsi_ibft.c
> +++ b/drivers/firmware/iscsi_ibft.c
> @@ -542,6 +542,7 @@ static umode_t __init ibft_check_tgt_for(void *data, int type)
>  	case ISCSI_BOOT_TGT_NIC_ASSOC:
>  	case ISCSI_BOOT_TGT_CHAP_TYPE:
>  		rc = S_IRUGO;
> +		break;
>  	case ISCSI_BOOT_TGT_NAME:
>  		if (tgt->tgt_name_len)
>  			rc = S_IRUGO;
> -- 
> 2.20.1
> 
