Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F4DC282C3
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 00:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43AAA218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 00:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="qdOLVVlr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbfAYAzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 19:55:32 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39798 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfAYAzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 19:55:32 -0500
Received: by mail-qt1-f195.google.com with SMTP id u47so8977632qtj.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 16:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5enGz62sQmbz9edqo02aKojbyGTmWpcSj4kNFI14c48=;
        b=qdOLVVlrnzw6XPC6XFds6iZJclnlBXpv90zitECXT7HYjfoD+GdoUMol4c4AV+wte3
         GBORMDcRC5KRETFVwwxY3HSgoGo9jYIsk1utyeLVzA8y7KF+fBd5bw6gu6MGIgZLgxIN
         5h/lKtAhK/oVdxKNUrKvQLiCK2PI7zJFSf2B/H9N51XGxaJQy/1AA2zXr8G+fBBsguHP
         SVbIRi3B/tsv4UHywiw5fujxpTIROVbNDREig+mORzdGMk6M/Nt7bDsbMEOEgg/kMItN
         zBigBYnegOHfNzl1Mf2x10tX82fFU5UNcpZ99PqLqmYr1gcIdbxZOXCeRDF8u5yJpioW
         lp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5enGz62sQmbz9edqo02aKojbyGTmWpcSj4kNFI14c48=;
        b=h8xz6Of3jd/93ndWqrDkx2OvIuAZefMi/0cEk6PYazRowPGUrDmTh7BwD4H9HljXqX
         lVfIVZa9F8v8zbd2Auh5JF5rCAtCdlWcsE/IHAiSVxmyQR6FL3ZjklcBv3btx89dYKlp
         UaeNVLSl13q+M8FOOGldwg+25Bz0noD/hq3Hb5eRRffoSE1kfY6S+lCtMe4tVqmFneIH
         VInevykSfIm2tSyaFRZ5mwWl520HJv6EkeevudGtsUsSX2w+zUzuZuNqF32uik/Puvhx
         XSl2aKyCWP0MMcPbwZV2SCW2HfgDpvjZSXuTi3Bo4Ir2iTd4U29rw0LI5bRdIeArDz5S
         zQFg==
X-Gm-Message-State: AJcUukcC3jCBCi6ceaj7sSWeN3xbHmO6w9zviBxKNfB9k+q/7tIj0jr2
        2GfT9EDuUGiMT04aKi/svrmtc/D7nBMmqBuLL2SjpCm2
X-Google-Smtp-Source: ALg8bN5yG71aFuADBWTiDdDT9OAJ3H1mZTMjwO3DOjNroiVwub2H+Vq9MVZMIpYRZPYFNlZLfI9/gIARzbmlpRfqikA=
X-Received: by 2002:a0c:e40a:: with SMTP id o10mr8045903qvl.197.1548377731083;
 Thu, 24 Jan 2019 16:55:31 -0800 (PST)
MIME-Version: 1.0
References: <20190124152310.29717-1-kai.heng.feng@canonical.com> <20190124152310.29717-3-kai.heng.feng@canonical.com>
In-Reply-To: <20190124152310.29717-3-kai.heng.feng@canonical.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Fri, 25 Jan 2019 08:55:20 +0800
Message-ID: <CAD8Lp47YpoVeDheK3pi0CcSJTdh2jSVcM8V9T_zmu=7deXszOw@mail.gmail.com>
Subject: Re: [PATCH 3/3] Bluetooth: btrtl: Skip initialization if firmware is
 already loaded
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Bluetooth mailing list 
        <linux-bluetooth@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 11:23 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
> Realtek bluetooth may not work after reboot:
> [   12.446130] Bluetooth: hci0: RTL: rtl: unknown IC info, lmp subver a99e, hci rev 826c, hci ver 0008
>
> The power is not cut during system reboot, so the firmware is kept in
> Bluetooth controller.
>
> Realtek bluetooth doesn't have the ability to check firmware loading
> status. but the version queried by HCI_OP_READ_LOCAL_VERSION will be
> different if firmware is already loaded. Realtek's own fork, rtk_btusb
> also use this method to detect the loading status.
>
> So let's assume the firmware is already loaded when we can't find
> matching IC info.

This logic was already present in the driver - but it looks like this
regressed at this point:

commit 26503ad25de8c7c93a2037f919c2e49a62cf65f1
Author: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu Aug 2 16:57:13 2018 +0200

    Bluetooth: btrtl: split the device initialization into smaller parts

After your patch it is effectively there in two places now, since it
is also in btrtl_download_firmware() (although not really effective
after the above commit). I wonder if that can be cleaned up to avoid
duplication.

Regarding the other patches that move away from the style of returning
either a useful value or an error, is this purely a stylistic thing or
is it needed for your 3rd patch? I don't have strong feelings either
way but I have the impression that the currently implemented approach
is a common style within kernel code and I don't see benefit in
splitting off a separate out parameter.

Daniel


> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201921
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/bluetooth/btrtl.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index c36f500d8313..e2f89d57dd14 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -546,9 +546,10 @@ int btrtl_initialize(struct hci_dev *hdev,
>                                             hdev->bus);
>
>         if (!btrtl_dev->ic_info) {
> -               rtl_dev_err(hdev, "rtl: unknown IC info, lmp subver %04x, hci rev %04x, hci ver %04x",
> -                           lmp_subver, hci_rev, hci_ver);
> -               return -EINVAL;
> +               rtl_dev_info(hdev, "rtl: unknown IC info, lmp subver %04x, hci rev %04x, hci ver %04x",
> +                            lmp_subver, hci_rev, hci_ver);
> +               rtl_dev_info(hdev, "rtl: firmware may be already loaded, or it's an unsupported IC.");
> +               return 0;
>         }
>
>         if (btrtl_dev->ic_info->has_rom_version) {
> @@ -621,7 +622,8 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
>         if (ret)
>                 return ret;
>
> -       ret = btrtl_download_firmware(hdev, &btrtl_dev);
> +       if (btrtl_dev.ic_info)
> +               ret = btrtl_download_firmware(hdev, &btrtl_dev);
>
>         return ret;
>  }
> --
> 2.17.1
>
