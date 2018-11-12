Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9314DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CD82241E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIk7j87a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50CD82241E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730734AbeKMIQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 03:16:50 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:33847 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbeKMIQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 03:16:50 -0500
Received: by mail-yb1-f193.google.com with SMTP id n140-v6so4591751yba.1;
        Mon, 12 Nov 2018 14:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=diXRFhfztRj81DZsL/kpbRJZsW9NmgaTLXoABrpWmv4=;
        b=PIk7j87av7NKhK6z9VhZD5DnzBLNhSYN+YbsfBydDfgtYBQ4ZGkh18JlwXmGUyUi94
         zo4tUb87y6QVspEbxRZp0+UfIFKeibnM0UsrMjZujXbY/3YyByB3UnL7L0Og0TjnGgPU
         P8RLgeyYzXGj5Ey4XDO1PebjbsG3XMw6Pvck+MG2zoqsRUcAEoIuy3s/DgsGq7IAVjTx
         rhDcTGhMVSj6xik2F9pbU6wQblhm1JJSEe9ocTDQNjCCykfpNPvWAR8/9phNZkUHseiD
         9I7DA5IUuvNqTfHIB5/ivgXK8AvO4Z5ctAg0t/YofYppI5HTW/ALP9f/zo8q7HMbtDlt
         Oqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=diXRFhfztRj81DZsL/kpbRJZsW9NmgaTLXoABrpWmv4=;
        b=jVlCgcG5/eZmWGfqsniLXYeTO7FDzyKZKnXvX4Rxxd+ODOG0PCMjMhZdPPsNx/n41W
         o2Mu8R4a2Ca8kOMMg4Xla0U8yGG6EQ0G2twlKm7Cmf6jooWSM0ItJtRj5GnDN4GshQZc
         RjfZqhqlUXhT57yagVDzGaj6D+EHNp1iBodFd9iSPTK+0J6tIrZXwbY4SXnDxqnv/TTs
         k1JSpqVeCbqHl6d51Z5sNATxbWgBtFTwX1J8WZ9YcK6QkTKNmly6BU7D7oTXD1EWWFsv
         NOwHZDA83WB6l/K1rc75FQMPRWeCiHsYx60D5iHwzLWyubIJbBUgpO9gw5btYYAzR2+B
         Xszg==
X-Gm-Message-State: AGRZ1gJjuaTsrd+dVG8LKT8cgTK+mn1B30qvYsoh46r60/v3inBumsJf
        GyTtcPei8P+cJNeDl6F+xsWxDaJJV/biosdaDF8=
X-Google-Smtp-Source: AJdET5flAsux6f40fonDGzKKF+bvO3kNBian6KJ4y939KdnPaxp5yzl5yEdcHvZWMycEDfGcNyBKQ0x4l3V+4NFapZg=
X-Received: by 2002:a25:5a82:: with SMTP id o124-v6mr2662067ybb.88.1542061301596;
 Mon, 12 Nov 2018 14:21:41 -0800 (PST)
MIME-Version: 1.0
References: <20181112192252.3911-1-diego.viola@gmail.com> <20181112194201.GA2849@kroah.com>
In-Reply-To: <20181112194201.GA2849@kroah.com>
From:   Diego Viola <diego.viola@gmail.com>
Date:   Mon, 12 Nov 2018 20:21:30 -0200
Message-ID: <CA+ToGPEfb84poj6S1hrZ2hFxb-D_hvVxjHYMVzMhNcic9a+jdg@mail.gmail.com>
Subject: Re: [PATCH RESEND] Blacklist SAMSUNG MZ7TD256HAFV-000L9 SSD
To:     gregkh@linuxfoundation.org
Cc:     axboe@kernel.dk, hdegoede@redhat.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 5:42 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Nov 12, 2018 at 05:22:52PM -0200, Diego Viola wrote:
> > med_power_with_dipm still causes freezes after updating the firmware to
> > the latest version (DXT04L5Q).
> >
> > Set model_rev to NULL and blacklist the device.
> >
> > Signed-off-by: Diego Viola <diego.viola@gmail.com>
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> >  drivers/ata/libata-core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
>
> </formletter>

Sorry about that, I'll get it right next time.

Thanks,
Diego
