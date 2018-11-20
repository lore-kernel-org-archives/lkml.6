Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46B2C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 947B42087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W5TKq7FX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 947B42087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbeKTXUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:20:04 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36565 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeKTXUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:20:03 -0500
Received: by mail-lj1-f193.google.com with SMTP id g11-v6so1530403ljk.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 04:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PutlsevFzKB0Xb1+ujrc6qu0Vmdkj6S5dtY8hPFM5mA=;
        b=W5TKq7FXqVu2vH82EYJQ/t03VPS+9X24ayT3j0GN38UGk2y+HIeDq7UYZ0O68+ek5g
         lsXUCfp9DgbdVgV7BC36oBswiWJ4rSvcpWgyGJtXBqC/7vopMCQrxiBZ6l+/TwBLNWoy
         qn22yvNNFhWTnD4jedQwwVCfU/a4s1b08Bw2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PutlsevFzKB0Xb1+ujrc6qu0Vmdkj6S5dtY8hPFM5mA=;
        b=WdX00W/o1+/9u8D/toRYfWNSBXnW/+hyDp7kwLpKwWeI/A1N9mEjbhX6HiT+S3K8vU
         7COY/Vuf7G26r8rMGBAeZO06iCfjeBzUe+15PiOejyNeTKRx1HysGh42F5Rx/+q4fMLI
         16KxTEcua469jhjxbol/aW/L7bR/czbn+JMQ5mVKwgQ8hmnqTSULDzuwVPB9FClvgr91
         bQCUsq6H9dyiAkeoswIUNb836Rn32F9hM3t4s2kGSQtPfYRYdWiJAseHSE2HC9BDWlpo
         +1lrcJYP9KEvNijMVMNVwuy/k2DtrLgPUoM1+wT1/QfXd9N4G7u7hNsrPhmVTUM1296r
         wT+w==
X-Gm-Message-State: AA+aEWaYKvXc/WDLj6eV/EjUEDol9lrYQIatFrK0T/fARgDMBAC3oHr+
        0dQYDAQGRo/QBcCPMAZLnt47IkO3QXyPacXjA2wQTQ==
X-Google-Smtp-Source: AFSGD/WvVCv7SPSL/dkS66Z6i6xwfb3ZU2rGeuqOm8KvcGtmZMQ8V4PJ02m+Cd/JcVqyWwI1Bn160WjxtGAaq5CZyGI=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr1141464ljj.9.1542718263381;
 Tue, 20 Nov 2018 04:51:03 -0800 (PST)
MIME-Version: 1.0
References: <20181106154022.9209-1-colin.king@canonical.com>
In-Reply-To: <20181106154022.9209-1-colin.king@canonical.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 20 Nov 2018 13:50:51 +0100
Message-ID: <CACRpkdbhQCjKJOf8FVDBrsOOTxccUnGGZP4Lz5ez_GqHyLgkJA@mail.gmail.com>
Subject: Re: [PATCH][drm-next] drm/panel: s6d16d0: fix spelling mistake
 "enble" -> "enable"
To:     Colin King <colin.king@canonical.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Dave Airlie <airlied@linux.ie>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        kernel-janitors@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 4:40 PM Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
>
> Trivial fix to spelling mistake in DRM_DEV_ERROR error message
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied.

Yours,
Linus Walleij
