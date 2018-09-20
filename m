Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E5FECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 03:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E3972087A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 03:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="utEETBgH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E3972087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733041AbeITJO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 05:14:59 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:38991 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730892AbeITJO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 05:14:58 -0400
Received: by mail-it0-f67.google.com with SMTP id h1-v6so10576507itj.4;
        Wed, 19 Sep 2018 20:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UJ8HjVOg78kqyhqVw16Z004D0fCpnpV2Mp/IBTy+DIc=;
        b=utEETBgHpGB+JJ8sr3TdFNNuiAovuE9yxiRUNkSdqIhC3tv4T2J8JT2lXCvHSMjckI
         hIUV8i/0pIpyFmXhMfISK2bnnK5ZNmnKu0nnRdsHzMvXMaUyUALcp6/5MdvN+56qGv+w
         Vrtp0f4I2i0VGtHlzSP+0d9v3odmQlI3dFfYzu5GKtXeT2GLMv8ChBERiSs0/bSX2FtF
         CoZBcIoqmiNrhmrmvGIFSWhMbTrWJSrrsfM5ch4GtGBxjS7XfI07KyVR4/dA7vQpToL3
         oi6qqu36ttQivvwm1nUTEIMupVyvI+PJiZXYHfkTFf1NKHjhCgFYqED2dyHqDePOm4bw
         9alg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UJ8HjVOg78kqyhqVw16Z004D0fCpnpV2Mp/IBTy+DIc=;
        b=YGXleLlP1sNCXnND1WNznyBMQ4rp/xu54MraLHLf0maM3F9UMgUQhkpPRsfYY/jiRH
         w6HvltIA6qUtvGpWMlwTeuqjKMIV1XnpPHXLlVeefw9eZ62jIqYDPJO3R93QpGtVU/cX
         J3lS7jCjPXHEDRQAIQY6w8N5v52akdSaeOSAC9eiR1dfkB13nEBYrK6J+D5dlM9jrCMQ
         NFc0uA1Zbx/n/COqN7oop7Xjxm2YwJ0nm/ffZw9KWRJqMvkxMDtzjQDYZqTbOdyXjkJn
         kN/q47wSYrvC3r2mZgoWCNh+1NK+KtSPsd2aAMk2CZke0cwAwyXqoUn1E9dR7SmL2ZB8
         STog==
X-Gm-Message-State: APzg51DWcwxDmo+aGLdHXTy9OaZCf7idL/Uu8xXFZ6Q3G+gV6rEZgUnp
        5r80Z694hAd7ez5Oda8UQ21BUv3WdRfYahc4q88=
X-Google-Smtp-Source: ANB0VdZo6wbtXCfMesKhsPy7r4U/RPelBfzFTf28R2CfWUTESfFCr7XGIWi7bqKx4GYL9X/7DA+YVCpl/JusAuyDobU=
X-Received: by 2002:a24:8e42:: with SMTP id h63-v6mr641497ite.17.1537414426793;
 Wed, 19 Sep 2018 20:33:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180918065411.30625-1-colin.king@canonical.com>
In-Reply-To: <20180918065411.30625-1-colin.king@canonical.com>
From:   Peter Chen <hzpeterchen@gmail.com>
Date:   Thu, 20 Sep 2018 11:33:35 +0800
Message-ID: <CAL411-pJT8AkmFpS__X9=JOd971-uxBUHVEUbnqBhe19SqXmYw@mail.gmail.com>
Subject: Re: [PATCH] usb: phy: mxs: fix spelling mistake "stardard" -> "standard"
To:     colin.king@canonical.com
Cc:     balbi@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 2:55 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Trivial fix to spelling mistake in dev_dbg message
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/usb/phy/phy-mxs-usb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
> index e5aa24c1e4fd..1b1bb0ad40c3 100644
> --- a/drivers/usb/phy/phy-mxs-usb.c
> +++ b/drivers/usb/phy/phy-mxs-usb.c
> @@ -563,7 +563,7 @@ static enum usb_charger_type mxs_charger_primary_detection(struct mxs_phy *x)
>         regmap_read(regmap, ANADIG_USB1_CHRG_DET_STAT, &val);
>         if (!(val & ANADIG_USB1_CHRG_DET_STAT_CHRG_DETECTED)) {
>                 chgr_type = SDP_TYPE;
> -               dev_dbg(x->phy.dev, "It is a stardard downstream port\n");
> +               dev_dbg(x->phy.dev, "It is a standard downstream port\n");
>         }
>
>         /* Disable charger detector */
> --
> 2.17.1
>

Acked-by: Peter Chen <peter.chen@nxp.com>
