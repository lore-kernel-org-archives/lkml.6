Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A14ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A5DF214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuWWrGCa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A5DF214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbeIQSdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:33:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:45752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbeIQSdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:33:22 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 572D3214DC;
        Mon, 17 Sep 2018 13:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537189566;
        bh=2XE7hTzF8swV2opiVZ+OIWHolQ0DYTOhbnXZzEY1kJo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TuWWrGCaM6sgKQ0kZg+JlTn3G4MzgU6wX7FAQVfSh9MsKkJUPE2W/EWbDJ/m6Lu1V
         xW+tzJ6AFyTc7G5fs5I7Vtuv8aPZ0dCN8HEDGqdbxz6WMAQ/OXkkVGN/H0I8Da7iBA
         i2s+5vfQ488x0ke5MvR4ivwGKl/PQB4YwRXY16/4=
Received: by mail-wm1-f44.google.com with SMTP id j25-v6so4663447wmc.1;
        Mon, 17 Sep 2018 06:06:06 -0700 (PDT)
X-Gm-Message-State: APzg51D+fu89n0fZJKLeiDGwU1EWdxdS0rBhbnebs4amMXc0j7i7ENVk
        LX71EBEghEXKE3JKr/WKtKt1UFjCZbX2vW0l6S4=
X-Google-Smtp-Source: ANB0VdaqR5U9vDQXEhdURW8ZXmhzGc0Fti14oZqIMRSmYrHJ3E8128jXYq0dI5aQ1LORkXYBl0ADlH5SrjofTXoJTPk=
X-Received: by 2002:a1c:7f93:: with SMTP id a141-v6mr11649828wmd.45.1537189564702;
 Mon, 17 Sep 2018 06:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20180913075858eucas1p1f528fd0776c32f1c10a3e46f8f2bacd0@eucas1p1.samsung.com>
 <1536825522-6027-1-git-send-email-c.manszewski@samsung.com> <20180913075858eucas1p1f528fd0776c32f1c10a3e46f8f2bacd0~T5q9BZO-j1335913359eucas1p1w@eucas1p1.samsung.com>
In-Reply-To: <20180913075858eucas1p1f528fd0776c32f1c10a3e46f8f2bacd0~T5q9BZO-j1335913359eucas1p1w@eucas1p1.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 17 Sep 2018 15:05:53 +0200
X-Gmail-Original-Message-ID: <CAJKOXPf8OFMY9BbjcYorbbX7_5u4MFg4fj72O3Wio5hb+n9J3Q@mail.gmail.com>
Message-ID: <CAJKOXPf8OFMY9BbjcYorbbX7_5u4MFg4fj72O3Wio5hb+n9J3Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] crypto: s5p-sss: Fix whitespace issues
To:     c.manszewski@samsung.com
Cc:     linux-crypto@vger.kernel.org, vz@mleia.com,
        k.konieczny@partner.samsung.com, herbert@gondor.apana.org.au,
        davem@davemloft.net,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Sep 2018 at 09:59, Christoph Manszewski
<c.manszewski@samsung.com> wrote:
>
> Fix two whitespace issues that occurred at line breakup.

The s5p_set_outdata_start() does not have issue - just new line is not
aligned. The other also is not a issue of whitespace (e.g. mixed
spaces and tabs) but alignment.
So how about:
"Fix misalignment of continued argument list."?

With commit and subject improvements:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

>
> Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
> ---
>  drivers/crypto/s5p-sss.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/crypto/s5p-sss.c b/drivers/crypto/s5p-sss.c
> index 0cf3f12d8f74..ce9bd13ea166 100644
> --- a/drivers/crypto/s5p-sss.c
> +++ b/drivers/crypto/s5p-sss.c
> @@ -491,7 +491,7 @@ static void s5p_unset_indata(struct s5p_aes_dev *dev)
>  }
>
>  static int s5p_make_sg_cpy(struct s5p_aes_dev *dev, struct scatterlist *src,
> -                           struct scatterlist **dst)
> +                          struct scatterlist **dst)
>  {
>         void *pages;
>         int len;
> @@ -1890,7 +1890,7 @@ static int s5p_set_indata_start(struct s5p_aes_dev *dev,
>  }
>
>  static int s5p_set_outdata_start(struct s5p_aes_dev *dev,
> -                               struct ablkcipher_request *req)
> +                                struct ablkcipher_request *req)
>  {
>         struct scatterlist *sg;
>         int err;
> --
> 2.7.4
>
