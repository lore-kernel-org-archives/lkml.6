Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2E0C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF7421532
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IxChfuza"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF7421532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbeHWOYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 10:24:55 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:35545 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbeHWOYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 10:24:55 -0400
Received: by mail-it0-f66.google.com with SMTP id 139-v6so7005956itf.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 03:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bZ391DwX32XAw9D2daFZnzUsC+7XIXLi0z21PFX1Ywc=;
        b=IxChfuzahKLgxOVUDQ7MoabOB0k4bOYvbVTupr2878ykxI9miu8xgCcm0j0D4kF9xW
         qup1eOCQnSfVfk2hRxrXQ9I6heyhbI7YiM9SU0jwW9Hu3FsyrBzljMHR+PMyRpodr2at
         Lsrf0V/6yFg4krAD/l4oSshmfM9z2wna26so8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bZ391DwX32XAw9D2daFZnzUsC+7XIXLi0z21PFX1Ywc=;
        b=sWvGo1pXOO1Muxf1yOSbch7XhoaY/sUtQmy8mDyDX6i+9e4z5lPqQJtI3H0WzEGdBz
         PSsw0wnBCKdOdgVNUIvaxm+BwJyGV24J2XPmktQgnx5R/delFdTY2xheWGF2bsQ76Cau
         vlAcKPlWy5L8tLHFttqhqWh5nzw7bkbaD6Th+4i2/nj9PCDa4z3tfaRFYwjB0bPRBDVu
         zT6lO3+jwwfSBzszalf2ni1gz+lwYvF1m5ekwCrxdaNiEY4HnCRcWQQ04W0DpG5CIZ4D
         ubK5tBzk6Pn3W0lBeyWAxf0+VZjnvt09GCB8llCU9WUYq4X+Ivc+gN2QZvT3EJyRP+C6
         6lyQ==
X-Gm-Message-State: AOUpUlFImBvCkM/TnRSgmPyUhAycX30UVikxQHJGYP35EsCrgr2v0HG3
        gDKWoPqmGeQKqBD6DNbiDtlchpckLWaCnMtZf7A3TA==
X-Google-Smtp-Source: AA+uWPz1mBMgtVhroWoT1DKLhk+ZWI01k934WgqzPWyPQfM8TFx+icNGLAZlPjujYW9yRqfUqDWWsyh5rqG9PntyZFY=
X-Received: by 2002:a02:5916:: with SMTP id p22-v6mr49505964jab.113.1535021746055;
 Thu, 23 Aug 2018 03:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180821105407.2318-1-colin.king@canonical.com>
In-Reply-To: <20180821105407.2318-1-colin.king@canonical.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Aug 2018 12:55:34 +0200
Message-ID: <CACRpkdZDpfPDOgXy8+58qSmMu=bMsMrtruoDeLzPe+t1eYpqCA@mail.gmail.com>
Subject: Re: [PATCH] drm/pl111: add in missing sentinel to a of_device_id array
To:     Colin King <colin.king@canonical.com>
Cc:     Eric Anholt <eric@anholt.net>, Dave Airlie <airlied@linux.ie>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        kernel-janitors@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 12:54 PM Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Array vexpress_muxfpga_match is missing an end of array sentinel,
> add it.
>
> Detected by Coccinelle: ("vexpress_muxfpga_match is not NULL
> terminated at line")
>
> Fixes: ca454bd42dc2 ("drm/pl111: Support the Versatile Express")
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
