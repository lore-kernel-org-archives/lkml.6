Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54053C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D329218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k09UR0Bq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbfB0Atb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 19:49:31 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41752 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729288AbfB0At3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 19:49:29 -0500
Received: by mail-pg1-f196.google.com with SMTP id m1so7037311pgq.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 16:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:references:message-id
         :user-agent:cc:subject:from:in-reply-to:date;
        bh=PNQZbZIKN4M7SIVa8uyjo2E9ZYEj8oRlU3g+EswhtZM=;
        b=k09UR0Bqcy6u5JR5CfSr6tXU+AEOsrDp0TRH97u2pBB2E9ay2at8qdSmwaDiSWtukh
         oBMNsa/7/JRErICa4KzN5Oow0Cy0vl2+129yDS+VTuhOUqDty+22nWZ60lFCLBv1zkrQ
         H2c3sesZcos239DvbxxKuc76V6prbenLpJ9a8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to
         :references:message-id:user-agent:cc:subject:from:in-reply-to:date;
        bh=PNQZbZIKN4M7SIVa8uyjo2E9ZYEj8oRlU3g+EswhtZM=;
        b=DefSUuXOGNwfXDWdF5X8Ycqn+DQ1LJIIuhpqbhWRXNGH1V6XLylFdSMSxS7nVqQBcT
         OCTXhCDLh4tm9bm/Em3a7p3EQNRYPRgQJitLoHmjvV1VTrsx1O4OoAwEm0rsRLhbDWYm
         tl9eag6/SilN1mTve3wHK5w4eCw1YOR3icWWqL5XN1ZYnEznMFi9gcWW5kYh3kWsZVJD
         rfwL9FErmlSgf2R0pJECuPqhHs/bDCj23Xd/Nxzla3ku4rWo3C4SPIlzSVtLms78z6my
         lpPVsbV79bWbPJN3u9QR+OUwhlIOffvvdrgeRwCJh2C2MyHODRJGM3EixbA/NEhMJBC4
         bbfQ==
X-Gm-Message-State: AHQUAuZLBE6XnxAXYIyrXL2LmiAYf9R6+u8x/naRVTxUlkwfTVodlkrB
        CNW5FL2JqGaMD2WLJJ1zj6ve8Q==
X-Google-Smtp-Source: AHgI3IZkjaqTW/OerHX1UNk5yqvgGvbJ/UIPZHqHr3DUpcL9xrVcOJa2DFBD/8gzlhbsBnyAyT2EPg==
X-Received: by 2002:a62:1854:: with SMTP id 81mr26456790pfy.223.1551228568516;
        Tue, 26 Feb 2019 16:49:28 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id z191sm5912840pgd.45.2019.02.26.16.49.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 16:49:27 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
References: <20190221121827.32427-1-rplsssn@codeaurora.org> <20190221121827.32427-3-rplsssn@codeaurora.org>
Message-ID: <155122856693.260864.16771523196413005158@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        ilina@codeaurora.org,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>
Subject: Re: [PATCH RESEND v3 2/3] drivers: qcom: rpmh-rsc: return if the controller is idle
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20190221121827.32427-3-rplsssn@codeaurora.org>
Date:   Tue, 26 Feb 2019 16:49:26 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Raju P.L.S.S.S.N (2019-02-21 04:18:26)
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index d6b834eeeb37..9cc303e88a06 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -524,6 +524,30 @@ static int tcs_ctrl_write(struct rsc_drv *drv, const=
 struct tcs_request *msg)
>         return ret;
>  }
> =20
> +/**
> + *  rpmh_rsc_ctrlr_is_idle: Check if any of the AMCs are busy.
> + *
> + *  @drv: The controller
> + *
> + *  Returns true if the TCSes are engaged in handling requests.
> + */
> +bool rpmh_rsc_ctrlr_is_idle(struct rsc_drv *drv)
> +{

This API seems inherently racy. How do we know that nothing else is
going to be inserted into the TCS after this function returns true? Do
you have a user of this API? It would be good to know how it is used
instead of adding some code that never gets called.

> +       int m;
> +       struct tcs_group *tcs =3D get_tcs_of_type(drv, ACTIVE_TCS);
> +
> +       spin_lock(&drv->lock);
> +       for (m =3D tcs->offset; m < tcs->offset + tcs->num_tcs; m++) {
> +               if (!tcs_is_free(drv, m)) {
> +                       spin_unlock(&drv->lock);
> +                       return false;
> +               }
> +       }
> +       spin_unlock(&drv->lock);
> +
> +       return true;
> +}
> +
>  /**
>   * rpmh_rsc_write_ctrl_data: Write request to the controller
>   *

