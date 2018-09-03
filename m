Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57D7C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 862952086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D3J2dRx9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 862952086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbeICXjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 19:39:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34313 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728421AbeICXjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 19:39:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id d19-v6so536995pgv.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 12:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e5K6h4GB475QOuICAPU/n95wv08uRMy37J31Hiewkhc=;
        b=D3J2dRx9/t04yRz1yKvh6Ndl/0yIA9kkxbLLTWGoUvifCHoa5srk2wyJ4FDdZsKTP6
         wBVFZhe2F1emKOhBx3XTfdwh7osHRVWAEVrIui2N99De0GT8FvNu+Kqgxw5aFucT4ibK
         d0H6fIsVJh4l1XuYbGlA1pU23PZRkGVtH520g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e5K6h4GB475QOuICAPU/n95wv08uRMy37J31Hiewkhc=;
        b=uOrpUPVqydB1sivjKV3X6bAnKdTx+SFNy60u6pixEl3axoTChI0Zsjin0DzuklrfQd
         HxPkxs7fABCDmWMVi27f8HwvzzRcRXPfxuBDNGbezriJvGlkxuZTwd5zqNaJ92RpM2mp
         fTSDYjRz4pS1jSdVrKHQFSvGQolxWm5otREIeum81QDKOPHZYjWggBUWNvIhHiwGIfXj
         snKzSihpdQil6I5PHhajHitSHv5bMBiQYFk+Qu/qzWT5VljWRhyOahfGb0gXXZeH+MLE
         Kq+3wU7cbYydZHCDQe7B6KQ28OcQw8W4uRGXoikGe0uDCJ8B1TIwVIZiUokKPS4Sv3ku
         babQ==
X-Gm-Message-State: APzg51Bk/4jtlKM5sWwSiS4oOthwVp2gt/LjIc+72Oe0BqWSUOjAHhFZ
        Ey1bCY3rLSEpCGliVw2ZgzVPbQ==
X-Google-Smtp-Source: ANB0Vdault4uhCFN2+WNMg1YB9XJ/zxwu5Ii7rl6b/qCJ3xSsP6ImLhyyNIg0wahJygpO62dEAUdgw==
X-Received: by 2002:a63:e443:: with SMTP id i3-v6mr28164775pgk.381.1536002288371;
        Mon, 03 Sep 2018 12:18:08 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w16-v6sm32894269pfi.101.2018.09.03.12.18.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 12:18:07 -0700 (PDT)
Date:   Mon, 3 Sep 2018 12:22:02 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 7/9] soc: qcom: wcnss_ctrl: Avoid string overflow
Message-ID: <20180903192202.GB3456@tuxbook-pro>
References: <20180829075724.9095-1-niklas.cassel@linaro.org>
 <20180829075724.9095-8-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829075724.9095-8-niklas.cassel@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29 Aug 00:57 PDT 2018, Niklas Cassel wrote:

> 'chinfo.name' is used as a NUL-terminated string, but using strncpy() with
> the length equal to the buffer size may result in lack of the termination:
> 
> drivers//soc/qcom/wcnss_ctrl.c: In function 'qcom_wcnss_open_channel':
> drivers//soc/qcom/wcnss_ctrl.c:284:2: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
>   strncpy(chinfo.name, name, sizeof(chinfo.name));
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This changes it to use the safer strscpy() instead.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/soc/qcom/wcnss_ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/wcnss_ctrl.c b/drivers/soc/qcom/wcnss_ctrl.c
> index df3ccb30bc2d..373400dd816d 100644
> --- a/drivers/soc/qcom/wcnss_ctrl.c
> +++ b/drivers/soc/qcom/wcnss_ctrl.c
> @@ -281,7 +281,7 @@ struct rpmsg_endpoint *qcom_wcnss_open_channel(void *wcnss, const char *name, rp
>  	struct rpmsg_channel_info chinfo;
>  	struct wcnss_ctrl *_wcnss = wcnss;
>  
> -	strncpy(chinfo.name, name, sizeof(chinfo.name));
> +	strscpy(chinfo.name, name, sizeof(chinfo.name));
>  	chinfo.src = RPMSG_ADDR_ANY;
>  	chinfo.dst = RPMSG_ADDR_ANY;
>  
> -- 
> 2.17.1
> 
