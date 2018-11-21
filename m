Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E170C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 05:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198FD2146D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 05:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j///fBuq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 198FD2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbeKUPjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 10:39:23 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41384 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeKUPjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 10:39:23 -0500
Received: by mail-ed1-f66.google.com with SMTP id z28so3808551edi.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 21:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JZ1k8k0effVcK2h5mrwQpghGNI41Urk+FZjlZ/wFtYg=;
        b=j///fBuqtGOPx7YbJwAJ8TGP8FSvQ7ZxroFueMgXgqbl6w+izk1OpdpcdHUnCI0BFk
         j5WTlaoNerxJGDNUmw+piD3Su24zlQoZp/EbJsNxHYG+QbZ+WPhOFwcQyfPsLwYr+zlp
         rUNeF1tafVccWX+IF2aC0pnSSCREn7/pjwqSSCN1Yu8PkhDcbo7f7AgJmq0am1vAHSqS
         YBdCUQY6e/MoPsmfF2VZSSLxIhEjJ2zQVQBcR6BF6Kstpg8X3Hs8R5sDN4Ysafb71HAr
         4MrUlx9N1lMNpIdD409ldloVg+kSYsdVVWsHPWyZWmzGPQGoOmPypX33vK6YJpZLSTFy
         XQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JZ1k8k0effVcK2h5mrwQpghGNI41Urk+FZjlZ/wFtYg=;
        b=WaMhFtFKXOt+wOvsyM1xO3oOUCEs/AZQ95O7XgUFSlmYIClEowLkNKjJqNU/UJePMU
         qkZPzPa2yp7Yv3HBq9pXgHllf5Mm9H0ekXnsPN2bd49cpP7rgxUB1CFA2WZOplTQv0Kg
         1jB+iEw4rUgM2mrjq+R2AzH5lBl5Z0ar8i1jo1Gxi+UhM/LOo0PSOaTI8g5ivcPqnfDm
         Anr091+doDScC7UkqZTPiwGTsOnFziMfqD/IeG4hDSAqyi7ti9JlSOq+mNI2+OY9FXLr
         ckw6p2mOczeP+54P351izKtmKJb8PcyqIY7JnOvetlbad/tvg3Hx1dIcVlxZAEIq1b0Z
         9eTQ==
X-Gm-Message-State: AA+aEWa6ieXPOWUVh+GpATFIVQEwA9VSiU225kW9uHDN60OaZY++f87O
        1JpUqtIr2vp9nIa3O95LQWqXiJZ7/pOg1vNKCXo=
X-Google-Smtp-Source: AFSGD/XoPG5/+9Sfuow6ZIrDrCimwRfOA0UeUnWBjTC3+3bX8uLIqXECK1YA3BQPGFBmlWnOZCDAA5s9ZDvkg8npTx0=
X-Received: by 2002:a17:906:4e82:: with SMTP id v2-v6mr881777eju.149.1542776789695;
 Tue, 20 Nov 2018 21:06:29 -0800 (PST)
MIME-Version: 1.0
References: <20181112055515.20341-1-anup@brainfault.org>
In-Reply-To: <20181112055515.20341-1-anup@brainfault.org>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Wed, 21 Nov 2018 13:06:18 +0800
Message-ID: <CAEUhbmWskEtQR-kAuAYx=SHOJ4-MrCRUchSQ68WwZ62hxsTQyQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Build flat and compressed kernel images
To:     Anup Patel <anup@brainfault.org>
Cc:     palmer@sifive.com, aou@eecs.berkeley.edu, hch@infradead.org,
        atish.patra@wdc.com, linux-riscv@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 1:55 PM Anup Patel <anup@brainfault.org> wrote:
>
> This patch extends Linux RISC-V build system to build and install:
> Image - Flat uncompressed kernel image
> Image.gz - Flat and GZip compressed kernel image
>
> Quiet a few bootloaders (such as Uboot, UEFI, etc) are capable of

nits: U-Boot

> booting flat and compressed kernel images. In case of Uboot, booting

nits: U-Boot

> Image or Image.gz is achieved using bootm command.
>
> The flat and uncompressed kernel image (i.e. Image) is very useful
> in pre-silicon developent and testing because we can create back-door
> HEX files for RAM on FPGAs from Image.
>
> Signed-off-by: Anup Patel <anup@brainfault.org>
> ---
>  arch/riscv/Makefile             | 15 ++++++++-
>  arch/riscv/boot/.gitignore      |  2 ++
>  arch/riscv/boot/Makefile        | 33 ++++++++++++++++++
>  arch/riscv/boot/install.sh      | 60 +++++++++++++++++++++++++++++++++
>  arch/riscv/kernel/head.S        | 10 ++++++
>  arch/riscv/kernel/vmlinux.lds.S |  2 +-
>  6 files changed, 120 insertions(+), 2 deletions(-)
>  create mode 100644 arch/riscv/boot/.gitignore
>  create mode 100644 arch/riscv/boot/Makefile
>  create mode 100644 arch/riscv/boot/install.sh
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>

Tested with U-Boot s-mode on QEMU virt, using bootm to boot the kernel
Tested-by: Bin Meng <bmeng.cn@gmail.com>

Regards,
Bin
