Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9294AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5620A206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLNyMMWu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5620A206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391579AbeKVMU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:20:26 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39135 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388737AbeKVMU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 07:20:26 -0500
Received: by mail-ed1-f67.google.com with SMTP id b14so6399091edt.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 17:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P363Lg+jXnBBHKFhYj0vs1K5DJ4vndbvmT+bFNVwpkI=;
        b=jLNyMMWu0wB2KD1+OWMd1NlsmOFZT6wqCRpxMJSY2lsVQzeeDrJLt12PlzDX1e1Tuz
         oAW85ufjPQxu+c2EEDNHx/fTrMgzXvvqB8yG1rXcnf2nDn4q6rUQHkSQmz3s0riaXYCH
         Gn3xaSWvnXzdepqjfskXgYymawBRQ4a8SgtmNCRmH+RCmHsGwE/PcdtchTBTmVq0j1eG
         BB+JltSQHejt2DM2bMYdxOQbZYLhDtf4FUbdTFosxhuKXzErtWnE7kODdsKgeeJvq2tz
         TpxhnhOCNGYG3YvY1o93REAvswGaDKmRR++vHBssNGZJj8CqGmcjjqz3BtAE7BOlVcpT
         Accg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P363Lg+jXnBBHKFhYj0vs1K5DJ4vndbvmT+bFNVwpkI=;
        b=IO9nSUBRbi1oTxFSxQQhlZjCqOaY8iOlkYWphOBzBLSaG0brxr+XKRlno6ZAOaxzrM
         zWlqM12zpjKFo271unw+6HkaTOgZYK/Gws3aU0YRIFKE4+9m4bFeuoaNmNz67p41Xy4o
         A1/U20rmxeqKIEG6qLa8RfzmtwVqxfnV252c86flJ7AEKLu3W1AK91PFzfrAQ2vAsfFx
         GMBnEoUvuGJzmkjbraHbrgjd/na2N7IznB+eVf8Dr+Tzp8zShwy/QAgJ4u7piuSzLxyA
         ayf2ioVwV5qV0XedSViA2fithccKXtL+ToTuIa/n8jX0HpnnPitGF3Gvp5j54GMds3Qd
         RKtQ==
X-Gm-Message-State: AA+aEWbAZTHCJmsd4UbkKODTPoFFUd+VXFrSPG2rQQvXI6JLBN56BWWM
        dezadepu8MmJkFLRpWG1IaL2F+L7XSKGWpTUCwg=
X-Google-Smtp-Source: AFSGD/X88L9Kxp/o7S1/GY4bnX+y6u2KAOXfVUnoNy8fn5sajQdGDPqFT+4JUY00erTGEaFkBaQ1ZhHrR7iGE4D3Ydo=
X-Received: by 2002:a05:6402:1347:: with SMTP id y7mr7611683edw.114.1542851004266;
 Wed, 21 Nov 2018 17:43:24 -0800 (PST)
MIME-Version: 1.0
References: <CAEUhbmWskEtQR-kAuAYx=SHOJ4-MrCRUchSQ68WwZ62hxsTQyQ@mail.gmail.com>
 <mhng-7be4f47d-bc3a-4073-a6db-dc5588304d2d@palmer-si-x1c4>
In-Reply-To: <mhng-7be4f47d-bc3a-4073-a6db-dc5588304d2d@palmer-si-x1c4>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Thu, 22 Nov 2018 09:43:12 +0800
Message-ID: <CAEUhbmW08WfTQRVSAaC6SRWhZmrUTAm9b8wefuMMbg8dGeKZVA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Build flat and compressed kernel images
To:     palmer@sifive.com
Cc:     Anup Patel <anup@brainfault.org>, aou@eecs.berkeley.edu,
        hch@infradead.org, atish.patra@wdc.com,
        linux-riscv@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On Thu, Nov 22, 2018 at 12:28 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Tue, 20 Nov 2018 21:06:18 PST (-0800), bmeng.cn@gmail.com wrote:
> > On Mon, Nov 12, 2018 at 1:55 PM Anup Patel <anup@brainfault.org> wrote:
> >>
> >> This patch extends Linux RISC-V build system to build and install:
> >> Image - Flat uncompressed kernel image
> >> Image.gz - Flat and GZip compressed kernel image
> >>
> >> Quiet a few bootloaders (such as Uboot, UEFI, etc) are capable of
> >
> > nits: U-Boot
> >
> >> booting flat and compressed kernel images. In case of Uboot, booting
> >
> > nits: U-Boot
>
> Thanks for the review.  The PR has already been tagged, but it's not scheduled
> to be sent out until later today.  I generally try to avoid rewriting the tags
> unless there's something major that's wrong, so unless you feel very strongly
> about this then I think I'll let it stand.
>
> Let me know if this is a big deal for you, I can rewrite things.
>
> >> Image or Image.gz is achieved using bootm command.
> >>
> >> The flat and uncompressed kernel image (i.e. Image) is very useful
> >> in pre-silicon developent and testing because we can create back-door
> >> HEX files for RAM on FPGAs from Image.
> >>
> >> Signed-off-by: Anup Patel <anup@brainfault.org>
> >> ---
> >>  arch/riscv/Makefile             | 15 ++++++++-
> >>  arch/riscv/boot/.gitignore      |  2 ++
> >>  arch/riscv/boot/Makefile        | 33 ++++++++++++++++++
> >>  arch/riscv/boot/install.sh      | 60 +++++++++++++++++++++++++++++++++
> >>  arch/riscv/kernel/head.S        | 10 ++++++
> >>  arch/riscv/kernel/vmlinux.lds.S |  2 +-
> >>  6 files changed, 120 insertions(+), 2 deletions(-)
> >>  create mode 100644 arch/riscv/boot/.gitignore
> >>  create mode 100644 arch/riscv/boot/Makefile
> >>  create mode 100644 arch/riscv/boot/install.sh
> >>
> >
> > Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> >
> > Tested with U-Boot s-mode on QEMU virt, using bootm to boot the kernel
> > Tested-by: Bin Meng <bmeng.cn@gmail.com>
>
> I also won't include the tags unless I rewrite the tags.
>
> Thanks for the review!

Thanks. Let's go with this as it's a minor nits.

Regards,
Bin
