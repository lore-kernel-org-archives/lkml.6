Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F38C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 11:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5214420883
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 11:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WA+aNg/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5214420883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbeKJVdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 16:33:00 -0500
Received: from mail-it1-f178.google.com ([209.85.166.178]:37159 "EHLO
        mail-it1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728959AbeKJVdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 16:33:00 -0500
Received: by mail-it1-f178.google.com with SMTP id j79-v6so7184456itb.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 03:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+tpj66HpG2o9IYATyMo2Lc/MF5WLzzbPHe856Bqvi4M=;
        b=WA+aNg/XrsnbGFMijKQzex8aHSl0E9fmofz4lGp63f6ZqUSWBvHmIvV/rKUkS+JkfH
         69W20eNxPuYY4o7aW/HFUWf1IpAshDpLfZwhNLkd0wnZ8Ny8FFDxzZniGH9l07BYf4+3
         nv2uxfv+NOfc8zUqWHJvSxsGOrzAax4hE3MkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+tpj66HpG2o9IYATyMo2Lc/MF5WLzzbPHe856Bqvi4M=;
        b=RiwYgRfTiGNQObzu6UTFIO4Il2YDuoF7VctSn5P537wjjJwwBPnoQva/Yo3I7DxIch
         JVV/01j+gRnNzczazKz+CRJGbj2YK7fUg17vIbQ99VSHbLa6ylNIUn1xrG1qJLeEkEid
         4Le0eBQdLj7TEQt21+uej7UM4Hot48TjgTM9XVQrNmU+dIStzeTA/HqVC5O5CbPutFW+
         vloInZWF1hUcjgN1NRtYhQjon0uMC7LXhO090BeO8qJUyitog6plIzktRE/tesS1F0uK
         gmg6aLD9wKXiztoegfFpgeAqSN4gTg+ZONAuEprY0XOvPIC7B0PVTkXFgPdB5MXaJwnd
         sbug==
X-Gm-Message-State: AGRZ1gLWcUZTZHSxulLyoFNBlLIz1ZybC6cS3U06/uHPI5BIy5XUyUDC
        b1GGw8mYo/uPR2myjBYzA+UvodvuU8yhnaXzAYm6jQ==
X-Google-Smtp-Source: AJdET5eO+L5/9KBnsB7cwSByqqiuHCKmG46QD7Mo/PwKyI5wSU3GkqOxuzM0hgCut2zdH5+zL5Eyl2SDAEI+PJyWDXQ=
X-Received: by 2002:a24:2190:: with SMTP id e138-v6mr5619739ita.71.1541850494452;
 Sat, 10 Nov 2018 03:48:14 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:4f16:0:0:0:0:0 with HTTP; Sat, 10 Nov 2018 03:48:13
 -0800 (PST)
In-Reply-To: <AAACED12-1AAD-4C03-97EF-EF87F05A7056@gmx.us>
References: <AAACED12-1AAD-4C03-97EF-EF87F05A7056@gmx.us>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 10 Nov 2018 12:48:13 +0100
Message-ID: <CAKv+Gu8RKJUnsEqSPDnvUSckUootTp8Tq=AhUA9iEVb3zMqdCA@mail.gmail.com>
Subject: Re: Object debugging warning from efivar
To:     Qian Cai <cai@gmx.us>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Jeremy Kerr <jk@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 November 2018 at 23:19, Qian Cai <cai@gmx.us> wrote:
> Booting this aarch64 server with the latest mainline (3541833fd1f2) get this warning
> using object debugging. Any idea?
>

Thanks Qian

Fix is here
https://lore.kernel.org/lkml/1540304307-2806-1-git-send-email-longman@redhat.com/

and is queued in efi/urgent


> [   34.716558] ODEBUG: object (____ptrval____) is NOT on stack (____ptrval____), but annotated.
> [   34.725266] WARNING: CPU: 0 PID: 1 at lib/debugobjects.c:369 __debug_object_init+0x910/0x918
> [   34.733806] Modules linked in:
> [   34.736903] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W         4.20.0-rc1+ #1
> [   34.744740] Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.50 06/01/2018
> [   34.752051] pstate: 20000085 (nzCv daIf -PAN -UAO)
> [   34.756902] pc : __debug_object_init+0x910/0x918
> [   34.761576] lr : __debug_object_init+0x594/0x918
> [   34.766249] sp : ffff8096c1a0f420
> [   34.769603] x29: ffff8096c1a0f420 x28: 1ffff012d8341ec6
> [   34.774984] x27: ffff20000bc21000 x26: ffff20000bc34e40
> [   34.780364] x25: ffff8096c411e8c8 x24: ffff8096c411e8d0
> [   34.785743] x23: ffff20000c5654d0 x22: ffff20000bc21c40
> [   34.791123] x21: ffff801ec1a00060 x20: ffff801ec1a00040
> [   34.796502] x19: ffff801ec1a00040 x18: 000000000000003f
> [   34.801881] x17: 0000000000000000 x16: 0000000000000000
> [   34.807260] x15: 0000000000007fff x14: 6e6120747562202c
> [   34.812640] x13: 295f5f5f5f6c6176 x12: ffff1012d8341ceb
> [   34.818019] x11: 00000000f2f2f2f2 x10: dfff200000000000
> [   34.823399] x9 : ffff20000a0e9848 x8 : ffff801ec1a00b70
> [   34.828778] x7 : 00000000f2f2f204 x6 : 00000000f2f2f204
> [   34.834157] x5 : 0000000041b58ab3 x4 : dfff200000000000
> [   34.839537] x3 : dfff200000000000 x2 : 2b6ba53cf7873600
> [   34.844916] x1 : 0000000000000000 x0 : 0000000000000050
> [   34.850295] Call trace:
> [   34.852772]  __debug_object_init+0x910/0x918
> [   34.857095]  debug_object_init_on_stack+0x20/0x28
> [   34.861859]  __init_work+0x34/0x50
> [   34.865304]  virt_efi_get_next_variable+0xbc/0x190
> [   34.870153]  efivar_init+0x144/0x4b0
> [   34.873773]  efisubsys_init+0x1a8/0x428
> [   34.877656]  do_one_initcall+0x160/0x6bc
> [   34.881628]  kernel_init_freeable+0x74c/0x814
> [   34.886040]  kernel_init+0x18/0x11c
> [   34.889572]  ret_from_fork+0x10/0x1c
> [   34.893189] irq event stamp: 882290
> [   34.896723] hardirqs last  enabled at (882289): [<ffff200008fab538>] _raw_spin_unlock_irqrestore+0x80/0x88
> [   34.906496] hardirqs last disabled at (882290): [<ffff200008fab264>] _raw_spin_lock_irqsave+0x34/0x98
> [   34.915829] softirqs last  enabled at (881706): [<ffff200008082210>] __do_softirq+0x7c8/0x9c8
> [   34.924460] softirqs last disabled at (881697): [<ffff20000812dbe4>] irq_exit+0x25c/0x2f0
> [   34.932736] ---[ end trace f86eaf2ac70822cc ]---
