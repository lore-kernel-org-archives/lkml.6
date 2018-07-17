Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AC3ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 03:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A31320BED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 03:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ok4Pi5nu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AZ5H4xrX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A31320BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbeGQE1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 00:27:25 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:40875 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbeGQE1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 00:27:25 -0400
Received: by mail-yb0-f195.google.com with SMTP id y11-v6so16295255ybm.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 20:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=gmh5bXsFrHKLy7iNW75AOlO+7QSQS0tyNvTCb+rsQfU=;
        b=ok4Pi5nuOTC2DvQzOsEEzLo0oNZLOR1v4aSX1KBwNtlZZ/UlnBLJ6vcDL/R8rNJQdw
         g+LwDZGlpaGOFdiE4kgrf90Fp86NOkahFUfX5PYhl/VERatzj1bvmqco2/mFATDJ3Fjs
         /xP/GxGQE6BL7dkCInCY28tymmq6ze49owv5ESBc2I+RZSS1zB9NghHnBeRJFb9TJ94V
         bYI3Pw5DKv40fQLTcWK2hwHW2E0fZduZ+x5gA4OD+2ipOcmIqzt+ZAgI1yAVyIg5OOy1
         yB0mGaH+FrSF6fvLexUWkirfcAFgtD9b3NVzSH5os9iD74gJHMRK/Nl99TI1rQ1S3BL3
         w/fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=gmh5bXsFrHKLy7iNW75AOlO+7QSQS0tyNvTCb+rsQfU=;
        b=AZ5H4xrXq4Bx04IxNGKc7TActproqqGO9hcP+BVwNTzox12VLoHAnzBQu7ddCUYbB4
         aC6WmmcIo03oD21/hZlL9ajk2NV0J60NUbJIy4jbXpifDdq/7k1iucGlKdatlPSkXQ3S
         zAbWmcBLhc1l1W3QyxoH3hCUjr5fZWpGIfx5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=gmh5bXsFrHKLy7iNW75AOlO+7QSQS0tyNvTCb+rsQfU=;
        b=lSm9g3T8MB4vxgpjJY8kq4mjCZPS+OCd8LpbWZx0lqg/zeccD7rO4KfD93Qx8b4v75
         OYjq0QEPguQ0xeCVAxojXmaRL1sAINpD0cq8oQtiTMHtpBx3REYyXAp0athtP9BP3YQx
         nA7jK6sqq+TqbXwrOoqdnCkr+WeLTdOUx3CqFtytFpWRqE7SZtL9NJRSGm7hvQSBEWwZ
         pS1P0znoTeL1KwvlJk2wvBIFhmLwncBkqhoYmH9b2zozhT4+bSN5vWQjWoDCp6cMoFBr
         0rY7tRMwtpLUUSs/q15qtnwDmjr0wpP8Qpkhbt/N9MP3ljX08GJTceU+7joU25Ok9y4Y
         /uzQ==
X-Gm-Message-State: AOUpUlERGSDAYYUJcmkfzUdlik/kydXhtogBKjkC7LoE/dkju0c0VaV+
        SOhlyOXDq0l1cA0f5bSgcQMlMiWyDI+s5IVjKWMQhA==
X-Google-Smtp-Source: AAOMgpe4oRUlo9xkeZkD6NhQGJ7WOD3C8EkPO4KS7WAXy3BYdpT/zNQIKA9CD/6mS6CykKmpMbi6GlZfQpKxXDE1sLo=
X-Received: by 2002:a25:afce:: with SMTP id d14-v6mr9545199ybj.343.1531799815524;
 Mon, 16 Jul 2018 20:56:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 20:56:54
 -0700 (PDT)
In-Reply-To: <20180629185254.GA37557@beast>
References: <20180629185254.GA37557@beast>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 16 Jul 2018 20:56:54 -0700
X-Google-Sender-Auth: qVeGM6o_26irSimAOsZw12_W9BU
Message-ID: <CAGXu5jKV-YAQZtN2heFdmiD9EOZ-AqrBc-NjC8fRYLSafovuyQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/msi: Remove VLA usage
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Rob Herring <robh@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 11:52 AM, Kees Cook <keescook@chromium.org> wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> switches from an unchanging variable to a constant expression to eliminate
> the VLA generation.
>
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Friendly ping! Michael, can you take this?

-Kees


> ---
>  arch/powerpc/sysdev/msi_bitmap.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/arch/powerpc/sysdev/msi_bitmap.c b/arch/powerpc/sysdev/msi_bitmap.c
> index 6243a7e537d0..e64a411d1a00 100644
> --- a/arch/powerpc/sysdev/msi_bitmap.c
> +++ b/arch/powerpc/sysdev/msi_bitmap.c
> @@ -225,22 +225,23 @@ static void __init test_of_node(void)
>         struct device_node of_node;
>         struct property prop;
>         struct msi_bitmap bmp;
> -       int size = 256;
> -       DECLARE_BITMAP(expected, size);
> +#define SIZE_EXPECTED 256
> +       DECLARE_BITMAP(expected, SIZE_EXPECTED);
>
>         /* There should really be a struct device_node allocator */
>         memset(&of_node, 0, sizeof(of_node));
>         of_node_init(&of_node);
>         of_node.full_name = node_name;
>
> -       WARN_ON(msi_bitmap_alloc(&bmp, size, &of_node));
> +       WARN_ON(msi_bitmap_alloc(&bmp, SIZE_EXPECTED, &of_node));
>
>         /* No msi-available-ranges, so expect > 0 */
>         WARN_ON(msi_bitmap_reserve_dt_hwirqs(&bmp) <= 0);
>
>         /* Should all still be free */
> -       WARN_ON(bitmap_find_free_region(bmp.bitmap, size, get_count_order(size)));
> -       bitmap_release_region(bmp.bitmap, 0, get_count_order(size));
> +       WARN_ON(bitmap_find_free_region(bmp.bitmap, SIZE_EXPECTED,
> +                                       get_count_order(SIZE_EXPECTED)));
> +       bitmap_release_region(bmp.bitmap, 0, get_count_order(SIZE_EXPECTED));
>
>         /* Now create a fake msi-available-ranges property */
>
> @@ -256,8 +257,8 @@ static void __init test_of_node(void)
>         WARN_ON(msi_bitmap_reserve_dt_hwirqs(&bmp));
>
>         /* Check we got the expected result */
> -       WARN_ON(bitmap_parselist(expected_str, expected, size));
> -       WARN_ON(!bitmap_equal(expected, bmp.bitmap, size));
> +       WARN_ON(bitmap_parselist(expected_str, expected, SIZE_EXPECTED));
> +       WARN_ON(!bitmap_equal(expected, bmp.bitmap, SIZE_EXPECTED));
>
>         msi_bitmap_free(&bmp);
>         kfree(bmp.bitmap);
> --
> 2.17.1
>
>
> --
> Kees Cook
> Pixel Security



-- 
Kees Cook
Pixel Security
