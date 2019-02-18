Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8E2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD4D2184E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbfBRIlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:41:11 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:46918 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbfBRIlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 03:41:10 -0500
Received: by mail-ed1-f44.google.com with SMTP id f2so13064132edy.13;
        Mon, 18 Feb 2019 00:41:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rrvN2fxzNsgbOib5GzTyYbcbZZj2FKN9mxwLPe1rUjM=;
        b=a7tRMwd1L407q9j90V9vCfuFcIqP7BQtXJcgwCDEHJ8HgxS/14Y8nAbHHfNNKx+PGk
         RdrSmO7dU4nTi7m8LZAwiW78N3GyqaIsdN6PCiWkLBOVhrm95/Y2GuMS671ghdnnb5f1
         4ynvRmXJHrq/60xXc+fKk6U2UvYu2BVg6irs3WM2pMNYXhvBz8XU9xLox+5lI6sskUCo
         z6JFGQZ9z8q6lWuJ9iva9juEPwSiGTxs3qTtzu6OSsdOtP8GsXuGVZOS97aN0TB9V7O4
         20Cv/9v33mXiHlBAhfmdl7PthyX5hPl+y6LaaqLTTdGz1vZlA7zdajyDOMIndGgFdr3O
         lc/g==
X-Gm-Message-State: AHQUAuY2mzJoYwspEoyVuZGVWQryt4hVO4GZi9h/bBvIA3wPKKIXy992
        cs894vLWAKvUM1LejLag88P0jeNPYFw=
X-Google-Smtp-Source: AHgI3IZQNv8WIMm4XKHpMQbBYS3DJzMwjCQYVJup3LM+Mhv9fvARkla6HVB/nGd8Q1aGq6vH+R5U4g==
X-Received: by 2002:aa7:d41a:: with SMTP id z26mr18107826edq.224.1550479268543;
        Mon, 18 Feb 2019 00:41:08 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id x2sm2420157eji.15.2019.02.18.00.41.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 00:41:08 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id a62so16445684wmh.4;
        Mon, 18 Feb 2019 00:41:08 -0800 (PST)
X-Received: by 2002:a1c:20d0:: with SMTP id g199mr14996721wmg.111.1550479267635;
 Mon, 18 Feb 2019 00:41:07 -0800 (PST)
MIME-Version: 1.0
References: <20190215094554.28593-1-colin.king@canonical.com>
In-Reply-To: <20190215094554.28593-1-colin.king@canonical.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 18 Feb 2019 16:40:57 +0800
X-Gmail-Original-Message-ID: <CAGb2v65JsDOMoUy8E1NbM8ccob7B110hZLbO18+3oS-i6m9w+A@mail.gmail.com>
Message-ID: <CAGb2v65JsDOMoUy8E1NbM8ccob7B110hZLbO18+3oS-i6m9w+A@mail.gmail.com>
Subject: Re: [PATCH][V3] regulator: axp20x: remove a redundant null check on rdev
To:     Colin King <colin.king@canonical.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 5:46 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently rdev is dereferenced when assigning desc before rdev is null
> checked, this is leading to static analysis warnings.  However, rdev
> can never be null, so the null check is redundant and can be removed.
>
> Detected by CoverityScan, CID#1476031 ("Dereference before null check")
>
> Fixes: 77e3e3b165db ("regulator: axp20x: add software based soft_start for AXP209 LDO3")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
