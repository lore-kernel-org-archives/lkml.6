Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FE2C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B392020881
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XHqulynD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732396AbfA3VHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 16:07:08 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38353 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfA3VHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 16:07:07 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so394669pfi.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 13:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZYlPBNKo59hOQzk++Fxdagq/04eusrQ3XJ2aXfQz8F0=;
        b=XHqulynDUEfjMmKZjYW6iIoCPti+NND1d220hA2Lb8AIJZ/o2SOp/fPcWhM6f6LUln
         pXNdc18s7RQa6n4wD7/CB+9CttZRFT/kf5xEe+r2TfBy+muAWxyLvnAskXVF9OfD7oEv
         qME2a0jlD/YRu3RgGlB/aCTaRknPt8YsM9C0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZYlPBNKo59hOQzk++Fxdagq/04eusrQ3XJ2aXfQz8F0=;
        b=CZ1335bcNjZ8AC3Fi6zL5Kc69jUPKI9FAX8Eg4EqOvjQIMj1c3K/F7StrkQCsBCt/y
         1B3jseA4wNluLq8WGPOkWPO+AhUz1tFdhHhdqHDVQHxO0Tcw6JCpqAURiQvLFogyf+Bq
         u6bg4E4AJGD2e5Ghkcpbi8oWy38p8sPWWbWa0R5ajAD2zGiQHW7o3lXWHY/cHthF4qpX
         4F9i+X1AX+ympo82dcPBn9LXJ+qY9TU6RSEM4Byj5E8gqSLEcHGZPZt3s0qQfIdjTGoy
         yClbjSHsr9K5B0jnuaUy9EtauqCnssmuYmShw0i/pMOm8oQpGmCgBkIIpX64XM+6bjIW
         Za0A==
X-Gm-Message-State: AJcUukdOb+GMw3hTeFqpMnOgXPb6iUjqv0G22mkE/WrBkcpaiXviZc40
        xccSkYyfCTQFAFcZdxBXPgVWzw==
X-Google-Smtp-Source: ALg8bN5pWIYGrka8jiFC+18vXU133cLPW9+kQPF852I8JBD2vlnVCu2rzMx5TgPsddbJezw0vWDEew==
X-Received: by 2002:a63:e101:: with SMTP id z1mr29147237pgh.310.1548882426681;
        Wed, 30 Jan 2019 13:07:06 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z9sm8066198pfd.99.2019.01.30.13.07.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 13:07:05 -0800 (PST)
Date:   Wed, 30 Jan 2019 13:07:04 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ramon Fried <ramon.fried@gmail.com>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: qcom_q6v5: don't auto boot remote processor
Message-ID: <20190130210704.GW31919@minitux>
References: <20180524192141.20323-1-ramon.fried@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524192141.20323-1-ramon.fried@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 24 May 12:21 PDT 2018, Ramon Fried wrote:

> Sometimes that rmtfs userspace module is not brought
> up fast enough and the modem crashes.
> disabling automated boot in the driver and triggering
> the boot from user-space sovles the problem.
> 
> Signed-off-by: Ramon Fried <ramon.fried@gmail.com>

While I don't think we have fully settled on the mechanism yet, it's
clear that we don't want this to auto boot using the existing mechanism.

So I picked this patch, with Sibi's ack.

Thanks,
Bjorn

> ---
>  drivers/remoteproc/qcom_q6v5_pil.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
> index cbbafdcaaecb..719ee96445b3 100644
> --- a/drivers/remoteproc/qcom_q6v5_pil.c
> +++ b/drivers/remoteproc/qcom_q6v5_pil.c
> @@ -1133,6 +1133,8 @@ static int q6v5_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	}
>  
> +	rproc->auto_boot = false;
> +
>  	qproc = (struct q6v5 *)rproc->priv;
>  	qproc->dev = &pdev->dev;
>  	qproc->rproc = rproc;
> -- 
> 2.17.0
> 
