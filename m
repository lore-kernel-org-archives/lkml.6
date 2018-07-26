Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB108C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 21:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840AB20862
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 21:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ft0FKReK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840AB20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731445AbeGZWbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 18:31:14 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46881 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730441AbeGZWbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 18:31:13 -0400
Received: by mail-pg1-f196.google.com with SMTP id p23-v6so1885542pgv.13;
        Thu, 26 Jul 2018 14:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7HITH8W2ZJIk6qhrYV1y9WAipGfBJKpFmu5xz2fon0s=;
        b=Ft0FKReK3LREAogRZUP0pdaydIxCesitJYagw+6pRxfXl3WBYM4UOhNi5V4D9hKR38
         MZxveElivZ0n1M17FnD+EcCtdRns0Fhc769l2jmAvwR7CVz3U52/9hfIlO4bNkIu9L73
         BXpfe+eJsKZZyMfaloyyqT5rbGk3lM/ViBt6OIrUtjNtK8Mwc5Mwf1TrIzwA87m39nXI
         n8+ttM+0jyBkMWQmlZo/tx9fWGT1muUeMeQ5ofpKjU3XJj4aoJ+wxWr3VpvPw/cAEnQY
         hgZ3aPqe+VG3r1+vjDNeV4C/o6/r62uK+lFJVIh4gqZMFi7QccjE8A95AAaEUv73zxvm
         HS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7HITH8W2ZJIk6qhrYV1y9WAipGfBJKpFmu5xz2fon0s=;
        b=Qxkcxfvp6DGfKZI4E4Uw+tOemKmhtsL3EzOTKUS9YrPMLW01LJ/WQtZLkIUyTMCor/
         fbY93hOS5UYYR8RaTs37zpd6zAz02C6NkRSkVnF8PxYY0ySWBW/lc64xhbvzcfJuewQd
         KIoDwU0EmWoxv+uUPVsB5YLwI4i7Xkodswut6m4DLtOJtcAvni5GSi1RpkIpHBNGiAda
         DiHqqv3fTid7gRbGncIK7N/6KD0+ynVoBWVxgVa9xn5/9opW1RMGCHir/u9CcK4dQ9Zs
         FlHXeLY4aVwn44acSsIORfIFg/b1wNsOEnIKomazI68cOhPv9UstO3u6yb1nvTEVuLYQ
         zaXw==
X-Gm-Message-State: AOUpUlHk9qGGwVN+Pu4SubKq79IJjAqFFQFVTxQOTZRcqyY/sDz8mXWs
        joFv1GGIBcdtNQ8ObjLKkMo=
X-Google-Smtp-Source: AAOMgpdvrOnuwpED0vMR2OcG5sXproIlVLUZeMduKSfNc9LSLYHkZlS0z/d13fInaSPtaYFeEYVx4w==
X-Received: by 2002:a63:4951:: with SMTP id y17-v6mr3492560pgk.32.1532639556648;
        Thu, 26 Jul 2018 14:12:36 -0700 (PDT)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id g69-v6sm5924160pfd.23.2018.07.26.14.12.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 14:12:35 -0700 (PDT)
Date:   Thu, 26 Jul 2018 14:12:38 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add myself as designated reviewer for
 thermal
Message-ID: <20180726211237.GA3487@localhost.localdomain>
References: <1532600980-29357-1-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532600980-29357-1-git-send-email-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 12:29:40PM +0200, Daniel Lezcano wrote:
> I would like to participate in the review process effort for the
> thermal framework, especially the SoC part.
> 
> Instead of capturing emails with message filters, I would like to
> humbly add myself as reviewer so I can receive the patches directly in
> my INBOX and focus on their review.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Eduardo Valentin <edubezval@gmail.com>

Thanks for the help Daniel.

Rui, want to take care of this?

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0fe4228..1890aad 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14119,6 +14119,7 @@ F:	drivers/media/radio/radio-raremono.c
>  THERMAL
>  M:	Zhang Rui <rui.zhang@intel.com>
>  M:	Eduardo Valentin <edubezval@gmail.com>
> +R:	Daniel Lezcano <daniel.lezcano@linaro.org>
>  L:	linux-pm@vger.kernel.org
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git
> -- 
> 2.7.4
> 
