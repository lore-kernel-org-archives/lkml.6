Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71188C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4011520866
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WGLK5XSB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfAVW3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 17:29:07 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36098 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbfAVW3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 17:29:06 -0500
Received: by mail-lj1-f193.google.com with SMTP id g11-v6so158531ljk.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 14:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ATJb8Y1QK0+DWFS5C9575PNIZ/kg7x8HH9FfSrgkB1I=;
        b=WGLK5XSB1+8mmb5g65v/2ltx2RQwKTpbRuDeKxSaDMZUzLtEDIHnwvd88+dzibti7f
         m/qpQ99vKGMgbWm2I80mSjhnoWuCKuZXGZZALyNHKkf31RX9jmp4thBWNhantnnsm0t9
         wGeEnMa2a11fndE2wmWDA7/x1iSOTaiMtRxgo5K53s5FPlBfyfHKHb+JLIcIdeC+XLoM
         L9P2V81DZV89sPdLB2oYHkBs6HIIreq8CotEz4ptAZ1y4BQppnztVNZMdUlTr3eCTFpO
         bv1g6BcNXY59Y3LH/Dnx0MImDonudTiN8IbxzWDW/KGdaCemwyk/CL7Cpz0XaGWYRPvJ
         M24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ATJb8Y1QK0+DWFS5C9575PNIZ/kg7x8HH9FfSrgkB1I=;
        b=LZSVT0EcG+AUYfCG8Lv7jWrKEMLBABCl1IAziuIYvjqbWFjZ+7phDqgmBP8I/J5dH4
         FP8plF80u0xMkOJPIAZSvPUw0K/QBNDlnWqFKgtD8yXquaLA5BJrvK8z6NOfB9Ar/3g8
         F6CsUHZWvQ9jOQxdbM64Z+2rWLh59qhXNnJxq/zd/qC9H+ggw5n8XJ0vnQCcO63OXAle
         4qTnydCg3BcJgW85dEvbTXf6+TrQ7sfPymYqiIz5FNhXkjPFHd8v4VsABGfZL9KM8cPv
         eDhYclXrwrIV0oD2vswB6Bq1dlygACWax+cgsJhwZzFUDKbZpWbx0rLFjDO2yh/O2zqI
         GCpA==
X-Gm-Message-State: AJcUukf3Du9cB+Pm8Glmb0wUsSVS309MY4LgIi5MpOcIkw4oDYCGcLs6
        pcm+BJqAYpHjf9znaW4/RS6NdFeiihopEX8Wxf5UfA==
X-Google-Smtp-Source: ALg8bN4oiPniTUo1bcuJEkQ8dvHztC/NIPTgsxSsGDXUI+KpR8FA1FBQioCBOlZ9LPKHMSTM0EcN2sIjGM59Ztefs1I=
X-Received: by 2002:a2e:9395:: with SMTP id g21-v6mr2157913ljh.78.1548196144151;
 Tue, 22 Jan 2019 14:29:04 -0800 (PST)
MIME-Version: 1.0
References: <20181117010748.24347-1-rajatja@google.com> <20190118223407.64818-1-rajatja@google.com>
 <C103ADA0-68A0-4571-AE47-1744E64E0D7E@holtmann.org>
In-Reply-To: <C103ADA0-68A0-4571-AE47-1744E64E0D7E@holtmann.org>
From:   Rajat Jain <rajatja@google.com>
Date:   Tue, 22 Jan 2019 14:28:27 -0800
Message-ID: <CACK8Z6FzWTZ_SYCBqGsOcf2xzSp3+W9HD-1inyRtJ=Wqsww8Pw@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] usb: split code locating ACPI companion into port
 and device
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dtor@chromium.org>,
        Alex Hung <alex.hung@canonical.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Dmitry Torokhov <dtor@google.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>,
        chethan.tumkur.narayan@intel.com,
        "Ghorai, Sukumar" <sukumar.ghorai@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

On Sat, Jan 19, 2019 at 11:51 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Rajat,
>
> > In preparation for handling embedded USB devices let's split
> > usb_acpi_find_companion() into usb_acpi_find_companion_for_device() and
> > usb_acpi_find_companion_for_port().
> >
> > Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Tested-by: Sukumar Ghorai <sukumar.ghorai@intel.com>
> > ---
> > v4: Add Acked-by and Tested-by in signatures.
> > v3: same as v1
> > v2: same as v1
> >
> > drivers/usb/core/usb-acpi.c | 133 +++++++++++++++++++-----------------
> > 1 file changed, 72 insertions(+), 61 deletions(-)
>
> what is the plan here? I take this via bluetooth-next tree?

Yes, I'd think that would be the best plan. Dmitry / Greg - do you
have any objections / suggestions?

>
> Regards
>
> Marcel
>
