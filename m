Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EEA13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D5F520892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="itvvkVX4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D5F520892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbeG3NI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 09:08:58 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39303 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbeG3NI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 09:08:58 -0400
Received: by mail-oi0-f66.google.com with SMTP id d189-v6so20549380oib.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 04:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nWShXJmGmXSlTLqNmjGYfc5vkz4s0/MZQiJBE64CPfE=;
        b=itvvkVX4jZPEKblkGtnmU20jj6nXebIVRW3uHQdLaaqTnlvB821FdsbL7hTj8uxfNt
         XE9vCWz82O4P1K0Gi8kOk9m+EHygrbnxuDCemyJsSCFGUUWxQUbGDktELr0DcY0gCb/0
         q2+YXjZ+ILG497p7qrn2yV18ADcYq16lm94+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nWShXJmGmXSlTLqNmjGYfc5vkz4s0/MZQiJBE64CPfE=;
        b=DS2VwRAV6p+sxzkHRNc/b1SJho6TkyJJxWaMFuFDxyiB44UTk83GpMYmThZQXLCOZR
         jAw71zphO5IEogJQL5hIgsrsEDS7nVB4MUWbl4YIJvV2lyJtzWzaeck4PCF3fAyMH1xk
         mfjxka170sQqY4EX2k1Ziwr5u+UykO0UWpoSOwZVHJvYcctsl62kcuKweD00gwY+svjF
         Y0q8yh4jrcOgHmMxi3588shyTOXncfkbPJty7JAvaTsGYmdmehYQ+bjeHr6XwXszCppd
         gzN4BuRfoAq05q7u+rXQBdPYwm959E7huqTftoyhnd2v+zUlPluUYBNRbPTgsITaobIc
         YChA==
X-Gm-Message-State: AOUpUlGo9x+c9uJWxUjDKnlOJzLeE0WtOwnpaosa+VOfzlKWSnyinpTi
        zdBg5pFmwx2GuQDE3u898slx41lRWCymAXVhacsT1w==
X-Google-Smtp-Source: AAOMgpfA0O8eIUTKe3lp4Mh8ratWMxy10LNNKHj++XL61qEIVLqNFtAn92U89hrVlkRY1c1QSqlSFheb7A3J56CdqoQ=
X-Received: by 2002:aca:7c2:: with SMTP id 185-v6mr18125474oih.31.1532950464732;
 Mon, 30 Jul 2018 04:34:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 04:34:24
 -0700 (PDT)
In-Reply-To: <782fc498b4f4c6e8130d64face93023eb3dc9866.1530152980.git.baolin.wang@linaro.org>
References: <782fc498b4f4c6e8130d64face93023eb3dc9866.1530152980.git.baolin.wang@linaro.org>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 30 Jul 2018 19:34:24 +0800
Message-ID: <CAMz4kuKGaMh=M9=P4TkpF4w0onJZJcRaPd+twMyEpj56KNVJLA@mail.gmail.com>
Subject: Re: [PATCH] hwspinlock: Fix incorrect return pointers
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-remoteproc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 28 June 2018 at 10:32, Baolin Wang <baolin.wang@linaro.org> wrote:
> The commit 4f1acd758b08 ("hwspinlock: Add devm_xxx() APIs to request/free
> hwlock") introduces one bug, that will return one error pointer if failed
> to request one hwlock, but we expect NULL pointer on error for consumers.
> This patch will fix this issue.
>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Could you pick up this patch which fixes the incorrect return value
issue? Thanks.

> ---
>  drivers/hwspinlock/hwspinlock_core.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hwspinlock/hwspinlock_core.c b/drivers/hwspinlock/hwspinlock_core.c
> index e16d648..2bad40d 100644
> --- a/drivers/hwspinlock/hwspinlock_core.c
> +++ b/drivers/hwspinlock/hwspinlock_core.c
> @@ -877,10 +877,10 @@ struct hwspinlock *devm_hwspin_lock_request(struct device *dev)
>
>         ptr = devres_alloc(devm_hwspin_lock_release, sizeof(*ptr), GFP_KERNEL);
>         if (!ptr)
> -               return ERR_PTR(-ENOMEM);
> +               return NULL;
>
>         hwlock = hwspin_lock_request();
> -       if (!IS_ERR(hwlock)) {
> +       if (hwlock) {
>                 *ptr = hwlock;
>                 devres_add(dev, ptr);
>         } else {
> @@ -913,10 +913,10 @@ struct hwspinlock *devm_hwspin_lock_request_specific(struct device *dev,
>
>         ptr = devres_alloc(devm_hwspin_lock_release, sizeof(*ptr), GFP_KERNEL);
>         if (!ptr)
> -               return ERR_PTR(-ENOMEM);
> +               return NULL;
>
>         hwlock = hwspin_lock_request_specific(id);
> -       if (!IS_ERR(hwlock)) {
> +       if (hwlock) {
>                 *ptr = hwlock;
>                 devres_add(dev, ptr);
>         } else {
> --
> 1.7.9.5
>



-- 
Baolin Wang
Best Regards
