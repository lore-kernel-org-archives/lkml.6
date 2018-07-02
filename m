Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E3DC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E2025469
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yr21O3IE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E2025469
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752528AbeGBOiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:38:01 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53996 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752466AbeGBOh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:37:59 -0400
Received: by mail-it0-f66.google.com with SMTP id a195-v6so12439911itd.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 07:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oWrrzbnulZgcXiAbWCM/JReVABwn/1QfjidFuSOBh7A=;
        b=Yr21O3IEeBk7kPF4aw7OV2eWwPkiHQVvKjTOpRkepp6FWhWIecjk+qcFVvBOA2uarr
         +Kax9HItU22dkTSJBN6aOKEJ00vbasDVjUpZRUnM8HH/9r77tBJWETp1YbezYSJqCW7j
         wOteTdw9jagD2nrrtJn6iGZpO4A+2LT/h59RM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oWrrzbnulZgcXiAbWCM/JReVABwn/1QfjidFuSOBh7A=;
        b=FHFQN/2pHRwhbph6qCcJgRFSFF7NnuUC54LtLFkswCWjEsKwC9YL8f/MsHpFJST0y6
         xM2pT1wjrEGLcyuV+6hTVsRgbcqIwyLGyN57cYawOiZ4XOpGL+hnGXohRLneiQdaGZJt
         /3OvrLdoQBGPU/LAgf9ePtycKDxpmx8nR5+7hkbdAwQRQ+B5F1QiHeJnSZ+68TFsI+6N
         CMMoFqbmOzSKbaTTXw5FIuBMpxmA4TbSvbK5giRrvG/T1CfB0iw21Ha1WnDsRkh8R1UE
         7iT/alT0hS1GHNk5g69otxs9Ol+JGuc84Uy+7QG+EysrrniP/4xyfUi5B85TrVNFYlGF
         2LQw==
X-Gm-Message-State: APt69E2bVZe2ylWNVriM1zszRD7gBy0K9X1dwKHWoHF1r/y9PUeAipH2
        0GiJP5DjYp7YOmb0YPPx0nRU5QqkMc+U55UvRwrJDQ==
X-Google-Smtp-Source: AAOMgpdrdFHG84louxCs0Eah+/SINuESX/AAUlFvEKdhhHkDinQox4/MWA54J4ZtNjneZXjQdxnuYKKuh4gD6lAHfZM=
X-Received: by 2002:a24:69cb:: with SMTP id e194-v6mr10861617itc.102.1530542279283;
 Mon, 02 Jul 2018 07:37:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 07:37:58 -0700 (PDT)
In-Reply-To: <CAMuHMdU709R3woOAvw7EH4=zGiBtezg0YeEer-4wG7pqo2SZBg@mail.gmail.com>
References: <1528310612-10158-1-git-send-email-clabbe@baylibre.com>
 <CAPDyKFoRUhwHk6=j0-scQa4W+nbnS_qXZbPUn0eTFm_3kqdwPQ@mail.gmail.com> <CAMuHMdU709R3woOAvw7EH4=zGiBtezg0YeEer-4wG7pqo2SZBg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 2 Jul 2018 16:37:58 +0200
Message-ID: <CAPDyKFrZYixkv7Exjt-L18sNX5sVcOLq_uFVxJmUwdU4Q6kavg@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc should depend on COMMON_CLK
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 July 2018 at 15:32, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Ulf,
>
> On Mon, Jul 2, 2018 at 3:18 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 6 June 2018 at 20:43, Corentin Labbe <clabbe@baylibre.com> wrote:
>> > This patch fix the following build failure on m68k:
>> > ERROR: "clk_set_rate" [drivers/mmc/host/dw_mmc.ko] undefined!
>> >
>> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
>>
>> Thanks, applied for next!
>
> Please drop this patch, I posted proper fixes for this general issue in series
> "[PATCH 0/3] Legacy clock drivers: Normalize clk API"
> (https://lkml.org/lkml/2018/6/11/122).
>
> All fixes above are already in next-20180702.
> Thanks!

Thanks for letting me know, patch dropped!

I had the feeling there was a better way. :-)

[...]

Kind regards
Uffe
