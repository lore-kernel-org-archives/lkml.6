Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A3CC67871
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 18:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A68F206B2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 18:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivv/0a2c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A68F206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeJGBqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 21:46:06 -0400
Received: from mail-it1-f177.google.com ([209.85.166.177]:40428 "EHLO
        mail-it1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbeJGBqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 21:46:06 -0400
Received: by mail-it1-f177.google.com with SMTP id i191-v6so7056689iti.5;
        Sat, 06 Oct 2018 11:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LhGcYQifUFhab0dWrZFati4U00BqsJHJdLqOzhALdzY=;
        b=ivv/0a2cENfb9jgZPGFPyNaAMKyEyzAi2rNlDLAk/VCi1eVATJUWbLViXK2jl0o5w4
         OX6HKoaPntV4M6jeX3Ae49qWu0GILpQYsUvOhlBBFinzCva+sqKjNa75OF8Tv5carUYS
         ckzyWZQdF97B+pb1Q0pSPgpdAnzzNna/0Bvp1KU6eH5eqt2AstnbTr2IOJgX2uDwjPgM
         njlIsrpxkd4EEx8h977XsePyEbvKFsE88/2z0Ym8U/8XMYoof2QKL5S4hZT4oR70kHcq
         enoXyHyqKIvSQ+Nodahtn/BVFUeiiLp5rrToT+vXfRKRsCU/2OTYk3bbm+XllwG4nRKk
         MWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LhGcYQifUFhab0dWrZFati4U00BqsJHJdLqOzhALdzY=;
        b=jylSPKou8ZDJJxknA4oO0LIFqHu/Ym72mnovXX67cVxqDB7A6pnvXDucu/48wRMSJC
         HQFjBpdUJJWiFgEWhWbVIvyar4HOQinHKFr2zHLYAQu3OaJvBcV3gHwPwXJBD69ujU+0
         MiCMbGOfHzdLSI/p2XAKmCxAgUw/r/UBMbCaziOIQ4tgT6QJScC8P9WwKC/c9GBpoM91
         NItBKZpJAefx/vile5vntNFYBvPG9HRFqRBmur80CkdaViQz6pGWbx/r+xL8ZAtXX5FP
         HBLleJofnpAY0nlKoGijY/SAmZJEtPq8MBitsKFwsee9Frf9yvI4fPwDDxDyj4iCGZum
         L8iQ==
X-Gm-Message-State: ABuFfogNyzRmJ2I32Uyt0Ud2HMOyjImd2fTYQX7sdARIchdbGRNAJes7
        XiNIQ4zF+QZLjtH7IFhCcZswWNO9kfJB/xo6buc=
X-Google-Smtp-Source: ACcGV62qEx3zb2LND6BbarRn8XP+SoH30IpFr5RPNaND4PovzugN6thmNsYAB95+oMVivKxYe82r9fYjs0lvDG9sKLc=
X-Received: by 2002:a24:ddd4:: with SMTP id t203-v6mr11998634itf.128.1538851303917;
 Sat, 06 Oct 2018 11:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180911161527.GA30689@vnote> <20180912083844.iegei2kobcz4b7ag@ws.net.home>
 <6d349d22d37041c1a2942d8ed4c76b69@AcuMS.aculab.com> <CAJC2YLaug4=7otnRC7x+UdDp=5ErgJFHFL_7mjRO7sdM2CrUfQ@mail.gmail.com>
 <2db38b2d1af34ab9b653c665d08872f1@AcuMS.aculab.com> <20180914110703.ishvqwcpcf5ozihy@ws.net.home>
In-Reply-To: <20180914110703.ishvqwcpcf5ozihy@ws.net.home>
From:   Eugene Korenevsky <ekorenevsky@gmail.com>
Date:   Sat, 6 Oct 2018 21:41:27 +0300
Message-ID: <CAJC2YLYqb6WB43P5pJe=D7GXgUY16PS=QLVJbD8=qEH=aB9qvg@mail.gmail.com>
Subject: Re: [PATCH v2] efi: take size of partition entry from GPT header
To:     kzak@redhat.com
Cc:     David.Laight@aculab.com, Davidlohr Bueso <dave@stgolabs.net>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> is_gpt_valid() already contains
>         pt_size = (u64)le32_to_cpu((*gpt)->num_partition_entries) *
>                 le32_to_cpu((*gpt)->sizeof_partition_entry);
>         if (pt_size > KMALLOC_MAX_SIZE)
>                 pr_debug("GUID Partition Table is too large: %llu > %lu bytes\n",
>                 (unsigned long long)pt_size, KMALLOC_MAX_SIZE);
>                 goto fail;
>         }
> I guess it good enough for sanity check.
>
> If you want to be really paranoid than you can also check that array
> is possible to store to the expected area on the disk:
>
>     pt_size <= (gpt->first_usable_lba - gpt->partition_entry_lba)
>

Well, we should apply several checks for different cases:
- primary GPT: table entries should not override gpt->first_usable_lba
- alternate GPT, table entries BEFORE agpt (agpt->partition_entry_lba
< agpt_lba): table entries should not override agpt_lba AND
agpt->partition_entry_lba MUST BE more than agpt->last_usable_lba
- alternate GPT, table entries AFTER agpt (agpt->partition_entry_lba >
agpt_lba): table entries should not override the end of the disk

Is this correct?

--
Eugene
