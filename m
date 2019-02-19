Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F31C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 04:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DCEA217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 04:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXeEyYm3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfBSE6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 23:58:07 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39068 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfBSE6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 23:58:07 -0500
Received: by mail-wm1-f67.google.com with SMTP id z84so1139166wmg.4;
        Mon, 18 Feb 2019 20:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+VXQ6ai2ZVsIW6FTuSspSxv9FDX96yPRY8IU9G/8BPc=;
        b=iXeEyYm35vMVX5VuwCLiGeuvqzOuYulC+bhMDaGhnG7R6ec9mfatzMZUVl8DXVwFte
         rVviGl/m2KZpBvjexIR039zpf0JQkz8Tlf9irS1wYbbbBnm3Kj5mnD+0t5ncD2LJ+rDS
         8/GYdoyIGvE4zipn2NijdU0NYHk84sNwpdtPPO6/08JhLma8NMBR5x4SJ0YF5L8LV94o
         /uFUUwFA00iYiUEi34eTg39HxJ9/NigoUUHA9cL7MhmLgUR51ujBKJtmNaZOAmtxBVaX
         1XgWK9IoqUDzQCoGDsf0NRox3kFgQsEtAWdK8YmfErVaFYm6dCVXy/EevorrnNNE91Bd
         0V8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+VXQ6ai2ZVsIW6FTuSspSxv9FDX96yPRY8IU9G/8BPc=;
        b=uk4qa2844MuAyXwPZUM+P4C8Afir1F2cOt+aiTOL11X50RomSH+EZQJ8JlFoSYvFCn
         rkEul6UXFi77+5Yj8CzwyFp19vAxExdxWcw0fhiMpXKH/9Rk71MwlxAVHxa3XfAzz5YB
         DG0XZVmZNH8Cj/2KaNOUy7lPF1VErPizJ254Z5ZAgvYh5I6oZiNaopia22PN7TKB0txn
         TDApFo06KEUzh3zRMRYEgBYTv0LzwHWXjY6gV2pTnLFWStBybxVMvdyutCatYe3uU4mj
         lMXzDO6AhCDc1vnKDHhAISmZNXSFolKobZQpnBQD/o4RgaFUFLTaSud571tSxgqZCcZV
         F4hQ==
X-Gm-Message-State: AHQUAubkZ4uhGBpIKiIET5UPgtCYtACjT47V97TdNdWWORTVJdJrJ7ps
        o368sOSrOXJ3m51P2JG5dVZlgzypt8FE7/HViyU=
X-Google-Smtp-Source: AHgI3IYM5AaDrQlsCKqL1JWDGruEwJWIG4cJ0HK5RjupzBbdVWKBSYZIi9piTJXIJ7YM7uHt6e7MBqiehDAFfNGSs54=
X-Received: by 2002:a1c:c489:: with SMTP id u131mr1178957wmf.127.1550552284809;
 Mon, 18 Feb 2019 20:58:04 -0800 (PST)
MIME-Version: 1.0
References: <20190208025828.30901-1-andrew.smirnov@gmail.com> <3E87E315-0F39-49BA-BD65-2EB0C3A9A782@holtmann.org>
In-Reply-To: <3E87E315-0F39-49BA-BD65-2EB0C3A9A782@holtmann.org>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 18 Feb 2019 20:57:53 -0800
Message-ID: <CAHQ1cqH+TCrU+7NE7iiiUwUsCQjfHs8hjKe24b7bj9A3R5GNWw@mail.gmail.com>
Subject: Re: [RFC] Bluetooth: Retry configure request if result is L2CAP_CONF_UNKNOWN
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
        Florian Dollinger <dollinger.florian@gmx.de>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 4:58 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Andrey,
>
> > Due to:
> >
> > - current implementation of l2cap_config_rsp() dropping BT
> >   connection if sender of configuration response replied with unknown
> >   option failure (Result=0x0003/L2CAP_CONF_UNKNOWN)
> >
> > - current implementation of l2cap_build_conf_req() adding
> >   L2CAP_CONF_RFC(0x04) option to initial configure request sent by
> >   the Linux host.
> >
> > devices that do no recongninze L2CAP_CONF_RFC, such as Xbox One S
> > controllers, will get stuck in endless connect -> configure ->
> > disconnect loop, never connect and be generaly unusable.
> >
> > To avoid this problem add code to do the following:
> >
> > 1. Store a mask of supported conf option types per connection
> >
> > 2. Parse the body of response L2CAP_CONF_UNKNOWN and adjust
> >    connection's supported conf option types mask
> >
> > 3. Retry configuration step the same way it's done for
> >    L2CAP_CONF_UNACCEPT
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>
> > Cc: Florian Dollinger <dollinger.florian@gmx.de>
> > Cc: Marcel Holtmann <marcel@holtmann.org>
> > Cc: Johan Hedberg <johan.hedberg@gmail.com>
> > Cc: linux-bluetooth@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >
> > Everyone:
> >
> > I marked this as an RFC, since I don't have a lot of experience with
> > Bluetooth subsystem and don't have hight degree of confidence about
> > choices made in this patch. I do, however, thins is is good enough to
> > start a discussion about the problem.
>
> can you take a btmon -w trace.log protocol trace so that I can see where it fails. This seems a really odd behavior of the Xbox controller. We have to be careful in not breaking Bluetooth qualification to just workaround some buggy remote device.
>

Sure, n/p, both "failure" (behavior before this patch) and "success"
(behavior with the patch) cases on my machine are available here:

https://gist.github.com/ndreys/2b74094933601978e200af1ff0a55372

Let me know if that's not accessible to you.

Thanks,
Andrey Smirnov
